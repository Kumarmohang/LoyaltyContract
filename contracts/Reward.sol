// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

contract Reward {
    struct Details {
        string tittle;
        string description;
        string shortDescription;
        uint discount;
        uint pointSpent;
        uint maxRedeemPoints;
        uint startTime;
        uint endTime;
    }

    Details public reward;
    uint public rate;
    address public admin;

    constructor(
        address adminAddress,
        string memory _tittle,
        string memory _description,
        string memory _shortDescription,
        uint _discount,
        uint _pointSpent,
        uint _maxRedeemPoints,
        uint _startTime,
        uint _endTime
    ) {
        admin = adminAddress;
        reward.tittle = _tittle;
        reward.description = _description;
        reward.shortDescription = _shortDescription;
        reward.discount = _discount;
        reward.pointSpent = _pointSpent;
        reward.maxRedeemPoints = _maxRedeemPoints;
        reward.startTime = _startTime;
        reward.endTime = _endTime;
        rate = _pointSpent / _discount;
    }

    function UpdateVariables(
        string memory _tittle,
        string memory _description,
        string memory _shortDescription,
        uint _discount,
        uint _pointSpent,
        uint _maxRedeemPoints
    ) external {
        require(msg.sender == admin, "you dont have permission to update");
        reward.tittle = _tittle;
        reward.description = _description;
        reward.shortDescription = _shortDescription;
        reward.discount = _discount;
        reward.pointSpent = _pointSpent;
        reward.maxRedeemPoints = _maxRedeemPoints;
    }

    function getLatestValues() external view returns (Details memory) {
        return reward;
    }
}
