const Monitoring = artifacts.require("Monitoring");

module.exports = function (deployer) {
  deployer.deploy(Monitoring);
};