// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract LoyaltyToken is ERC20 {
    constructor(address _add) ERC20("Loyalty", "HCL") {
        _mint(_add, 1000000000 * 10 ** 18);
    }
}
