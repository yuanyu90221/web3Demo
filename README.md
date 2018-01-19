## Web3Demo

# 1 first public smart contract on <http://remix.ethereum.org/#optimize=false&version=soljson-v0.4.19+commit.c4cbbb05.js>

```code
pragma solidity ^0.4.18;

contract Coursetro {
    string fName;
    uint age;
    
    event Instructor(
        string name,
        uint age
    );
    
    function setInstructor(string _fName, uint _age) public {
        fName = _fName;
        age = _age;
        Instructor(_fName, _age);
    }
    
    function getInstructor() public constant returns (string, uint) {
        return (fName, age);
    }
}

```

# 2 run up testrpc on localhost

```code
  testrpc
```

# 3 use web3.js to load smart contract abi and assign the reference address

```code
  // set up web3
    $("#loader").hide();
    if(typeof web3 !== 'undefined') {
      web3 =  new Web3(web3.currentProvider);
    }
    else {
      web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:8545"));
    }
    // get Account
    web3.eth.defaultAccount = web3.eth.accounts[0];
    // get contract
    var CoursetroContract = web3.eth.contract([
    {
      "constant": true,
      "inputs": [],
      "name": "getInstructor",
      "outputs": [
        {
          "name": "",
          "type": "string"
        },
        {
          "name": "",
          "type": "uint256"
        }
      ],
      "payable": false,
      "stateMutability": "view",
      "type": "function"
    },
    {
      "anonymous": false,
      "inputs": [
        {
          "indexed": false,
          "name": "name",
          "type": "string"
        },
        {
          "indexed": false,
          "name": "age",
          "type": "uint256"
        }
      ],
      "name": "Instructor",
      "type": "event"
    },
    {
      "constant": false,
      "inputs": [
        {
          "name": "_fName",
          "type": "string"
        },
        {
          "name": "_age",
          "type": "uint256"
        }
      ],
      "name": "setInstructor",
      "outputs": [],
      "payable": false,
      "stateMutability": "nonpayable",
      "type": "function"
    }
  ]);
  var Coursetro = CoursetroContract.at('0x5ebc2141c3e30c764a898fa696bc3fd5070fbdd1');
    
  var instructorEvent = Coursetro.Instructor();
  instructorEvent.watch(function(error, result) {
    
    if(!error) {
      $("#loader").hide();
      $('#instructor').html(result.args.name + ' (' + result.args.age + ' years old)');
    }
    else {
      $("#loader").hide();
      console.error(error);
    }
    $("#instructor").show();
  });
```

# 4 add modifier to verify owner

```code
pragma solidity ^0.4.18;

contract Coursetro {
    string fName;
    uint age;
    address owner;
    
    function Coursetro() public {
        owner = msg.sender;
    }
    
    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }
    event Instructor(
        string name,
        uint age
    );
    
    function setInstructor(string _fName, uint _age) onlyOwner public {
        fName = _fName;
        age = _age;
        Instructor(_fName, _age);
    }
    
    function getInstructor() public constant returns (string, uint) {
        return (fName, age);
    }
}
``` 

# 4 Watch Event with function

```code
 var instructEventCallback = Coursetro.Instructor(function(error, result){
    $("#loader").hide();
    if(!error) {
      console.log(`watch result`);
      console.log(result);
      $('#instructor').html(result.args.name + ' (' + result.args.age + ' years old)');
    } else {
      console.error(error);
    }
    $("#instructor").show();
  });
```