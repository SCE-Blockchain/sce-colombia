const EmissionRightsToken = artifacts.require("EmissionRightsToken");
const EmissionsComplianceCycle = artifacts.require("EmissionsComplianceCycle");

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
  console.log("address: " + token.address);
  await deployer.deploy(EmissionsComplianceCycle, token.address, {
    from: accounts[0],
  });
};
