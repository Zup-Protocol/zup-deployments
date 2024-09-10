// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity 0.8.26;

import {Test} from "forge-std/Test.sol";
import {FeeControllerDeploy, FeeController} from "script/FeeController.deploy.s.sol";
import {Ownable} from "lib/router-contracts/lib/openzeppelin-contracts/contracts/access/Ownable.sol";
import {ZupAddresses} from "script/helpers/ZupAddresses.sol";

contract FeeControllerDeployTest is Test {
    FeeControllerDeploy private deployoor;
    FeeController private feeController;

    function setUp() public {
        vm.chainId(11155111);

        deployoor = new FeeControllerDeploy();
        feeController = deployoor.run();
    }

    function test_deployUsesCorrectFeeAdmin() public view {
        assertEq(Ownable(feeController).owner(), ZupAddresses.getZupFeeAdmin());
    }

    function test_FeeControllerDeployUsesCreate2() public view {
        bytes memory bytecode = type(FeeController).creationCode;
        bytes32 initCodeHash = keccak256(
            abi.encodePacked(
                bytecode, abi.encode(deployoor.INITIAL_JOIN_POOL_FEE_BIPS(), ZupAddresses.getZupFeeAdmin())
            )
        );

        bytes32 salt = deployoor.DEPLOYMENT_SALT();
        address expectedAddress = vm.computeCreate2Address(salt, initCodeHash);

        assertEq(expectedAddress, address(feeController));
    }

    function test_FeeControllerDeployUsesConstantCreate2() public {
        vm.expectRevert();
        deployoor.run();
    }
}
