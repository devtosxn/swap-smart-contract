// SPDX-License-Identifier: MIT

pragma solidity ^0.8.1;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Web3Token is ERC20, Ownable {
    uint256 public constant maxTotalSupply = 10000000 * 10**18;

    constructor() ERC20("Web3Bridge", "W3B") {}

    function mint(uint256 _amount) internal {
        _mint(msg.sender, _amount);
    }
}
