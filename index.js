/** @format */
import "./shims";
import { AppRegistry } from "react-native";
import App from "./app/App";
import { name as appName } from "./app.json";

import React from "react";
import { Drizzle, generateStore } from "drizzle";
import EmissionRights from "./build/contracts/EmissionRights.json";

const options = {
  contracts: [EmissionRights],
};
const drizzleStore = generateStore(options);
const drizzle = new Drizzle(options, drizzleStore);

AppRegistry.registerComponent(appName, () => () => <App drizzle={drizzle} />);
