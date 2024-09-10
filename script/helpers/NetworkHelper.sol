// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity 0.8.26;

library NetworkHelper {
    struct NetworkParams {
        address wrappedNative;
    }

    error UnknownChainConfig(uint256 chainId);

    function _networkConfig() internal view returns (NetworkParams memory) {
        return NetworkParams({wrappedNative: _getWrappedNative()});
    }

    function _getWrappedNative() private view returns (address) {
        // Mainnets
        if (block.chainid == 1) return address(0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2);

        // Testnets
        if (block.chainid == 11155111) return address(0x7b79995e5f793A07Bc00c21412e50Ecae098E7f9);

        revert UnknownChainConfig(block.chainid);
    }
}
