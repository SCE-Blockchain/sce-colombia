const EmissionRights = artifacts.require("EmissionRights");

module.exports = function (deployer, network, accounts) {
  deployer.deploy(EmissionRights, accounts[0]);
};
