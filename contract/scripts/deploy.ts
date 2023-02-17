import { ethers } from "hardhat";

async function deploy() {
  // コントラクトをデプロイするアカウントのアドレスを取得
  const [deployer] = await ethers.getSigners();

  const AssetTokenization = await ethers.getContractFactory(
    "AssetTokenization"
  );
  const assetTokenization = await AssetTokenization.deploy();
  await assetTokenization.deployed();

  console.log("assetTokenization address: ", assetTokenization.address);
  console.log("account address that deploy contract: ", deployer.address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
deploy().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
