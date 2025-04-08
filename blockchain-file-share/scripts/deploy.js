const hre = require("hardhat");

async function main() {
  const FileShare = await hre.ethers.getContractFactory("FileShare");
  const fileShare = await FileShare.deploy();

  await fileShare.waitForDeployment(); // ✅ Ethers v6 way to wait for deployment

  const address = await fileShare.getAddress(); // ✅ Ethers v6 way to get contract address
  console.log("FileShare deployed to:", address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
