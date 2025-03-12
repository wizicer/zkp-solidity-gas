package main

import (
        "bytes"
        "fmt"
        "math/big"
        "os"
        "strings"
        "time"

        "github.com/consensys/gnark/frontend/cs/r1cs"
        "github.com/consensys/gnark/frontend/cs/scs"
        "github.com/consensys/gnark/test/unsafekzg"

        "log"

        "encoding/hex"
        "encoding/json"

        "github.com/consensys/gnark/backend/groth16"
        "github.com/consensys/gnark/backend/plonk"

        "github.com/consensys/gnark-crypto/ecc"
        "github.com/consensys/gnark/backend/witness"
        "github.com/consensys/gnark/constraint"

        "github.com/consensys/gnark/frontend"
)

type Schema int

const (
        Groth16 Schema = iota + 1
        Plonk
)

func main() {
        proveTest(Groth16)
        // proveTest(Plonk)
}

func proveTest(schema Schema) {
        start := time.Now()

        builder := (map[bool]frontend.NewBuilder{true: r1cs.NewBuilder, false: scs.NewBuilder})[schema == Groth16]
        cs, witnessData, err := generateWitness(builder)
        panicIfErr(err)

        start = time.Now()
        if schema == Groth16 {

                // 1. One time setup
                pk, vk, err := groth16.Setup(cs)
                panicIfErr(err)

                fmt.Printf("setup %v\n", time.Since(start))
                start = time.Now()

                // 2. Proof creation
                proof, err := groth16.Prove(cs, pk, witnessData)
                panicIfErr(err)

                fmt.Printf("prove %v\n", time.Since(start))
                // start = time.Now()

                log.Println("end proof")

                log.Println("start verify")
                publicWitness, err := witnessData.Public()
                panicIfErr(err)

                // 3. Proof verification
                err = groth16.Verify(proof, vk, publicWitness)
                panicIfErr(err)
                log.Println("end verify")

                fSolidity, err := os.Create("gnark_groth16_verifier.sol")
                panicIfErr(err)
                err = vk.ExportSolidity(fSolidity)
                panicIfErr(err)
                err = fSolidity.Close()
                panicIfErr(err)

                // proof to argument
                buf := bytes.Buffer{}
                _, err = proof.WriteRawTo(&buf)
                panicIfErr(err)

                proofInt := writeProof(buf.Bytes())
                fmt.Println("proof", "["+strings.Join(proofInt[:], ",")+"]")
        } else {
                // 1. One time setup
                srs, srsLagrange, err := unsafekzg.NewSRS(cs)
                panicIfErr(err)

                pk, vk, err := plonk.Setup(cs, srs, srsLagrange)
                panicIfErr(err)

                // 2. Proof creation
                proof, err := plonk.Prove(cs, pk, witnessData)
                panicIfErr(err)

                fmt.Printf("prove %v\n", time.Since(start))
                // start = time.Now()

                log.Println("end proof")

                log.Println("start verify")
                publicWitness, err := witnessData.Public()
                panicIfErr(err)
                // 3. Proof verification
                err = plonk.Verify(proof, vk, publicWitness)
                panicIfErr(err)
                log.Println("end verify")
                // log.Println("proof", proof)

                fSolidity, err := os.Create("gnark_plonk_verifier.sol")
                panicIfErr(err)
                err = vk.ExportSolidity(fSolidity)
                panicIfErr(err)
                err = fSolidity.Close()
                panicIfErr(err)

                // proof to hex
                _proof, ok := proof.(interface{ MarshalSolidity() []byte })
                if !ok {
                        panic("proof does not implement MarshalSolidity()")
                }

                proofStr := hex.EncodeToString(_proof.MarshalSolidity())
                fmt.Println("proof", "0x"+proofStr)
        }
}

func writeProof(proofBytes []byte) [8]string {
        const fpSize = 4 * 8

        var proof [8]string

        for i := 0; i < 8; i++ {
                proof[i] = new(big.Int).SetBytes(proofBytes[fpSize*i : fpSize*(i+1)]).String()
        }
        return proof
}

func generateWitness(newBuilder frontend.NewBuilder) (constraint.ConstraintSystem, witness.Witness, error) {
        circuit := BasicCircuit{}
        witnessCircuit := BasicCircuit{
                A: 3,
                B: 4,
                C: 5,
                D: 7,
        }

        witnessData, err := frontend.NewWitness(&witnessCircuit, ecc.BN254.ScalarField())
        panicIfErr(err)

        cs, err := frontend.Compile(ecc.BN254.ScalarField(), newBuilder, &circuit)
        panicIfErr(err)

        isPrintingWitness := false
        if isPrintingWitness {
                schema, _ := frontend.NewSchema(&witnessCircuit)
                ret, _ := witnessData.ToJSON(schema)

                var b bytes.Buffer
                json.Indent(&b, ret, "", "\t")
                log.Println("start proof: witness", b.String())
        }

        return cs, witnessData, nil
}
