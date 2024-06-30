// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {EnglishAuction} from "../src/EnglishAuction.sol";

contract EnglishAuction is Test {
    EnglishAuction public EnglishAuction;

    function setUp() public {
        EnglishAuction = new EnglishAuction();
        EnglishAuction.setNumber(0);
    }

    function test_Increment() public {
        EnglishAuction.increment();
        assertEq(EnglishAuction.number(), 1);
    }

    function testFuzz_SetNumber(uint256 x) public {
        EnglishAuction.setNumber(x);
        assertEq(EnglishAuction.number(), x);
    }
}
