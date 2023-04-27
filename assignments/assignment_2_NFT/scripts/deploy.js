const { ethers } = require("hardhat");

async function main() {
  const [deployer] = await ethers.getSigners();

  console.log("Deploying contracts with the account:", deployer.address);

  const TestNFT = await ethers.getContractFactory("TestNFT");
  const testNFT = await TestNFT.deploy();

  console.log("TestNFT deployed to:", testNFT.address);

  await testNFT.deployed();
  await testNFT.deployTransaction.wait(6);

  await hre.run("verify:verify", {
    address: testNFT.address,
    constructorArguments: [],
  });

  console.log("Contract verified on Etherscan");
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
