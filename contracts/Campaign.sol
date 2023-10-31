// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

contract Campaign {
    struct Details {
        string tittle;
        string description;
        string shortDescription;
        uint earnPoints;
        uint amountSpent;
        uint maxPoints;
        uint startTime;
        uint endTime;
    }

    Details public campaign;
    uint public rate;
    address public admin;

    constructor(
        address adminAddress,
        string memory _tittle,
        string memory _description,
        string memory _shortDescription,
        uint _earnPoints,
        uint _amountSpent,
        uint _maxPoints,
        uint _startTime,
        uint _endTime
    ) {
        admin = adminAddress;
        campaign.tittle = _tittle;
        campaign.description = _description;
        campaign.shortDescription = _shortDescription;
        campaign.earnPoints = _earnPoints;
        campaign.amountSpent = _amountSpent;
        campaign.maxPoints = _maxPoints;
        campaign.startTime = _startTime;
        campaign.endTime = _endTime;
        rate = _amountSpent / _earnPoints;
    }

    function UpdateVariables(
        string memory _tittle,
        string memory _description,
        string memory _shortDescription,
        uint _earnPoints,
        uint _amountSpent,
        uint _maxPoints
    ) external {
        require(msg.sender == admin, "you dont have permission to update");
        campaign.tittle = _tittle;
        campaign.description = _description;
        campaign.shortDescription = _shortDescription;
        campaign.earnPoints = _earnPoints;
        campaign.amountSpent = _amountSpent;
        campaign.maxPoints = _maxPoints;
    }

    function getLatestValues() external view returns (Details memory) {
        return campaign;
    }
}
