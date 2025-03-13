# ZKP System Solidity Gas Estimation Report

## Executive Summary

This report provides a comprehensive analysis of gas consumption for various Zero-Knowledge Proof (ZKP) systems implemented in Solidity. The analysis includes deployment costs, function execution costs, and local VM view gas measurements across different frameworks and schemas.

## Comparative Analysis

### Gas Consumption by Framework and Schema

| Framework | Schema | Public inputs | Local VM View Gas | Sepolia deployment gas | Sepolia function gas |
|-----------|--------|---------------|-------------------|------------------------|----------------------|
| gnark | groth16 | 2 | 195,099 | [1,917,298](https://sepolia.etherscan.io/tx/0xa34994b804de55ce34874b474664ee4aa3978aa8508f6889cfd8f40e65d1517c) | [220,583](https://sepolia.etherscan.io/tx/0x9051e844827afe3190b90019237db1ff3945ccc1d79a62d06a72283bc2cda430) |
| gnark | groth16(compressed proof) | 2 | - | [1,945,169](https://sepolia.etherscan.io/tx/0x9a29c2a43c6b2a36c757eb8744d269bd0c496b5c79e9db7bff740deb22e59d8a) | [231,209](https://sepolia.etherscan.io/tx/0xd5e92676401e0845288460d9063bb8345d60e6a9ff6a435d800016d12be1333d) |
| gnark | groth16 with pedersen | 1 | - | [1,439,031](https://sepolia.etherscan.io/tx/0xe0dba53364c77da07bd9757ea2ff51095a37f7d58057ac5a208dd3d71c6b41da) | [337,291](https://sepolia.etherscan.io/tx/0xfcce5d59ad5b7c353005ba6e99f1e77616905dda01a043cf49d91d981acd8dc8) |
| gnark | groth16(compressed with pedersen) | 1 | - | [1,439,031](https://sepolia.etherscan.io/tx/0xe0dba53364c77da07bd9757ea2ff51095a37f7d58057ac5a208dd3d71c6b41da) | [350,842](https://sepolia.etherscan.io/tx/0xd18c9d7f299ef2c8eed1e201c3939d35e0a25972394f0200b17b245f14d7f3f4) |
| gnark | plonk | 2 | 253,087 | [2,083,848](https://sepolia.etherscan.io/tx/0x247ae04e4bf98eabbdf0784186ea5019acd3e9c1ae4f3274c432a5b705399b7c) | [287,310](https://sepolia.etherscan.io/tx/0x6c90a60423a45f485f37317987ac71aedb8bf4752063353e46b5da872fea385e) |
| snarkjs | groth16 | 2 | 195,836 | [412,528](https://sepolia.etherscan.io/tx/0xf84b681beaefaabb61d58f1438699f7e0f748f0bbbf72883eab4bfe0459aa571) | [221,305](https://sepolia.etherscan.io/tx/0xed13868b1fc7295670dc8f9207741ea65f2bef171729c0fb5d3c30bc4ffb7469) |
| snarkjs | plonk | 2 | 256,348 | [1,591,128](https://sepolia.etherscan.io/tx/0xa98f9803fcf58b6078ac6412fcde4a368a5bed2dd53ebde546295fd6263df5f5) | [291,197](https://sepolia.etherscan.io/tx/0xa8aa27480db7365c6480b910f9bdc8644e783ae695f38a575b119bb06faa2480) |
| snarkjs | fflonk | 2 | 167,842 | [5,273,847](https://sepolia.etherscan.io/tx/0x1d88872a4dcf13e4430d566d7cde3a24496668af37c963cc4c3b7fa7db182292) | [201,077](https://sepolia.etherscan.io/tx/0x7a2faddaef2c326a0059b701c18b52886d8adff53807fd504569c73d778d4d20) |
| noir | plonk | 1 | - | [2,571,102](https://sepolia.etherscan.io/tx/0x12be521b2a46feef18d1c24e5bd38af68e19c3972b01a8c6d9664f613c20cd79) | [441,681](https://sepolia.etherscan.io/tx/0x5a157daa6bd70dd6ba80e5243a5e73acde5c385e4302fdf979f92b866446d596) |
| halo2 | plonk(degree:16) | 16 | - | [308,351](https://sepolia.etherscan.io/tx/0x2e3638cc31222b22f408332fc2ba5e9a6b6d23c76b906231685dad3b18cd858a) + [828,497](https://sepolia.etherscan.io/tx/0x5a7a1ef3ff5c0b77bbbdd4bbeab7a2f1a7b72b039d30f22fb56bf64eeee9a869) | [321,377](https://sepolia.etherscan.io/tx/0x5167bfe66630eb86f565bfa6432b591a26faec9e32271117aef68ee077715e6b) |
| halo2 | plonk(degree:16) | 2 | - | [308,315](https://sepolia.etherscan.io/tx/0x90a3f738dd7e519f6da3ec3a7039dca17efb081023315aa6818db30e506dceeb) + [828,497](https://sepolia.etherscan.io/tx/0xdc4909c90306c8d09d0ffc316239f72d444660e539ffcc33f0fcaf331201e82e) | [305,073](https://sepolia.etherscan.io/tx/0xabe5b457a62f8b8662937b4a103286e2111472600f2aeac1ca97b2434d47ab67) |
| halo2 | plonk(degree:16, efixed:200) | 2 | - | [2,904,633](https://sepolia.etherscan.io/tx/0xc9ca0641852f4102b2ef8715ae4b1cd31d401b507dce21b6db48bd089883f990) + [841,012](https://sepolia.etherscan.io/tx/0x07b687ca4c31e8e3b297a98250e61c1d45bb3c40466dca35b373283191493c5e) | [307,900](https://sepolia.etherscan.io/tx/0xc50d7c3b3c8ad71208e1fb815e5c7fa67bf0b70f44042e7f288a5e9e13a1fd07) |
| plonky3 | No solidity verifier | - | - | - | - |

**Notes:**
- Local VM View Gas: Executed the public view in Remix VM (Cancun)
- Sepolia function gas: Executed verify in Sepolia testnet with a simple wrapper function without view

## Gas Cost Formulas

On Ethereum, the gas cost formulas for Groth16 and FFLONK verifiers (snarkjs) can be expressed as:

- Groth16 Gas Cost ≈ 207k + 7.16k × l
- FFLONK Gas Cost ≈ 200k + 0.9k × l

Where l represents the length of the public signals. Both systems have similar cost structures but with different constants, resulting in varying overall gas costs.

*Reference: https://hackmd.io/Fa4A8lVKRM2TwVh1dhUb1Q*

## Framework Details

For detailed information about each framework, please refer to the respective README files:

- [Gnark](./gnark/README.md)
- [Snarkjs](./snarkjs/README.md)
- [Noir](./noir/README.md)
- [Halo2](./halo2/README.md)
