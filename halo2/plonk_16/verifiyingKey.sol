// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Halo2VerifyingKey {
    constructor() {
        assembly {
            mstore(0x0000, 0x03974da9ccb9fe4e28afb5a60d6110a0e3592e3732e9218594870ec34755367d) // vk_digest
            mstore(0x0020, 0x0000000000000000000000000000000000000000000000000000000000000010) // num_instances
            mstore(0x0040, 0x0000000000000000000000000000000000000000000000000000000000000010) // k
            mstore(0x0060, 0x30641e0e92bebef818268d663bcad6dbcfd6c0149170f6d7d350b1b1fa6c1001) // n_inv
            mstore(0x0080, 0x09d2cc4b5782fbe923e49ace3f647643a5f5d8fb89091c3ababd582133584b29) // omega
            mstore(0x00a0, 0x0cf312e84f2456134e812826473d3dfb577b2bfdba762aba88b47b740472c1f0) // omega_inv
            mstore(0x00c0, 0x17cbd779ed6ea1b8e9dbcde0345b2cfdb96e80bea0dd1318bdd0e183a00e0492) // omega_inv_to_l
            mstore(0x00e0, 0x0000000000000000000000000000000000000000000000000000000000000000) // has_accumulator
            mstore(0x0100, 0x0000000000000000000000000000000000000000000000000000000000000000) // acc_offset
            mstore(0x0120, 0x0000000000000000000000000000000000000000000000000000000000000000) // num_acc_limbs
            mstore(0x0140, 0x0000000000000000000000000000000000000000000000000000000000000000) // num_acc_limb_bits
            mstore(0x0160, 0x0000000000000000000000000000000000000000000000000000000000000001) // g1_x
            mstore(0x0180, 0x0000000000000000000000000000000000000000000000000000000000000002) // g1_y
            mstore(0x01a0, 0x198e9393920d483a7260bfb731fb5d25f1aa493335a9e71297e485b7aef312c2) // g2_x_1
            mstore(0x01c0, 0x1800deef121f1e76426a00665e5c4479674322d4f75edadd46debd5cd992f6ed) // g2_x_2
            mstore(0x01e0, 0x090689d0585ff075ec9e99ad690c3395bc4b313370b38ef355acdadcd122975b) // g2_y_1
            mstore(0x0200, 0x12c85ea5db8c6deb4aab71808dcb408fe3d1e7690c43d37b4ce6cc0166fa7daa) // g2_y_2
            mstore(0x0220, 0x17cb08598d7d1bbdf168ae6dde544462e08199af30dd25f5defa5096624acbe0) // neg_s_g2_x_1
            mstore(0x0240, 0x1b626193b86dde481f33f2a5bbee958ca7a38a89f886df3cd39c46c29f239153) // neg_s_g2_x_2
            mstore(0x0260, 0x0f7eef4f890f1b3f5a2e9386f655b63eb4e3228f8ded1e862e8a8cb84ec0ee56) // neg_s_g2_y_1
            mstore(0x0280, 0x0db29b64a1bd1ad5f8757f2d65d4e5daf154a4297ef88a1574065dd648582a3f) // neg_s_g2_y_2
            mstore(0x02a0, 0x1792ea02a8e09ec552a1c2156858f9b6639bb2b704b2d56b9daeafce5105549a) // fixed_comms[0].x
            mstore(0x02c0, 0x10b573b29f0727e8d64d5742051086473ae9c82742fc7a48f98ea86b8e68e8ce) // fixed_comms[0].y
            mstore(0x02e0, 0x284173c25f35ef240b2b5bef88516b0d8cd40a33e08f749b91082e2930ce0996) // fixed_comms[1].x
            mstore(0x0300, 0x0643a6dd9f9e24dfb18fdc6cac68fe81cf6e02cd3fe0ec7f644322a8463b9813) // fixed_comms[1].y
            mstore(0x0320, 0x1ca3b22fd2ba1931d8f12db865821313e287dac3430d94759faddbdd5da7d508) // fixed_comms[2].x
            mstore(0x0340, 0x11be08dd2c6769bd3c1014ab59bfc6fbfca7c594fcb1d4a6e2562145bcdd6f85) // fixed_comms[2].y
            mstore(0x0360, 0x2f59ca0b95ca562275fc5a24df8d5a2dfa8b3584e1faf7c4a2a913f09f1aaa83) // fixed_comms[3].x
            mstore(0x0380, 0x163fa0ff8718f1b4d0c2f97381067bf3aa43b70cecd348fce2f0efaa83c57b5e) // fixed_comms[3].y
            mstore(0x03a0, 0x203e9563a92efab74df39b66544789808bd906d9e20f249e10de5445d4f2d7fc) // fixed_comms[4].x
            mstore(0x03c0, 0x29826f1c65f07c26d2ec497a40e634da76c7152ed8f18110598e6da0c00b6c79) // fixed_comms[4].y
            mstore(0x03e0, 0x2c43a2d6fe0e3d596ef027ba02a56b1a76be3d324390e5b0b8c075900c4d55ee) // permutation_comms[0].x
            mstore(0x0400, 0x2341a1c177f71bd95883ab85bdcad25d6f2b0a2433829209e6b0fe9724174af2) // permutation_comms[0].y
            mstore(0x0420, 0x0673393b6b971775998ddd90e0297c593566f01d35ab5548843799190f13fb9b) // permutation_comms[1].x
            mstore(0x0440, 0x1e55426ed44759e76c4c77cdf9fe74caad75c2f3fd44ee9a5f6046d2ee56551d) // permutation_comms[1].y
            mstore(0x0460, 0x098e8c477fada8fe9a9dbad0a51f0f1f636dad3061c32c52c8ce6cd5e5583f6d) // permutation_comms[2].x
            mstore(0x0480, 0x120d12b54320727865d6a78d824152f7887db8398b0b304d2d518f7d18a79c00) // permutation_comms[2].y

            return(0, 0x04a0)
        }
    }
}