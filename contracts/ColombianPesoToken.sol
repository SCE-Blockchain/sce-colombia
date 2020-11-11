// SPDX-License-Identifier: MIT
pragma solidity >=0.4.21 <0.7.0;

import "@openzeppelin/contracts/token/ERC20/ERC20Mintable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20Detailed.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20Burnable.sol";

contract ColombianPesoToken is ERC20Mintable, ERC20Detailed, ERC20Burnable {
    constructor(
        string memory name,
        string memory symbol,
        uint8 decimals
    ) public ERC20Detailed(name, symbol, decimals) {}
}
