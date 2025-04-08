const hre = require("hardhat");

async function main() {
  // Deploy FileShare
  const FileShare = await hre.ethers.getContractFactory("FileShare");
  const fileShare = await FileShare.deploy();
  await fileShare.waitForDeployment();
  const fileShareAddress = await fileShare.getAddress();
  console.log("✅ FileShare deployed to:", fileShareAddress);

  // Deploy FileVersionControl
  const FileVersionControl = await hre.ethers.getContractFactory("FileVersionControl");
  const fileVersionControl = await FileVersionControl.deploy();
  await fileVersionControl.waitForDeployment();
  const fileVersionControlAddress = await fileVersionControl.getAddress();
  console.log("✅ FileVersionControl deployed to:", fileVersionControlAddress);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
