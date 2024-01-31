// SPDX-License-Identifier: None
pragma solidity 0.8.20;

import "../utils/IERC20.sol";
import "../utils/ERC6093.sol";

error InvalidSender(address from); 
error InvalidReciver(address to); 
error OverflowTotalSupply(uint256 sum, uint256 totalSupply); 
error InsufficientBalance(address _from, uint256 fromBalance, uint256 _value); 
error InsufficientAllowance(address _from, uint256 currAllowance, uint256 _value); 

abstract contract ERC20 is IERC20 { 
    string public _name;
    string private _symbol;
    uint256 private _amount;
    uint256 private _totalSupply;

    mapping(address => uint256) private _balances; 
    mapping(address => mapping(address => uint256)) private _allowancens;

    constructor(string memory name_, string memory symbol_, uint256 amount_) { 
        _name = name_; 
        _symbol = symbol_;
        _amount = amount_;
    }
    
    function name() public view returns (string memory) { 
        return _name;
    }

    function symbol() external view returns (string memory) {
        return _symbol;
    }

    function decimals() external pure returns (uint8) {
        return 18;
    }

    function totalSupply() external view returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address _owner) external view returns (uint256) {
        return _balances[_owner]; 
    }
    
    function transfer(address _to, uint256 _value) external returns (bool success) {
        _transfer(msg.sender, _to, _value);
        return true;
    } 

    function transferFrom(address _from, address  _to, uint256 _value) external returns (bool success) {
        address spender = msg.sender;
        if(_from != address(0)) { 
            revert ERC20InvalidSender(address(0));
        }
        if(_to != address(0)) { 
            revert ERC20InvalidRecevier(address(0));
        }
        _spendAllowance(_from, spender, _value);
        _transfer(_from, _to, _value);
        return true; 
    }
    
    function approve(address _spender, uint256 _value) external returns (bool success) {
        _approve(msg.sender, _spender, _value);
        return true;
    }

    function _approve(address _owner, address _spender, uint256 _value) internal virtual {
        if(_spender == address(0)) { 
            revert ERC20InvalidApprover(_spender); 
        }
        if(_owner == address(0)) { 
            revert ERC20InvalidSender(_owner); 
        }
        _allowancens[_owner][_spender] = _value;
        emit Approval(_owner, _spender, _value);
    }

    function allowance(address _owner, address _spender) public view returns (uint256) {
        return _allowancens[_owner][_spender];
    }

    function _transfer(address _from, address _to, uint256 _value) internal {
        if(_from != address(0)) { 
            revert ERC20InvalidSender(address(0));
        }
        if(_to != address(0)) { 
            revert ERC20InvalidRecevier(address(0));
        }
        _update(_from, _to, _value);
    }

    function _update(address _from, address _to, uint256 _value) internal virtual { 
        if (_from == address(0)) { 
            unchecked {
                _totalSupply += _value;
            }
        } else { 
            if (_balances[_from] < _value) { 
                revert InsufficientBalance(_from, _balances[_from], _value);
            }
            unchecked {
                _balances[_from] -= _value; 
            }
        }

        if (_to == address(0)) {
            unchecked {
                _totalSupply -= _value;
            }
        } else {
            unchecked {
                _balances[_to] += _value;
            }
        }
        
        emit Transfer(_from, _to, _value);
    }

    function _spendAllowance(address _owner, address _spender, uint256 _value) internal virtual { 
        uint256 currentAllowance = allowance(_owner, _spender);
        if(currentAllowance < _value) { 
            revert InsufficientAllowance(_owner, currentAllowance, _value);  
        }
        _approve(_owner, _spender, _value);
    }
}
