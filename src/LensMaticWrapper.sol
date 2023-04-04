pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "./ILensHub.sol";

contract LensMaticWrapper is Pausable {
    address public lensHubAddress;

    constructor(address _lensHubAddress) {
        lensHubAddress = _lensHubAddress;
    }

    function setLensHubAddress(address _lensHubAddress) external onlyOwner {
        lensHubAddress = _lensHubAddress;
    }

    function collectWithSig(
        ILensHub.DataTypes.CollectWithSigData calldata vars
    ) external whenNotPaused {
        ILensHub(lensHubAddress).collectWithSig(vars);
    }
}
