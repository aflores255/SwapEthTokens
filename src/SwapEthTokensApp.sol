//1. License
//SPDX-License-Identifier: MIT

//2. Solidity
pragma solidity 0.8.28;

import "./interfaces/IRouterV2.sol";
import "../lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
import "../lib/openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol";

//3. Contract

contract SwapEthTokensApp {
    using SafeERC20 for IERC20;

    //Variables
    address public RouterV2Address;
    //Events

    event SwapERC20Tokens(address tokenIn, address tokenOut, uint256 amountIn, uint256 amountOut);
    event SwapETHForTokens(address tokenOut, uint256 amountIn, uint256 amountOut);
    event SwapTokensForETH(address tokenIn, uint256 amountIn, uint256 amountOut);

    /**
     * @notice Contract constructor
     * @param RouterV2Address_ Address of the router contract to perform swaps
     */
    constructor(address RouterV2Address_) {
        RouterV2Address = RouterV2Address_;
    }

    /**
     * @notice Swap an exact amount of input tokens for as many output tokens as possible
     * @param amountIn_ Exact amount of tokens to send
     * @param amountOutMin_ Minimum amount of output tokens expected
     * @param path_ Array of token addresses (swap route)
     * @param deadline_ Latest timestamp the transaction is valid
     */
    function swapExactTokensForTokens(
        uint256 amountIn_,
        uint256 amountOutMin_,
        address[] memory path_,
        uint256 deadline_
    ) external {
        //Get first Token
        IERC20(path_[0]).safeTransferFrom(msg.sender, address(this), amountIn_);
        //Approve
        IERC20(path_[0]).approve(RouterV2Address, amountIn_);
        //Swap
        uint256[] memory amountsOut_ =
            IRouterV2(RouterV2Address).swapExactTokensForTokens(amountIn_, amountOutMin_, path_, msg.sender, deadline_);

        emit SwapERC20Tokens(path_[0], path_[path_.length - 1], amountIn_, amountsOut_[amountsOut_.length - 1]);
    }

    /**
     * @notice Swap tokens to receive an exact amount of output tokens
     * @param amountOut_ Exact amount of tokens desired
     * @param amountInMax_ Maximum amount of input tokens allowed
     * @param path_ Array of token addresses (swap route)
     * @param deadline_ Latest timestamp the transaction is valid
     */
    function swapTokensForExactTokens(
        uint256 amountOut_,
        uint256 amountInMax_,
        address[] memory path_,
        uint256 deadline_
    ) external {
        // Get First Token MaxIn
        IERC20(path_[0]).safeTransferFrom(msg.sender, address(this), amountInMax_);
        //Approve
        IERC20(path_[0]).approve(RouterV2Address, amountInMax_);

        uint256[] memory amounts_ =
            IRouterV2(RouterV2Address).swapTokensForExactTokens(amountOut_, amountInMax_, path_, msg.sender, deadline_);

        emit SwapERC20Tokens(path_[0], path_[path_.length - 1], amounts_[0], amountOut_);
    }

    /**
     * @notice Swap exact amount of ETH for as many tokens as possible
     * @param amountOutMin_ Minimum amount of tokens expected
     * @param path_ Array of token addresses (first address must be WETH)
     * @param deadline_ Latest timestamp the transaction is valid
     */
    function swapExactETHForTokens(uint256 amountOutMin_, address[] memory path_, uint256 deadline_) external payable {
        require(msg.value > 0, "Incorrect amount");
        uint256[] memory amounts_ = IRouterV2(RouterV2Address).swapExactETHForTokens{value: msg.value}(
            amountOutMin_, path_, msg.sender, deadline_
        );

        emit SwapETHForTokens(path_[path_.length - 1], msg.value, amounts_[amounts_.length - 1]);
    }

    /**
     * @notice Swap tokens to receive an exact amount of ETH
     * @param amountOut_ Exact amount of ETH desired
     * @param amountInMax_ Maximum amount of tokens allowed to spend
     * @param path_ Array of token addresses (last address must be WETH)
     * @param deadline_ Latest timestamp the transaction is valid
     */
    function swapTokensForExactETH(uint256 amountOut_, uint256 amountInMax_, address[] memory path_, uint256 deadline_)
        external
    {
        // Get First Token MaxIn
        IERC20(path_[0]).safeTransferFrom(msg.sender, address(this), amountInMax_);
        // Approve
        IERC20(path_[0]).approve(RouterV2Address, amountInMax_);

        uint256[] memory amounts_ =
            IRouterV2(RouterV2Address).swapTokensForExactETH(amountOut_, amountInMax_, path_, msg.sender, deadline_);

        emit SwapTokensForETH(path_[0], amounts_[0], amountOut_);
    }

    /**
     * @notice Swap an exact amount of tokens for as much ETH as possible
     * @param amountIn_ Exact amount of tokens to send
     * @param amountOutMin_ Minimum amount of ETH expected
     * @param path_ Array of token addresses (last address must be WETH)
     * @param deadline_ Latest timestamp the transaction is valid
     */
    function swapExactTokensForETH(uint256 amountIn_, uint256 amountOutMin_, address[] memory path_, uint256 deadline_)
        external
    {
        IERC20(path_[0]).safeTransferFrom(msg.sender, address(this), amountIn_);
        IERC20(path_[0]).approve(RouterV2Address, amountIn_);

        uint256[] memory amounts =
            IRouterV2(RouterV2Address).swapExactTokensForETH(amountIn_, amountOutMin_, path_, msg.sender, deadline_);

        emit SwapTokensForETH(path_[0], amountIn_, amounts[amounts.length - 1]);
    }
}
