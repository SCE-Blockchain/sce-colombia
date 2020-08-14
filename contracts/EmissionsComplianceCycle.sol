// SPDX-License-Identifier: MIT
pragma solidity >=0.4.21 <0.7.0;

import "@openzeppelin/contracts/access/Roles.sol";
import "./EmissionReport.sol";

contract EmissionsComplianceCycle {
    using Roles for Roles.Role;
    // Access control roles
    Roles.Role private _government;
    Roles.Role private _verifiers;

    address[] public verifiers;
    address[] public reports;

    constructor(address emissionRightsTokenContract) public {
        _government.add(msg.sender);
    }

    modifier onlyGovernment() {
        require(_government.has(msg.sender), "Only government can call this.");
        _;
    }

    modifier onlyVerifiers() {
        require(_verifiers.has(msg.sender), "Only verifiers can call this.");
        _;
    }

    function addVerifier(address verifier) public onlyGovernment {
        verifiers.push(verifier)
        _verifiers.add(verifier);
    }
}
