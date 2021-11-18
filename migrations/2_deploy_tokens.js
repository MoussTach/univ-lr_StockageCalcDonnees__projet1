const Ananas = artifacts.require('./Ananas.sol');

module.exports = (deployer) => {
  deployer.deploy(Ananas, 10000, 'Ananas', 1, 'ANA');
};