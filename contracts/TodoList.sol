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

    event TaskCreated(
        uint id,
        string content,
        bool completed
    );

    event TaskCompleted(
        uint id,
        bool completed
    );

    // mapping is a kind of array where we store a key value pair
    // in this case de key is a uint (index) and the value a Task
    mapping(uint => Task) public tasks;

    constructor() public {
        createTask("Check out the app.com");
    }

    function createTask(string memory _content) public {
        taskCount++;
        tasks[taskCount] = Task(taskCount, _content, false);

        emit TaskCreated(taskCount, _content, false);
    }

    function toggleCompleted(uint _id) public {
        // Task datatype, underscore means that is a local variable, and not a global one (is not a rule it is just good practice)
        Task memory _task = tasks[_id];

        // change the value
        _task.completed = !_task.completed;

        tasks[_id] = _task;

        emit TaskCompleted(_id, _task.completed);
    }
}