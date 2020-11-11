import React from "react";
import { DrizzleContext } from "@drizzle/react-plugin";
import { Drizzle } from "@drizzle/store";
import drizzleOptions from "./drizzleOptions";
//import MyComponent from "./MyComponent";
import GovComponent from "./GovComponent";
//import BankComponent from "./BankComponent";
import "./App.css";

const drizzle = new Drizzle(drizzleOptions);

const App = () => {
  return (
    <DrizzleContext.Provider drizzle={drizzle}>
      <DrizzleContext.Consumer>
        {(drizzleContext) => {
          const { drizzle, drizzleState, initialized } = drizzleContext;

          if (!initialized) {
            return "Loading...";
          }

          return (
            <GovComponent drizzle={drizzle} drizzleState={drizzleState} />
            //<BankComponent drizzle={drizzle} drizzleState={drizzleState} />
          );
        }}
      </DrizzleContext.Consumer>
    </DrizzleContext.Provider>
  );
};

export default App;
