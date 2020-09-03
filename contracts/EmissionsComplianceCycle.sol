// SPDX-License-Identifier: MIT
pragma solidity >=0.4.21 <0.7.0;

import "@openzeppelin/contracts/access/Roles.sol";
import "./EmissionReport.sol";
import "./IEmissionRightsToken.sol";

contract EmissionsComplianceCycle {
    using Roles for Roles.Role;
    // Access control roles
    Roles.Role private _government;
    Roles.Role private _verifiers;
    Roles.Role private _emitters;

    address[] public verifiers;
    address[] public emitters;
    EmissionReport[] public reports;
    address private _token;

    //address[] public acceptedTokens;

    constructor(address emissionRightsTokenContract) public {
        _government.add(msg.sender);
        _token = emissionRightsTokenContract;
    }

    modifier onlyGovernment() {
        require(_government.has(msg.sender), "Only government can call this.");
        _;
    }

    modifier onlyEmitters() {
        require(_emitters.has(msg.sender), "Only emitters can call this.");
        _;
    }

    modifier onlyVerifiers() {
        require(_verifiers.has(msg.sender), "Only verifiers can call this.");
        _;
    }

    function addVerifier(address verifier) public onlyGovernment {
        verifiers.push(verifier);
        _verifiers.add(verifier);
    }

    function addEmitter(address emitter) public onlyGovernment {
        emitters.push(emitter);
        _emitters.add(emitter);
    }

    function getVerifiers() public view returns (address[] memory) {
        return verifiers;
    }

    function getEmitters() public view returns (address[] memory) {
        return emitters;
    }

    function hasGovernmentRole(address account) public view returns (bool) {
        return _government.has(account);
    }

    function reportEmissions(
        string memory reportUri,
        uint256 amount,
        address verifier
    ) public onlyEmitters {
        require(
            _verifiers.has(verifier),
            "Only registered verifiers can be set."
        );
        EmissionReport report = new EmissionReport(
            msg.sender,
            reportUri,
            amount,
            verifier,
            IEmissionRightsToken(_token)
        );
        reports.push(report);
    }

    function approveReport(address reportAddress) public onlyGovernment {
        EmissionReport report = EmissionReport(reportAddress);
        report.approve();
    } // Remove this function when having GUI for EmissionReport contracts

    function getReports() public view returns (EmissionReport[] memory) {
        return reports;
    }
}
