// SPDX-License-Identifier: None
pragma solidity 0.8.20;

import {ERC20Impl} from "../src/ERC20Impl.sol"; 
import {DSTest} from "ds-test/test.sol";
import {Vm} from "forge-std/Vm.sol"; 
import "forge-std/Console.sol";
// import "@openzeppelin/contracts/utils/Strings.sol";

contract TestERC20 is DSTest { 
    using Strings for uint256;
    Vm internal immutable vm = Vm(HEVM_ADDRESS); 
    ERC20Impl public erc20;

    address public constant DEPLOYER = payable(address(1));
    address public constant ALICE = payable(address(2));
    address public constant BOB = payable(address(3));

    function setUp() public { 
        vm.startPrank(DEPLOYER);
        uint256 value = 100 * (10 ** erc20.decimals());
         
        erc20 = new ERC20Impl("NAME", "Symbol", value);
        // log();
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
    
    // function testMint() public {
    //     vm.prank(DEPLOYER);
    //     erc20.mint(ALICE, 10 ** erc20.decimals());
    //     assertEq(erc20.balanceOf(ALICE), 10 ** erc20.decimals());
    //     assertEq(erc20.totalSupply(), 110 ** erc20.decimals());
    // }
    // function testTransfer() public {}
    // function testTransferFrom() public {} 
    // function testApprove() public {}
    // function testMint() {}
    // function testUpdate() {} 
}