pragma solidity ^0.4.19;

/**
*  Basic token
*  Basic version of StandardToken, with no allowances
 */
contract BasicToken {
  address public owner;
  uint public totalSupply;
  mapping(address => uint) balances;

  event Transfer(address indexed from, address indexed to, uint value);

  function BasicToken() public {
    owner = msg.sender;
    balances[owner] = 10000;
  }

  function balanceOf(address _owner) public constant returns (uint) {
    return balances[_owner];
  }

  function transfer(address _to, uint _value) public {
    balances[msg.sender] = safeSub(balances[msg.sender], _value);
    balances[_to] = safeAdd(balances[_to], _value);
    Transfer(msg.sender, _to, _value);
  }

  function safeAdd(uint adder, uint addee) pure internal returns (uint) {
    uint sum = adder + addee;
    assert(sum >= adder && sum >= addee);
    return sum;
  }

  function safeSub(uint substractor, uint substractee) pure internal returns (uint) {
    assert(substractee < substractor);
    return substractor - substractee;
  }

  // function assertSelf(bool assertion) pure internal {
  //   if (!assertion) {
  //     throw;
  //   }
  // }
}