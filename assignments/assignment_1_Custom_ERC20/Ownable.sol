//SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

contract Ownable {
    address private owner;

    event E_TransferOfOwnership(address previous_owner, address new_owner);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    function transferOwnership(address _newOwner) public onlyOwner {
        require(_newOwner != address(0), "New owner is zero address");
        emit E_TransferOfOwnership(owner, _newOwner);
        owner = _newOwner;
    }
}
