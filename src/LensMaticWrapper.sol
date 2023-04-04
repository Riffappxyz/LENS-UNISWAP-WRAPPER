// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./interfaces/ILensHub.sol";

contract LensMaticWrapper is Pausable, Ownable {
    address public lensHubAddress;

    constructor(address _lensHubAddress) Ownable() Pausable() {
        lensHubAddress = _lensHubAddress;
    }

    function setLensHubAddress(address _lensHubAddress) external onlyOwner {
        lensHubAddress = _lensHubAddress;
    }

    function collectWithSig(
        DataTypes.CollectWithSigData calldata vars
    ) external whenNotPaused {
        ILensHub(lensHubAddress).collectWithSig(vars);
    }
}
