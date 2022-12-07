const { network } = require("hardhat");
const {
  developmentChains,
  INITIAL_SUPPLY,
} = require("../helper-hardhat-config");
const { verify } = require("../utils/verify");

module.exports = async function ({ getNamedAccounts, deployments }) {
  const { deploy, log } = deployments;
  const { deployer } = await getNamedAccounts();
  const chainId = network.config.chainId;
  const ManualToken = await deploy("ManualToken", {
    from: deployer,
    args: [INITIAL_SUPPLY],
    log: true,

    waitConfirmations:  5,
  });
  log(`ManualToken deployed at ${ManualToken.address}`);

  if (
    !developmentChains.includes(network.name) &&
    process.env.ETHERSCAN_API_KEY
  ) {
    await verify(ManualToken.address, [INITIAL_SUPPLY]);
  }
};

module.exports.tags = ["all", "token"];
