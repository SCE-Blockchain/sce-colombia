// SPDX-License-Identifier: MIT
pragma solidity >=0.4.21 <0.7.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract EmissionReport {
    IERC20 private _token;

    contract complianceCycleContract;
    enum State {Reported, Approved, Unapproved, Overdue, Paid};
    State state;
    address reporter;
    string uri;
    uint amount;
    address verifier;


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
    function pay(uint amount) external {
        address from = msg.sender;
        require(reporter == from);

        _token.transferFrom(from, address(this), amount);
        _token.burn(amount)

        // emit Paid event with amount and from
    }
}
