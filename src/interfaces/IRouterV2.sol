//1. License
//SPDX-License-Identifier: MIT

//2. Solidity
pragma solidity 0.8.28;

//3. Interface

interface IRouterV2 {
    /**
     * @notice Swaps an exact amount of input tokens for as many output tokens as possible.
     * @param amountIn Amount of input tokens to send.
     * @param amountOutMin Minimum amount of output tokens that must be received for the transaction not to revert.
     * @param path Array of token addresses (swap route).
     * @param to Address to receive the output tokens.
     * @param deadline Unix timestamp after which the transaction will revert.
     * @return amounts Array of token amounts at each step of the swap.
     */
    function swapExactTokensForTokens(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external returns (uint256[] memory amounts);

    /**
     * @notice Swaps tokens to receive an exact amount of output tokens.
     * @param amountOut Exact amount of output tokens desired.
     * @param amountInMax Maximum amount of input tokens allowed.
     * @param path Array of token addresses (swap route).
     * @param to Address to receive the output tokens.
     * @param deadline Unix timestamp after which the transaction will revert.
     * @return amounts Array of token amounts at each step of the swap.
     */
    function swapTokensForExactTokens(
        uint256 amountOut,
        uint256 amountInMax,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external returns (uint256[] memory amounts);

    /**
     * @notice Swaps ETH for as many output tokens as possible.
     * @param amountOutMin Minimum amount of output tokens that must be received for the transaction not to revert.
     * @param path Array of token addresses (first address must be WETH).
     * @param to Address to receive the output tokens.
     * @param deadline Unix timestamp after which the transaction will revert.
     * @return amounts Array of token amounts at each step of the swap.
     */
    function swapExactETHForTokens(uint256 amountOutMin, address[] calldata path, address to, uint256 deadline)
        external
        payable
        returns (uint256[] memory amounts);

    /**
     * @notice Swaps tokens to receive an exact amount of ETH.
     * @param amountOut Exact amount of ETH desired.
     * @param amountInMax Maximum amount of input tokens allowed.
     * @param path Array of token addresses (last address must be WETH).
     * @param to Address to receive the ETH.
     * @param deadline Unix timestamp after which the transaction will revert.
     * @return amounts Array of token amounts at each step of the swap.
     */
    function swapTokensForExactETH(
        uint256 amountOut,
        uint256 amountInMax,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external returns (uint256[] memory amounts);

    /**
     * @notice Swaps an exact amount of tokens for as much ETH as possible.
     * @param amountIn Amount of input tokens to send.
     * @param amountOutMin Minimum amount of ETH that must be received for the transaction not to revert.
     * @param path Array of token addresses (last address must be WETH).
     * @param to Address to receive the ETH.
     * @param deadline Unix timestamp after which the transaction will revert.
     * @return amounts Array of token amounts at each step of the swap.
     */
    function swapExactTokensForETH(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external returns (uint256[] memory amounts);
}
