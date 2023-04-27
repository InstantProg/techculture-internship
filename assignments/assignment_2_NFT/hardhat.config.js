require("@nomicfoundation/hardhat-toolbox");

require("dotenv").config();

const privateKey = process.env.PRIVATE_KEY || "";

module.exports = {
  solidity: "0.8.4",
  networks: {
    hardhat: {
      chainId: 31337,
    },
    localhost: {
      url: "http://127.0.0.1:8545",
    },
    bscTestnet: {
      url: "https://data-seed-prebsc-1-s1.binance.org:8545",
      chainId: 97,
      gasPrice: 20000000000,
      accounts: [privateKey],
    },
    sepolia: {
      url: "https://eth-sepolia.g.alchemy.com/v2/cZWBuRuOQ9AwX3_qOl5D0SEGWaDyHcba",
      accounts: [privateKey],
      chainId: 11155111,
    },
  },
  etherscan: {
    apiKey: "UZXNMQS3XIB2XE4NTCIQ44B3SYWJTS9H68",
  },
};
