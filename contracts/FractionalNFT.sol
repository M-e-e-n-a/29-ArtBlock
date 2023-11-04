// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract FractionalNFT is ERC721URIStorage {
    uint256 private _tokenIdTracker = 0;

    constructor() ERC721("FractionalNFT", "F-NFT") {}

    function mintFractionalNFT(address recipient, string memory tokenURI)
        public
        returns (uint256)
    {
        uint256 newItemId = _tokenIdTracker + 1;
        _tokenIdTracker = newItemId;

        _mint(recipient, newItemId);
        _setTokenURI(newItemId, tokenURI);

        return newItemId;
    }
}
