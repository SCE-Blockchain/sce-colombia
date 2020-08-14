// SPDX-License-Identifier: MIT
pragma solidity >=0.4.21 <0.7.0;

import "@openzeppelin/contracts/token/ERC20/ERC20Mintable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20Detailed.sol";

contract EmissionRightsToken is ERC20Mintable, ERC20Detailed {
    constructor() public ERC20Detailed("DerechosDeEmisión", "DDE", 18) {}
}
