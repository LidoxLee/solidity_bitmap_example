import { loadFixture } from "@nomicfoundation/hardhat-network-helpers";
import { expect } from "chai";
import { ethers } from "hardhat";
import { setNFTInfo } from "../test/utils/utils";
import { BigNumber, utils } from "ethers";
import "hardhat-gas-reporter";

describe("Bitwise test", function () {
  async function deployTESTBitwiseContract() {
    // Contracts are deployed using the first signer/account by default
    const signers = await ethers.getSigners();
    const deployer = signers[0];
    const account_1 = signers[1];
    const account_2 = signers[2];
    const account_3 = signers[3];

    const NFTInfo = {
      // counts total use bit, need < 256 bits
      salePrice: ethers.utils.parseEther("0.1"),
      saleStartTime: Math.floor(Date.now() / 1000),
      saleEndTime: Math.floor(Date.now() / 1000) + 10 * 24 * 60 * 60,
      maxSupply: 10000,
      totalSupply: 0,
      maxMintLimit: 10,
      haveTokenURI: true,
      shouldRefund: true,
      initialized: true,
      isRecordMinter: true,
    };
    //get factory
    const TESTBitwiseContract_Factory = await ethers.getContractFactory("TESTBitwiseContract");
    const TESTBitwise_Instance = await TESTBitwiseContract_Factory.deploy();

    return { deployer, account_1, account_2, account_3, NFTInfo, TESTBitwise_Instance };
  }

  describe("mintERC2309 test", function () {
    it("deploy contract", async function () {
      const { deployer, NFTInfo, TESTBitwise_Instance } = await loadFixture(
        deployTESTBitwiseContract
      );
      const bytescode = setNFTInfo(NFTInfo);
      console.log(" bytescode : ", bytescode);
      const nftId = 1;
      const nftStuctId = 2;
      const tx = await TESTBitwise_Instance.setNFTInfo(nftId, bytescode);
      const tx_struct = await TESTBitwise_Instance.setNFTStructInfo(nftStuctId, NFTInfo);
      // await TESTBitwise_Instance.getNFTData(nftStuctId);
    });
  });
});
