import Web3 from "web3";
import EmissionRightsToken from "./contracts/EmissionRightsToken.json";
import EmissionsComplianceCycle from "./contracts/EmissionsComplianceCycle.json";
import ColombianPesoToken from "./contracts/ColombianPesoToken.json";
import EmissionRightsMarket from "./contracts/EmissionRightsMarket.json";

const options = {
  web3: {
    block: false,
    customProvider: new Web3("ws://localhost:8545"),
  },
  contracts: [
    EmissionRightsToken,
    EmissionsComplianceCycle,
    ColombianPesoToken,
    EmissionRightsMarket,
  ],
  events: {
    EmissionRightsToken: ["Transfer"],
    ColombianPesoToken: ["Transfer"],
  },
};

export default options;
