// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity 0.8.26;

import {ZupAddresses} from "script/helpers/ZupAddresses.sol";
import {Test} from "forge-std/Test.sol";

contract ZupAddressesTest is Test {
    function test_getZupFeeAdmin() public pure {
        assertEq(ZupAddresses.getZupFeeAdmin(), address(0xc2b583255c8dC3b1F910dbDBc93E5E7b4dA8e3b1));
    }
}
