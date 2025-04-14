# 🔁 SwapEthTokensApp

## 📌 Description

**SwapEthTokensApp** is a Solidity smart contract that allows users to seamlessly swap between ERC-20 tokens and ETH using a Uniswap V2-compatible router. It supports most major swap scenarios including token-to-token, ETH-to-token, and token-to-ETH swaps.

Built with **Solidity 0.8.28**, the contract uses OpenZeppelin's `SafeERC20` for secure token interactions and includes a comprehensive test suite written in **Foundry**, deployed and tested on **Arbitrum One**.

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

---

## 🔗 Dependencies

- [OpenZeppelin Contracts](https://github.com/OpenZeppelin/openzeppelin-contracts)
- [Foundry](https://book.getfoundry.sh/)
- [`IRouterV2.sol`](./interfaces/IRouterV2.sol) - Custom interface compatible with Uniswap V2

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
