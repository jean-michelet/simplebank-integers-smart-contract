// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

import "remix_tests.sol"; 
import "../contracts/SimpleEtherBank.sol";
import "./TestUser.sol";

contract SimpleEtherBankTest {
    SimpleEtherBank bank;

    function beforeEach() public {
        bank = new SimpleEtherBank();
    }

    function testValidDeposit() public payable {
        TestUser user = new TestUser{ value: 1 ether}();
        
    }
}