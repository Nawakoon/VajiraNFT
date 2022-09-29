const { assert, expect } = require("chai")
const { ethers, deployments, network } = require("hardhat")
const { developmentChains, networkConfig, waitBlockConfirmations} = require("../helper-hardhat-config")

!developmentChains.includes(network.name)
    ? describe.skip
    : describe("Vajira110 Unit Tests", function () {
        beforeEach(async () => {
            // accounts = await ethers.getSigners() 
            // deployer = accounts[0]
        })

        describe("contructor", function () {
            it("intitiallizes Vajira110 correctly", async () => {})
        })

        describe("mint function", function () {
            it("mint corectly", async () => {})              
            it("can't mint if have not enough matic", async () => {})
        })

        describe("Withdraw function", function () {
            it("withdraw corectly", async () => {})
        })

        describe("claimHealthCheck function", function () {
            it("claim corectly", async () => {})
        })
    })
    
