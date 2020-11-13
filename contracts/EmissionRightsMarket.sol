// SPDX-License-Identifier: MIT
pragma solidity >=0.4.21 <0.7.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract EmissionRightsMarket {
    struct Order {
        address payable placer;
        uint256 amount;
    }

    mapping(uint256 => Order[]) public sellOrders;
    mapping(uint256 => uint256) public sellOrdersTotal;
    mapping(uint256 => Order[]) public buyOrders;
    mapping(uint256 => uint256) public buyOrdersTotal;

    address private _token;
    address private _cop;

    //address[] public acceptedTokens;

    constructor(
        address emissionRightsTokenContract,
        address colombianPesoTokenContract
    ) public {
        _token = emissionRightsTokenContract;
        _cop = colombianPesoTokenContract;
    }

    // Makes an offer to trade emissionRightsAmount of emission rights token for
    function sell(uint256 emissionRightsAmount, uint256 copSellPrice) public {
        require(
            IERC20(_token).allowance(msg.sender, address(this)) >=
                emissionRightsAmount,
            "Insufficient allowance set by seller"
        );

        // Check buyOrders before doing this:
        uint256 instantSaleAmount = buyOrdersTotal[copSellPrice] >=
            emissionRightsAmount
            ? emissionRightsAmount
            : buyOrdersTotal[copSellPrice];
        uint256 sellOrderAmount = emissionRightsAmount - instantSaleAmount;

        // Execute instant sales with available buy orders
        for (uint256 i = 0; instantSaleAmount > 0; i++) {
            address placer = buyOrders[copSellPrice][i].placer;
            uint256 sellAmount = buyOrders[copSellPrice][i].amount;
            if (buyOrders[copSellPrice][i].amount > instantSaleAmount) {
                buyOrders[copSellPrice][i].amount -= instantSaleAmount;
                sellAmount = instantSaleAmount;
            } else {
                delete buyOrders[copSellPrice][i];
            }
            instantSaleAmount -= sellAmount;
            buyOrdersTotal[copSellPrice] -= sellAmount;
            IERC20(_cop).transfer(msg.sender, copSellPrice * sellAmount);
            IERC20(_token).transferFrom(msg.sender, placer, sellAmount);
        }

        // Place sell order if needed
        if (sellOrderAmount > 0) {
            sellOrders[copSellPrice].push(Order(msg.sender, sellOrderAmount));
            sellOrdersTotal[copSellPrice] += sellOrderAmount;

            IERC20(_token).transferFrom(
                msg.sender,
                address(this),
                sellOrderAmount
            );
        }
    }

    function buy(uint256 emissionRightsAmount, uint256 copBuyPrice) public {
        require(
            IERC20(_cop).allowance(msg.sender, address(this)) >=
                emissionRightsAmount * copBuyPrice,
            "Insufficient allowance set by buyer"
        );

        // Check SellOrders before adding to the orderbook
        uint256 instantBuyAmount = sellOrdersTotal[copBuyPrice] >=
            emissionRightsAmount
            ? emissionRightsAmount
            : sellOrdersTotal[copBuyPrice];
        uint256 buyOrderAmount = emissionRightsAmount - instantBuyAmount;

        // Execute instant buys with available sell orders
        for (uint256 i = 0; instantBuyAmount > 0; i++) {
            address placer = sellOrders[copBuyPrice][i].placer;
            uint256 buyAmount = sellOrders[copBuyPrice][i].amount;
            if (sellOrders[copBuyPrice][i].amount > instantBuyAmount) {
                sellOrders[copBuyPrice][i].amount -= instantBuyAmount;
                buyAmount = instantBuyAmount;
            } else {
                delete sellOrders[copBuyPrice][i];
            }
            instantBuyAmount -= buyAmount;
            sellOrdersTotal[copBuyPrice] -= buyAmount;
            IERC20(_token).transfer(msg.sender, buyAmount);
            IERC20(_cop).transferFrom(
                msg.sender,
                placer,
                copBuyPrice * buyAmount
            );
        }

        // Place buy order if needed
        if (buyOrderAmount > 0) {
            buyOrders[copBuyPrice].push(Order(msg.sender, buyOrderAmount));
            buyOrdersTotal[copBuyPrice] += buyOrderAmount;

            IERC20(_cop).transferFrom(
                msg.sender,
                address(this),
                buyOrderAmount * copBuyPrice
            );
        }
    }
}
