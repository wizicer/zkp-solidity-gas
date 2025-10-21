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

contract Groth16Verifier {
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

    uint256 constant nPublic = 1;
    uint256 constant proofLength = 544;
    
    bytes32 constant IC0x_0 = 0x000000000000000000000000000000000b0304bd45414d17e9b4bff6c54c6536;
    bytes32 constant IC0x_1 = 0x33221268300f8ac4129208fb1fcfc209df3d8452f21c7f2c12f404096c7de5a4;
    bytes32 constant IC0y_0 = 0x0000000000000000000000000000000019a335feb6e1189f3f996268a5515d8d;
    bytes32 constant IC0y_1 = 0x64f75954f19f2a9f9b591451e6a848deed97062776b5d9d35098a1ade4947114;
    
    bytes32 constant IC1x_0 = 0x0000000000000000000000000000000015933376fb8617419410029045bb0410;
    bytes32 constant IC1x_1 = 0x6926696ce4403944d93be25c8ad5ded73f67417590fc8eede7edc456721278f3;
    bytes32 constant IC1y_0 = 0x00000000000000000000000000000000020e35670d3310465844a8dd796ff22b;
    bytes32 constant IC1y_1 = 0x59716b159cfbc0bb84ca4cd26b0f87f377e6a368d2c8340d4125b3d6e68e0cb2;
    

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
            
            // vk
            let success := staticcall(sub(gas(), 2000), G1_MSM_PRECOMPILE, 0, 320, 0, 128)
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