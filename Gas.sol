// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

contract GasStation {
    address payable owner;

    event Transaction(address to, uint amount);

    enum Gasing {setGalon, paid}
    Gasing public gasing;

    constructor() {
        owner = payable(msg.sender);
    }

    uint public add;

    //choose amount of galon in Liter

    function SetLiterGas(uint liter) public returns(string memory, uint) {
        gasing = Gasing.setGalon;
        add = liter;
        add *= 0.01 ether;
        return ("price : $", add);
    }

    //pay the galon

    function Pay() public payable {
        gasing = Gasing.paid;
        payable(msg.sender).transfer(add);
        emit Transaction(owner, add);
    }

    receive() external payable {
        Pay();
    }

    //view your gasoline price

    function getPrice() public view returns(uint) {
        return add;
    }

    //view the real gasoline price

    function getGalonPrice() public pure returns(string memory) {
        return "1 Liter is 0.01 ether";
    }
}
