
# Zup Deployments

This repository contains the most recent addresses of all Zup deployed smart contracts.

## Table of Contents
1. [Dependencies](#dependencies)
2. [Deploying Contracts](#deploying)
   - [Deploying to an Already Deployed Network](#already-deployed)
   - [Deploying to a New Network](#new-network)
4. [Creating New Deploy Script Conventions](#script)

## Dependencies <a name="dependencies"></a>

- **Foundry**
  - To check if Foundry is installed, run `forge --version`. You should see a response like `forge x.x.x`.
  - If Foundry is not installed, follow the [Foundry Installation guide](https://book.getfoundry.sh/getting-started/installation).

- **GNU Make**
  - To check if Make is installed, run `make --version`. You should see a response like `GNU Make x.xx`.
  - If Make is not installed, visit the [GNU Make website](https://www.gnu.org/software/make/) for installation instructions.

## Deploying Contracts <a name="deploying"></a>

Deploying a smart contract is straightforward. Open your terminal in the repository directory and run:

```bash
make deploy -- {CONTRACT_NAME} {NETWORK_NAME}
```

**Example:**

```bash
make deploy -- ZupRouter sepolia
```

**Warnings**:
- The `NETWORK_NAME` parameter should match the one set in the `[rpc_endpoints]` and `[etherscan]` sections of the [foundry.toml](foundry.toml) file.
- The `make deploy` command uses the `--trezor` flag by default to deploy with a Trezor hardware wallet. If you don't want to use a hardware wallet, you can remove the flag and add the necessary parameters for a non-hardware wallet deployment.

### Deploying to an Already Deployed Network <a name="already-deployed"></a>

If you want to deploy a contract that has already been deployed on the same network, you just need to set up the block explorer API key in the `.env` file and run the deploy command.

#### Setting Up the Block Explorer API Key

1. Create a `.env` file in the root of the repository.
2. Set the `BLOCK_EXPLORER_API_KEY` variable according to the network you are deploying to. For example:
   - For **Polygon Mainnet**, use the [Polygonscan](https://polygonscan.com/) API key.
   - For **Polygon Mumbai Testnet**, use the [Polygonscan](https://polygonscan.com/) API key.
   - For **Ethereum Mainnet**, use the [Etherscan](https://etherscan.io/) API key.

### Deploying to a New Network <a name="new-network"></a>

To deploy to a new network, follow these steps before running the deploy command:

1. Add the required parameters in the helper files.
2. Add the network to the [foundry.toml](foundry.toml) file.
3. Add the block explorer API key to the `.env` file.

#### Adding Required Parameters to Helpers

There are two possible files where you might need to add new parameters:
- **[NetworkHelper.sol](script/helpers/NetworkHelper.sol)**: For external parameters (e.g., WETH address).
- **[ZupAddresses.sol](script/helpers/ZupAddresses.sol)**: For internal Zup-specific parameters (e.g., Admin address).

To figure out which file to modify, check the relevant deployment script in the [script](script/) folder for the contract you want to deploy.

⚠️ It's a best practice to add an automated test for each new parameter you add. Tests can be found in the [test](test/) folder. ⚠️

#### Adding the Network to [foundry.toml](foundry.toml)

In the [foundry.toml](foundry.toml) file, you need to add the network configuration, including the RPC endpoint and block explorer API URL. Add the network to both the `[rpc_endpoints]` and `[etherscan]` sections, ensuring the network names match. The environment variable for the API key should always be `BLOCK_EXPLORER_API_KEY`.

**Example**:

```toml
[etherscan]
newchain = { key = "${BLOCK_EXPLORER_API_KEY}", url = "https://newchain.api.endpoint" }

[rpc_endpoints]
newchain = "https://newchain-rpc.com"
```

#### Adding the Block Explorer API Key to the `.env` File

This step is simple: add a key named `BLOCK_EXPLORER_API_KEY` to your `.env` file and assign the appropriate block explorer API key based on the network. For example, use a Polygonscan API key for **Polygon Mainnet** or **Polygon Mumbai**.

### Creating New Deploy Script Conventions <a name="script"></a>

- All deployment scripts should be placed in the [script](script/) folder.
- New deployment scripts should follow the naming convention `{CONTRACT_NAME}Deploy` to work with the `make deploy` command. For example: `NewContractDeploy`.
