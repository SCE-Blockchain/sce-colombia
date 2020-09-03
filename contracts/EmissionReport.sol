// SPDX-License-Identifier: MIT
pragma solidity >=0.4.21 <0.7.0;

import "./IEmissionRightsToken.sol";
import "./EmissionsComplianceCycle.sol";

contract EmissionReport {
    IEmissionRightsToken private _token;

    enum State {Reported, Certified, Approved, Paid, Overdue}
    State public state;
    address public reporter;
    address public verifier;
    string public uri;
    string public certificateUri;
    uint256 public amount;
    uint256 public burnedEmissionRights;
    EmissionsComplianceCycle complianceCycleContract;

    event Uncertified();
    event Unapproved();

    /**
     * @dev Constructor sets token that can be received
     */
    constructor(
        address reporterAddress,
        string memory reportUri,
        uint256 emissionAmount,
        address selectedVerifier,
        IEmissionRightsToken token
    ) public {
        reporter = reporterAddress;
        uri = reportUri;
        amount = emissionAmount;
        verifier = selectedVerifier;
        _token = token;
        complianceCycleContract = EmissionsComplianceCycle(msg.sender);
    }

    modifier onlyReporter() {
        require(msg.sender == reporter, "Only the reporter can call this");
        _;
    }

    modifier onlyVerifier() {
        require(
            msg.sender == verifier,
            "Only the selected verifier can call this"
        );
        _;
    }

    modifier onlyGovernment() {
        require(
            complianceCycleContract.hasGovernmentRole(msg.sender) ||
                msg.sender == address(complianceCycleContract), // Delete the OR when having front for individual reports
            "Only a government account can call this"
        );
        _;
    }

    modifier onlyReported() {
        require(
            state == State.Reported,
            "This can only be done if the report is just created."
        );
        _;
    }

    modifier onlyCertified() {
        require(
            state == State.Certified,
            "This can only be done if the report is certified."
        );
        _;
    }

    modifier onlyApproved() {
        require(
            state == State.Approved,
            "The report and certificate need to be approved by the government first."
        );
        _;
    }

    function modifyReport(
        string memory reportUri,
        uint256 emissionAmount,
        address selectedVerifier
    ) public onlyReporter onlyReported {
        uri = reportUri;
        amount = emissionAmount;
        verifier = selectedVerifier;

        //emit ReportModified()
    }

    function certify(string memory uriOfCertificate, uint256 emissionAmount)
        public
        onlyVerifier
        onlyReported
    {
        require(
            amount == emissionAmount,
            "The reported amount should be the same as the certified amount."
        );
        certificateUri = uriOfCertificate;
        state = State.Certified;
    }

    function approve() public onlyGovernment onlyCertified {
        state = State.Approved;
        uint256 availableBalance = _token.allowance(reporter, address(this));
        if (availableBalance > 0) {
            uint256 amountToBurn = availableBalance;
            if (availableBalance - amount > 0) {
                amountToBurn = amount;
            }
            // Extract following functionality to a separate internal function so it can be reused in the pay function
            _token.burnFrom(reporter, amountToBurn);
            burnedEmissionRights += amountToBurn;
            if (burnedEmissionRights == amount) {
                state = State.Paid;
            }
        }

        //emit Approved();
    }

    /**
     * @dev Do stuff, requires tokens
     */
    function pay(uint256 amountToBurn) public onlyApproved onlyReporter {
        require(
            amountToBurn <= amount - burnedEmissionRights,
            "You can not pay more emission rights than the reported amount."
        );

        _token.burnFrom(msg.sender, amountToBurn);
        burnedEmissionRights += amountToBurn;
        if (burnedEmissionRights == amount) {
            state = State.Paid;
        }

        // Check if full amount is paid already to change the state of the report
        // emit Paid event with amount and from
    }

    function setOverdue() public onlyGovernment {
        state = State.Overdue;
    }
}
