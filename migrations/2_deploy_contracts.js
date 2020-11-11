const EmissionRightsToken = artifacts.require("EmissionRightsToken");
const EmissionsComplianceCycle = artifacts.require("EmissionsComplianceCycle");
const ColombianPesoToken = artifacts.require("ColombianPesoToken");

module.exports = async function (deployer, network, accounts) {
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
  await deployer.deploy(EmissionsComplianceCycle, token.address, {
    from: accounts[0],
  });
  await deployer.deploy(ColombianPesoToken, "ColombianPesoToken", "COP", 0, {
    from: accounts[1],
  });
};
