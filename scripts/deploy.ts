import { ethers } from "hardhat";

const main = async () => {
  const SwapFactory = await ethers.getContractFactory("SwapContract");
  const swapcontract = await SwapFactory.deploy();

  await swapcontract.deployed();

  console.log("Staking Contract deployed to:", swapcontract.address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
