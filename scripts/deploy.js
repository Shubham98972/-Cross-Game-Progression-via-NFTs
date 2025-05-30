const hre = require("hardhat");

async function main() {
  const SaveNFT = await hre.ethers.getContractFactory("SaveNFT");
  const saveNFT = await SaveNFT.deploy();

  await saveNFT.deployed();
  console.log("SaveNFT contract deployed to:", saveNFT.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
