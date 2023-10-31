import { ethers, run } from "hardhat";

async function main() {
    const admin = "0x1a6936f989e1ED2967f1fDfF7EAbe55408BFb261"
    const Factory = await ethers.getContractFactory("LoyaltyToken");
    const factory = await Factory.deploy(admin);
    await factory.deployed();

    console.log(`LoyaltyToken contract address is ${factory.address}`);

}


// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});


// npx hardhat verify --network sepolia --contract contracts/LoyaltyToken.sol:LoyaltyToken 0x587c09C4672E2b77c0F7cE88De1684aceC94b8d5 0x1a6936f989e1ED2967f1fDfF7EAbe55408BFb261
