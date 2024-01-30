// SPDX-License-Identifier: None
pragma solidity 0.8.20;

import "./ERC20.sol";

contract ERC20Impl is ERC20 { 
    constructor(string memory _name, string memory _symbol, uint256 _amount) ERC20(_name, _symbol, _amount) {}
    
    function mint(address _to, uint256 _value) public { 
        _mint(_to, _value);
    }    
    
    function burn(address _from, uint256 _value) public { 
        _burn(_from, _value);
    }

}
