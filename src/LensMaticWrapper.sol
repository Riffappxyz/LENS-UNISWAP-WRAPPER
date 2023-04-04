// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./interfaces/ILensHub.sol";
import "./interfaces/IWmatic.sol";

contract LensMaticWrapper is Pausable, Ownable {
    address public lensHubAddress;
    address public wMaticAddress;

    constructor(
        address _lensHubAddress,
        address _wMaticAddress
    ) Ownable() Pausable() {
        lensHubAddress = _lensHubAddress;
        wMaticAddress = _wMaticAddress;
    }

    function setLensHubAddress(address _lensHubAddress) external onlyOwner {
        lensHubAddress = _lensHubAddress;
    }

    function setWMaticAddress(address _wMaticAddress) external onlyOwner {
        wMaticAddress = _wMaticAddress;
    }

    function wrapMatic() internal {
        IWmatic(wMaticAddress).deposit{value: msg.value}();
    }

    function collectWithSig(
        DataTypes.CollectWithSigData calldata vars
    ) external whenNotPaused {
        // Wrap MATIC to WMATIC
        wrapMatic();

        // Transfer the WMATIC to the user's wallet
        IERC20 wMaticToken = IERC20(wMaticAddress);
        uint256 wMaticBalance = wMaticToken.balanceOf(address(this));
        wMaticToken.transfer(msg.sender, wMaticBalance);

        ILensHub(lensHubAddress).collectWithSig(vars);
    }
}
