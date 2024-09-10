// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity 0.8.26;

import {Test} from "forge-std/Test.sol";
import {DeployAddresses} from "script/helpers/DeployAddresses.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";

contract DeployAddressesTest is Test {
    function setUp() public {
        vm.chainId(11155111);
    }

    function test_getDeployedFeeController() public view {
        address latestDeploy = DevOpsTools.get_most_recent_deployment("FeeController", block.chainid, "./deployments");
        assertEq(DeployAddresses._getDeployedFeeController(), latestDeploy);
    }
}
