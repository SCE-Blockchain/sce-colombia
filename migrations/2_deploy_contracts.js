const ColombianPesoToken = artifacts.require("ColombianPesoToken");
const EmissionRightsToken = artifacts.require("EmissionRightsToken");
const EmissionRightsMarket = artifacts.require("EmissionRightsMarket");
const EmissionsComplianceCycle = artifacts.require("EmissionsComplianceCycle");

module.exports = async function (deployer, network, accounts) {
  await deployer.deploy(ColombianPesoToken, "ColombianPesoToken", "COP", 0, {
    from: accounts[1],
  });
  await deployer.deploy(
    EmissionRightsToken,
    "EmissionRightsTokenColombia",
    "ERTCOL",
    0,
    {
      from: accounts[0],
    }
  );
  const token = await EmissionRightsToken.deployed();
  const cop = await ColombianPesoToken.deployed();
  await deployer.deploy(EmissionRightsMarket, token.address, cop.address, {
    from: accounts[0],
  });
  await deployer.deploy(EmissionsComplianceCycle, token.address, {
    from: accounts[0],
  });
};
