const SimpleStorage = artifacts.require("SimpleStorage");
const EmissionRightsToken = artifacts.require("EmissionRightsToken");
const ComplexStorage = artifacts.require("ComplexStorage");

module.exports = function (deployer, network, accounts) {
  deployer.deploy(SimpleStorage);
  deployer.deploy(EmissionRightsToken, accounts[0]);
  deployer.deploy(ComplexStorage);
};
