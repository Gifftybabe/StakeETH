// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract StakeToken is ReentrancyGuard {

    // ERC-20 token to be used for staking
    IERC20 public token;

    // Constants
    uint256 public constant MAX_DURATION = 60 days; // in seconds
    uint256 public constant FIXED_RATE = 10; // rate in percentage

    // Struct to represent a stake
    struct Stake {
        address _address;
        uint256 endTime;
        uint256 expectedInterest;
        bool isComplete;
    }