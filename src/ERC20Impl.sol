// SPDX-License-Identifier: None
pragma solidity 0.8.20;

import "./ERC20.sol";

contract ERC20Impl is ERC20 { 
    constructor(string memory _name, string memory _symbol) ERC20(_name, _symbol) {}

    function mint(address _to, uint256 _value) public { 
        _update(address(0), _to, _value);
    }
    function burn(address _from, uint256 _value) public { 
        _update(_from, address(0), _value);
    }
}
