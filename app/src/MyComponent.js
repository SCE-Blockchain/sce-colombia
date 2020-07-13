import React from "react";
import { newContextComponents } from "@drizzle/react-components";
import logo from "./logo.png";

const { AccountData, ContractData, ContractForm } = newContextComponents;

export default ({ drizzle, drizzleState }) => {
  // destructure drizzle and drizzleState from props
  return (
    <div className="App">
      <div>
        <img src={logo} alt="drizzle-logo" />
        <h1>Sistema de Comercio de Emisiones</h1>
        <p>
          Applicación para la administración del sistema de Comercio de
          Emisiones por el gobierno Colombiano.
        </p>
      </div>

      <div className="section">
        <h2>Active Account</h2>
        <AccountData
          drizzle={drizzle}
          drizzleState={drizzleState}
          accountIndex={0}
          units="ether"
          precision={3}
        />
      </div>

      <div className="section">
        <h2>SimpleStorage</h2>
        <p>
          This shows a simple ContractData component with no arguments, along
          with a form to set its value.
        </p>
        <p>
          <strong>Stored Value: </strong>
          <ContractData
            drizzle={drizzle}
            drizzleState={drizzleState}
            contract="SimpleStorage"
            method="storedData"
          />
        </p>
        <ContractForm drizzle={drizzle} contract="SimpleStorage" method="set" />
      </div>

      <div className="section">
        <h2>Derechos de Emisión (DDE) Token</h2>
        <p>
          <strong>Total Supply: </strong>
          <ContractData
            drizzle={drizzle}
            drizzleState={drizzleState}
            contract="EmissionRightsToken"
            method="totalSupply"
            methodArgs={[{ from: drizzleState.accounts[0] }]}
          />{" "}
          <ContractData
            drizzle={drizzle}
            drizzleState={drizzleState}
            contract="EmissionRightsToken"
            method="symbol"
            hideIndicator
          />
        </p>
        <p>
          <strong>My Balance: </strong>
          <ContractData
            drizzle={drizzle}
            drizzleState={drizzleState}
            contract="EmissionRightsToken"
            method="balanceOf"
            methodArgs={[drizzleState.accounts[0]]}
          />
        </p>
        <h3>Mint Tokens</h3>
        <ContractForm
          drizzle={drizzle}
          contract="EmissionRightsToken"
          method="mint"
          labels={["Amount to Mint"]}
        />
        <h3>Distribute Tokens</h3>
        <ContractForm
          drizzle={drizzle}
          contract="EmissionRightsToken"
          method="transfer"
          labels={["To Address", "Amount to Send"]}
        />
      </div>
    </div>
  );
};
