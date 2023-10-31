import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import "dotenv/config";
import "@nomiclabs/hardhat-etherscan";

const Goerli_URL = process.env.Goerli;
const Private_key = process.env.PRIVATE_KEY as string;
const mumbaiKey = process.env.PRIVATE_key as string;
const apikey = process.env.API_Key as string;
const Sepolia_URL = process.env.Sepolia;
const Mainnet_URL = process.env.Mainnet;

const config: HardhatUserConfig = {
  solidity: "0.8.17",
  networks: {
    goerli: {
      url: Goerli_URL || "",
      accounts: [Private_key],
    },
    sepolia: {
      url: Sepolia_URL || "",
      accounts: [Private_key],
    },
    mainnet: {
      url: Mainnet_URL || "",
      accounts: [Private_key],
    },
    polygon_mumbai: {
      url: "https://rpc-mumbai.maticvigil.com",
      accounts: [mumbaiKey]
    }
  },
  etherscan: {
    apiKey: apikey,
    // contracts: {
    //   "0x34032A74538cAa7A80b7c84E35200189254BBfa4": "PBToken",
    //   contractName: "contracts/PBToken.sol:PBToken",
    // },
  },
};

export default config;
