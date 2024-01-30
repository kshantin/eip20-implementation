// SPDX-License-Identifier: None
pragma solidity 0.8.20;

/// ERC20 

error ERC20InsufficientBalance(address _sender, uint256 _balance, uint256 _needed); 
error ERC20InsufficientAllowance(address _reciver);
error ERC20InvalidSender(address _sender); 
error ERC20InvalidRecevier(address _reciver);
error ERC20InvalidOwner(address _owner);
error ERC20InvalidSpender(address _owner);
error ERC20InvalidApprover(address approver);
