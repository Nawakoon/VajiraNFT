const networkConfig = {
    default: {
        name: "hardhat",
    },
    31337: {
        name: "localhost",
    },
    4: {
        name: "rinkeby",
    },
    // also need mumbai network 
}

const developmentChains = ["hardhat", "localhost"]
const VERIFICATION_BLOCK_CONFIRMATIONS = 6

const frontEndContractsFile = "../frontend/constants/contractAddresses.json"
const frontEndAbiFile = "../frontend/constants/abi.json"

module.exports = {
    networkConfig,
    developmentChains,
    VERIFICATION_BLOCK_CONFIRMATIONS,
    frontEndContractsFile,
    frontEndAbiFile,
}
