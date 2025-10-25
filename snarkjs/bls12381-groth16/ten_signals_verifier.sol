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

contract TenSignalsGroth16Verifier {
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

    uint256 constant nPublic = 5;
    uint256 constant proofLength = 672;
    
    bytes32 constant IC0x_0 = 0x00000000000000000000000000000000020c401aec61f537689883d26150945d;
    bytes32 constant IC0x_1 = 0xceaacc1c90675dedb3a49434e6d1fdd436e9b095d8d596c182132b6a8d839bce;
    bytes32 constant IC0y_0 = 0x00000000000000000000000000000000100ecbd611dec276d072773d8da0e8b0;
    bytes32 constant IC0y_1 = 0xdd09582e972f5911bb1d238bbbbb701eb72b22c7d5445bd5315c013d62e45a78;
    
    bytes32 constant IC1x_0 = 0x000000000000000000000000000000000a46d94293cdb56eef984ededad7ae2b;
    bytes32 constant IC1x_1 = 0x739f553531c25295e517922358da6a708e87b9fc0b1901fa6a03620575c7a278;
    bytes32 constant IC1y_0 = 0x00000000000000000000000000000000059e8959449d185f1fa2bfa6cb86325e;
    bytes32 constant IC1y_1 = 0xff7d03936a14afa32234b7f80ff6f1a300ace53172bcaff3df4a850d8ac2b965;
    
    bytes32 constant IC2x_0 = 0x0000000000000000000000000000000009ca34dd33f92f5ad30482fd9b4482f9;
    bytes32 constant IC2x_1 = 0x6e7cb953f100e85ba27038baa6fbaa10366da4e67c59f9e06ba6b0c3f469784c;
    bytes32 constant IC2y_0 = 0x0000000000000000000000000000000007503f90e29b965bf9c32b198cd72efb;
    bytes32 constant IC2y_1 = 0x2a415a3236d797ad60611ce9c49bd4417073894fb0f31b33cc835b466ef2d361;
    
    bytes32 constant IC3x_0 = 0x0000000000000000000000000000000012b452a1947239ea3af18e91e3ba72c0;
    bytes32 constant IC3x_1 = 0xfaa68b5543fa25b1b14fcb0f2476c394bb5abf509b98e9f9849bfaaa7413cfb6;
    bytes32 constant IC3y_0 = 0x0000000000000000000000000000000001b268f92eee8ffba47c337ebe18b44b;
    bytes32 constant IC3y_1 = 0xa87602c5bc8afaffe7e74f943e5ea30663ef8990e9f91150b99f49640db15e6c;
    
    bytes32 constant IC4x_0 = 0x000000000000000000000000000000000aa11e07362d116fb93597d7a4afbe45;
    bytes32 constant IC4x_1 = 0x16fc66bb4cdc2a922d23738816e858cd8353ed3d24f21a182fe67facc289bee4;
    bytes32 constant IC4y_0 = 0x00000000000000000000000000000000016d971bad3efafc6b76e14dcbaaaae4;
    bytes32 constant IC4y_1 = 0xaae1c94fbc47524f39350d264e09711ec2294f808cc22076954dce9f80a90d41;
    
    bytes32 constant IC5x_0 = 0x0000000000000000000000000000000011c7fb62fb3ee911d594cfd78badc364;
    bytes32 constant IC5x_1 = 0xa2e37930ff5c1cd6212af39a444c3f35baa2ab03d69ff092454a0016cf31259f;
    bytes32 constant IC5y_0 = 0x0000000000000000000000000000000016d161f5ed9f3fe50e070ce9f5049d4c;
    bytes32 constant IC5y_1 = 0x69f7fb98288bf88881f0e25ea685b65153477a54db86f693ee2d6f14562c269e;
    

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
            
            mstore(320, IC3x_0)
            mstore(352, IC3x_1)
            mstore(384, IC3y_0)
            mstore(416, IC3y_1)
            tmp := calldataload(add(o, 576))
            checkField(tmp)
            mstore(448, tmp)
            
            mstore(480, IC4x_0)
            mstore(512, IC4x_1)
            mstore(544, IC4y_0)
            mstore(576, IC4y_1)
            tmp := calldataload(add(o, 608))
            checkField(tmp)
            mstore(608, tmp)
            
            mstore(640, IC5x_0)
            mstore(672, IC5x_1)
            mstore(704, IC5y_0)
            mstore(736, IC5y_1)
            tmp := calldataload(add(o, 640))
            checkField(tmp)
            mstore(768, tmp)
            
            // vk
            let success := staticcall(sub(gas(), 2000), G1_MSM_PRECOMPILE, 0, 960, 0, 128)
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