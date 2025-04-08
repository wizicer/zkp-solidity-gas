// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

/*
    Sonobe's Nova + CycleFold decider verifier.
    Joint effort by 0xPARC & PSE.

    More details at https://github.com/privacy-scaling-explorations/sonobe
    Usage and design documentation at https://privacy-scaling-explorations.github.io/sonobe-docs/

    Uses the https://github.com/iden3/snarkjs/blob/master/templates/verifier_groth16.sol.ejs
    Groth16 verifier implementation and a KZG10 Solidity template adapted from
    https://github.com/weijiekoh/libkzg.
    Additionally we implement the NovaDecider contract, which combines the
    Groth16 and KZG10 verifiers to verify the zkSNARK proofs coming from
    Nova+CycleFold folding.
*/


/* =============================== */
/* KZG10 verifier methods */
/**
 * @author  Privacy and Scaling Explorations team - pse.dev
 * @dev     Contains utility functions for ops in BN254; in G_1 mostly.
 * @notice  Forked from https://github.com/weijiekoh/libkzg.
 * Among others, a few of the changes we did on this fork were:
 * - Templating the pragma version
 * - Removing type wrappers and use uints instead
 * - Performing changes on arg types
 * - Update some of the `require` statements 
 * - Use the bn254 scalar field instead of checking for overflow on the babyjub prime
 * - In batch checking, we compute auxiliary polynomials and their commitments at the same time.
 */
contract KZG10Verifier {

    // prime of field F_p over which y^2 = x^3 + 3 is defined
    uint256 public constant BN254_PRIME_FIELD =
        21888242871839275222246405745257275088696311157297823662689037894645226208583;
    uint256 public constant BN254_SCALAR_FIELD =
        21888242871839275222246405745257275088548364400416034343698204186575808495617;

    /**
     * @notice  Performs scalar multiplication in G_1.
     * @param   p  G_1 point to multiply
     * @param   s  Scalar to multiply by
     * @return  r  G_1 point p multiplied by scalar s
     */
    function mulScalar(uint256[2] memory p, uint256 s) internal view returns (uint256[2] memory r) {
        uint256[3] memory input;
        input[0] = p[0];
        input[1] = p[1];
        input[2] = s;
        bool success;
        assembly {
            success := staticcall(sub(gas(), 2000), 7, input, 0x60, r, 0x40)
            switch success
            case 0 { invalid() }
        }
        require(success, "bn254: scalar mul failed");
    }

    /**
     * @notice  Negates a point in G_1.
     * @param   p  G_1 point to negate
     * @return  uint256[2]  G_1 point -p
     */
    function negate(uint256[2] memory p) internal pure returns (uint256[2] memory) {
        if (p[0] == 0 && p[1] == 0) {
            return p;
        }
        return [p[0], BN254_PRIME_FIELD - (p[1] % BN254_PRIME_FIELD)];
    }

    /**
     * @notice  Adds two points in G_1.
     * @param   p1  G_1 point 1
     * @param   p2  G_1 point 2
     * @return  r  G_1 point p1 + p2
     */
    function add(uint256[2] memory p1, uint256[2] memory p2) internal view returns (uint256[2] memory r) {
        bool success;
        uint256[4] memory input = [p1[0], p1[1], p2[0], p2[1]];
        assembly {
            success := staticcall(sub(gas(), 2000), 6, input, 0x80, r, 0x40)
            switch success
            case 0 { invalid() }
        }

        require(success, "bn254: point add failed");
    }

    /**
     * @notice  Computes the pairing check e(p1, p2) * e(p3, p4) == 1
     * @dev     Note that G_2 points a*i + b are encoded as two elements of F_p, (a, b)
     * @param   a_1  G_1 point 1
     * @param   a_2  G_2 point 1
     * @param   b_1  G_1 point 2
     * @param   b_2  G_2 point 2
     * @return  result  true if pairing check is successful
     */
    function pairing(uint256[2] memory a_1, uint256[2][2] memory a_2, uint256[2] memory b_1, uint256[2][2] memory b_2)
        internal
        view
        returns (bool result)
    {
        uint256[12] memory input = [
            a_1[0],
            a_1[1],
            a_2[0][1], // imaginary part first
            a_2[0][0],
            a_2[1][1], // imaginary part first
            a_2[1][0],
            b_1[0],
            b_1[1],
            b_2[0][1], // imaginary part first
            b_2[0][0],
            b_2[1][1], // imaginary part first
            b_2[1][0]
        ];

        uint256[1] memory out;
        bool success;

        assembly {
            success := staticcall(sub(gas(), 2000), 8, input, 0x180, out, 0x20)
            switch success
            case 0 { invalid() }
        }

        require(success, "bn254: pairing failed");

        return out[0] == 1;
    }

    uint256[2] G_1 = [
            0x171149d656ab2678f03a81fb4a13b38cb13c584222498b9f0824377ff4ef1c6c,
            0x1078a9c7358344c97989a825cd493c02502c5979785ab4102b85cab8785e1652
    ];
    uint256[2][2] G_2 = [
        [
            0x2e85a64b176a89f651b755522402780ac5224a690c62c2a3580e2b77391eb85f,
            0x25a630e1b1bb847ca0e32e8d5a2c62d424e4b0d67d8295d094589efba2611485
        ],
        [
            0x105e2254f385a54471f0f072b96fc88fc2a55e98e8fccbdcd5da2729f42941c7,
            0x1478cea7a3717eed37243042378ca4d61c6d69d433ecbf2967d813cb1adc02ae
        ]
    ];
    uint256[2][2] VK = [
        [
            0x213df544b48e424ce1eca450ed03a5496169eddd748b653832354ca0bcf23f62,
            0x2959a960103c0295e1a16715e806239ff6c59e4c0743824c117de81ae7f85c96
        ],
        [
            0x2dc616d796b0ecac95c855ccb68ea147ba7ae912cc510afd22db4596056d6886,
            0x1afc010c12a7d030252d49bbe091ac357b40f62e2c1ac4c1f346b20ce3c2c5c6
        ]
    ];

    

    /**
     * @notice  Verifies a single point evaluation proof. Function name follows `ark-poly`.
     * @dev     To avoid ops in G_2, we slightly tweak how the verification is done.
     * @param   c  G_1 point commitment to polynomial.
     * @param   pi G_1 point proof.
     * @param   x  Value to prove evaluation of polynomial at.
     * @param   y  Evaluation poly(x).
     * @return  result Indicates if KZG proof is correct.
     */
    function check(uint256[2] calldata c, uint256[2] calldata pi, uint256 x, uint256 y)
        public
        view
        returns (bool result)
    {
        //
        // we want to:
        //      1. avoid gas intensive ops in G2
        //      2. format the pairing check in line with what the evm opcode expects.
        //
        // we can do this by tweaking the KZG check to be:
        //
        //          e(pi, vk - x * g2) = e(c - y * g1, g2) [initial check]
        //          e(pi, vk - x * g2) * e(c - y * g1, g2)^{-1} = 1
        //          e(pi, vk - x * g2) * e(-c + y * g1, g2) = 1 [bilinearity of pairing for all subsequent steps]
        //          e(pi, vk) * e(pi, -x * g2) * e(-c + y * g1, g2) = 1
        //          e(pi, vk) * e(-x * pi, g2) * e(-c + y * g1, g2) = 1
        //          e(pi, vk) * e(x * -pi - c + y * g1, g2) = 1 [done]
        //                        |_   rhs_pairing  _|
        //
        uint256[2] memory rhs_pairing =
            add(mulScalar(negate(pi), x), add(negate(c), mulScalar(G_1, y)));
        return pairing(pi, VK, rhs_pairing, G_2);
    }

    function evalPolyAt(uint256[] memory _coefficients, uint256 _index) public pure returns (uint256) {
        uint256 m = BN254_SCALAR_FIELD;
        uint256 result = 0;
        uint256 powerOfX = 1;

        for (uint256 i = 0; i < _coefficients.length; i++) {
            uint256 coeff = _coefficients[i];
            assembly {
                result := addmod(result, mulmod(powerOfX, coeff, m), m)
                powerOfX := mulmod(powerOfX, _index, m)
            }
        }
        return result;
    }

    
}

/* =============================== */
/* Groth16 verifier methods */
/*
    Copyright 2021 0KIMS association.

    * `solidity-verifiers` added comment
        This file is a template built out of [snarkJS](https://github.com/iden3/snarkjs) groth16 verifier.
        See the original ejs template [here](https://github.com/iden3/snarkjs/blob/master/templates/verifier_groth16.sol.ejs)
    *

    snarkJS is a free software: you can redistribute it and/or modify it
    under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    snarkJS is distributed in the hope that it will be useful, but WITHOUT
    ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
    or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public
    License for more details.

    You should have received a copy of the GNU General Public License
    along with snarkJS. If not, see <https://www.gnu.org/licenses/>.
*/

contract Groth16Verifier {
    // Scalar field size
    uint256 constant r    = 21888242871839275222246405745257275088548364400416034343698204186575808495617;
    // Base field size
    uint256 constant q   = 21888242871839275222246405745257275088696311157297823662689037894645226208583;

    // Verification Key data
    uint256 constant alphax  = 0x2f533773c015d749042417c39ea56614dd53d08589e768d281dbcb86ffe2670b;
    uint256 constant alphay  = 0x0669e4ebda9cd22a4e8746b54c76973cb132bcc309e239793c1674b9abd2e215;
    uint256 constant betax1  = 0x0e845ac323b50b30c9389be6a4557940ad6a56fa250ab10a23d13cf59f02f852;
    uint256 constant betax2  = 0x204a52d89924b36e627cc40b5b1f36a83dfa6875be69e48dc0fff9f7d0ec0fa7;
    uint256 constant betay1  = 0x25be03fd6cfd1ce69cf6e7c89fcdcefcba70b7f4ad808e0e2994c939482a293b;
    uint256 constant betay2  = 0x04448b11ea18556011eafa36f552c856cd6a57ca0d15653c7936ae1ef10fec08;
    uint256 constant gammax1 = 0x0c5ddfbd6fc8b343dfc5f334677e5f4ba3c17edde3a3d78efcf91a4115447217;
    uint256 constant gammax2 = 0x0f6a5215f3940b3fbe7c83061b7fea555f1f39c0cdfd2d47bdf57d4d3ac33b61;
    uint256 constant gammay1 = 0x266eda018cdbf14d548cac2d6818e24eab9d499c157fac10a2c75cf4b52db9bd;
    uint256 constant gammay2 = 0x1b7ba7b05e4b1b5f1746d769353ef72cbebf94d78cde5d1742fc9a67161710d8;
    uint256 constant deltax1 = 0x1a8efdea2c899e0b74a3f8ab12fb19fa5fcd5d3e0d42410e3ad44aed6e986d68;
    uint256 constant deltax2 = 0x2a362fe4541af063cd6c43599494cf62fc57942e1c267252152683dd02773f66;
    uint256 constant deltay1 = 0x2b90569100f076a909e0f5f31c356daaeef14dabefb7e1f552fd866ee10e7741;
    uint256 constant deltay2 = 0x1d3e141ffb0fee901f45d4031db3d47afce9968b76f1f17bf534da0d92fdddf1;

    
    uint256 constant IC0x = 0x08bfdb3499ad4e55a7a893ed71831cbe9aebb2ae9a3bf79f3a6891e85d83dd1a;
    uint256 constant IC0y = 0x07c3b06ab659d56727a6e17c501fa5b465c2df903e0219516cbd0905034eb056;
    
    uint256 constant IC1x = 0x25d163c68e6913bbfcd242ed01df774c4c6dffd58f37ee360a76222d5a23b560;
    uint256 constant IC1y = 0x03e720a8e92f9d7e4e8a48de1018e45b18f2de258b7dd3771facdc57cfec44af;
    
    uint256 constant IC2x = 0x08b64189bcb5d9290fa07d0472f36e45dc34fc659fccd15826df58de34af516a;
    uint256 constant IC2y = 0x26903a96cb554745a2af08e285b903674ba67f2240c9f37fb577e5599d7b9a03;
    
    uint256 constant IC3x = 0x2387397e741f406320d13c09ddfbbf593b934b578739a0ad63af3f73d4cc9b69;
    uint256 constant IC3y = 0x01c166256cead57e7e505cefc6bd559e1213168321cfbc9309991a6e30cc9113;
    
    uint256 constant IC4x = 0x00c6a3b40b1547b8ab0cfb946c4ad22c7784c7ec96c74f4b99ca055e9800e754;
    uint256 constant IC4y = 0x0fe5734917cf9afd67f5cbc6b29e22e2ef49d805ecccba3c588af45f01a70ce4;
    
    uint256 constant IC5x = 0x0fefa15e268da6c9c9295a21a372ea098bc091f6cb36c3bc3f47eea6accc280e;
    uint256 constant IC5y = 0x292dbf52d1e05a6a31d1caceeb54e5bd6f258924c2432816f11d44fd853277e5;
    
    uint256 constant IC6x = 0x22edd124a9274ec184c720f2b338796ba3812d8cd9df377771e50478c80f3ce8;
    uint256 constant IC6y = 0x0fa6b301b58bd9590c3216441e9669c3ee2189189f90b21b69fb9920afd398f3;
    
    uint256 constant IC7x = 0x1ad047c83a9fa37f8768b04a680276fcc8d734b4d40669a7908609a3d94bfb8a;
    uint256 constant IC7y = 0x0bfca9527d874882cd1a310e9d338766eb9cddaf953bb084f942b063ab2def59;
    
    uint256 constant IC8x = 0x085a27a73e01f0097b5ae642d7bce5a08f79d04e848d12c2af21eba0e6042a6e;
    uint256 constant IC8y = 0x0e07ad37a7f104d0e30e1543c79120d65fa4f3d9a0dbe7657bcb1d053f79cc05;
    
    uint256 constant IC9x = 0x2040efd5b67e2df8c316d6cb97a680e3827c7191e5b637875d51f6bbff524e33;
    uint256 constant IC9y = 0x185febeb7a2d28f4890120a5f3b975f04b6ba84ce7e2e938c0b10b9203b8c4ed;
    
    uint256 constant IC10x = 0x1827acbf9a6566c6b90efba7e39ff8db03baeac78b7d46c45cf5cdb7a2b9c456;
    uint256 constant IC10y = 0x10fa6fe1a044d5abc522ece473aaa71e7ebfb5bce095d156b512bdb23cad2bc5;
    
    uint256 constant IC11x = 0x2202338115ed377bada07fba4bd74bf1f8367152669cb197806a023dff90ded5;
    uint256 constant IC11y = 0x08c723b7f9b90f419b28a8f78ebfa603d067f864a96ae281ed60300d066e5453;
    
    uint256 constant IC12x = 0x018496f2da339bca72296bdcf397c33b704139861f3ea18d6cf924f07062d01b;
    uint256 constant IC12y = 0x2179a582c00c20c7f68452f6bff484539b02cac60ad15f6303143414e6752871;
    
    uint256 constant IC13x = 0x0ec865b971df02ef9394ed35726424eac7da95ef5c0c4220fdceb1aa216efd05;
    uint256 constant IC13y = 0x25bbe5f5fa32843b19467af592c454ca9ea4fc99dfc7571afe8853226094b007;
    
    uint256 constant IC14x = 0x1eeccd92a33606776db52b073d1b713de75163963720d6ddc49de771554ee655;
    uint256 constant IC14y = 0x0b38737c19d4a7562b9063f1dd231e93500f7765e2bcb9714b1be84ead7f7f77;
    
    uint256 constant IC15x = 0x06bea6229e786ab7663e5a2c280fc4821b0185a9748fd96f7650d514b9398bdc;
    uint256 constant IC15y = 0x27efd5ffa9f0b2dcd6b1c6dbc0bdc0f11d8a5feaf2ffaa39bffd132ddb8dc38d;
    
    uint256 constant IC16x = 0x0bf7e19aaa77df6209d18bce1f77e530c2bf38ffe68a98f22c4ce406ac0d3351;
    uint256 constant IC16y = 0x25a9eab05217ab802bd4a4308b2ba0ea6ef05f7701605e0ed5229109dfa3517b;
    
    uint256 constant IC17x = 0x1f095bcbba133829833607436514f29e841885b0e3bbcfc09f9da1699ad1c657;
    uint256 constant IC17y = 0x14eed25c40d238e64ae3f301d6acab1a77d2ff05d3b6f0f03b6e03289e94df5f;
    
    uint256 constant IC18x = 0x1515ceeaef8f9df4470399b35ccd91d69221e727609de4a9110dc00e39f22d9c;
    uint256 constant IC18y = 0x0b62bbfddf7c14c3275bc342b17cb49a2e5de2c8e05045be26818eb2a4cd81ce;
    
    uint256 constant IC19x = 0x16ff9f4b686347d951e1064e8706e8fe0f41104b319fc0bc7f4f875a13b85ed6;
    uint256 constant IC19y = 0x0bf42a9c94b95f66aaf8b66ec43e5a11ec70c48e280c1b4c0f13bd110a16b21a;
    
    uint256 constant IC20x = 0x0ea517a52295bae26507fac285c7816dcca8b510008c04a696a1e87a5a9319f7;
    uint256 constant IC20y = 0x1a06b2d335757ef2675adf7ec87b319188c6c1af443229c9f411ebce1cef70fc;
    
    uint256 constant IC21x = 0x12e09a6e6a55dee32e36218268c4abec564b9d178b781ad946fb8139fd9cde3f;
    uint256 constant IC21y = 0x1d9e89719f822041753a1a2541f85a28527377053d714d7bea4f3e3cea8406d1;
    
    uint256 constant IC22x = 0x0e5a9700db3775bc00ecdc6db8586c0ecd7cfdb97edfef2fa5ae92ed1058be8e;
    uint256 constant IC22y = 0x20a4568384b344614a38441027f0ecdf3780b6033ae0dddf1091c28acd6eab76;
    
    uint256 constant IC23x = 0x205b724216afba3690a8b39c5a2b568fc61ed95e08b48fe25a8c22f7246fc83c;
    uint256 constant IC23y = 0x2e4b7f5701803cc25f4e76f16fb2f1ae26ea17efced5f26184bd6a2c5afa1171;
    
    uint256 constant IC24x = 0x2894a0148c2924f5c3a818298ca8f80242c7c0a524754551ca6c36285c039dd0;
    uint256 constant IC24y = 0x1643d32372c7a98c4c86c47f311cb0579792a84bad60b233cd40454eb421bda0;
    
    uint256 constant IC25x = 0x10dbad4674dd7475cbf597bec1c17e1e6e3ee68f7aea981619201fca9b1f725b;
    uint256 constant IC25y = 0x1b4f66f0d82c7458fd3a644d2888b66b5016c44ef5ecb2193a5c20499f9ec5f4;
    
    uint256 constant IC26x = 0x16930dfe82c3163c2c3d953bf356da125abc0cb58e9985b23b16e08d4db4c866;
    uint256 constant IC26y = 0x2976940af3fc2bf4310f92fe316d8d5a6ccb3d9e7bdcc728b135d1118e131bbb;
    
    uint256 constant IC27x = 0x2dcb7db68a32abd93447ee46b1728d1e91c4b07ef1d0f3dfa3707ed3897e9c52;
    uint256 constant IC27y = 0x2af0e86a68fc31da3ac966abd25d5c48e30eab953d7f05afc61a58d65406a22b;
    
    uint256 constant IC28x = 0x05742d2fbcd9b8036006338461d383ac43816fd82b615918970c4a4fb424dc1c;
    uint256 constant IC28y = 0x0717a985d441649db03023d42ee36686235922e4a948c70a5678efcc45eef621;
    
    uint256 constant IC29x = 0x0e964b59ca73e8c103d1842801a7d5f2b06c2cb41e0e0df535ca27ed8ed0e36e;
    uint256 constant IC29y = 0x1caaa6431237220a7f3e854298dc7880cbea25b869a7c182f08e336a5eacb623;
    
    uint256 constant IC30x = 0x1f264abff753bf36009c7a2dc34fe86b73412e0a670024691a8f6ec41b9fb0a2;
    uint256 constant IC30y = 0x08d015d243c739838028a8823e3c3902fd8ec984a582a5852bf2b3dd94d2d8ed;
    
    uint256 constant IC31x = 0x24ddc720e647e56d9788021d3e5b05179425e6394d2da4e013af3fa75c15a230;
    uint256 constant IC31y = 0x00a6f202001e2c3f9b8cfa4ed98534a901e27c38973830deafd4ee64d66f3e3d;
    
    uint256 constant IC32x = 0x06f7e7a772b17fabfce1189954628e47659bb0a414212ab46dddac6e53df3f83;
    uint256 constant IC32y = 0x27c1b2c35559ba549f02d1d2479402a14abd9ca1b6fe82beb43cf1d45f0eddb7;
    
    
    // Memory data
    uint16 constant pVk = 0;
    uint16 constant pPairing = 128;

    uint16 constant pLastMem = 896;

    function verifyProof(uint[2] calldata _pA, uint[2][2] calldata _pB, uint[2] calldata _pC, uint[32] calldata _pubSignals) public view returns (bool) {
        assembly {
            function checkField(v) {
                if iszero(lt(v, r)) {
                    mstore(0, 0)
                    return(0, 0x20)
                }
            }
            
            // G1 function to multiply a G1 value(x,y) to value in an address
            function g1_mulAccC(pR, x, y, s) {
                let success
                let mIn := mload(0x40)
                mstore(mIn, x)
                mstore(add(mIn, 32), y)
                mstore(add(mIn, 64), s)

                success := staticcall(sub(gas(), 2000), 7, mIn, 96, mIn, 64)

                if iszero(success) {
                    mstore(0, 0)
                    return(0, 0x20)
                }

                mstore(add(mIn, 64), mload(pR))
                mstore(add(mIn, 96), mload(add(pR, 32)))

                success := staticcall(sub(gas(), 2000), 6, mIn, 128, pR, 64)

                if iszero(success) {
                    mstore(0, 0)
                    return(0, 0x20)
                }
            }

            function checkPairing(pA, pB, pC, pubSignals, pMem) -> isOk {
                let _pPairing := add(pMem, pPairing)
                let _pVk := add(pMem, pVk)

                mstore(_pVk, IC0x)
                mstore(add(_pVk, 32), IC0y)

                // Compute the linear combination vk_x
                
                
                g1_mulAccC(_pVk, IC1x, IC1y, calldataload(add(pubSignals, 0)))
                g1_mulAccC(_pVk, IC2x, IC2y, calldataload(add(pubSignals, 32)))
                g1_mulAccC(_pVk, IC3x, IC3y, calldataload(add(pubSignals, 64)))
                g1_mulAccC(_pVk, IC4x, IC4y, calldataload(add(pubSignals, 96)))
                g1_mulAccC(_pVk, IC5x, IC5y, calldataload(add(pubSignals, 128)))
                g1_mulAccC(_pVk, IC6x, IC6y, calldataload(add(pubSignals, 160)))
                g1_mulAccC(_pVk, IC7x, IC7y, calldataload(add(pubSignals, 192)))
                g1_mulAccC(_pVk, IC8x, IC8y, calldataload(add(pubSignals, 224)))
                g1_mulAccC(_pVk, IC9x, IC9y, calldataload(add(pubSignals, 256)))
                g1_mulAccC(_pVk, IC10x, IC10y, calldataload(add(pubSignals, 288)))
                g1_mulAccC(_pVk, IC11x, IC11y, calldataload(add(pubSignals, 320)))
                g1_mulAccC(_pVk, IC12x, IC12y, calldataload(add(pubSignals, 352)))
                g1_mulAccC(_pVk, IC13x, IC13y, calldataload(add(pubSignals, 384)))
                g1_mulAccC(_pVk, IC14x, IC14y, calldataload(add(pubSignals, 416)))
                g1_mulAccC(_pVk, IC15x, IC15y, calldataload(add(pubSignals, 448)))
                g1_mulAccC(_pVk, IC16x, IC16y, calldataload(add(pubSignals, 480)))
                g1_mulAccC(_pVk, IC17x, IC17y, calldataload(add(pubSignals, 512)))
                g1_mulAccC(_pVk, IC18x, IC18y, calldataload(add(pubSignals, 544)))
                g1_mulAccC(_pVk, IC19x, IC19y, calldataload(add(pubSignals, 576)))
                g1_mulAccC(_pVk, IC20x, IC20y, calldataload(add(pubSignals, 608)))
                g1_mulAccC(_pVk, IC21x, IC21y, calldataload(add(pubSignals, 640)))
                g1_mulAccC(_pVk, IC22x, IC22y, calldataload(add(pubSignals, 672)))
                g1_mulAccC(_pVk, IC23x, IC23y, calldataload(add(pubSignals, 704)))
                g1_mulAccC(_pVk, IC24x, IC24y, calldataload(add(pubSignals, 736)))
                g1_mulAccC(_pVk, IC25x, IC25y, calldataload(add(pubSignals, 768)))
                g1_mulAccC(_pVk, IC26x, IC26y, calldataload(add(pubSignals, 800)))
                g1_mulAccC(_pVk, IC27x, IC27y, calldataload(add(pubSignals, 832)))
                g1_mulAccC(_pVk, IC28x, IC28y, calldataload(add(pubSignals, 864)))
                g1_mulAccC(_pVk, IC29x, IC29y, calldataload(add(pubSignals, 896)))
                g1_mulAccC(_pVk, IC30x, IC30y, calldataload(add(pubSignals, 928)))
                g1_mulAccC(_pVk, IC31x, IC31y, calldataload(add(pubSignals, 960)))
                g1_mulAccC(_pVk, IC32x, IC32y, calldataload(add(pubSignals, 992)))

                // -A
                mstore(_pPairing, calldataload(pA))
                mstore(add(_pPairing, 32), mod(sub(q, calldataload(add(pA, 32))), q))

                // B
                mstore(add(_pPairing, 64), calldataload(pB))
                mstore(add(_pPairing, 96), calldataload(add(pB, 32)))
                mstore(add(_pPairing, 128), calldataload(add(pB, 64)))
                mstore(add(_pPairing, 160), calldataload(add(pB, 96)))

                // alpha1
                mstore(add(_pPairing, 192), alphax)
                mstore(add(_pPairing, 224), alphay)

                // beta2
                mstore(add(_pPairing, 256), betax1)
                mstore(add(_pPairing, 288), betax2)
                mstore(add(_pPairing, 320), betay1)
                mstore(add(_pPairing, 352), betay2)

                // vk_x
                mstore(add(_pPairing, 384), mload(add(pMem, pVk)))
                mstore(add(_pPairing, 416), mload(add(pMem, add(pVk, 32))))


                // gamma2
                mstore(add(_pPairing, 448), gammax1)
                mstore(add(_pPairing, 480), gammax2)
                mstore(add(_pPairing, 512), gammay1)
                mstore(add(_pPairing, 544), gammay2)

                // C
                mstore(add(_pPairing, 576), calldataload(pC))
                mstore(add(_pPairing, 608), calldataload(add(pC, 32)))

                // delta2
                mstore(add(_pPairing, 640), deltax1)
                mstore(add(_pPairing, 672), deltax2)
                mstore(add(_pPairing, 704), deltay1)
                mstore(add(_pPairing, 736), deltay2)


                let success := staticcall(sub(gas(), 2000), 8, _pPairing, 768, _pPairing, 0x20)


                isOk := and(success, mload(_pPairing))
            }

            let pMem := mload(0x40)
            mstore(0x40, add(pMem, pLastMem))

            // Validate that all evaluations ∈ F
            
            checkField(calldataload(add(_pubSignals, 0)))
            
            checkField(calldataload(add(_pubSignals, 32)))
            
            checkField(calldataload(add(_pubSignals, 64)))
            
            checkField(calldataload(add(_pubSignals, 96)))
            
            checkField(calldataload(add(_pubSignals, 128)))
            
            checkField(calldataload(add(_pubSignals, 160)))
            
            checkField(calldataload(add(_pubSignals, 192)))
            
            checkField(calldataload(add(_pubSignals, 224)))
            
            checkField(calldataload(add(_pubSignals, 256)))
            
            checkField(calldataload(add(_pubSignals, 288)))
            
            checkField(calldataload(add(_pubSignals, 320)))
            
            checkField(calldataload(add(_pubSignals, 352)))
            
            checkField(calldataload(add(_pubSignals, 384)))
            
            checkField(calldataload(add(_pubSignals, 416)))
            
            checkField(calldataload(add(_pubSignals, 448)))
            
            checkField(calldataload(add(_pubSignals, 480)))
            
            checkField(calldataload(add(_pubSignals, 512)))
            
            checkField(calldataload(add(_pubSignals, 544)))
            
            checkField(calldataload(add(_pubSignals, 576)))
            
            checkField(calldataload(add(_pubSignals, 608)))
            
            checkField(calldataload(add(_pubSignals, 640)))
            
            checkField(calldataload(add(_pubSignals, 672)))
            
            checkField(calldataload(add(_pubSignals, 704)))
            
            checkField(calldataload(add(_pubSignals, 736)))
            
            checkField(calldataload(add(_pubSignals, 768)))
            
            checkField(calldataload(add(_pubSignals, 800)))
            
            checkField(calldataload(add(_pubSignals, 832)))
            
            checkField(calldataload(add(_pubSignals, 864)))
            
            checkField(calldataload(add(_pubSignals, 896)))
            
            checkField(calldataload(add(_pubSignals, 928)))
            
            checkField(calldataload(add(_pubSignals, 960)))
            
            checkField(calldataload(add(_pubSignals, 992)))
            
            checkField(calldataload(add(_pubSignals, 1024)))
            

            // Validate all evaluations
            let isValid := checkPairing(_pA, _pB, _pC, _pubSignals, pMem)

            mstore(0, isValid)
            
            return(0, 0x20)
        }
    }
}


/* =============================== */
/* Nova+CycleFold Decider verifier */
/**
 * @notice  Computes the decomposition of a `uint256` into num_limbs limbs of bits_per_limb bits each.
 * @dev     Compatible with sonobe::folding-schemes::folding::circuits::nonnative::nonnative_field_to_field_elements.
 */
library LimbsDecomposition {
    function decompose(uint256 x) internal pure returns (uint256[4] memory) {
        uint256[4] memory limbs;
        for (uint8 i = 0; i < 4; i++) {
            limbs[i] = (x >> (64 * i)) & ((1 << 64) - 1);
        }
        return limbs;
    }
}

/**
 * @author  PSE & 0xPARC
 * @title   NovaDecider contract, for verifying Nova IVC SNARK proofs.
 * @dev     This is an askama template which, when templated, features a Groth16 and KZG10 verifiers from which this contract inherits.
 */
contract NovaDecider is Groth16Verifier, KZG10Verifier {
    /**
     * @notice  Computes the linear combination of a and b with r as the coefficient.
     * @dev     All ops are done mod the BN254 scalar field prime
     */
    function rlc(uint256 a, uint256 r, uint256 b) internal pure returns (uint256 result) {
        assembly {
            result := addmod(a, mulmod(r, b, BN254_SCALAR_FIELD), BN254_SCALAR_FIELD)
        }
    }

    /**
     * @notice  Verifies a nova cyclefold proof consisting of two KZG proofs and of a groth16 proof.
     * @dev     The selector of this function is "dynamic", since it depends on `z_len`.
     */
    function verifyNovaProof(
        // inputs are grouped to prevent errors due stack too deep
        uint256[3] calldata i_z0_zi, // [i, z0, zi] where |z0| == |zi|
        uint256[4] calldata U_i_cmW_U_i_cmE, // [U_i_cmW[2], U_i_cmE[2]]
        uint256[2] calldata u_i_cmW, // [u_i_cmW[2]]
        uint256[3] calldata cmT_r, // [cmT[2], r]
        uint256[2] calldata pA, // groth16 
        uint256[2][2] calldata pB, // groth16
        uint256[2] calldata pC, // groth16
        uint256[4] calldata challenge_W_challenge_E_kzg_evals, // [challenge_W, challenge_E, eval_W, eval_E]
        uint256[2][2] calldata kzg_proof // [proof_W, proof_E]
    ) public view returns (bool) {

        require(i_z0_zi[0] >= 2, "Folding: the number of folded steps should be at least 2");

        // from gamma_abc_len, we subtract 1. 
        uint256[32] memory public_inputs; 

        public_inputs[0] = 0x02d0dc8ffac5872a826112989c9ce25d4971ffe7ad07ba7b978e22906139a319;
        public_inputs[1] = i_z0_zi[0];

        for (uint i = 0; i < 2; i++) {
            public_inputs[2 + i] = i_z0_zi[1 + i];
        }

        {
            // U_i.cmW + r * u_i.cmW
            uint256[2] memory mulScalarPoint = super.mulScalar([u_i_cmW[0], u_i_cmW[1]], cmT_r[2]);
            uint256[2] memory cmW = super.add([U_i_cmW_U_i_cmE[0], U_i_cmW_U_i_cmE[1]], mulScalarPoint);

            {
                uint256[4] memory cmW_x_limbs = LimbsDecomposition.decompose(cmW[0]);
                uint256[4] memory cmW_y_limbs = LimbsDecomposition.decompose(cmW[1]);
        
                for (uint8 k = 0; k < 4; k++) {
                    public_inputs[4 + k] = cmW_x_limbs[k];
                    public_inputs[8 + k] = cmW_y_limbs[k];
                }
            }
        
            require(this.check(cmW, kzg_proof[0], challenge_W_challenge_E_kzg_evals[0], challenge_W_challenge_E_kzg_evals[2]), "KZG: verifying proof for challenge W failed");
        }

        {
            // U_i.cmE + r * cmT
            uint256[2] memory mulScalarPoint = super.mulScalar([cmT_r[0], cmT_r[1]], cmT_r[2]);
            uint256[2] memory cmE = super.add([U_i_cmW_U_i_cmE[2], U_i_cmW_U_i_cmE[3]], mulScalarPoint);

            {
                uint256[4] memory cmE_x_limbs = LimbsDecomposition.decompose(cmE[0]);
                uint256[4] memory cmE_y_limbs = LimbsDecomposition.decompose(cmE[1]);
            
                for (uint8 k = 0; k < 4; k++) {
                    public_inputs[12 + k] = cmE_x_limbs[k];
                    public_inputs[16 + k] = cmE_y_limbs[k];
                }
            }

            require(this.check(cmE, kzg_proof[1], challenge_W_challenge_E_kzg_evals[1], challenge_W_challenge_E_kzg_evals[3]), "KZG: verifying proof for challenge E failed");
        }

        {
            // add challenges
            public_inputs[20] = challenge_W_challenge_E_kzg_evals[0];
            public_inputs[21] = challenge_W_challenge_E_kzg_evals[1];
            public_inputs[22] = challenge_W_challenge_E_kzg_evals[2];
            public_inputs[23] = challenge_W_challenge_E_kzg_evals[3];

            uint256[4] memory cmT_x_limbs;
            uint256[4] memory cmT_y_limbs;
        
            cmT_x_limbs = LimbsDecomposition.decompose(cmT_r[0]);
            cmT_y_limbs = LimbsDecomposition.decompose(cmT_r[1]);
        
            for (uint8 k = 0; k < 4; k++) {
                public_inputs[20 + 4 + k] = cmT_x_limbs[k]; 
                public_inputs[24 + 4 + k] = cmT_y_limbs[k];
            }

            bool success_g16 = this.verifyProof(pA, pB, pC, public_inputs);
            require(success_g16 == true, "Groth16: verifying proof failed");
        }

        return(true);
    }
}