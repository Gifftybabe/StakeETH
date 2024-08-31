# Staking Smart Contracts

This repository provides a set of Solidity smart contracts designed for staking both ERC20 tokens and Ether. The contracts enable users to earn rewards by locking their assets in the contract for specified periods, with varying interest rates based on the chosen staking tier.

## Contracts Included

### `StakingWithERC20`

Allows users to stake ERC20 tokens. Users can select from three tiers, each offering different interest rates and durations:

- **Tier 1**: 5% interest for 30 days
- **Tier 2**: 10% interest for 60 days
- **Tier 3**: 15% interest for 90 days

#### Key Features:
- **Stake Tokens**: Deposit ERC20 tokens and choose a staking tier.
- **Claim Rewards**: Retrieve earned rewards after the staking period.
- **View Stakes**: Access detailed information on user stakes.

### `StakingWithEther`

Facilitates staking of Ether with similar tier-based interest rates and durations:

- **Tier 1**: 5% interest for 30 days
- **Tier 2**: 10% interest for 60 days
- **Tier 3**: 15% interest for 90 days

#### Key Features:
- **Stake Ether**: Deposit Ether and select a staking tier.
- **Claim Rewards**: Withdraw rewards upon completing the staking period.
- **View Stakes**: Retrieve details of user stakes.
- **Fallback Function**: Allows the contract to receive Ether.

### `NGtoken`

A sample ERC20 token contract used for interacting with the `StakingWithERC20` contract. This contract supports basic minting operations and initial token distribution.

#### Key Features:
- **Mint Tokens**: Create new tokens (restricted to the contract owner).

## Getting Started

1. **Clone the Repository**:
   ```sh
   git clone https://github.com/Gifftybabe/StakeETH.git
   cd StakeETH.git
   ```

2. **Install Dependencies**:
   ```sh
   npm install
   ```

3. **Deploy Contracts**:
   - **Deploy `NGtoken`**: Deploy the ERC20 token contract first.
   - **Deploy `StakingWithERC20`**: Deploy the ERC20 staking contract with the address of the deployed token.
   - **Deploy `StakingWithEther`**: Deploy the Ether staking contract.

4. **Interact with Contracts**:
   - Use the `stake` functions to deposit assets.
   - Claim rewards using the `claimReward` functions.
   - Check staking details with the `getUserStakes` functions.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.


