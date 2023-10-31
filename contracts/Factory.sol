// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;
import "./Campaign.sol";
import "./Reward.sol";

contract Factory {
    address public admin;
    Reward[] public rewards;
    Campaign[] public campaign;
    event DeployCampaignContract(address indexed contractaddress);
    event DeployRewardContract(address indexed contractaddress);

    constructor() {
        admin = msg.sender;
    }

    // Deploying New Capaign contract function
    function deployCampaignContract(
        address adminAddress,
        string memory _tittle,
        string memory _description,
        string memory _shortDescription,
        uint _earnPoints,
        uint _amountSpent,
        uint _maxPoints,
        uint _startTime,
        uint _endTime
    ) external {
        // here we are adding 1 hour after the current time (buffer time).
        require(
            _startTime + 3600 >= block.timestamp,
            "start time should be Greater"
        );
        require(_endTime > _startTime, "End time should be grater");
        Campaign newCampaign = new Campaign(
            adminAddress,
            _tittle,
            _description,
            _shortDescription,
            _earnPoints,
            _amountSpent,
            _maxPoints,
            _startTime,
            _endTime
        );
        campaign.push(newCampaign);
        emit DeployCampaignContract(address(newCampaign));
    }

    // Get the Latest contract address
    function addressCampaignContract() external view returns (address) {
        return address(campaign[campaign.length - 1]);
    }

    // it returns all the contract or history of campaign.
    function campaignAllContractAddress()
        external
        view
        returns (Campaign[] memory)
    {
        return campaign;
    }

    // Deploying New Reward contract function
    function deployRewardContract(
        address adminAddress,
        string memory _tittle,
        string memory _description,
        string memory _shortDescription,
        uint _discount,
        uint _pointSpent,
        uint _maxRedeemPoints,
        uint _startTime,
        uint _endTime
    ) external {
        require(
            _startTime + 3600 >= block.timestamp,
            "start time should be Greater"
        );
        require(_endTime > _startTime, "End time should be grater");
        Reward newReward = new Reward(
            adminAddress,
            _tittle,
            _description,
            _shortDescription,
            _discount,
            _pointSpent,
            _maxRedeemPoints,
            _startTime,
            _endTime
        );
        rewards.push(newReward);
        emit DeployRewardContract(address(newReward));
    }

    // get the Latest Reward contract address
    function addressRewardContract() external view returns (address) {
        return address(rewards[rewards.length - 1]);
    }

    // get the all the contract adrress/history of Reward contract address.
    function rewardAllContractAddress()
        external
        view
        returns (Reward[] memory)
    {
        return rewards;
    }
}
