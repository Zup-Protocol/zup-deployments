// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity 0.8.26;

import {ZupRouter} from "lib/router-contracts/src/contracts/ZupRouter.sol";
import {Script} from "forge-std/Script.sol";
import {DeployAddresses} from "script/helpers/DeployAddresses.sol";
import {NetworkHelper} from "script/helpers/NetworkHelper.sol";

contract ZupRouterDeploy is Script {
    bytes32 public constant DEPLOYMENT_SALT = "CREATE2DEPLOY";

    function run() external returns (ZupRouter router) {
        address feeController = DeployAddresses._getDeployedFeeController();
        NetworkHelper.NetworkParams memory network = NetworkHelper._networkConfig();

        vm.startBroadcast();
        router = new ZupRouter{salt: DEPLOYMENT_SALT}(network.wrappedNative, feeController);
        vm.stopBroadcast();
    }
}
