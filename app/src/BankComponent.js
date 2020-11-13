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
          Applicación para la administración del token estable del COP por una
          entidad financiera que custodiara el fiat que emite como respaldo del
          token.
        </p>
      </div>

      <div className="section">
        <h2>Banco</h2>
        <h2>Active Account</h2>
        <AccountData
          drizzle={drizzle}
          drizzleState={drizzleState}
          accountIndex={1}
          units="ether"
          precision={3}
        />
      </div>
      <div className="row">
        <div className="column">
          <div className="section">
            <h2>Colombian Peso Token (COP)</h2>
            <p>
              <strong>Total Supply: </strong>
              <ContractData
                drizzle={drizzle}
                drizzleState={drizzleState}
                contract="ColombianPesoToken"
                method="totalSupply"
                methodArgs={[{ from: drizzleState.accounts[1] }]}
              />{" "}
              <ContractData
                drizzle={drizzle}
                drizzleState={drizzleState}
                contract="ColombianPesoToken"
                method="symbol"
                hideIndicator
              />
            </p>
            <p>
              <strong>My Balance: </strong>
              <ContractData
                drizzle={drizzle}
                drizzleState={drizzleState}
                contract="ColombianPesoToken"
                method="balanceOf"
                methodArgs={[drizzleState.accounts[1]]}
              />
            </p>
            <h3>Mint Tokens</h3>
            <ContractForm
              drizzle={drizzle}
              contract="ColombianPesoToken"
              method="mint"
              labels={["To Account", "Amount to Mint"]}
            />
            <h3>Distribute Tokens</h3>
            <ContractForm
              drizzle={drizzle}
              contract="ColombianPesoToken"
              method="transfer"
              labels={["To Account", "Amount to Send"]}
            />
          </div>
        </div>
      </div>
    </div>
  );
};
