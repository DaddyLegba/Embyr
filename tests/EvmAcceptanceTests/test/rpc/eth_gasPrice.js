const helper = require("../../helper/GeneralHelper");
assert = require("chai").assert;

const METHOD = "eth_gasPrice";

describe("Calling " + METHOD, function () {
  it("should return the gasPrice as specified in the ethereum protocol", async function () {
    await helper.callEthMethod(METHOD, 1, [], (result, status) => {
      hre.logDebug(result);

      assert.equal(status, 200, "has status code");
      assert.property(result, "result", result.error ? result.error.message : "error");
      assert.isString(result.result, "is not a string");
      assert.match(result.result, /^0x/, "should be HEX starting with 0x");
      assert.isNumber(+result.result, "can be converted to a number");

      const expectedMinGasPrice = 1000000; // default minimum Zilliqa gas price in wei
      assert.isAtLeast(+result.result, expectedMinGasPrice, "should have a gas price " + expectedMinGasPrice);
    });
  });
});
