// SPDX-License-Identifier: None
pragma solidity 0.8.20;

interface IERC20 { 
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
    function transfer(address _to, uint256 _value) external returns (bool success); 
    function transferFrom(address _from, address _to, uint256 _value) external returns (bool success); 
    function approve(address _sender, uint256 _value) external returns (bool success);
    function totalSupply() external view returns (uint256); 
    function balanceOf(address _account) external view returns (uint256); 
    function allowance(address _owner, address _spender) external view returns (uint256); 
}