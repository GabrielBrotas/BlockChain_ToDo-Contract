module.exports = {
  // specify the networks
  networks: {
    development: {
      host: "127.0.0.1", // localhost
      port: 7545, // port that ganache run
      network_id: "*" // Match any network id
    }
  },
  solc: {
    optimizer: {
      enabled: true,
      runs: 200
    }
  }
}