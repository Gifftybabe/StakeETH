// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;
import "./IERC20.sol";

contract StakingWithERC20 {
    IERC20 public giftToken;
    uint256 public constant DAYS_IN_YEAR = 365;
    uint256 public constant TIER_1_RATE = 5; // 5% for 30 days
    uint256 public constant TIER_2_RATE = 10; // 10% for 60 days
    uint256 public constant TIER_3_RATE = 15; // 15% for 90 days

    uint256 public constant TIER_1_DURATION = 30 days;
    uint256 public constant TIER_2_DURATION = 60 days;
    uint256 public constant TIER_3_DURATION = 90 days;

    struct Stake {
        address staker;
        uint256 principal;
        uint256 startTime;
        uint256 duration;
        uint256 interestRate;
        bool isComplete;
    }

    mapping(address => Stake[]) public userStakes;

    constructor(address _giftToken) {
        giftToken = IERC20(_giftToken);
    }

    // Allows users to stake their tokens and select a tier (1, 2, or 3)
    function stake(uint8 _tier, uint256 _amount) external {
        require(msg.sender != address(0), "Invalid address");
        require(_amount > 0, "Amount must be greater than zero");
        require(_tier >= 1 && _tier <= 3, "Invalid tier selected");

        // Set the duration and interest rate based on the selected tier
        uint256 duration;
        uint256 interestRate;

        if (_tier == 1) {
            duration = TIER_1_DURATION;
            interestRate = TIER_1_RATE;
        } else if (_tier == 2) {
            duration = TIER_2_DURATION;
            interestRate = TIER_2_RATE;
        } else if (_tier == 3) {
            duration = TIER_3_DURATION;
            interestRate = TIER_3_RATE;
        }

        // Transfer the GIFT tokens to the contract
        require(
            giftToken.transferFrom(msg.sender, address(this), _amount),
            "Token transfer failed"
        );

        // Create a new stake
        Stake memory newStake = Stake({
            staker: msg.sender,
            principal: _amount,
            startTime: block.timestamp,
            duration: duration,
            interestRate: interestRate,
            isComplete: false
        });

        // Store the stake
        userStakes[msg.sender].push(newStake);
    }

    // Users claim their reward after the stake period ends
    function claimReward(uint256 _index) external {
        require(_index < userStakes[msg.sender].length, "Invalid stake index");
        Stake storage stakeData = userStakes[msg.sender][_index];
        require(!stakeData.isComplete, "Stake already claimed");
        require(
            block.timestamp >= stakeData.startTime + stakeData.duration,
            "Stake period not ended"
        );

        // Calculate interest and total reward
        uint256 totalReward = calculateInterest(
            stakeData.principal,
            stakeData.interestRate,
            stakeData.duration
        );

        // Mark the stake as completed
        stakeData.isComplete = true;

        // Transfer the reward + principal to the user
        require(
            giftToken.balanceOf(address(this)) >= totalReward,
            "Insufficient contract token balance"
        );
        require(
            giftToken.transfer(msg.sender, totalReward),
            "Reward transfer failed"
        );
    }

    // View function to get all stakes for a user
    function getUserStakes(
        address _user
    ) external view returns (Stake[] memory) {
        return userStakes[_user];
    }

    // Interest calculation formula
    function calculateInterest(
        uint256 _principal,
        uint256 _rate,
        uint256 _duration
    ) public pure returns (uint256) {
        // Simple interest formula: Interest = P * r * t
        // Where r = interestRate / 100 and t = duration / DAYS_IN_YEAR
        uint256 timeInYears = (_duration * 1e18) / DAYS_IN_YEAR; // Using wei for precision
        uint256 interest = (_principal * _rate * timeInYears) / (100 * 1e18); // Calculating interest
        return _principal + interest; // Return principal + interest
    }   
}