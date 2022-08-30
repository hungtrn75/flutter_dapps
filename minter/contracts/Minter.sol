pragma solidity ^0.8.0;

contract Minter {
  address public minter;
  mapping(address => uint) public balance;

  constructor(){
    minter = msg.sender;
  }

  event Sent(address from, address to, uint amount);

  function mint(address receiver, uint amount) public {
    if(minter != msg.sender) return;
    balance[receiver] += amount;
  }

  function send(address sender, address receiver, uint amount) public {
    if(balance[sender] < amount) revert();
    balance[sender] -= amount;
    balance[receiver] += amount;

    emit Sent(sender, receiver, amount);
  }
}
