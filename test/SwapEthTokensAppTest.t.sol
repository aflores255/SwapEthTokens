//1. License
//SPDX-License-Identifier: MIT

//2. Solidity
pragma solidity 0.8.28;

import "forge-std/Test.sol";
import "../src/SwapEthTokensApp.sol";

//3. Contract

contract SwapTokensAppTest is Test {
    SwapEthTokensApp swapEthTokensApp;
    address routerAddress = 0x4752ba5DBc23f44D87826276BF6Fd6b1C372aD24; // Arbitrum one
    address user1 = 0x7711C90bD0a148F3dd3f0e587742dc152c3E9DDB; // Holder USDC
    address user2 = 0x52Aa899454998Be5b000Ad077a46Bbe360F4e497; //Holder USDT
    address USDC = 0xaf88d065e77c8cC2239327C5EDb3A432268e5831; // USDC Address in Arbitrum One Mainnet
    address USDT = 0xFd086bC7CD5C481DCC9C85ebE478A1C0b69FCbb9; // USDT Address in Arbitrum One Mainnet
    address WETH = 0x82aF49447D8a07e3bd95BD0d56f35241523fBab1; //WETH Address in Arbitrum One Mainnet

    /**
     * @notice Deploys the SwapEthTokensApp contract before running each test.
     */
    function setUp() public {
        swapEthTokensApp = new SwapEthTokensApp(routerAddress);
    }

    /**
     * @notice Tests that the deployed contract stores the correct router address.
     */
    function testInitialDeploy() public view {
        assert(swapEthTokensApp.RouterV2Address() == routerAddress);
    }

    /**
     * @notice Tests swapping an exact amount of USDC for USDT.
     */
    function testSwapExactTokensForTokens() public {
        uint256 amountIn_ = 10 * 1e6;
        uint256 amountOutMin_ = 9 * 1e6;
        uint256 deadline_ = block.timestamp + 600000;
        address[] memory path_ = new address[](2);
        path_[0] = USDC;
        path_[1] = USDT;

        vm.startPrank(user1);
        uint256 userToken1BalanceBefore = IERC20(USDC).balanceOf(user1);
        uint256 userToken2BalanceBefore = IERC20(USDT).balanceOf(user1);

        IERC20(USDC).approve(address(swapEthTokensApp), amountIn_);
        swapEthTokensApp.swapExactTokensForTokens(amountIn_, amountOutMin_, path_, deadline_);

        uint256 userToken1BalanceAfter = IERC20(USDC).balanceOf(user1);
        uint256 userToken2BalanceAfter = IERC20(USDT).balanceOf(user1);

        assert(userToken1BalanceAfter == userToken1BalanceBefore - amountIn_);
        assert(
            userToken2BalanceBefore < userToken2BalanceAfter
                && (userToken2BalanceAfter - userToken2BalanceBefore >= amountOutMin_)
        );

        vm.stopPrank();
    }

    /**
     * @notice Tests swapping USDC for an exact amount of USDT.
     */
    function testSwapTokensForExactTokens() public {
        uint256 amountOut_ = 9 * 1e6;
        uint256 amountInMax_ = 10 * 1e6;
        uint256 deadline_ = block.timestamp + 600000;

        address[] memory path_ = new address[](2);
        path_[0] = USDC;
        path_[1] = USDT;

        vm.startPrank(user1);
        uint256 userToken1BalanceBefore = IERC20(USDC).balanceOf(user1);
        uint256 userToken2BalanceBefore = IERC20(USDT).balanceOf(user1);

        IERC20(USDC).approve(address(swapEthTokensApp), amountInMax_);

        swapEthTokensApp.swapTokensForExactTokens(amountOut_, amountInMax_, path_, deadline_);
        uint256 userToken1BalanceAfter = IERC20(USDC).balanceOf(user1);
        uint256 userToken2BalanceAfter = IERC20(USDT).balanceOf(user1);

        assert(userToken2BalanceAfter == userToken2BalanceBefore + amountOut_);
        assert(
            (userToken1BalanceAfter < userToken1BalanceBefore)
                && (userToken1BalanceBefore - userToken1BalanceAfter <= amountInMax_)
        );

        vm.stopPrank();
    }

    /**
     * @notice Tests swapping an exact amount of USDC for ETH.
     */
    function testSwapExactTokensForETH() public {
        uint256 amountIn_ = 10 * 1e6;
        uint256 amountOutMin_ = 0.003 ether;
        uint256 deadline_ = block.timestamp + 600000;

        address[] memory path_ = new address[](2);
        path_[0] = USDC;
        path_[1] = WETH;

        vm.startPrank(user2);
        uint256 userToken1BalanceBefore = IERC20(USDC).balanceOf(user2);
        uint256 userEthBalanceBefore = user2.balance;
        IERC20(USDC).approve(address(swapEthTokensApp), amountIn_);

        swapEthTokensApp.swapExactTokensForETH(amountIn_, amountOutMin_, path_, deadline_);
        uint256 userToken1BalanceAfter = IERC20(USDC).balanceOf(user2);

        assert(user2.balance >= userEthBalanceBefore + amountOutMin_);
        assert(userToken1BalanceAfter == userToken1BalanceBefore - amountIn_);

        vm.stopPrank();
    }

    /**
     * @notice Tests swapping USDC for an exact amount of ETH.
     */
    function testSwapTokensForExactETH() public {
        uint256 amountOut_ = 0.003 ether;
        uint256 amountInMax_ = 10 * 1e6;
        uint256 deadline_ = block.timestamp + 600000;

        address[] memory path_ = new address[](2);
        path_[0] = USDC;
        path_[1] = WETH;

        vm.startPrank(user2);
        uint256 userToken1BalanceBefore = IERC20(USDC).balanceOf(user2);
        uint256 userEthBalanceBefore = user2.balance;
        IERC20(USDC).approve(address(swapEthTokensApp), amountInMax_);

        swapEthTokensApp.swapTokensForExactETH(amountOut_, amountInMax_, path_, deadline_);
        uint256 userToken1BalanceAfter = IERC20(USDC).balanceOf(user2);

        assert(user2.balance == userEthBalanceBefore + amountOut_);
        assert(
            (userToken1BalanceAfter < userToken1BalanceBefore)
                && (userToken1BalanceBefore - userToken1BalanceAfter >= amountInMax_)
        );

        vm.stopPrank();
    }

    /**
     * @notice Tests swapping an exact amount of ETH for USDC.
     */
    function testSwapExactETHForTokens() public {
        uint256 amountOutMin_ = 1.5 * 1e6;
        uint256 ethAmount_ = 0.001 ether;
        uint256 deadline_ = block.timestamp + 600000;

        address[] memory path_ = new address[](2);
        path_[0] = WETH;
        path_[1] = USDC;

        vm.startPrank(user2);
        uint256 userTokenBalanceBefore = IERC20(USDC).balanceOf(user2);
        uint256 userEthBalanceBefore = user2.balance;
        swapEthTokensApp.swapExactETHForTokens{value: ethAmount_}(amountOutMin_, path_, deadline_);
        uint256 userTokenBalanceAfter = IERC20(USDC).balanceOf(user2);
        assert(userEthBalanceBefore - user2.balance == ethAmount_);
        assert(userTokenBalanceAfter - userTokenBalanceBefore >= amountOutMin_);
        vm.stopPrank();
    }

    /**
     * @notice Tests reverting when trying to swap 0 ETH.
     */
    function testIncorrectSwapExactETHForTokens() public {
        uint256 amountOutMin_ = 1.5 * 1e6;
        uint256 ethAmount_ = 0 ether;
        uint256 deadline_ = block.timestamp + 600000;

        address[] memory path_ = new address[](2);
        path_[0] = WETH;
        path_[1] = USDC;

        vm.startPrank(user1);
        vm.expectRevert("Incorrect amount");
        swapEthTokensApp.swapExactETHForTokens{value: ethAmount_}(amountOutMin_, path_, deadline_);
        vm.stopPrank();
    }
}
