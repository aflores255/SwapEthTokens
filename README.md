# 🔁 SwapEthTokensApp – A Smart Contract for Token and ETH Swaps Using a Uniswap V2-Compatible Router

## 📌 Description

**SwapEthTokensApp** is a versatile and gas-efficient Solidity smart contract that enables users to perform secure and seamless swaps between ERC-20 tokens and ETH. Designed to work with any Uniswap V2-compatible router, it covers all major swap operations including token-to-token, ETH-to-token, and token-to-ETH – making it a powerful DeFi building block for any dApp.

Built with **Solidity 0.8.28**, the contract uses OpenZeppelin's `SafeERC20` for secure token interactions and includes a comprehensive test suite written in **Foundry**, tested on **Arbitrum One**.

---

## 🚀 Features

| **Feature** | **Description** |
|-------------|-----------------|
| 🔄 **Token ↔ Token Swaps** | Swap ERC-20 tokens via customizable paths. |
| 🌐 **ETH ↔ Token Swaps** | Seamlessly convert between ETH and tokens. |
| 🛡️ **Secure Transfers** | Utilizes `SafeERC20` from OpenZeppelin for secure token operations. |
| 🧪 **Foundry Test Suite** | Includes end-to-end tests using real tokens and users. |
| 📡 **Event Logging** | Emits detailed events after every swap for easy tracking. |

---

## 📜 Contract Details

### ⚙️ Constructor

```solidity
constructor(address RouterV2Address_)
```

Sets the address of the router (e.g., UniswapV2 or similar) to handle swaps.

---

### 🔧 Functions

| **Function** | **Description** |
|--------------|------------------|
| `swapExactTokensForTokens` | Swaps a fixed amount of tokens for a minimum amount of output tokens. |
| `swapTokensForExactTokens` | Swaps a variable amount of tokens to receive a fixed amount of output tokens. |
| `swapExactETHForTokens` | Swaps a fixed amount of ETH for a minimum amount of tokens. |
| `swapTokensForExactETH` | Swaps a variable amount of tokens to receive a fixed amount of ETH. |
| `swapExactTokensForETH` | Swaps a fixed amount of tokens for a minimum amount of ETH. |

---

### 📡 Events

| **Event** | **Description** |
|-----------|-----------------|
| `SwapERC20Tokens` | Emitted when tokens are swapped for other tokens. |
| `SwapETHForTokens` | Emitted when ETH is swapped for tokens. |
| `SwapTokensForETH` | Emitted when tokens are swapped for ETH. |

---

## 🧪 Testing with Foundry

All swap functions are tested with real user addresses and token balances on the **Arbitrum One** mainnet. 

### ✅ Implemented Tests

| **Test** | **Description** |
|----------|------------------|
| `testInitialDeploy` | Validates constructor sets router correctly. |
| `testSwapExactTokensForTokens` | Tests token-to-token swap with fixed input. |
| `testSwapTokensForExactTokens` | Tests token-to-token swap with fixed output. |
| `testSwapExactTokensForETH` | Tests token-to-ETH swap with fixed input. |
| `testSwapTokensForExactETH` | Tests token-to-ETH swap with fixed output. |
| `testSwapExactETHForTokens` | Tests ETH-to-token swap with fixed input. |
| `testIncorrectSwapExactETHForTokens` | Ensures function reverts with 0 ETH input. |

### 📊 Coverage Report

| File                    | % Lines         | % Statements     | % Branches      | % Functions     |
|-------------------------|------------------|-------------------|------------------|------------------|
| `src/SwapEthTokensApp.sol` | 100.00% (30/30) | 100.00% (25/25) | 100.00% (2/2) | 100.00% (6/6)   |


---

## 🔗 Dependencies

- [OpenZeppelin Contracts](https://github.com/OpenZeppelin/openzeppelin-contracts)
- [Foundry](https://book.getfoundry.sh/)
- [`IRouterV2.sol`](https://github.com/aflores255/SwapEthTokens/blob/master/src/interfaces/IRouterV2.sol) - Custom interface compatible with Uniswap V2

---

## 🛠️ How to Use

### 🔧 Prerequisites

- [Foundry](https://book.getfoundry.sh/getting-started/installation) installed
- Access to the **Arbitrum One** network
- Wallet with ETH and ERC-20 tokens (e.g., USDC, USDT, WETH)

---

### 🧪 Run Tests

```bash
forge test
```

---

### 🚀 Deployment

1. Clone the repository:

```bash
git clone https://github.com/aflores255/SwapEthTokensApp.git
cd SwapEthTokensApp
```

2. Deploy the contract with your preferred tool 

```solidity
new SwapEthTokensApp(routerAddress);
```

Pass the router address (e.g., UniswapV2 router on Arbitrum) to the constructor.

---

## 📄 License

This project is licensed under the **MIT License**.
