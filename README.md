# ERC20 and Ether Staking Project

## Overview
This project consists of two Solidity contracts: 
1. `ERC20Staking` – Enables users to stake ERC20 tokens and receive rewards over time.
2. `EtherStaking` – Allows users to stake Ether (ETH) and earn rewards based on staking duration.

The owner of the contracts can set the reward rate, deposit tokens or Ether, and withdraw tokens or Ether from the contract. Users can stake their tokens or Ether, view their current stake, and withdraw their staked assets along with rewards after the staking period.

## Contracts

### 1. `ERC20Staking`
The `ERC20Staking` contract allows users to stake an ERC20 token and earn rewards based on the staked amount and time. The reward rate is set by the contract owner.

#### Features:
- **Staking**: Users can stake a specified amount of ERC20 tokens for a given duration.
- **Reward Calculation**: Rewards are calculated daily based on the reward rate set by the contract owner.
- **Withdrawal**: After the staking period has elapsed, users can withdraw both the staked tokens and the accumulated rewards.
- **Owner Controls**: The owner can set the reward rate, deposit tokens, and withdraw tokens from the contract.

#### Key Functions:
- `deposit(uint256 _amount)`: Allows the owner to deposit tokens into the contract.
- `stake(uint256 _amount, uint256 _duration)`: Allows users to stake tokens for a specified duration.
- `withdrawStake()`: Users can withdraw their staked tokens and rewards after the staking period ends.
- `calculateReward(address _user)`: Calculates the staking reward based on the reward rate and time staked.

### 2. `EtherStaking`
The `EtherStaking` contract allows users to stake Ether and earn rewards based on the staked amount and time. Similar to the ERC20 contract, the reward rate is set by the contract owner.

#### Features:
- **Ether Staking**: Users can stake Ether for a specific duration and earn rewards.
- **Reward Calculation**: Rewards are calculated daily based on the staking duration and reward rate.
- **Withdrawal**: Users can withdraw their staked Ether and rewards after the staking period has elapsed.
- **Owner Controls**: The owner can set the reward rate and withdraw Ether from the contract.

#### Key Functions:
- `deposit()`: Allows the owner to deposit Ether into the contract.
- `stake(uint256 _duration)`: Users can stake Ether for a specified duration.
- `withdrawStake()`: Users can withdraw their staked Ether and rewards after the staking period ends.
- `calculateReward(address _user)`: Calculates the staking reward based on the reward rate and time staked.

## Requirements

- Solidity version `0.8.26`
- OpenZeppelin contracts for ERC20 (`IERC20.sol`, `ERC20.sol`)
  
## Installation

1. Install dependencies:
   ```bash
   npm install @openzeppelin/contracts
   ```

2. Compile the contracts:
   ```bash
   npx hardhat compile
   ```

3. Deploy the contracts using Hardhat or any compatible Ethereum deployment tool.

## License

This project is licensed under the MIT License.