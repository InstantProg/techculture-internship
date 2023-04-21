//SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;
import "./Ownable.sol";
import "./IERC20.sol";

contract TCToken is Ownable, IERC20 {
    address private owner;
    string private _name;
    string private _symbol;
    uint256 private theTotalSupply;

    mapping(address => uint256) private balances;
    mapping(address => mapping(address => uint256)) private allowances;

    constructor(string memory coinName, string memory coinSymbol) {
        owner = msg.sender;
        _name = coinName;
        _symbol = coinSymbol;
        theTotalSupply = 10000 * 1e18;
        balances[owner] = theTotalSupply;
    }

    function name() public view returns (string memory) {
        return _name;
    }

    function symbol() public view returns (string memory) {
        return _symbol;
    }

    function decimals() public view returns (uint32) {
        return 18;
    }

    function totalSupply() public view override returns (uint256) {
        return theTotalSupply;
    }

    function balanceOf(address account) public view override returns (uint) {
        return balances[msg.sender];
    }

    function transferFrom(
        address _from,
        address _to,
        uint _value
    ) public override returns (bool) {
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
    ) public override returns (bool success) {
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
    ) public view override returns (uint256) {
        return allowances[_owner][_spender];
    }

    function transfer(
        address _to,
        uint256 _value
    ) public override returns (bool) {
        // Added bool return type
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

        return true;
    }
}
