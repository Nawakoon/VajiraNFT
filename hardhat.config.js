require("@nomiclabs/hardhat-waffle")
require("@nomiclabs/hardhat-etherscan")
require("hardhat-deploy")
require("solidity-coverage")
require("hardhat-gas-reporter")
require("hardhat-contract-sizer")
require("dotenv").config()

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
const MAINNET_RPC_URL = process.env.MAINNET_RPC_URL || process.env.ALCHEMY_MAINNET_RPC_URL || ""
const RINKEBY_RPC_URL = process.env.RINKEBY_RPC_URL || ""
const PRIVATE_KEY = process.env.PRIVATE_KEY1 || process.env.PRIVATE_KEY2
const ETHERSCAN_API_KEY = process.env.ETHERSCAN_API_KEY || "key"
const COINMARKETCAP_API_KEY = process.env.COINMARKETCAP_API_KEY || "key"

module.exports = {
    defaultNetwork: "hardhat",
    networks: {
        hardhat: {
            chainId: 31337,
            blockConfirmations: 1,
            forking: {
                url: MAINNET_RPC_URL,
            },
        },
        localhost: {
            chainId: 31337,
            blockConfirmations: 1,
        },
        rinkeby: {
            url: RINKEBY_RPC_URL,
            accounts: [PRIVATE_KEY],
            chainId: 4,
            blockConfirmations: 6,
        },
    },
    etherscan: {
        apiKey: ETHERSCAN_API_KEY,
    },
    gasReporter: {
        enabled: false,
        currency: "USD",
        outputFile: "gas-report.txt",
        noColors: true,
        coinmarketcap: COINMARKETCAP_API_KEY,
        // token: "MATIC", // to see gas report on MATIC chain
        // https://www.npmjs.com/package/hardhat-gas-reporter
    },
    solidity: {
        compilers: [
            {
                version: "0.8.7",
            },
            {
                version: "0.6.12"
            },
            {
                version: "0.4.24",
            },
        ],
    },
    namedAccounts: {
        deployer: {
            default: 0,
            1: 0,
        },
        player: {
            default: 1,
        },
    },
    mocha: {
        timeout: 500000, // 500 seconds max for running test
    },
}
