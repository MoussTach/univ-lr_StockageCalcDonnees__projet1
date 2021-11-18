const AnanasFactory = artifacts.require('./AnanasFactory.sol');

module.exports = (deployer) => {
  deployer.deploy(AnanasFactory);
};