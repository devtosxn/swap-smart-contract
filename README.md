# Sample Hardhat Project

This project demonstrates a basic Hardhat use case. It comes with a sample contract, a test for that contract, and a script that deploys that contract.

## Project Description
- Create an order-based swap contract that allows users to deposit various kind of tokens.
- These tokens can be purchased by others with another token specified by the depositors.
- For example; Ada deposits 100 link tokens, she wants in return, as a payment, 20W3B tokens for for 100 link tokens.

- A swap smart contract that allow users to swap between two tokens, for example Link token and W3B token
- You need to determine the price of link token and web3bridge token,
- Assuming link is $50,
- Assuming W3B is $200,

- Therefore, assuming a user wants to swap Link to W3B token, he needs to create an order, by putting all informaton necessary e.g, the token address he wants to swap, the token address he wants to receive, the amount he want to swap, and deadline.

- Use struct to identify each order and a mapping of uint to struct to identify each order,
- After someone has created an order, another user can decide to execute the order by inputing the ID of the order he wants to execute and send the token to the user that created the order while he get the token that was use to execute order.

Try running some of the following tasks:

```shell
npx hardhat help
npx hardhat test
GAS_REPORT=true npx hardhat test
npx hardhat node
npx hardhat run scripts/deploy.ts
```
