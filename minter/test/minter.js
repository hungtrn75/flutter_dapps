const Minter = artifacts.require("Minter");

/*
 * uncomment accounts to access the test accounts made available by the
 * Ethereum client
 * See docs: https://www.trufflesuite.com/docs/truffle/testing/writing-tests-in-javascript
 */
contract("Minter", function (/* accounts */) {
  let minter = null ;
  before(async () => {
      minter = await Minter.deployed() ;
  });

  it("Should Mint coins", async function () {
    await minter.mint("0x2E8D623CCF83C125575A022f9075AF3409740238", 200);
    const balance = await minter.balance("0x2E8D623CCF83C125575A022f9075AF3409740238");
    assert(balance.toNumber() == 200);
  });

  it("Should Send coins", async function () {
    await minter.send("0x2E8D623CCF83C125575A022f9075AF3409740238", "0x715bCfcF27f2801F4166A4f5c3c88b21dC7e135C", 50);
    const senderBalance = await minter.balance("0x2E8D623CCF83C125575A022f9075AF3409740238");
    const receiverBalance = await minter.balance("0x715bCfcF27f2801F4166A4f5c3c88b21dC7e135C");
    assert(senderBalance.toNumber() == 150);
    assert(receiverBalance.toNumber() == 50);
  });
});
