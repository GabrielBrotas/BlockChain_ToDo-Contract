## Blockchain App

 Instead of connect direct to a server we are going to access ou data (To do list) via browser

and we are going to connect to the client side application

This client side it is going to talk direct to the blockchain

In the blockchain we will have code written with etherium smart contracts that will contain all business logic for our to do list and all the to do items are gonna be stored on the block chain itself and this is how  a blockchain web application work, different than a tradicional web ↔server app .

## What is a blockchain

It is a seperated network, peer-to-peer network of nodes that all talk to one another, different machines talking to on another and we can connect to an individual node on the blockchain in order to use it.

all the node in that network participate in running the network they all contain a copy of the code on the blockchain and all the data,

And all the data on the blockchain is contained bundles of records called blocks

and all the nodes on the network also participate in ensuring that the data on the blockchain is secury and unchangeble.

## Smart contracts

All the code in block chain is contained in smart contracts, programs that run in the blockchain

They are going to be the building blocks of blockchain applications.

All the code in a smart contract is immutable, unchangeble, once we deploy that code we are not able to update that code anymore.

Like microservices on the web 

## Ganache

personal Ethereum blockchain which you can use to run tests, execute commands, and inspect state while controlling how the chain operates.

## Truffle

Create smart contracts

## Metamask

Browser extension for google chrome, etherium blockchain is a network so we need a browser extension in order to connect with dat network,

Metamask will allow us to connect with blockchain with our personal account and interect with the smart contracts
![image](https://user-images.githubusercontent.com/63565773/138577103-1b522e87-4928-4092-853e-ff8e81228dfa.png)

## Project —

>truffle init // create project

>yarn init -y

```jsx
{
  "name": "todo-list",
  "version": "1.0.0",
  "main": "tuggle-config.js",
  "license": "MIT",
  "scripts": {
    "dev": "lite-server"
  },
  "devDependencies": {
    "bootstrap": "4.1.3",
    "chai": "^4.1.2",
    "chai-as-promised": "^7.1.1",
    "chai-bignumber": "^2.0.2",
    "lite-server": "^2.3.0",
    "nodemon": "^1.17.3",
    "truffle": "5.0.2",
    "truffle-contract": "3.0.6"
  }

}
```
![image](https://user-images.githubusercontent.com/63565773/138577114-42f84989-a388-4232-a40e-9a56091d8190.png)

the contracts folder is where we will have our contracts

new contract: 

**contracts/TodoList.sol**

```jsx
// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.22 <0.9.0;

contract TodoList {
    // number of task where we have in our to do list
    // public allow the client read this value
    uint public taskCount = 0;
}
```

compile this code 

>truffle compile
![image](https://user-images.githubusercontent.com/63565773/138577119-80aaaca4-983f-4281-a411-94d1b51f233b.png)

this will create a json representation of our contract in build/contracts
![image](https://user-images.githubusercontent.com/63565773/138577126-6ca4d147-07f4-46ba-ad1b-0eb9a1bcfa1d.png)

**truffle-config.js**

```jsx
module.exports = {
  // specify the networks
  networks: {
    development: {
      host: "127.0.0.1", // localhost
      port: 7545, // port that ganache run
      network_id: "*" // Match any network id
    }
  },
  solc: {
    optimizer: {
      enabled: true,
      runs: 200
    }
  }
}
```

**migrations**

 Whenever we deploy a smart contract to the blockchain you are actually changing the blockchain state (Blockchain is a big database in one sense) and whenever we put the smart contract on the blockchain we are updating the state and we need a migration in order to do that.

migrations/2_deploy_contracts.js

```jsx
// truffles creates an artifacts outside 
const TodoList = artifacts.require("./TodoList");

module.exports = function (deployer) {
  deployer.deploy(TodoList);
};
```

>truffle migrate

![image](https://user-images.githubusercontent.com/63565773/138577141-ad376857-2d66-4402-a3bb-c71768212556.png)


We can see that each contract and migration cost something to deploy

![image](https://user-images.githubusercontent.com/63565773/138577145-c85272e9-c78d-4056-806a-9ec38d4356b0.png)

In the first account the balence went down a little bit. this account paid the gas to deploy the smart contract.

- Console

>truffle console

>todoList = await TodoList.deployed()

![image](https://user-images.githubusercontent.com/63565773/138577153-ecf470c5-255b-4a2e-8f10-47b6136bfa84.png)

Here we are assign the todoList to the migration TodoList that we deployed in the migration
![image](https://user-images.githubusercontent.com/63565773/138577159-f17fc3c2-4397-4f7a-bfc9-b4797a1202c9.png)

And now we have access to some informations about this contract

![image](https://user-images.githubusercontent.com/63565773/138577162-eb3329a8-e321-4c50-b440-0a092c15a506.png)

### Data Types, Functions and Constructor

contracts/TodoList.sol

```jsx
// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.22 <0.9.0;

contract TodoList {
    // number of task where we have in our to do list
    // public allow the client read this value
    uint public taskCount = 0;

    // struct allow us to create a type 
    struct Task {
        uint id; // integer that can be negative
        string content;
        bool completed;
    }

    // mapping is a kind of array where we store a key value pair
    // in this case de key is a uint (index) and the value a Task
    mapping(uint => Task) public tasks;

    constructor() {
        createTask("Check out the app.com");
    }

    function createTask(string memory _content) public {
        taskCount++;

        tasks[taskCount] = Task(taskCount, _content, false);
    }
}
```

>truffle compile

>truffle migrate —reset // deploy a new copy and override the other

![image](https://user-images.githubusercontent.com/63565773/138577167-03f8972a-393c-483c-987b-fc780ed1aa2c.png)

we can see that the id is a BN (Big Number0 with the value 1, content and completed is in there as well.

![image](https://user-images.githubusercontent.com/63565773/138577172-561c4c77-f4ee-4cb2-ae13-49c2588cb5ca.png)
## Testing

test/TodoList.test.js

```jsx
const TodoList = artifacts.require('./TodoList.sol')

contract('TodoList', (accounts) => {
    before(async () => {
        this.todoList = await TodoList.deployed()
    })

    it('should deploys successfully', async () => {
        const address = await this.todoList.address

        assert.notEqual(address, 0x0)
        assert.notEqual(address, '')
        assert.notEqual(address, null)
        assert.notEqual(address, undefined)
        console.log(address)
    })
})
```

>truffle test
![image](https://user-images.githubusercontent.com/63565773/138577179-d486c933-7762-4d5b-821b-1ea8beb1b6b5.png)
