// SPDX-License-Identifier: None
pragma solidity 0.8.20;

import {ERC20Impl} from "../src/ERC20Impl.sol"; 
import "../utils/ERC6093.sol";
// import {Vm} from "forge-std/Vm.sol";
// import {console} from "forge-std/console.sol";
import {Test, console, Vm, StdCheats} from "forge-std/Test.sol";

contract TestERC20 is Test { 
    ERC20Impl public erc20;
    // StdCheats
    address public constant DEPLOYER = payable(address(1));
    address public constant ALICE = payable(address(2));
    address public constant BOB = payable(address(3));

    function setUp() public { 
        erc20 = new ERC20Impl("NAME", "Symbol");
    } 

    function testName() public {
        assertEq(erc20.name(), "NAME");
    }

    function testSymbol() public {
        assertEq(erc20.symbol(), "Symbol");
    }
    
    function testDecimals() public {
        assertEq(erc20.decimals(), 18);
    }

    function testBalanceOf() public {
        vm.prank(DEPLOYER);
        deal(address(erc20), ALICE, 10);
        assertEq(erc20.balanceOf(ALICE), 10);
    }

    function testTransfer() public {
        deal(address(erc20), ALICE, 10);
        vm.prank(ALICE);
        erc20.transfer(BOB, 5);
        assertEq(erc20.balanceOf(ALICE), 5);
        assertEq(erc20.balanceOf(BOB), 5);
    }

    function testTransferFrom() public {
        deal(address(erc20), DEPLOYER, 10);
        vm.prank(DEPLOYER);
        erc20.approve(ALICE, 3);
        vm.prank(ALICE);
        erc20.transferFrom(DEPLOYER, BOB, 3);
        assertEq(erc20.balanceOf(ALICE), 0);
        assertEq(erc20.balanceOf(BOB), 3);
        assertEq(erc20.balanceOf(DEPLOYER), 7);
    } 
    
    function testTransferFormERC20InvalidSender() public {
        vm.expectRevert(abi.encodeWithSelector(ERC20InvalidSender.selector, address(0)));
        erc20.transferFrom(address(0), ALICE, 10);
    }
    
    function testTransferFormERC20InvalidSReciver() public {
        deal(address(erc20), ALICE, 10);
        vm.expectRevert(abi.encodeWithSelector(ERC20InvalidRecevier.selector, address(0)));
        erc20.transferFrom(ALICE, address(0), 10);
    }

    function testApproveERC20InvalidSender() public {
        deal(address(erc20), DEPLOYER, 10);
        vm.prank(address(0));
        vm.expectRevert(abi.encodeWithSelector(ERC20InvalidSender.selector, address(0)));
        erc20.approve(ALICE, 3);
    }
    
    function testApproveERC20InvalidApprover() public {
        deal(address(erc20), DEPLOYER, 10);
        vm.prank(DEPLOYER);
        vm.expectRevert(abi.encodeWithSelector(ERC20InvalidApprover.selector, address(0)));
        erc20.approve(address(0), 3);
    }
    
    function testTransferERC20InvalidSender() public { 
        vm.prank(address(0)); 
        vm.expectRevert(abi.encodeWithSelector(ERC20InvalidSender.selector, address(0)));
        erc20.transfer(ALICE, 10);
    }
    
    function testTransferERC20InvalidReciver() public { 
        vm.prank(ALICE); 
        vm.expectRevert(abi.encodeWithSelector(ERC20InvalidRecevier.selector, address(0)));
        erc20.transfer(address(0), 10);
    }

    function testTransferBalanceLessThenValue() public {
        deal(address(erc20), ALICE, 10);
        vm.prank(ALICE);
        vm.expectRevert(abi.encodeWithSelector(ERC20InsufficientBalance.selector, ALICE, 10, 15));
        erc20.transfer(BOB, 15);
    }

    function testApproveERC20InsufficentAllowance() public { 
        deal(address(erc20), DEPLOYER, 10);
        vm.prank(DEPLOYER);
        erc20.approve(ALICE, 5);
        vm.prank(ALICE);
        vm.expectRevert(abi.encodeWithSelector(ERC20InsufficientAllowance.selector, DEPLOYER, 5, 10));
        erc20.transferFrom(DEPLOYER, BOB, 10);
    }

    function testTotalSupplyIncrease() public { 
        vm.prank(ALICE);
        erc20.mint(BOB, 5);
        assertEq(erc20.totalSupply(), 5);
    }

    function testTotalSupplyDecrease() public { 
        vm.prank(ALICE);
        erc20.mint(BOB, 10);
        vm.prank(BOB);
        erc20.burn(BOB, 5);
        assertEq(erc20.totalSupply(), 5);
    }
}