// SPDX-License-Identifier: GPL-3.0
// Author: Rubydusa 2025
/*
    This file is generated with [snarkJS](https://github.com/iden3/snarkjs).

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

pragma solidity >=0.7.0 <0.9.0;

contract SumProductGroth16Verifier {
    // precompiles
    uint256 constant G1_ADD_PRECOMPILE = 11;
    uint256 constant G1_MSM_PRECOMPILE = 12;
    uint256 constant PAIRING_PRECOMPILE = 15;
    // Main subgroup order
    uint256 constant q = 0x73eda753299d7d483339d80809a1d80553bda402fffe5bfeffffffff00000001;

    // Verification Key data
    bytes32 constant alphax_0  = 0x00000000000000000000000000000000014903ce877dbd6e1164182714bbaa38;
    bytes32 constant alphax_1  = 0xfb2e902d82ad2b235e8dab2ede24fb15ac8f9813389c992a107d075b51f6846a;
    bytes32 constant alphay_0  = 0x000000000000000000000000000000001769de2c3e8f9953dca4d4584197bee5;
    bytes32 constant alphay_1  = 0xf0a8f91992bab8cc1aa2d7a1c2d2e4c2707d33d7e015f3f38d409202718c0a76;
    
    bytes32 constant betax1_0  = 0x0000000000000000000000000000000013dbebe0c50eb843943a67d6330c6d71;
    bytes32 constant betax1_1  = 0x2f4e0edf2e3b670a3d79f46c998d045c98b6a1a8a8be1e8295f07dad97ea9d68;
    bytes32 constant betay1_0  = 0x00000000000000000000000000000000037169704c2fb28b32dd7ad23f0c15e7;
    bytes32 constant betay1_1  = 0x7a6239be5f5368b203c50e6fe43c190079f675c7996d0f4f62280e8c26a10775;
    bytes32 constant betax2_0  = 0x00000000000000000000000000000000111b1f2f98cf0e4314d546b2f8aa2beb;
    bytes32 constant betax2_1  = 0x553021ed2cd78566b69dd1bab89172d5639c19a89aff3fa9a4e414e41938fabb;
    bytes32 constant betay2_0  = 0x000000000000000000000000000000000a6eee141afd80b17dec6796bb5c1c80;
    bytes32 constant betay2_1  = 0x49a5b087a81cf16c4a9f638134c8a4bbb7d0ec36440416c35e9e339d9918082c;

    bytes32 constant gammax1_0 = 0x00000000000000000000000000000000024aa2b2f08f0a91260805272dc51051;
    bytes32 constant gammax1_1 = 0xc6e47ad4fa403b02b4510b647ae3d1770bac0326a805bbefd48056c8c121bdb8;
    bytes32 constant gammay1_0 = 0x0000000000000000000000000000000013e02b6052719f607dacd3a088274f65;
    bytes32 constant gammay1_1 = 0x596bd0d09920b61ab5da61bbdc7f5049334cf11213945d57e5ac7d055d042b7e;
    bytes32 constant gammax2_0 = 0x000000000000000000000000000000000ce5d527727d6e118cc9cdc6da2e351a;
    bytes32 constant gammax2_1 = 0xadfd9baa8cbdd3a76d429a695160d12c923ac9cc3baca289e193548608b82801;
    bytes32 constant gammay2_0 = 0x000000000000000000000000000000000606c4a02ea734cc32acd2b02bc28b99;
    bytes32 constant gammay2_1 = 0xcb3e287e85a763af267492ab572e99ab3f370d275cec1da1aaa9075ff05f79be;

    bytes32 constant deltax1_0 = 0x00000000000000000000000000000000024aa2b2f08f0a91260805272dc51051;
    bytes32 constant deltax1_1 = 0xc6e47ad4fa403b02b4510b647ae3d1770bac0326a805bbefd48056c8c121bdb8;
    bytes32 constant deltay1_0 = 0x0000000000000000000000000000000013e02b6052719f607dacd3a088274f65;
    bytes32 constant deltay1_1 = 0x596bd0d09920b61ab5da61bbdc7f5049334cf11213945d57e5ac7d055d042b7e;
    bytes32 constant deltax2_0 = 0x000000000000000000000000000000000ce5d527727d6e118cc9cdc6da2e351a;
    bytes32 constant deltax2_1 = 0xadfd9baa8cbdd3a76d429a695160d12c923ac9cc3baca289e193548608b82801;
    bytes32 constant deltay2_0 = 0x000000000000000000000000000000000606c4a02ea734cc32acd2b02bc28b99;
    bytes32 constant deltay2_1 = 0xcb3e287e85a763af267492ab572e99ab3f370d275cec1da1aaa9075ff05f79be;

    uint256 constant nPublic = 2;
    uint256 constant proofLength = 576;
    
    bytes32 constant IC0x_0 = 0x0000000000000000000000000000000011077b55d4c4b739cb07812c3a30e13d;
    bytes32 constant IC0x_1 = 0x904499cee432deed6e7f07f41b857108e77753308dda37ef2a73e0db2644e00f;
    bytes32 constant IC0y_0 = 0x0000000000000000000000000000000000024cfaba9f4f00f93fda896f02b53b;
    bytes32 constant IC0y_1 = 0x1b1d134653d11b03a9dee2de2cbb0d0d18aab2ae753155957a82f1d244549ab6;
    
    bytes32 constant IC1x_0 = 0x00000000000000000000000000000000153caf1592aef235dd0a53c6b69829da;
    bytes32 constant IC1x_1 = 0xf351b0081916363d8de6cf709a19afde7be07a9805982f283d3be1355ff7b786;
    bytes32 constant IC1y_0 = 0x0000000000000000000000000000000017f9f9b784eb476c929d4f18164c756e;
    bytes32 constant IC1y_1 = 0x62f4e70ea121b9d9fca630b9bc5f216612958614815934d8aedc11a75b35655f;
    
    bytes32 constant IC2x_0 = 0x000000000000000000000000000000000b2286f924501cf75a3f11cb81e47f27;
    bytes32 constant IC2x_1 = 0x12b136f86e4062bccd6f6ce86fa89f91de267a89ea19f2dbb9cf56255dec3331;
    bytes32 constant IC2y_0 = 0x000000000000000000000000000000001774449d683d6585dc04e5562a77ae71;
    bytes32 constant IC2y_1 = 0xed7cd827be25e4ee62a26e000f5395aaec9f93e2a278ac72cdc8511ba05187b2;
    

    bytes4 constant ERROR_NOT_IN_FIELD = 0x81452424;  // cast sig "NotInField(uint256)"
    bytes4 constant ERROR_INVALID_PROOF_LENGTH = 0x4dc5f6a4;  // cast sig "InvalidProofLength()"
    bytes4 constant ERROR_G1_MSM_FAILED = 0x5f776986;  // cast sig "G1MSMFailed()"
    bytes4 constant ERROR_G1_ADD_FAILED = 0xd6cc76eb;  // cast sig "G1AddFailed()"
    bytes4 constant ERROR_PAIRING_FAILED = 0x4df45e2f;  // cast sig "PairingFailed()"

    // proof structure:
    // negA: 128 bytes
    // B: 256 bytes
    // C: 128 bytes
    // pubSignals: 32 * nPublic bytes
    function verifyProof(bytes calldata proof) public view returns (bool){
        assembly {
            function checkField(v) {
                if iszero(lt(v, q)) {
                    mstore(0, ERROR_NOT_IN_FIELD)
                    mstore(4, v)
                    revert(0, 0x24)
                }
            }

            // check proof length
            if iszero(eq(proof.length, proofLength)) {
                mstore(0, ERROR_INVALID_PROOF_LENGTH)
                revert(0, 0x04)
            }

            let tmp := 0
            let o := proof.offset
            // msm of pub signals (skipping IC0)
            
            mstore(0, IC1x_0)
            mstore(32, IC1x_1)
            mstore(64, IC1y_0)
            mstore(96, IC1y_1)
            tmp := calldataload(add(o, 512))
            checkField(tmp)
            mstore(128, tmp)
            
            mstore(160, IC2x_0)
            mstore(192, IC2x_1)
            mstore(224, IC2y_0)
            mstore(256, IC2y_1)
            tmp := calldataload(add(o, 544))
            checkField(tmp)
            mstore(288, tmp)
            
            // vk
            let success := staticcall(sub(gas(), 2000), G1_MSM_PRECOMPILE, 0, 480, 0, 128)
            if iszero(success) {
                mstore(0, ERROR_G1_MSM_FAILED)
                revert(0, 0x04)
            }

            mstore(128, IC0x_0)
            mstore(160, IC0x_1)
            mstore(192, IC0y_0)
            mstore(224, IC0y_1)
            // add IC0 to the result of the MSM
            success := staticcall(sub(gas(), 2000), G1_ADD_PRECOMPILE, 0, 256, 0, 128)
            // in practice this error should never happen, only if the precompile is broken
            if iszero(success) {
                mstore(0, ERROR_G1_ADD_FAILED)
                revert(0, 0x04)
            }

            // https://www.zeroknowledgeblog.com/index.php/groth16
            // e(vk, gamma) * e(C, delta) * e(alpha, beta) * e(-A, B) == 1

            // gamma
            mstore(128, gammax1_0)
            mstore(160, gammax1_1)
            mstore(192, gammay1_0)
            mstore(224, gammay1_1)
            mstore(256, gammax2_0)
            mstore(288, gammax2_1)
            mstore(320, gammay2_0)
            mstore(352, gammay2_1)
            // C
            calldatacopy(384, add(o, 384), 128)
            // delta
            mstore(512, deltax1_0)
            mstore(544, deltax1_1)
            mstore(576, deltay1_0)
            mstore(608, deltay1_1)
            mstore(640, deltax2_0)
            mstore(672, deltax2_1)
            mstore(704, deltay2_0)
            mstore(736, deltay2_1)
            // alpha
            mstore(768, alphax_0)
            mstore(800, alphax_1)
            mstore(832, alphay_0)
            mstore(864, alphay_1)
            // beta
            mstore(896, betax1_0)
            mstore(928, betax1_1)
            mstore(960, betay1_0)
            mstore(992, betay1_1)
            mstore(1024, betax2_0)
            mstore(1056, betax2_1)
            mstore(1088, betay2_0)
            mstore(1120, betay2_1)
            // e(-A, B)
            calldatacopy(1152, o, 384)

            // result of pairing check is saved to offset 0
            success := staticcall(sub(gas(), 2000), PAIRING_PRECOMPILE, 0, 1536, 0, 32)
            if iszero(success) {
                mstore(0, ERROR_PAIRING_FAILED)
                revert(0, 0x04)
            }

            return(0, 0x20)
        }
    }
}