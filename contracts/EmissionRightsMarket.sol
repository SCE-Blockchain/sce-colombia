// SPDX-License-Identifier: MIT
pragma solidity >=0.4.21 <0.7.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract EmissionRightsMarket {
    struct Order {
        address placer;
        uint256 amount;
    }
    struct PriceOrders {
        uint256 total;
        Order[] orders;
    }
    mapping(uint256 => PriceOrders) public sellOrders; // The selling prices hold the specific orders
    mapping(uint256 => PriceOrders) public buyOrders; // The buying prices hold the specific orders

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
    function Sell(uint256 emissionRightsAmount, uint256 copSellPrice) public {
        require(
            IERC20(_token).allowance(msg.sender, address(this)) >=
                emissionRightsAmount,
            "Insufficient allowance set by seller"
        );

        // Check buyOrders before doing this:
        PriceOrders storage priceBuyOrders = buyOrders[copSellPrice];
        uint256 instantSaleAmount = priceBuyOrders.total >= emissionRightsAmount
            ? emissionRightsAmount
            : priceBuyOrders.total;
        uint256 sellOrderAmount = emissionRightsAmount - instantSaleAmount;

        // Execute instant sales with available buy orders
        for (uint256 i = 0; instantSaleAmount > 0; i++) {
            Order storage order = priceBuyOrders.orders[i];
            uint256 sellAmount = order.amount;
            if (order.amount > instantSaleAmount) {
                order.amount -= instantSaleAmount;
                sellAmount = instantSaleAmount;
                instantSaleAmount = 0;
            } else {
                instantSaleAmount -= order.amount;
                delete priceBuyOrders.orders[i];
            }
            IERC20(_cop).transfer(msg.sender, copSellPrice * sellAmount);
            IERC20(_token).transferFrom(msg.sender, order.placer, sellAmount);
        }

        // Place sell order if needed
        if (sellOrderAmount > 0) {
            Order memory order = Order(msg.sender, sellOrderAmount);
            PriceOrders storage priceSellOrders = sellOrders[copSellPrice];
            priceSellOrders.orders.push(order);
            priceSellOrders.total += sellOrderAmount;

            IERC20(_token).transferFrom(
                msg.sender,
                address(this),
                sellOrderAmount
            );
        }
    }

    function Buy(uint256 emissionRightsAmount, uint256 copSellPrice) public {
        PriceOrders storage priceOrders = sellOrders[copSellPrice];

        // Check SellOrders before adding to the orderbook
    }
}
