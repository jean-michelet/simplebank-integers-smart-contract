// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleEtherBank {
    mapping(address => uint256) public balances;

    uint256 private constant MIN_DEPOSIT = 0.0001 ether;
    uint256 private constant MAX_DEPOSIT = 0.001 ether;
    uint256 private constant MAX_WITHDRAW = 0.001 ether;

    constructor() payable { }

    function deposit() public payable {
        require(msg.value >= MIN_DEPOSIT, "Deposit is too small.");
        require(msg.value <= MAX_DEPOSIT, "Deposit exceeds max limit.");
        balances[msg.sender] += msg.value;
    }

    function withdraw(uint256 amount) public payable  {
        require(amount <= MAX_WITHDRAW, "Withdrawal exceeds limit.");
        require(balances[msg.sender] >= amount, "Insufficient funds.");
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
    }

    function getBalance() public view returns (uint256) {
        return balances[msg.sender];
    }

    function contractBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
