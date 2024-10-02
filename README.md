# ERC20 and Ether Staking Project

## Overview
This project includes two Solidity smart contracts that allow users to stake ERC20 tokens or Ether (ETH) and earn rewards over time. Both contracts were successfully deployed on the **Lisk Sepolia Testnet** at the addresses provided below.

### Contracts:
1. **ERC20Staking** – Enables users to stake ERC20 tokens and earn rewards.
2. **EtherStaking** – Allows users to stake Ether and earn rewards based on the staking duration.

The contract owner can set the reward rate, deposit or withdraw assets, and manage the staking process, while users can stake their assets and withdraw them along with rewards after the staking period.

## Deployed Contracts

- **ERC20Staking Contract**: `0x1eD88aacAF58bbbfE2c05e60eC67d945D58140Ab`
- **ERC20Token Contract**: `0x04779da65d93DcF42Cf50589779cdB52D77A4c0B`
- **EtherStaking Contract**: `0x203f460B27333B150cd4a41A62120E351Ac6eA8C`

## Contract Details

### 1. ERC20Staking Contract

The `ERC20Staking` contract allows users to stake an ERC20 token and receive rewards based on the amount staked and the staking duration. The owner sets the reward rate.

#### Features:
- **Staking**: Stake ERC20 tokens for a chosen period.
- **Reward Calculation**: Rewards are calculated daily based on the reward rate set by the owner.
- **Withdrawals**: After the staking period ends, users can withdraw their tokens and rewards.
- **Owner Controls**: The owner manages reward rates, token deposits, and withdrawals.

#### Key Functions:
- `deposit(uint256 _amount)`: Owner deposits ERC20 tokens into the contract.
- `stake(uint256 _amount, uint256 _duration)`: Users stake tokens for a chosen duration.
- `withdrawStake()`: Withdraw staked tokens and rewards after the staking period ends.
- `calculateReward(address _user)`: Calculates user rewards based on the reward rate and staking period.

### 2. EtherStaking Contract

The `EtherStaking` contract enables users to stake Ether and earn rewards based on the staking duration. The owner sets the reward rate.

#### Features:
- **Ether Staking**: Users stake Ether for a specific duration.
- **Reward Calculation**: Rewards are calculated daily based on the staked Ether and time.
- **Withdrawals**: Users can withdraw Ether and rewards after the staking period ends.
- **Owner Controls**: The owner manages reward rates and Ether withdrawals.

#### Key Functions:
- `deposit()`: Owner deposits Ether into the contract.
- `stake(uint256 _duration)`: Users stake Ether for a specific period.
- `withdrawStake()`: Withdraw staked Ether and rewards after the staking period ends.
- `calculateReward(address _user)`: Calculates user rewards based on the reward rate and staking duration.

