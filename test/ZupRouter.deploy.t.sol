// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity 0.8.26;

import {Test} from "forge-std/Test.sol";
import {ZupRouterDeploy, ZupRouter} from "script/ZupRouter.deploy.s.sol";
import {DeployAddresses} from "script/helpers/DeployAddresses.sol";
import {NetworkHelper} from "script/helpers/NetworkHelper.sol";

contract ZupRouterDeployTest is Test {
    ZupRouterDeploy private deployoor;
    ZupRouter private zupRouter;

    function setUp() public {
        vm.chainId(11155111);
        deployoor = new ZupRouterDeploy();
        zupRouter = deployoor.run();
    }

    function test_ZupRouterDeployUsesLastDeployedFeeController() public view {
        assertEq(DeployAddresses._getDeployedFeeController(), zupRouter.getFeeController());
    }

    function test_ZupRouterDeployUsesCorrectWrappedNativeAddress() public view {
        assertEq(NetworkHelper._networkConfig().wrappedNative, zupRouter.getWrappedNative());
    }

    function test_ZupRouterDeployUsesCreate2() public view {
        bytes memory bytecode = type(ZupRouter).creationCode;
        bytes32 initCodeHash = keccak256(
            abi.encodePacked(
                bytecode,
                abi.encode(NetworkHelper._networkConfig().wrappedNative, DeployAddresses._getDeployedFeeController())
            )
        );

        bytes32 salt = deployoor.DEPLOYMENT_SALT();
        address expectedAddress = vm.computeCreate2Address(salt, initCodeHash);

        assertEq(expectedAddress, address(zupRouter));
    }

    function test_ZupRouterDeployUsesConstantCreate2() public {
        vm.expectRevert();
        deployoor.run();
    }
}
