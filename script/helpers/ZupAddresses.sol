// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity 0.8.26;

library ZupAddresses {
    function getZupFeeAdmin() internal pure returns (address) {
        return address(0xc2b583255c8dC3b1F910dbDBc93E5E7b4dA8e3b1); // TODO: CHANGE TO MULTISIG
    }
}
