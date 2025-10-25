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

contract FiftySignalsGroth16Verifier {
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

    uint256 constant nPublic = 25;
    uint256 constant proofLength = 1312;
    
    bytes32 constant IC0x_0 = 0x000000000000000000000000000000001785e68b164e61d8172be69585d0be61;
    bytes32 constant IC0x_1 = 0xa435790bad0c8e75b97233bc41ad0c9be0cb04d0f3a7d1bc93d33b074614e6b2;
    bytes32 constant IC0y_0 = 0x0000000000000000000000000000000011851308486bf998e65bbe72e7c5f62f;
    bytes32 constant IC0y_1 = 0xc4dca508adf7275a3ae589e4c5e1ae94f76293e22e571daa10bf684c481a1046;
    
    bytes32 constant IC1x_0 = 0x000000000000000000000000000000000525410debba2ce9e8aa56fafe364637;
    bytes32 constant IC1x_1 = 0xd942bc7baeb2df6bea768e69534f9b5812212ffdf71ce867e9c3506c0a97b946;
    bytes32 constant IC1y_0 = 0x00000000000000000000000000000000087cb5486403731946390f5a9617c39e;
    bytes32 constant IC1y_1 = 0xa16236475ffe362d7c4f4ffaf94e74532d08075253e11e7359da474e3d495078;
    
    bytes32 constant IC2x_0 = 0x000000000000000000000000000000000d51a39fb2df5cc0c0a31c5a4d6aa8cb;
    bytes32 constant IC2x_1 = 0xa25b28152676ca018596e39a069f6413840dad8bdbc8acd67b25ffe33e218788;
    bytes32 constant IC2y_0 = 0x0000000000000000000000000000000008847da5836f182169981163d1b6ee2b;
    bytes32 constant IC2y_1 = 0x2be93e08f794dc6430855dad88bc3ff616099d15cdf2d2302e4be83d052ef161;
    
    bytes32 constant IC3x_0 = 0x0000000000000000000000000000000010e202a9002266b71d8cb43d9ee5e2cf;
    bytes32 constant IC3x_1 = 0xe7c9cb8f1c69b7417c7ed9bb507de279b528966b1ff6af2380d232de45929c68;
    bytes32 constant IC3y_0 = 0x0000000000000000000000000000000004299a7223000308e1275b936224b969;
    bytes32 constant IC3y_1 = 0x9538e90d185fb480bb1f9e3e1b5b2f83be4e413faafc56367bf54539df531930;
    
    bytes32 constant IC4x_0 = 0x0000000000000000000000000000000002cee31158938b9bb8bc6df3f7d1cd86;
    bytes32 constant IC4x_1 = 0x1c96281c0ef6106272da1f248c0cfa88df1b0435039c8ac5ccb336511d932bea;
    bytes32 constant IC4y_0 = 0x0000000000000000000000000000000001d95a9bb85a16cb9ab204dff032638b;
    bytes32 constant IC4y_1 = 0xf2baa4058d883ebba34c9d347e12a5aedddf71d815ccd61ea43b6823141f3ac9;
    
    bytes32 constant IC5x_0 = 0x000000000000000000000000000000001895db72a06e2e1a169697f43bc458c9;
    bytes32 constant IC5x_1 = 0xea700bcfce2c0c1c4005cab9587044cead68a063c16bdaa1c6d35c24ff3148c3;
    bytes32 constant IC5y_0 = 0x0000000000000000000000000000000011059be050f9a56802746a999deaf4a0;
    bytes32 constant IC5y_1 = 0x434e3caf100ab1d285c6c9928df88d6abcc8fcd5b07d689d8ece6f91e24feec3;
    
    bytes32 constant IC6x_0 = 0x000000000000000000000000000000000da7caea7e2fe6f53b4fea677b612794;
    bytes32 constant IC6x_1 = 0xe8ee76845a04176ead02bd390eb8afe91b4253f62143268185b3d1376d3d0fa3;
    bytes32 constant IC6y_0 = 0x000000000000000000000000000000000a2943bf230e7ebe4a3da52aae2d9d1e;
    bytes32 constant IC6y_1 = 0x5abb56d89b0940d844de51efca0f5fd91c22e38e6b725a68cdc34e99f5572b65;
    
    bytes32 constant IC7x_0 = 0x0000000000000000000000000000000010a7a8c65803f4bdea7ab0646768c9ce;
    bytes32 constant IC7x_1 = 0xb1faa0ea4e395d85b8c62f6acfcb325ca4cab7d87e04d084c639f001529e9c04;
    bytes32 constant IC7y_0 = 0x00000000000000000000000000000000091eb3dc31645004ecc2c828fd5b1dae;
    bytes32 constant IC7y_1 = 0x5d024b8ec9888e6910862399043dce0a39908ff85b52f36f8f276650ae212186;
    
    bytes32 constant IC8x_0 = 0x000000000000000000000000000000000e20a01e26ca22a9b14c73d3951496d0;
    bytes32 constant IC8x_1 = 0xfaebbf766f0d75f9243c80f2b56c92dc1236558d540b2b6bd76eadf9f98c09a9;
    bytes32 constant IC8y_0 = 0x000000000000000000000000000000000077384e1b2730ba569db857ac188971;
    bytes32 constant IC8y_1 = 0xfb792c5983f2ddba15ba039d20263027556fb5b140cdea65c04450cae4fc1b24;
    
    bytes32 constant IC9x_0 = 0x00000000000000000000000000000000129b900c1eb9f4d4790669661b3e7474;
    bytes32 constant IC9x_1 = 0x9a71427e225f9f28ca72d94581901b6113cd617a33331743b2e733bf372321bb;
    bytes32 constant IC9y_0 = 0x0000000000000000000000000000000012c632b5509a40e1ca46fc480263318f;
    bytes32 constant IC9y_1 = 0xa6b0d8b87a8a249822c7fbc75ac4dc7179ac0650a614d7ceed3dfe1aaa25b5ae;
    
    bytes32 constant IC10x_0 = 0x00000000000000000000000000000000046fdf9874c77b9cc0f8bd04fd3d59a2;
    bytes32 constant IC10x_1 = 0x9564ce90c9762c71338d1365292a2fe18ce604f3f6a8ff736ca84732b25e0f89;
    bytes32 constant IC10y_0 = 0x0000000000000000000000000000000019807d402a46a2e7e53b242bef9f0799;
    bytes32 constant IC10y_1 = 0x01b53fc04cac92c5d1bac3082551bb4b2ab911ab9bc8e9fe660582ae145fa927;
    
    bytes32 constant IC11x_0 = 0x00000000000000000000000000000000159a3da41a49ef937faaaf9d37a3c452;
    bytes32 constant IC11x_1 = 0xce824ba217ba6d44b0a90387d060159966c75a01f43da9bc3470e4ee6a579a23;
    bytes32 constant IC11y_0 = 0x00000000000000000000000000000000006464933ad67d8cf8fb5b54fb62b6b4;
    bytes32 constant IC11y_1 = 0x1afc9a5143f97889324281840b080dc0537e6c898bb6b6f710bedacc06e1bcb8;
    
    bytes32 constant IC12x_0 = 0x000000000000000000000000000000000ef0eb30d10b202da38044ac6e7c815d;
    bytes32 constant IC12x_1 = 0x495b274b75d23aeb090338978db398bb730a3f02a50da464fd73ea13724af536;
    bytes32 constant IC12y_0 = 0x000000000000000000000000000000000f43c455a42b4376cbb376714140586a;
    bytes32 constant IC12y_1 = 0xd5364c8c0a6da92dd8f5f6a45bcac48519ad1b66be74cdd307189b2f7c6a4c72;
    
    bytes32 constant IC13x_0 = 0x0000000000000000000000000000000007d695ecf0536828eaaf8fd643bc7ce0;
    bytes32 constant IC13x_1 = 0xc2264cef9b059baae4c971540ffb215ab18521f93576debfc7b10d57d6d50b75;
    bytes32 constant IC13y_0 = 0x0000000000000000000000000000000019cfddefb7d72f41085ec5896f1510bd;
    bytes32 constant IC13y_1 = 0x131c9d4dfea1adca1bc300778475d8c4183cfcef95d38b87af98a5429ed12ff3;
    
    bytes32 constant IC14x_0 = 0x000000000000000000000000000000000d5d0052f36cf805751f0d52e5ebac37;
    bytes32 constant IC14x_1 = 0xae6546ea1790717749f65880b57e127223295c5fc57749c0a8df6e2132baa86c;
    bytes32 constant IC14y_0 = 0x000000000000000000000000000000000d2fe5021539b02d941d6945ee1182cf;
    bytes32 constant IC14y_1 = 0x0a5a14352e2dd4a1540fc2909bcf90d36916369fa31375a9a283f33bad18e34b;
    
    bytes32 constant IC15x_0 = 0x0000000000000000000000000000000019e57689f29965890eab424a8d1c477e;
    bytes32 constant IC15x_1 = 0xd4b85e50ee212fed8dd01cd23c1b1a7ff6bdd2cdaa9d205cee40ac3d6cb215af;
    bytes32 constant IC15y_0 = 0x0000000000000000000000000000000010d4af7dac0bafb2aca7b54c5535c44c;
    bytes32 constant IC15y_1 = 0x7ded3c6f9391b4f180dbef3f0909da6e84fbdcec3221c25ee04f4187382be20d;
    
    bytes32 constant IC16x_0 = 0x000000000000000000000000000000000fa65673071c33266c049d0253c28c84;
    bytes32 constant IC16x_1 = 0xa3aa68577853eec7ce8843618aac2204cde3bbb3a36303c25ba31d439602ebd3;
    bytes32 constant IC16y_0 = 0x0000000000000000000000000000000010618bc40f060e4e812b2d149ab21dc9;
    bytes32 constant IC16y_1 = 0x306c58fb395f4243c0065083d2645c12f4bfd348c0ebb8f0aef7a61b72c67b24;
    
    bytes32 constant IC17x_0 = 0x000000000000000000000000000000000ad5ef9d0943454ca54857909697bacd;
    bytes32 constant IC17x_1 = 0x54f385936a08946dd2341c4841447630733117365c7259fc65faae405b722fca;
    bytes32 constant IC17y_0 = 0x0000000000000000000000000000000014ea706abd4210e3548876ceffe25c36;
    bytes32 constant IC17y_1 = 0x3c4c9c7b34896f4e007af6a0f0ebadc0ee46b56401fc017e07732815b3ab274c;
    
    bytes32 constant IC18x_0 = 0x000000000000000000000000000000000221e516553f5796986618c23c7afacf;
    bytes32 constant IC18x_1 = 0xf994084d5e9f6f9b7af61c7592f5273d13551a1764d355ab3cf8bff8e4c4681e;
    bytes32 constant IC18y_0 = 0x0000000000000000000000000000000018f51b2b169fdb5eba65867121f0ac5d;
    bytes32 constant IC18y_1 = 0x6e97355fd2b1138efc707a2c8040c67c08767c3fe3aa6468156f5d8aaf0f270c;
    
    bytes32 constant IC19x_0 = 0x0000000000000000000000000000000002d5ac4bc2a7deb80ac4506fccb375f4;
    bytes32 constant IC19x_1 = 0x59fcdfbeb5543ab5cd3d4929d699f46b0d9700e4742fba2736210f497417317d;
    bytes32 constant IC19y_0 = 0x000000000000000000000000000000000370d140062ee6264bcd1965ba18aec9;
    bytes32 constant IC19y_1 = 0x2fa13b98151ccf2ff71905b0a6de9745bec20fdefb18f5a68cab3bcc1d7ca79d;
    
    bytes32 constant IC20x_0 = 0x0000000000000000000000000000000004763513da96c2481cb03d44866e8ef7;
    bytes32 constant IC20x_1 = 0x7df2af24ead640a4c831bc92ad206ad6da6ae12049d7ed98b99e234405cc7bd1;
    bytes32 constant IC20y_0 = 0x000000000000000000000000000000000ce370288f7b78e344240ab0963ef12f;
    bytes32 constant IC20y_1 = 0xab2db624b98437bf82e884433472f536303f2e3bef9160081f596bcbd03a68c1;
    
    bytes32 constant IC21x_0 = 0x000000000000000000000000000000000622c0c2bc4269c754c55d0547817e0d;
    bytes32 constant IC21x_1 = 0x70de8a72f795d5e65a7e0b0cc8e78931343652c47d35b3b398ece1bcf71880ea;
    bytes32 constant IC21y_0 = 0x000000000000000000000000000000000ab06d86462c73267b7b7cc3eceb4132;
    bytes32 constant IC21y_1 = 0x28b9584ae5a7a21108bb59c7dc0aae61fb1e2248b3e69337cc28541ff1887d73;
    
    bytes32 constant IC22x_0 = 0x000000000000000000000000000000000b2a1fa9072e5d7ef464c85fd588c4b1;
    bytes32 constant IC22x_1 = 0xe6d7f6a3611d156cba4824a5dd50a527ae64c1590e247cd4b36b28f79344df80;
    bytes32 constant IC22y_0 = 0x0000000000000000000000000000000010270c41727dd12fee6738f7fce3f41f;
    bytes32 constant IC22y_1 = 0x99e6ce2dec720eeabba250b4ce0fa048d070fd4f4ea8221c2f8ad585ddd408c5;
    
    bytes32 constant IC23x_0 = 0x000000000000000000000000000000001414ec6440a7366c3d388a728fca1978;
    bytes32 constant IC23x_1 = 0x60d9ccdd148cff90ed0a37fcb369e856b7c21ec63998263cd62a96faacb7eca1;
    bytes32 constant IC23y_0 = 0x00000000000000000000000000000000016b6adff9043e41bf7991deb4435e19;
    bytes32 constant IC23y_1 = 0x8259d04c01664426e813e67834bd88e5f8c71e32fcf43356c82b9a7130140af4;
    
    bytes32 constant IC24x_0 = 0x0000000000000000000000000000000014c73fd65a05479a6812b0a5ba4ccde2;
    bytes32 constant IC24x_1 = 0x0030ce0b21f5d517d5344bb0424b33a1df914d3dfd978d14ab4bf27065147289;
    bytes32 constant IC24y_0 = 0x0000000000000000000000000000000001a3ba6bc8f52eaf1a73423a282a4a11;
    bytes32 constant IC24y_1 = 0xf696d65b8a1679f168c237e01da611a255873c484f56109a402f7da6e6e00e0b;
    
    bytes32 constant IC25x_0 = 0x000000000000000000000000000000000c1236eca89e884a086bad53eb1bc704;
    bytes32 constant IC25x_1 = 0x54f5b96e8230e9f8fc9dc41fb178902255de63f29bc2f8ff53c5aa2de01dcf67;
    bytes32 constant IC25y_0 = 0x000000000000000000000000000000000c4cc86fa8c815517267369d61541ef8;
    bytes32 constant IC25y_1 = 0xf42a4ad9b5203d857c7f115db354e78f84707710ed8c4fbf519cd56b986ed9a7;
    

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
            
            mstore(800, IC6x_0)
            mstore(832, IC6x_1)
            mstore(864, IC6y_0)
            mstore(896, IC6y_1)
            tmp := calldataload(add(o, 672))
            checkField(tmp)
            mstore(928, tmp)
            
            mstore(960, IC7x_0)
            mstore(992, IC7x_1)
            mstore(1024, IC7y_0)
            mstore(1056, IC7y_1)
            tmp := calldataload(add(o, 704))
            checkField(tmp)
            mstore(1088, tmp)
            
            mstore(1120, IC8x_0)
            mstore(1152, IC8x_1)
            mstore(1184, IC8y_0)
            mstore(1216, IC8y_1)
            tmp := calldataload(add(o, 736))
            checkField(tmp)
            mstore(1248, tmp)
            
            mstore(1280, IC9x_0)
            mstore(1312, IC9x_1)
            mstore(1344, IC9y_0)
            mstore(1376, IC9y_1)
            tmp := calldataload(add(o, 768))
            checkField(tmp)
            mstore(1408, tmp)
            
            mstore(1440, IC10x_0)
            mstore(1472, IC10x_1)
            mstore(1504, IC10y_0)
            mstore(1536, IC10y_1)
            tmp := calldataload(add(o, 800))
            checkField(tmp)
            mstore(1568, tmp)
            
            mstore(1600, IC11x_0)
            mstore(1632, IC11x_1)
            mstore(1664, IC11y_0)
            mstore(1696, IC11y_1)
            tmp := calldataload(add(o, 832))
            checkField(tmp)
            mstore(1728, tmp)
            
            mstore(1760, IC12x_0)
            mstore(1792, IC12x_1)
            mstore(1824, IC12y_0)
            mstore(1856, IC12y_1)
            tmp := calldataload(add(o, 864))
            checkField(tmp)
            mstore(1888, tmp)
            
            mstore(1920, IC13x_0)
            mstore(1952, IC13x_1)
            mstore(1984, IC13y_0)
            mstore(2016, IC13y_1)
            tmp := calldataload(add(o, 896))
            checkField(tmp)
            mstore(2048, tmp)
            
            mstore(2080, IC14x_0)
            mstore(2112, IC14x_1)
            mstore(2144, IC14y_0)
            mstore(2176, IC14y_1)
            tmp := calldataload(add(o, 928))
            checkField(tmp)
            mstore(2208, tmp)
            
            mstore(2240, IC15x_0)
            mstore(2272, IC15x_1)
            mstore(2304, IC15y_0)
            mstore(2336, IC15y_1)
            tmp := calldataload(add(o, 960))
            checkField(tmp)
            mstore(2368, tmp)
            
            mstore(2400, IC16x_0)
            mstore(2432, IC16x_1)
            mstore(2464, IC16y_0)
            mstore(2496, IC16y_1)
            tmp := calldataload(add(o, 992))
            checkField(tmp)
            mstore(2528, tmp)
            
            mstore(2560, IC17x_0)
            mstore(2592, IC17x_1)
            mstore(2624, IC17y_0)
            mstore(2656, IC17y_1)
            tmp := calldataload(add(o, 1024))
            checkField(tmp)
            mstore(2688, tmp)
            
            mstore(2720, IC18x_0)
            mstore(2752, IC18x_1)
            mstore(2784, IC18y_0)
            mstore(2816, IC18y_1)
            tmp := calldataload(add(o, 1056))
            checkField(tmp)
            mstore(2848, tmp)
            
            mstore(2880, IC19x_0)
            mstore(2912, IC19x_1)
            mstore(2944, IC19y_0)
            mstore(2976, IC19y_1)
            tmp := calldataload(add(o, 1088))
            checkField(tmp)
            mstore(3008, tmp)
            
            mstore(3040, IC20x_0)
            mstore(3072, IC20x_1)
            mstore(3104, IC20y_0)
            mstore(3136, IC20y_1)
            tmp := calldataload(add(o, 1120))
            checkField(tmp)
            mstore(3168, tmp)
            
            mstore(3200, IC21x_0)
            mstore(3232, IC21x_1)
            mstore(3264, IC21y_0)
            mstore(3296, IC21y_1)
            tmp := calldataload(add(o, 1152))
            checkField(tmp)
            mstore(3328, tmp)
            
            mstore(3360, IC22x_0)
            mstore(3392, IC22x_1)
            mstore(3424, IC22y_0)
            mstore(3456, IC22y_1)
            tmp := calldataload(add(o, 1184))
            checkField(tmp)
            mstore(3488, tmp)
            
            mstore(3520, IC23x_0)
            mstore(3552, IC23x_1)
            mstore(3584, IC23y_0)
            mstore(3616, IC23y_1)
            tmp := calldataload(add(o, 1216))
            checkField(tmp)
            mstore(3648, tmp)
            
            mstore(3680, IC24x_0)
            mstore(3712, IC24x_1)
            mstore(3744, IC24y_0)
            mstore(3776, IC24y_1)
            tmp := calldataload(add(o, 1248))
            checkField(tmp)
            mstore(3808, tmp)
            
            mstore(3840, IC25x_0)
            mstore(3872, IC25x_1)
            mstore(3904, IC25y_0)
            mstore(3936, IC25y_1)
            tmp := calldataload(add(o, 1280))
            checkField(tmp)
            mstore(3968, tmp)
            
            // vk
            let success := staticcall(sub(gas(), 2000), G1_MSM_PRECOMPILE, 0, 4160, 0, 128)
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