// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract TestNFT is ERC721, ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;

    mapping(uint256 => uint256) public listedItems;

    constructor() ERC721("TestNFT", "CBK") {
        _tokenIdCounter.increment();
    }

    function _baseURI() internal pure override returns (string memory) {
        return
            "https://nftstorage.link/ipfs/bafybeicj72oi2tryh565s3o6wvztqh57nek2x2bbv7pqx3obkgqnwgftey/";
    }

    //     - Функция cancel() - отмена продажи выставленного предмета
    // - Функция buyItem() - покупка предмета.
    // - Функция listItem() - выставление предмета на продажу.
    // - Функция createItem() - создание нового предмета, обращается к контракту NFT и вызывает функцию mint.

    function createItem(address to, string memory uri) public onlyOwner {
        safeMint(to, uri);
    }

    function listItem(uint256 _tokenId, uint256 price) public {
        _requireMinted(_tokenId);
        require(
            ownerOf(_tokenId) == msg.sender,
            "Only the owner of the item can list it"
        );
        listedItems[_tokenId] = price;
    }

    function buyItem(uint256 _tokenId) public payable {
        _requireMinted(_tokenId);
        require(listedItems[_tokenId] != 0, "The item is not listed");
        require(
            msg.value >= listedItems[_tokenId],
            "Not sufficient ETH is sent"
        );
        address payable previousOwner = payable(ownerOf(_tokenId));

        (bool success, ) = previousOwner.call{value: listedItems[_tokenId]}("");
        require(success, "The transfer of ETH was unsuccessful");

        uint256 excess = msg.value - listedItems[_tokenId];
        if (excess > 0) {
            (bool refundSuccess, ) = msg.sender.call{value: excess}("");
            require(refundSuccess, "Failed to refund excess Ether.");
        }
        _approve(msg.sender, _tokenId);

        safeTransferFrom(ownerOf(_tokenId), msg.sender, _tokenId);
    }

    function cancel(uint256 _tokenId) public {
        _requireMinted(_tokenId);
        require(
            ownerOf(_tokenId) == msg.sender,
            "Only the owner of the item can cancel its listing"
        );
        listedItems[_tokenId] = 0;
    }

    function safeMint(address to, string memory uri) public onlyOwner {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
    }

    // The following functions are overrides required by Solidity.

    function _burn(
        uint256 tokenId
    ) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function tokenURI(
        uint256 tokenId
    ) public view override(ERC721, ERC721URIStorage) returns (string memory) {
        return super.tokenURI(tokenId);
    }
}
