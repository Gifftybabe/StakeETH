// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract StakeEth {

    //function stake

    //Multiple User can stake.
    /**
    * stakes => [user][amount, duration, interest]
    */

    uint256 constant public MAX_DURATION = 60; //in days
    uint256 constant public DAYS_IN_YEAR = 365;
    uint256 constant public FIXED_RATE = 10; //RATE IN PERCENTAGE

    constructor () payable {
        
    }


    struct Stake{
        address _address;
        uint256 endTime;
        uint256 expectedInterest;
        bool isComplete;
    }
    Stake [] stakes;
    mapping (address => Stake[]) userStakes;

    function stake () external payable {
        require(msg.sender != address(0), "Address zero detected");
        require(msg.value > 0, "Amount must be greater than zero");
        // When staking calculate estimated Reward for the user 
        Stake memory newStake = Stake({
            _address: msg.sender,
            endTime: block.timestamp + MAX_DURATION,
            expectedInterest: calculateInterest(msg.value, FIXED_RATE, MAX_DURATION),
            isComplete: false
        });
        stakes.push(newStake);
        userStakes[msg.sender] = stakes; 
    }

     //claimReward
    function claimReward(address _address, uint256 _index) external payable {
        require(userStakes[_address][_index].expectedInterest > 0, "No valid stake at the selected index");
        Stake storage selectedStake = userStakes[_address][_index];
        require(block.timestamp > selectedStake.endTime, "Stake is still ongoing");
        require(!selectedStake.isComplete, "Stake already completed");
        require(address(this).balance >= selectedStake.expectedInterest, "Contract does not have enough funds");
        selectedStake.isComplete = true;
        (bool success,) = msg.sender.call{value: selectedStake.expectedInterest}("");
        require(success, "Reward transfer failed");
    }


    function getAllUserStakes(address _address) external view returns (Stake[] memory) {
        require(msg.sender != address(0), "Address zero detected.");
        require(userStakes[_address].length > 0, "User not found.");
        return userStakes[_address];
    }

    
    function calculateInterest(uint256 principal, uint256 rate, uint256 daysStaked) public pure returns (uint256) {
        // Simple interest formula: Interest = P * r * t
        // Where r = interestRate / 100 and t = daysStaked / DAYS_IN_YEAR
        uint256 timeInYears = daysStaked * 1e18 / DAYS_IN_YEAR; // Converting to wei for precision
        uint256 interest = (principal * rate * timeInYears) / (100 * 1e18); // Calculating interest
        return principal + interest;
    }
}
