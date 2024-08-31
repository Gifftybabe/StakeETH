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
}