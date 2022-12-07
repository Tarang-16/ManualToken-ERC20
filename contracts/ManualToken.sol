// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

contract ManualToken {
    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;
    uint256 totalSupply;

    constructor(uint256 initialSupply) {
        totalSupply = initialSupply * 10 ** 18;
        balanceOf[msg.sender] = totalSupply;
    }

    function _transfer(address _from, address _to, uint256 _value) internal {
        require(_to != address(0x0)); // ensuring that money does not transfer to this adddress
        require(balanceOf[_from] >= _value);
        require(balanceOf[_to] + _value >= balanceOf[_to]); // checking for overflows

        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;
    }

    function transfer(
        address _to,
        uint256 _value
    ) public returns (bool success) {
        _transfer(msg.sender, _to, _value);
        return true;
    }

    function transferFrom(
        address _from,
        address _to,
        uint256 _value
    ) public returns (bool success) {
        require(allowance[_from][msg.sender] >= _value); // agar samajh nhi aye to 8 min pe ye video dekh lena https://www.youtube.com/watch?v=51s1K5Asi80&ab_channel=ErcDev
        allowance[_from][msg.sender] -= _value; // here msg.sender is _spender who can spend only _value tokens at max.
        _transfer(_from, _to, _value);
        return true;
    }

    function approve(
        address _spender,
        uint256 _value
    ) public returns (bool success) {
        allowance[msg.sender][_spender] = _value; // Allows `_spender` to spend no more than `_value` tokens on your behalf
        return true;
    }
}
