// SPDX-License-Identifier: GPL-3.0
        
pragma solidity >=0.4.22 <0.9.0;

// This import is automatically injected by Remix
import "remix_tests.sol"; 

import "../contracts/SimpleBank.sol";
import "./TestUser.sol";

contract SimpleBankTest {
    SimpleBank bank;

    /// Run before each test
    function beforeEach() public {
        bank = new SimpleBank();
    }

    function testValidDeposit() public {
        uint amount = 10;

        bank.deposit(amount);

        Assert.equal(bank.getBalance(), amount, "Balance should equal the deposit");
    }

    function testDepositTooSmall() public {
        uint amount = 5;

        try bank.deposit(amount) {
            Assert.ok(false, "Should revert due to small deposit");
        } catch Error(string memory reason) {
            Assert.equal(reason, "Deposit is too small.", "Wrong error message");
        }
    }

    function testDepositTooBig() public {
        uint amount = 500;

        try bank.deposit(amount) {
            Assert.ok(false, "Should revert due to exceeds limits");
        } catch Error(string memory reason) {
            Assert.equal(reason, "Deposit exceeds max limit.", "Wrong error message");
        }
    }

    function testValidWithdraw() public {
        bank.deposit(100);

        bank.withdraw(10);

        uint balance = bank.getBalance();
        Assert.equal(balance, 90, "Balance should have been decreased");
    }

    function testWithdrawOverLimit() public {
        bank.deposit(100);
        try bank.withdraw(200) {
            Assert.ok(false, "Should revert due to exceeds limits");
        } catch Error(string memory reason) {
            Assert.equal(reason, "Withdrawal exceeds limit.", "Wrong error message");
        }
    }

    function testWithdrawTooMuch() public {
        bank.deposit(50);
        try bank.withdraw(60) {
            Assert.ok(false, "Should revert due to withdrawal over balance");
        } catch Error(string memory reason) {
            Assert.equal(reason, "Insufficient funds.", "Wrong error message");
        }
    }

    function testWithdrawFullBalance() public {
        bank.deposit(50);
        Assert.equal(bank.getBalance(), 50, "Balance should be 50 before withdrawal");
        bank.withdraw(50);
        Assert.equal(bank.getBalance(), 0, "Balance should be zero after full withdrawal");
    }

    function testMultipleUsersIsolation() public {
        bank.deposit(50); // msg.sender (user1)
        Assert.equal(bank.getBalance(), 50, "User1 should have 50");

        // Simulate user2 using proxy contract
        TestUser user2 = new TestUser();
        user2.depositToBank(bank, 30);

        Assert.equal(user2.getBalanceFromBank(bank), 30, "User2 should have 30");
        Assert.equal(bank.getBalance(), 50, "User1 balance should still be 50");
    }
}
