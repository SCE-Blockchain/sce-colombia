# sce-colombia

```sh
# terminal 1
truffle develop
compile
migrate

# terminal 2
cd app
yarn start
```

> browser
register verifiers
register emitters
mint tokens
distribute 1200 tokens to emitter
check tokens in metamask

```sh
# terminal 1
let accounts = await web3.eth.getAccounts()
let emitter1Account = accounts[1];
let verifier1Account = accounts[2];
let emissionsComplianceCycle = await EmissionsComplianceCycle.deployed()
```

> ipfs
upload report

```sh
# terminal 1
emissionsComplianceCycle.reportEmissions("https://ipfs.io/ipfs/QmcHfMeVA3R9jPbfg3wcGC6toFhgpA2JtWJsiL55MfbXNd", 1000, verifier1Account, {from: emitter1Account});
let reportAddress = "0x2ae640E68865403D849B78d8Fa50Db79ef4d3f58";
let tokenContract = await EmissionRightsToken.deployed()
tokenContract.approve(reportAddress, 1000, {from: emitter1Account});
let report = await EmissionReport.at(reportAddress)
report.certify("uri", 1000, {from: verifier1Account});
# report.approve({from: accounts[0]})
# report.pay(1000, {from: emitter1Account});
```

> browser
approve report
check report state
check metamask balance of emitter
