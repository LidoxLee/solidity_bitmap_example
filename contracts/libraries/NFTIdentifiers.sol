// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

library NFTIdentifiers {
    struct NFTInfo {
        // counts total use bit, need < 256 bits
        uint96 salePrice;
        uint40 saleStartTime;
        uint40 saleEndTime;
        uint16 maxSupply;
        uint16 totalSupply;
        uint16 maxMintLimit;
        bool haveTokenURI;
        bool shouldRefund;
        bool initialized;
        bool isRecordMinter;
    }

    uint8 internal constant SALE_PRICE_BIT = 96;
    uint8 internal constant SALE_START_TIME_BIT = 40;
    uint8 internal constant SALE_END_TIME_BIT = 40;
    uint8 internal constant MAX_SUPPLY_BIT = 16;
    uint8 internal constant TOTAL_SUPPLY_BIT = 16;
    uint8 internal constant MAX_MINT_LIMIT_BIT = 16;
    uint8 internal constant STATES_BIT = 8;

    uint256 internal constant HAVE_TOKEN_URI_FLAG = 1 << 3;
    uint256 internal constant SHOULD_REFUND_FLAG = 1 << 2;
    uint256 internal constant INITIALIZED_FLAG = 1 << 1;
    uint256 internal constant IS_RECORD_MINTER_FLAG = 1;

    uint8 internal constant TOTAL_BIT = 232; //

    uint256 constant SALE_PRICE_MASK = (1 << SALE_PRICE_BIT) - 1;
    uint256 constant SALE_START_TIME_MASK = (1 << SALE_START_TIME_BIT) - 1;
    uint256 constant SALE_END_TIME_MASK = (1 << SALE_END_TIME_BIT) - 1;
    uint256 constant MAX_SUPPLY_MASK = (1 << MAX_SUPPLY_BIT) - 1;
    uint256 constant TOTAL_SUPPLY_MASK = (1 << TOTAL_SUPPLY_BIT) - 1;
    uint256 constant MAX_MINT_LIMIT_MASK = (1 << MAX_MINT_LIMIT_BIT) - 1;

    function salePrice(uint256 _nftId) internal pure returns (uint96) {
        return uint96(_nftId >> (TOTAL_BIT - SALE_PRICE_BIT));
    }

    function saleStartTime(uint256 _nftId) internal pure returns (uint40) {
        return
            uint40(
                (_nftId >> (TOTAL_BIT - SALE_PRICE_BIT - SALE_START_TIME_BIT)) &
                    SALE_START_TIME_MASK
            );
    }

    function saleEndTime(uint256 _nftId) internal pure returns (uint40) {
        return
            uint40(
                (_nftId >>
                    (TOTAL_BIT -
                        SALE_PRICE_BIT -
                        SALE_START_TIME_BIT -
                        SALE_END_TIME_BIT)) & SALE_END_TIME_MASK
            );
    }

    function maxSupply(uint256 _nftId) internal pure returns (uint16) {
        return
            uint16(
                (_nftId >>
                    (TOTAL_BIT -
                        SALE_PRICE_BIT -
                        SALE_START_TIME_BIT -
                        SALE_END_TIME_BIT -
                        MAX_SUPPLY_BIT)) & MAX_SUPPLY_MASK
            );
    }

    function totalSupply(uint256 _nftId) internal pure returns (uint16) {
        return
            uint16(
                (_nftId >>
                    (TOTAL_BIT -
                        SALE_PRICE_BIT -
                        SALE_START_TIME_BIT -
                        SALE_END_TIME_BIT -
                        MAX_SUPPLY_BIT -
                        TOTAL_SUPPLY_BIT)) & TOTAL_SUPPLY_MASK
            );
    }

    function maxMintLimit(uint256 _nftId) internal pure returns (uint16) {
        return
            uint16(
                (_nftId >>
                    (TOTAL_BIT -
                        SALE_PRICE_BIT -
                        SALE_START_TIME_BIT -
                        SALE_END_TIME_BIT -
                        MAX_SUPPLY_BIT -
                        TOTAL_SUPPLY_BIT -
                        MAX_MINT_LIMIT_BIT)) & MAX_MINT_LIMIT_MASK
            );
    }

    function haveTokenURI(uint256 _nftId) internal pure returns (bool) {
        return _nftId & HAVE_TOKEN_URI_FLAG != 0;
    }

    function shouldRefund(uint256 _nftId) internal pure returns (bool) {
        return _nftId & SHOULD_REFUND_FLAG != 0;
    }

    function initialized(uint256 _nftId) internal pure returns (bool) {
        return _nftId & INITIALIZED_FLAG != 0;
    }

    function isRecordMinter(uint256 _nftId) internal pure returns (bool) {
        return _nftId & IS_RECORD_MINTER_FLAG != 0;
    }
}
