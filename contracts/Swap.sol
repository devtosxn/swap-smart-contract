// SPDX-License-Identifier:MIT
pragma solidity ^0.8.4;

import "./Web3Token.sol";

contract SwapContract is Web3Token {
    // Create an order-based swap contract that allows users to deposit various kind of tokens.
    // These tokens can be purchased by others with another token specified by the depositors.
    // For example; Ada deposits 100 link tokens, she wants in return, as a payment, 20W3B tokens for for 100 link tokens.

    // A swap smart contract that allow users to swap between two tokens, for example Link token and W3B token
    // You need to determine the price of link token and web3bridge token,
    // Assuming link is $50,
    // Assuming W3B is $200,
    //  Therefore, assuming a user wants to swap Link to W3 token, he needs to create an order, by putting all informaton necessary e.g, the token address he wants to swap, the token address he wants to receive, the amount he want to swap, and deadline.

    // Use struct to identify each order and a mapping of uint to struct to identify each order,
    // After someone has created an order, another user can decide to execute the order by inputing the ID of the order he wants to execute and send the token to the user that created the order while he get the token that was use to execute order.
    // Hint: you would need a price feed you actually calculated in your smart contract.

    // Create a struct to identify each order
    struct Order {
        uint256 id;
        address tokenToSwap;
        address tokenToReceive;
        uint256 amountToSwap;
        uint256 amountToReceive;
        uint256 deadline;
        address payable owner;
    }

    // Create a mapping of uint to struct to identify each order
    mapping(uint256 => Order) public orders;

    // Create a variable to identify the number of orders
    uint256 public numberOfOrders;

    // Create a function to create an order
    function createOrder(
        address _tokenToSwap,
        address _tokenToReceive,
        uint256 _amountToSwap,
        uint256 _amountToReceive,
        uint256 _deadline
    ) public {
        // Create an order
        Order memory newOrder = Order(
            numberOfOrders,
            _tokenToSwap,
            _tokenToReceive,
            _amountToSwap,
            _amountToReceive,
            _deadline,
            payable(msg.sender)
        );
        // Add the order to the mapping
        orders[numberOfOrders] = newOrder;
        // Increment the number of orders
        numberOfOrders++;
    }

    // Create a function to execute an order
    function executeOrder(uint256 _id) public {
        // Fetch the order using the id
        Order memory _order = orders[_id];
        // Make sure the order is valid
        require(_order.deadline >= block.timestamp, "Order is not valid");
        // Make sure the user has enough token to execute the order
        require(
            ERC20(_order.tokenToSwap).balanceOf(msg.sender) >=
                _order.amountToSwap,
            "You do not have enough token to execute this order"
        );
        // Make sure the contract has enough token to execute the order
        require(
            ERC20(_order.tokenToReceive).balanceOf(address(this)) >=
                _order.amountToReceive,
            "The contract does not have enough token to execute this order"
        );
        // Transfer the token to the user that created the order
        ERC20(_order.tokenToSwap).transferFrom(
            msg.sender,
            _order.owner,
            _order.amountToSwap
        );
        // Transfer the token to the user that executed the order
        ERC20(_order.tokenToReceive).transferFrom(
            address(this),
            msg.sender,
            _order.amountToReceive
        );
        // Remove the order from the mapping
        delete orders[_id];
    }

 

    // Create a function to get the balance of a token
    function getBalance(address _token) public view returns (uint256) {
        return ERC20(_token).balanceOf(address(this));
    }

    // Create a function to get the balance of a token
    function getBalanceOf(address _token, address _user)
        public
        view
        returns (uint256)
    {
        return ERC20(_token).balanceOf(_user);
    }

    // Create a function to get the number of orders
    function getNumberOfOrders() public view returns (uint256) {
        return numberOfOrders;
    }
}
