// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../contracts/SimpleBank.sol";

contract TestUser {
    function depositToBank(SimpleBank bank, uint256 amount) public {
        bank.deposit(amount);
    }

    function withdrawFromBank(SimpleBank bank, uint256 amount) public {
        bank.withdraw(amount);
    }

    function getBalanceFromBank(SimpleBank bank) public view returns (uint256) {
        return bank.getBalance();
    }
}
