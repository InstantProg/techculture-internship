//SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;
import "./Ownable.sol";

contract TCToken is Ownable {
    address private owner;
    string private name;
    string private symbol;
    uint256 private theTotalSupply;

    mapping(address => uint256) private balances;
    mapping(address => mapping(address => uint256)) private allowances;

    event Transfer(address indexed _from, address indexed _to, uint _value);
    event Approval(
        address indexed _owner,
        address indexed _spender,
        uint _value
    );

    constructor(string memory _name, string memory _symbol) {
        owner = msg.sender;
        name = _name;
        symbol = _symbol;
        theTotalSupply = 10000 * 1e18;
        balances[owner] = theTotalSupply;
    }

    function getTokenName() public view returns (string memory) {
        return name;
    }

    function getTokenSymbol() public view returns (string memory) {
        return symbol;
    }

    function getTokenDecimals() public view returns (uint32) {
        return 18;
    }

    function totalSupply() public returns (uint) {
        return theTotalSupply;
    }

    function balanceOf(address account) public view returns (uint) {
        return balances[msg.sender];
    }

    function transferFrom(
        address _from,
        address _to,
        uint _value
    ) public returns (bool) {
        uint256 transferFee = (_value * 5) / 100;
        require(
            balances[_from] >= _value + transferFee,
            "from does not have sufficient funds"
        );
        require(allowances[_from][_to] >= _value, "insufficient allowance");

        balances[_from] -= _value + transferFee;
        balances[owner] += transferFee;
        balances[_to] += _value;
        emit Transfer(_from, _to, _value);
        return true;
    }

    function approve(
        address _spender,
        uint _value
    ) public returns (bool success) {
        require(
            balances[msg.sender] >= _value,
            "now sufficient funds for approval"
        );
        allowances[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    function allowance(
        address _owner,
        address _spender
    ) public returns (uint remaining) {
        return allowances[_owner][_spender];
    }

    function transfer(address _to, uint _value) public {
        require(
            msg.sender != address(0),
            "ERC20: transfer from the zero address"
        );

        require(_to != address(0), "ERC20: transfer to the zero address");
        uint256 transferFee = (_value * 5) / 100;
        require(
            balances[msg.sender] >= _value + transferFee,
            "sender has no sufficient funds"
        );

        balances[msg.sender] -= _value + transferFee;
        balances[owner] += transferFee;
        balances[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
    }
}
