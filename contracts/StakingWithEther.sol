// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract StakingWithEther {

    uint256 constant public DAYS_IN_YEAR = 365;
    uint256 constant public TIER_1_RATE = 5;  // 5% for 30 days
    uint256 constant public TIER_2_RATE = 10; // 10% for 60 days
    uint256 constant public TIER_3_RATE = 15; // 15% for 90 days

    uint256 constant public TIER_1_DURATION = 30 days;
    uint256 constant public TIER_2_DURATION = 60 days;
    uint256 constant public TIER_3_DURATION = 90 days;

    struct Stake {
        address staker;
        uint256 principal;
        uint256 startTime;
        uint256 duration;
        uint256 interestRate;
        bool isComplete;
    }

    mapping(address => Stake[]) public userStakes;

    // Allows users to stake their ETH and select a tier (1, 2, or 3)
    function stake(uint8 _tier) external payable {
        require(msg.sender != address(0), "Invalid address");
        require(msg.value > 0, "Amount must be greater than zero");
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

        // Create a new stake
        Stake memory newStake = Stake({
            staker: msg.sender,
            principal: msg.value,
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
        require(block.timestamp >= stakeData.startTime + stakeData.duration, "Stake period not ended");

        // Calculate interest and total reward
        uint256 totalReward = calculateInterest(stakeData.principal, stakeData.interestRate, stakeData.duration);

        // Mark the stake as completed
        stakeData.isComplete = true;

        // Transfer the reward + principal to the user
        require(address(this).balance >= totalReward, "Insufficient contract balance");
        (bool success,) = msg.sender.call{value: totalReward}("");
        require(success, "Reward transfer failed");
    }

    // View function to get all stakes for a user
    function getUserStakes(address _user) external view returns (Stake[] memory) {
        return userStakes[_user];
    }

    // Interest calculation formula
    function calculateInterest(uint256 _principal, uint256 _rate, uint256 _duration) public pure returns (uint256) {
        // Simple interest formula: Interest = P * r * t
        // Where r = interestRate / 100 and t = duration / DAYS_IN_YEAR
        uint256 timeInYears = _duration * 1e18 / DAYS_IN_YEAR; // Using wei for precision
        uint256 interest = (_principal * _rate * timeInYears) / (100 * 1e18); // Calculating interest
        return _principal + interest; // Return principal + interest
    }

    // Fallback function to receive ETH
    receive() external payable {}
}