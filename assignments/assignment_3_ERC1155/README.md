# **TechCultureFlameSword**

Link for item in OpenSea [marketplace](https://testnets.opensea.io/assets/bsc-testnet/0x0c81a4baa5905038b13ff1a1233137fec8d56290/1)


This is a Solidity smart contract for an ERC-1155 token that represents a digital asset called TechCultureFlameSword. The contract includes the ability to mint new tokens, set the URI for the token metadata, and transfer tokens between addresses. It also includes a whitelist feature that limits the ability to purchase tokens to only those addresses on the whitelist.

## **Getting Started**

To use this contract, you will need a development environment for Solidity. You can use Remix, Hardhat, or Truffle. You will also need an Ethereum wallet to interact with the contract.

## **Usage**

### **Contract Deployment**

To deploy the contract, you can use Remix or another development environment. You will need to set the compiler version to 0.8.9 and import the necessary dependencies.

### **Minting Tokens**

To mint new tokens, call the `mint` or `mintBatch` function with the appropriate parameters. You must be the owner of the contract to mint new tokens.

### **Setting the URI**

To set the URI for the token metadata, call the `setURI` function with the new URI as the parameter. You must be the owner of the contract to set the URI.

### **Transferring Tokens**

To transfer tokens between addresses, call the `_safeTransferFrom` function with the appropriate parameters.

### **Whitelist**

To add an address to the whitelist, call the `addWhitelist` function with the new address as the parameter. Only addresses on the whitelist can purchase tokens.

### **Purchasing Tokens**

To purchase tokens, call the `buyNft` function with the appropriate parameters. You must be on the whitelist to purchase tokens.

## **License**

This contract is licensed under the MIT License. See the SPDX-License-Identifier comment at the top of the contract for more information.

## **Acknowledgements**

This contract was built using the OpenZeppelin library.