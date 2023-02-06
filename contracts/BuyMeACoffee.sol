// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

contract BuyMeACoffee {
    event NewMemo(
        address indexed from,
        uint256 timestamp,
        string name,
        string message
    );

    //Memo strcut
    struct Memo {
        address from;
        uint256 timestamp;
        string name;
        string message;
    }
    //List of all memos recived form friends.abi
    Memo[] memos;

    //Address of contract deployer
    address payable owner;

    //Deploy logic
    constructor() {
        owner = payable(msg.sender);
    }

    function buyCoffee(string memory _name, string memory _message)
        public
        payable
    {
        require(msg.value > 0, "cant buy coffee with 0 eth");


        //emit a log event when a new memo is created!
        memos.push(Memo(msg.sender, block.timestamp, _name, _message));
        emit NewMemo(msg.sender, block.timestamp, _name, _message);


    }


    function withdrawTips() public {
    require(owner.send(address(this).balance));        

    }

    function getMemos() public view returns(Memo[] memory){
        return memos;
    }
}
