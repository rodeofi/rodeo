// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

interface IJoeLBPair {
    function tokenX() external view returns (address);
    function tokenY() external view returns (address);
    function getReservesAndId() external view returns (uint256 reserveX, uint256 reserveY, uint256 activeId);
    function totalSupply(uint256) external view returns (uint256);
    function balanceOf(address, uint256) external view returns (uint256);
    function getBin(uint24) external view returns (uint256, uint256);
    function setApprovalForAll(address, bool) external;
    function collectFees(address, uint256[] calldata) external;
}

interface IJoeLBRouter {
    struct LiquidityParameters {
        address tokenX;
        address tokenY;
        uint256 binStep;
        uint256 amountX;
        uint256 amountY;
        uint256 amountXMin;
        uint256 amountYMin;
        uint256 activeIdDesired;
        uint256 idSlippage;
        int256[] deltaIds;
        uint256[] distributionX;
        uint256[] distributionY;
        address to;
        uint256 deadline;
    }

    function getIdFromPrice(address pair, uint256 price) external view returns (uint24);
    function getPriceFromId(address pair, uint24 id) external view returns (uint256);

    function addLiquidity(LiquidityParameters calldata liquidityParameters)
        external
        returns (uint256[] memory depositIds, uint256[] memory liquidityMinted);

    function removeLiquidity(
        address tokenX,
        address tokenY,
        uint16 binStep,
        uint256 amountXMin,
        uint256 amountYMin,
        uint256[] memory ids,
        uint256[] memory amounts,
        address to,
        uint256 deadline
    ) external returns (uint256 amountX, uint256 amountY);

    function swapExactTokensForTokensSupportingFeeOnTransferTokens(
        uint256 amountIn,
        uint256 amountOutMin,
        uint256[] memory pairBinSteps,
        address[] memory tokenPath,
        address to,
        uint256 deadline
    ) external returns (uint256 amountOut);
}
