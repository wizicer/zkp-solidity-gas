// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./verifier.sol";

contract GasMeasurer {
    Groth16Verifier public verifier;
    
    constructor(address _verifier) {
        verifier = Groth16Verifier(_verifier);
    }
    
    function verifyWithGas(bytes calldata proof) external returns (bool) {
        return verifier.verifyProof(proof);
    }
}
