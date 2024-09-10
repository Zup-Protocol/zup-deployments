// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity 0.8.26;

import {FeeController} from "lib/router-contracts/src/contracts/FeeController.sol";
import {Script} from "forge-std/Script.sol";
import {ZupAddresses} from "script/helpers/ZupAddresses.sol";

contract FeeControllerDeploy is Script {
    uint256 public constant INITIAL_JOIN_POOL_FEE_BIPS = 15;
    bytes32 public constant DEPLOYMENT_SALT = "CREATE2_DEPLOY";

    function run() external returns (FeeController feeController) {
        vm.startBroadcast();
        feeController =
            new FeeController{salt: DEPLOYMENT_SALT}(INITIAL_JOIN_POOL_FEE_BIPS, ZupAddresses.getZupFeeAdmin());
        vm.stopBroadcast();
    }
}
