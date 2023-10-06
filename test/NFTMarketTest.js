const NFTMarket = artifacts.require("NFTMarket");

contract("NFTMarket", function () {
  it("NFT Mint Test", async function () {
    const instance = await NFTMarket.deployed();

    // 토큰을 생성하기 전 _nextTokenId 값을 확인
    const beforeTokenId = await instance._nextTokenId.call();

    await instance.createNFT(
      "0x905067b3cc28eb7571526b44524a9d0c66cddbea",
      "My Virtual Animal/TEST"
    );

    // 토큰을 생성한 후 _nextTokenId 값을 확인
    const afterTokenId = await instance._nextTokenId.call();

    assert.equal(
      afterTokenId.toNumber(),
      beforeTokenId.toNumber() + 1,
      "NFT Minting Fail"
    );
  });
});
