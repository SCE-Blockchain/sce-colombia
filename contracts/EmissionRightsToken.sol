// SPDX-License-Identifier: MIT
pragma solidity >=0.4.21 <0.7.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20Detailed.sol";
import "@openzeppelin/contracts/access/Roles.sol";

contract EmissionRightsToken is ERC20, ERC20Detailed {
    using Roles for Roles.Role;
    // Access control roles
    Roles.Role private _minters;

    constructor(address minter)
        public
        ERC20Detailed("DerechosDeEmisión", "DDE", 18)
    {
        _minters.add(minter);
    }

    function mint(uint256 amount) public {
        // Only minters can mint
        require(_minters.has(msg.sender), "Caller is not a minter");
        _mint(msg.sender, amount);
    }

    function mintTo(address to, uint256 amount) public {
        // Only minters can mint
        require(_minters.has(msg.sender), "Caller is not a minter");
        _mint(to, amount);
    }
}
