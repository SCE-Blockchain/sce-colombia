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
      <div className="row">
        <div className="column">
          <div className="section">
            <h2>Emission Rights Token of Colombia (ERTCOL)</h2>
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
              labels={["To Account", "Amount to Mint"]}
            />
            <h3>Distribute Tokens</h3>
            <ContractForm
              drizzle={drizzle}
              contract="EmissionRightsToken"
              method="transfer"
              labels={["To Account", "Amount to Send"]}
            />
          </div>
        </div>
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
                methodArgs={[{ from: drizzleState.accounts[0] }]}
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
                methodArgs={[drizzleState.accounts[0]]}
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
        <div className="column">
          <div className="section">
            <h3>Register verifiers</h3>
            {
              <ContractForm
                drizzle={drizzle}
                contract="EmissionsComplianceCycle"
                method="addVerifier"
                labels={["Verifier Account"]}
              />
            }
            <h3>Registered verifiers</h3>
            {
              <ContractData
                drizzle={drizzle}
                drizzleState={drizzleState}
                contract="EmissionsComplianceCycle"
                method="getVerifiers"
              />
            }

            <h3>Register emitters</h3>
            {
              <ContractForm
                drizzle={drizzle}
                contract="EmissionsComplianceCycle"
                method="addEmitter"
                labels={["Emitter Account"]}
              />
            }
            <h3>Registered emitters</h3>
            {
              <ContractData
                drizzle={drizzle}
                drizzleState={drizzleState}
                contract="EmissionsComplianceCycle"
                method="getEmitters"
              />
            }

            <h3>Reports</h3>
            {
              <ContractData
                drizzle={drizzle}
                drizzleState={drizzleState}
                contract="EmissionsComplianceCycle"
                method="getReports"
              />
            }

            <h3>Approve report</h3>
            {
              <ContractForm
                drizzle={drizzle}
                contract="EmissionsComplianceCycle"
                method="approveReport"
                labels={["Report Address"]}
              />
            }
          </div>
        </div>
      </div>
    </div>
  );
};
