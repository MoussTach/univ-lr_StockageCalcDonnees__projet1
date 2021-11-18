const Ananasactory = artifacts.require('AnanasFactory');

contract('AnanasFactory', (accounts) => {
  it('Verify a Human Standard Token once deployed using both verification functions.', async () => {
    const factory = await AnanasFactory.new();
    const newTokenAddr = await factory.createAnanas.call(100000, 'Ananas', 2, 'ANA', { from: accounts[0] });
    await factory.createAnanas(100000, 'Ananas', 2, 'ANA', { from: accounts[0] });
    const res = await factory.verifyAnanas.call(newTokenAddr, { from: accounts[0] });
    assert(res, 'Could not verify the token.');
  });
});