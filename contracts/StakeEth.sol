// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract StakeEth {

    uint256 public duration = 30; //days

    mapping (address => uint256) userStake;

    //function to stake
    function stake() external payable  {
        require(msg.sender != address(0), "Address zero detected");
        require(msg.value > 0, "Amount must be greater than zero.");
        uint256 amount = msg.value;
        userStake[msg.sender] += amount;
    }
    //function  to claimReward

    // function to Withdraw

}
