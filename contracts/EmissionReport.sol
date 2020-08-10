// SPDX-License-Identifier: MIT
pragma solidity >=0.4.21 <0.7.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract EmissionReport {
    IERC20 private _token;

    contract complianceCycleContract;
    enum State {Reported, Approved, Overdue, Paid};
    State state;
    address reporter;
    string uri;
    uint amount;
    address verifier;
    string verifierUri;


    /**
     * @dev Constructor sets token that can be received
     */
    constructor (address reporter, string uri, uint amount, address verifier, IERC20 token) public {
        this.reporter = reporter;
        this.uri = uri;
        this.amount = amount;
        this.verifier = verifier;
        _token = token;
    }

    /**
     * @dev Do stuff, requires tokens
     */
    function pay() external {
        address from = msg.sender;

        _token.transferFrom(from, address(this), 1000);
        _token.burn()

        emit DoneStuff(from);
    }
}
