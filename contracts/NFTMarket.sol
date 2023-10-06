// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ERC721URIStorage} from "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract NFTMarket is ERC721URIStorage {
    uint256 public _nextTokenId;
    mapping(uint256 => uint256) private _nftPrices;
    mapping(uint256 => bool) private _isForSale;

    event NFTPriceUpdated(uint256 indexed tokenId, uint256 price);
    event NFTSaleStatusUpdated(uint256 indexed tokenId, bool isForSale);
    event NFTSold(uint256 indexed tokenId, address indexed buyer, address indexed seller, uint256 price);

    constructor() ERC721("MyVirtualAnimal", "MVA"){}

    // NFT Minting
    function createNFT(address owner, string memory tokenURI)
        public
        returns (uint256)
    {
        uint256 tokenId = _nextTokenId++;
        _mint(owner, tokenId);
        _setTokenURI(tokenId, tokenURI);

        return tokenId;
    }

    // set NFT Price
    function setNFTPrice(uint256 tokenId, uint256 price) public {
        require(ownerOf(tokenId) == msg.sender, "Only owner can set the price");
        _nftPrices[tokenId] = price;
        emit NFTPriceUpdated(tokenId, price);
    }

    function markNFTForSale(uint256 tokenId, bool isForSale) public {
        require(ownerOf(tokenId) == msg.sender, "Only owner can set the sale status");
        require(_nftPrices[tokenId] > 0, "NFT price should be greater than 0");
        _isForSale[tokenId] = isForSale;
        emit NFTSaleStatusUpdated(tokenId, isForSale);
    }

    function buyNFT(uint256 tokenId) public payable {
        require(_isForSale[tokenId], "NFT is not for sale");
        require(msg.value == _nftPrices[tokenId], "Incorrect Ether sent");

        address seller = ownerOf(tokenId);
        _transfer(seller, msg.sender, tokenId);

        payable(seller).transfer(msg.value);

        _isForSale[tokenId] = false;

        emit NFTSold(tokenId, msg.sender, seller, msg.value);
    }

    function getNFTPrice(uint256 tokenId) public view returns (uint256) {
        return _nftPrices[tokenId];
    }

    function isNFTForSale(uint256 tokenId) public view returns (bool) {
        return _isForSale[tokenId];
    }
}
