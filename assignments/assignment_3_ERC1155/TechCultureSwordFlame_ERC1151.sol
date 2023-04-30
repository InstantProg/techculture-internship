// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts@4.8.3/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts@4.8.3/access/Ownable.sol";
import "@openzeppelin/contracts@4.8.3/token/ERC1155/extensions/ERC1155Burnable.sol";
import "@openzeppelin/contracts@4.8.3/token/ERC1155/extensions/ERC1155Supply.sol";

contract TechCultureFlameSword is
    ERC1155,
    Ownable,
    ERC1155Burnable,
    ERC1155Supply
{
    mapping(address => bool) public whiteList;

    constructor()
        ERC1155(
            "https://nftstorage.link/ipfs/bafkreieqek2hqm7co6ea7pdlod7xhnak2utoptktl5w57sivqf7lng2uc4"
        )
    {}

    function setURI(string memory newuri) public onlyOwner {
        _setURI(newuri);
    }

    function mint(
        address account,
        uint256 id,
        uint256 amount,
        bytes memory data
    ) public onlyOwner {
        _mint(account, id, amount, data);
    }

    function mintBatch(
        address to,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data
    ) public onlyOwner {
        _mintBatch(to, ids, amounts, data);
    }

    // The following functions are overrides required by Solidity.

    function _beforeTokenTransfer(
        address operator,
        address from,
        address to,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data
    ) internal override(ERC1155, ERC1155Supply) {
        super._beforeTokenTransfer(operator, from, to, ids, amounts, data);
    }

    function addWhitelist(address _newMember) public onlyOwner {
        whiteList[_newMember] = true;
    }

    function buyNft(uint256 _id, uint256 amount) public payable {
        require(whiteList[msg.sender] == true, "you are not in the whitelist!");
        uint256 totalPrice = amount * 100000000000000000;
        require(
            msg.value >= totalPrice,
            "you have sent less than the total price, to calculate it multiply the amount you want by 0.1 eth"
        );
        uint256 excess = msg.value - totalPrice;
        if (excess > 0) {
            (bool refundSuccess, ) = msg.sender.call{value: excess}("");
            require(refundSuccess, "Failed to refund excess Ether.");
        }
        _safeTransferFrom(owner(), msg.sender, _id, amount, "0x00");
    }

    //     - Функция buyNft() - Покупка нфт  нового предмета, обращается к контракту NFT и вызывает функцию mint
    // - Функция mint() - создание нфт овнером
}
