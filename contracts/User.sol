// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract User is ReentrancyGuard {
    address public admin;
    address public ercAddress;
    enum voucher {
        none,
        notredeem,
        redeemed,
        tokened
    }
    mapping(address => voucher) public voucherStatus;
    mapping(address => mapping(uint => uint)) public pointOf;
    mapping(address => bytes32) public voucherHash;
    mapping(address => mapping(bytes32 => uint)) public voucherShare;

    // Events
    event PrividePoints(
        uint userId,
        address indexed add,
        uint share,
        voucher status
    );
    event TokenConversion(
        uint userId,
        address indexed add,
        uint share,
        voucher status
    );
    event VocherGeneration(
        uint userId,
        address indexed add,
        uint share,
        voucher status
    );

    constructor() {
        admin = msg.sender;
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "you are not admin");
        _;
    }

    // this function called by admin and provides the points the user based on user id, address
    function providePoints(
        uint _userId,
        address _add,
        uint _amount,
        uint rate,
        uint _max
    ) external nonReentrant onlyAdmin {
        uint share = _amount / rate;
        if (share <= _max) {
            pointOf[_add][_userId] += share;
        } else {
            pointOf[_add][_userId] += _max;
        }
        voucherStatus[_add] = voucher.notredeem;
        emit PrividePoints(_userId, _add, share, voucher.notredeem);
    }

    // set the ERC address after the Loyalty contract deployed .
    function setErcaddress(address _contractAddress) external onlyAdmin {
        ercAddress = _contractAddress;
    }

    // it converts the the point to the Layalty tokens using this function.
    function tokenConersion(
        uint _userId,
        uint _points,
        uint rate
    ) external nonReentrant {
        require(voucherStatus[msg.sender] == voucher.notredeem, "its Redeemed");
        uint share = _points / rate;
        require(pointOf[msg.sender][_userId] >= _points, "insuffient points");
        pointOf[msg.sender][_userId] -= _points;
        voucherStatus[msg.sender] = voucher.tokened;
        IERC20(ercAddress).transfer(msg.sender, share * 10 ** 18);
        emit TokenConversion(_userId, msg.sender, share, voucher.tokened);
    }

    // it generates theVoucher for the user based on business logic.
    function vocherGeneration(
        uint _userId,
        uint _points,
        uint rate
    ) external nonReentrant returns (bytes32) {
        require(voucherStatus[msg.sender] == voucher.notredeem, "its Redeemed");
        uint share = _points / rate;
        require(pointOf[msg.sender][_userId] >= _points, "insuffient points");
        bytes32 hash = getRandomValue(msg.sender);
        pointOf[msg.sender][_userId] -= _points;
        voucherHash[msg.sender] = hash;
        voucherStatus[msg.sender] = voucher.redeemed;
        voucherShare[msg.sender][hash] = share;
        emit VocherGeneration(_userId, msg.sender, share, voucher.redeemed);
        return voucherHash[msg.sender];
    }

    // it will generate randomHash value for the Voucher.
    function getRandomValue(address user) internal view returns (bytes32) {
        uint256 blockValue = uint256(block.timestamp);
        return bytes32(keccak256(abi.encodePacked(blockValue, user)));
    }
}
