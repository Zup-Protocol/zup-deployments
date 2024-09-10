// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity 0.8.26;

import {NetworkHelper} from "script/helpers/NetworkHelper.sol";
import {Test} from "forge-std/Test.sol";

contract NetworkHelperTest is Test {
    function test_networkConfig_revertsIfNotSetForCurrentChain() external {
        uint256 unknownChainID = 12345678910111213;
        vm.chainId(unknownChainID);

        vm.expectRevert(abi.encodeWithSelector(NetworkHelper.UnknownChainConfig.selector, unknownChainID));
        NetworkHelper._networkConfig();
    }

    // mainnets

    function test_wrappedNativeAddress_ethereum() external {
        vm.chainId(1);
        assertEq(NetworkHelper._networkConfig().wrappedNative, address(0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2));
    }

    // Testnets

    function test_wrappedNativeAddress_sepolia() external {
        vm.chainId(11155111);
        assertEq(NetworkHelper._networkConfig().wrappedNative, address(0x7b79995e5f793A07Bc00c21412e50Ecae098E7f9));
    }
}
