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
let reportAddress = "0xE68A3F65bd2205cBbb5258904adEE315a4e4de68";
let tokenContract = await EmissionRightsToken.deployed()
tokenContract.approve(reportAddress, 1000, {from: emitter1Account});
let report = await EmissionReport.at(reportAddress)
report.state()
report.amount()
report.verifier()
report.uri()
report.certify("https://ipfs.io/ipfs/QmP5Mzmhc1J61HcwFfDYL3dYFxii6xJMtEhZVqBwLdrree", 1000, {from: verifier1Account});
report.approve({from: accounts[0]})
# report.pay(1000, {from: emitter1Account});
```

> browser
approve report
check report state
check metamask balance of emitter
