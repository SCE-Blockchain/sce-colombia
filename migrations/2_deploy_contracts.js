const EmissionRightsToken = artifacts.require("EmissionRightsToken");
const EmissionsComplianceCycle = artifacts.require("EmissionsComplianceCycle");

module.exports = function (deployer, network, accounts) {
  await deployer.deploy(EmissionRightsToken, accounts[0]);
  const token = await EmissionRightsToken.deployed();
  await deployer.deploy(EmissionsComplianceCycle, token.addresss, {
    from: accounts[0],
  });
};
