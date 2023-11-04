// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";

contract Marketplace {
    struct Listing {
        uint256 tokenId;
        address seller;
        uint256 price;
        bool isSold;
    }

    IERC721 public immutable nftContract;
    Listing[] public listings;

    event Listed(uint256 indexed tokenId, address indexed seller, uint256 price);
    event Sold(uint256 indexed tokenId, address indexed seller, address indexed buyer, uint256 price);

    constructor(address _nftContract) {
        nftContract = IERC721(_nftContract);
    }

    function listToken(uint256 tokenId, uint256 price) public {
        require(nftContract.ownerOf(tokenId) == msg.sender, "Not token owner");
        require(nftContract.isApprovedForAll(msg.sender, address(this)), "Marketplace not approved");

        listings.push(Listing(tokenId, msg.sender, price, false));
        emit Listed(tokenId, msg.sender, price);
    }

    function buyToken(uint256 listingId) public payable {
        Listing storage listing = listings[listingId];
        require(!listing.isSold, "Token already sold");
        require(msg.value >= listing.price, "Insufficient payment");

        listing.isSold = true;
        nftContract.transferFrom(listing.seller, msg.sender, listing.tokenId);

        payable(listing.seller).transfer(listing.price);
        emit Sold(listing.tokenId, listing.seller, msg.sender, listing.price);
    }
}
