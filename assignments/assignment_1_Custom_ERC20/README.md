# TCToken - Custom ERC20 Token Contract

TCToken is a custom ERC20 token contract built on the Ethereum blockchain using Solidity. This contract inherits from the `Ownable` contract, which allows for the transfer of ownership and restricts certain functions for use by the contract owner only.

## Features

- Standard ERC20 token functionalities such as transferring tokens, approving allowances, and checking balances.
- Customizable token name, symbol, and decimals.
- A 5% transfer fee on each token transfer, paid by the sender to the contract owner.

## Why TCToken?

TCToken is a unique ERC20 token contract that incorporates a transfer fee mechanism. This feature provides an additional revenue stream for the contract owner, as they receive a 5% fee from each token transfer. This could be useful for funding project development, rewarding token holders, or supporting a specific cause.

## Usage

1. Deploy the `Ownable` contract.
2. Deploy the `TCToken` contract, passing the desired token name and symbol as constructor arguments.
3. Interact with the contract using standard ERC20 functions such as `balanceOf`, `transfer`, `approve`, `allowance`, and `transferFrom`.

## Example

```solidity
// Deploy TCToken with a name and symbol
TCToken token = new TCToken("My Token", "MTK");

// Check token name, symbol, and decimals
string memory name = token.getTokenName(); // "My Token"
string memory symbol = token.getTokenSymbol(); // "MTK"
uint32 decimals = token.getTokenDecimals(); // 18

// Transfer tokens and pay a 5% fee to the contract owner
token.transfer(receiverAddress, 100 * 1e18); // Sends 100 tokens to `receiverAddress` and 5 tokens to the contract owner
```


# Address of the deployed instance of contract (Sepolia Network): 
[0x4b1C976107fa1c8b8be570bdCA9E5d8951939577](https://sepolia.etherscan.io/address/0x4b1c976107fa1c8b8be570bdca9e5d8951939577)
