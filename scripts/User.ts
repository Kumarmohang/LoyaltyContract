import { ethers, run } from "hardhat";
import { any } from "hardhat/internal/core/params/argumentTypes";

async function main() {
  const name = "PBToken";
  const symbol = "PBDAO";
  const to = "0x0Bf3d06DE2b696b97610E4B8bA67A928efBeDD17";
  const TotalSupply = "100000000000000000000000000";
  const args: any = [];
  console.log("total supply is ", TotalSupply);

  const User = await ethers.getContractFactory("User");
  const user = await User.deploy();
  //console.log("pbtoken error", pbtoken);
  await user.deployed();

  console.log(`PB token address  ${user.address}`);
  const ad = await verify(user.address, args);
}
async function verify(contractAddress: any, args: any) {
  try {
    await run("verify:verify", {
      address: contractAddress,
      constructorArguments: args,
      contract: "contracts/User.sol:User",
    });
  } catch (error) {
    console.error(error);
  }
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});

// PBTOken is 0x77A1d4cA4Fb4ddF3C4AaC176c067C0Da9c2867eF
// Stating address is : 0x3Fe96bd6Ba01eB14ed878E6Bf2198bd767151A72
