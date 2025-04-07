// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleBank {
    mapping(address => uint256) public balances;

    uint256 public constant MIN_DEPOSIT = 10;    // Represents 0.0001 ETH
    uint256 public constant MAX_DEPOSIT = 100;  // Represents 0.01 ETH
    uint256 public constant MAX_WITHDRAW = 100;

    function deposit(uint256 amount) public {
        require(amount >= MIN_DEPOSIT, "Deposit is too small.");
        require(amount <= MAX_DEPOSIT, "Deposit exceeds max limit.");
        balances[msg.sender] += amount;
    }

    function withdraw(uint256 amount) public {
        require(amount <= MAX_WITHDRAW, "Withdrawal exceeds limit.");
        require(balances[msg.sender] >= amount, "Insufficient funds.");
        balances[msg.sender] -= amount;
    }

    function getBalance() public view returns (uint256) {
        return balances[msg.sender];
    }
}
