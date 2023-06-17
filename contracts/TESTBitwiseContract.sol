// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import {NFTIdentifiers} from "./libraries/NFTIdentifiers.sol";

contract TESTBitwiseContract {
    using NFTIdentifiers for uint256;

    constructor() {}

    struct NFTInfo {
        // counts total use bit, need < 256 bits
        uint96 salePrice; // 96 bit
        uint40 saleStartTime; // 136 bit
        uint40 saleEndTime; // 176 bit
        uint16 maxSupply; // 192 bit
        uint16 totalSupply; // 208 bit
        uint16 maxMintLimit; // 224 bit
        bool haveTokenURI; // 225 bit
        bool shouldRefund; // 226 bit
        bool initialized; // 227 bit
        bool isRecordMinter; // 228 bit
    }

    // nftId => nftInfo
    mapping(uint256 => uint256) nftInfos;

    // nftId => nftInfo
    mapping(uint256 => NFTInfo) nftStrctInfos;

    function setNFTStructInfo(
        uint256 _nftId,
        NFTInfo calldata _nftInfo
    ) external {
        nftStrctInfos[_nftId] = _nftInfo;
    }

    function setNFTInfo(uint256 _nftId, uint256 _nftInfo) external {
        nftInfos[_nftId] = _nftInfo;
    }

    function getNFTStructInfo(
        uint256 _nftId
    ) external view returns (NFTInfo memory nftInfo) {
        return nftStrctInfos[_nftId];
    }

    function getNFTData(uint256 _nftId) external view returns (uint256) {
        return nftInfos[_nftId];
    }

    function getNFTInfoWithStruct(
        uint256 _nftId
    ) external view returns (NFTInfo memory nftInfo) {
        uint256 nftInfoUint = nftInfos[_nftId];
        nftInfo.salePrice = nftInfoUint.salePrice();
        nftInfo.saleStartTime = nftInfoUint.saleStartTime();
        nftInfo.saleEndTime = nftInfoUint.saleEndTime();
        nftInfo.maxSupply = nftInfoUint.maxSupply();
        nftInfo.totalSupply = nftInfoUint.totalSupply();
        nftInfo.maxMintLimit = nftInfoUint.maxMintLimit();
        nftInfo.haveTokenURI = nftInfoUint.haveTokenURI();
        nftInfo.shouldRefund = nftInfoUint.shouldRefund();
        nftInfo.initialized = nftInfoUint.initialized();
        nftInfo.isRecordMinter = nftInfoUint.isRecordMinter();
    }

    function getNFTStructSalePriceInfo(
        uint256 _nftId
    ) external view returns (uint256) {
        return nftStrctInfos[_nftId].salePrice;
    }
}
