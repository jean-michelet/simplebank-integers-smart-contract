// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SampleContract {
    string public myString = "Hello World";

    function updateString(string memory _newString) public payable {
        require(msg.value == 1 ether, "You should pay exactly 1 ether");
        
        myString = _newString;
    }
}
