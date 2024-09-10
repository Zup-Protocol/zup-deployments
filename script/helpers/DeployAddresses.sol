// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity 0.8.26;

import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";

library DeployAddresses {
    string constant RELATIVE_BROADCAST_PATH = "./deployments";

    function _getDeployedFeeController() internal view returns (address) {
        return DevOpsTools.get_most_recent_deployment("FeeController", block.chainid, RELATIVE_BROADCAST_PATH);
    }
}
