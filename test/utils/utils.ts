import { BigNumber, utils } from "ethers";

export const setNFTInfo = async (NFTInfo: any) => {
  const arrSalePrice = utils.zeroPad(utils.hexlify(NFTInfo.salePrice), 12);
  const arrSaleStartTime = utils.zeroPad(utils.hexlify(NFTInfo.saleStartTime), 5);
  const arrSaleEndTime = utils.zeroPad(utils.hexlify(NFTInfo.saleEndTime), 5);
  const arrMaxSupply = utils.zeroPad(utils.hexlify(NFTInfo.maxSupply), 2);
  const arrTotalSupply = utils.zeroPad(utils.hexlify(NFTInfo.totalSupply), 2);
  const arrMaxMintLimit = utils.zeroPad(utils.hexlify(NFTInfo.maxMintLimit), 2);
  let boolStates = 0;
  if (NFTInfo.haveTokenURI) {
    boolStates = boolStates | (1 << 3);
  }
  if (NFTInfo.shouldRefund) {
    boolStates = boolStates | (1 << 2);
  }
  if (NFTInfo.initialized) {
    boolStates = boolStates | (1 << 1);
  }
  if (NFTInfo.isRecordMinter) {
    boolStates = boolStates | 1;
  }
  const arrStates = utils.zeroPad(utils.hexlify(boolStates), 1);

  const nftInfo = utils.hexConcat([
    arrSalePrice,
    arrSaleStartTime,
    arrSaleEndTime,
    arrMaxSupply,
    arrTotalSupply,
    arrMaxMintLimit,
    arrStates,
  ]);
  return BigNumber.from(nftInfo);
};

export const getStoreTokenId = (sender: string, index: number, maxSupply: number) => {
  // ethers.arrayify()
  const arrSender = utils.arrayify(sender);
  const arrIndex = utils.zeroPad(utils.hexlify(index), 7);
  const arrSupply = utils.zeroPad(BigNumber.from(maxSupply).toHexString(), 5);
  const tokenIDStr = utils.hexConcat([arrSender, arrIndex, arrSupply]);
  return BigNumber.from(tokenIDStr);
};
