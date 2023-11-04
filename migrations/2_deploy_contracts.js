const FractionalNFT = artifacts.require("FractionalNFT");
const Marketplace = artifacts.require("Marketplace");

module.exports = async function(deployer) {
  await deployer.deploy(FractionalNFT);
  const fractionalNFT = await FractionalNFT.deployed();
  
  // Assuming the Marketplace constructor requires the FractionalNFT address
  await deployer.deploy(Marketplace, fractionalNFT.address);
};

