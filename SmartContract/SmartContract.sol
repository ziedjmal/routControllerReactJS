// SPDX-License-Identifier: GPL-3.0
import "hardhat/console.sol";
pragma solidity ^0.8.0;

contract PFA {
    mapping(string => uint256) public registrations;
    address payable private owner;
    address payable private sender;


    constructor() {
        console.log("Owner contract deployed by:", msg.sender);
        owner = payable(msg.sender); // 'msg.sender' is sender of current call, contract deployer for a constructor
    }

    function register(string memory key, uint256 value) public {
        registrations[key] = value;
    }

    function pay(string memory key) public payable {
        uint256 rest = 0;
        require(msg.value > 0, "No ether sent");
        require(msg.value >= registrations[key], "No enough ether "); //7ata na3erfou kifeh transfer mich ikoun mil lien  donc 5tarna inou ikoun == mich >=
        rest = msg.value - registrations[key];
        console.log( " | sent = ",msg.value," | pay = ",registrations[key]);
        console.log("rest = ", rest );
        owner.transfer(registrations[key]);
        registrations[key] = 0;
        console.log("Sender of money :", msg.sender);
        require(rest > 0, "No excess balance to return.");
         payable(msg.sender).transfer(rest);
    }

    function getRegistrationValue(string memory key) public view returns (uint256)
    {
        return registrations[key];
    }
    function close() public 
        require(msg.sender == owner, "Only the owner can close this contract");
        selfdestruct(owner);{//deprecaded
    }
}
