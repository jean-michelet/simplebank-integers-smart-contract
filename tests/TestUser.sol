// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../contracts/SimpleBank.sol";
import "../contracts/SimpleEtherBank.sol";

contract TestUser {
    constructor() payable {}

    function depositToBank(SimpleBank bank, uint256 amount) public {
        bank.deposit(amount);
    }

    function withdrawFromBank(SimpleBank bank, uint256 amount) public {
        bank.withdraw(amount);
    }

    function getBalanceFromBank(SimpleBank bank) public view returns (uint256) {
        return bank.getBalance();
    }

        // Deposit real ETH into SimpleEtherBank
    function depositToEtherBank(SimpleEtherBank bank) public payable {
        bank.deposit{value: msg.value}();
    }

    // Withdraw ETH from SimpleEtherBank
    function withdrawFromEtherBank(SimpleEtherBank bank, uint256 amount) public {
        bank.withdraw(amount);
    }

    // Read user’s balance from SimpleEtherBank
    function getBalanceFromEtherBank(SimpleEtherBank bank) public view returns (uint256) {
        return bank.getBalance();
    }

    // (Optional) Get the total ETH held in SimpleEtherBank
    function getContractBalanceFromEtherBank(SimpleEtherBank bank) public view returns (uint256) {
        return bank.contractBalance();
    }
}
