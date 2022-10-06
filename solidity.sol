//SPDX-License-Identifier: GPL-3.0
pragma solidity >0.4.0 < 0.9.0;

/*declare license and then solidity version */
//having less function or less computation will cost less gas

contract solidity_rough{

    //datatype for storing the address of owner who compiler and deploy this contract
    address owner;



    //simple string in local scope
    string message = "String massage";

    //simple string in public scope
    //state variable
    string public message_public = "String massage";

    //making constructor
    constructor(){
        //getting address of owner
        owner = msg.sender;
    }


    //function which is public with no return value
    //while in passing variable you need to defince memory or path of that incoming variable
    function setMessageVal(string memory input) public {
        message_public = input;
    }

    //function which is public with  return value
    //use returns in returning values and return inside the fucntion
    //view for showing showing result and not changing anything in funciton
    function GetMessageVal() public view returns(string memory) {
        return message;
    }

    //Variables
    //different type of variables cost different gas while transactions
    //like other languages local - global - state ( permanetly stored value in contract and declare in starting of contract  )


    //in this case we have to use pure keyword and it will cost no gas in transaction
    function GetMessageValLocal(string memory input) public pure {
        string memory message1 = "rough";
        message1 = input;
    }

    //global variables which give info of chain
    //uint like int 
    function GetMessageValGlobal() public view returns (uint){
        return block.number;
    }

    //function for checking the owner kind of ownership   
    function checkowner() public view returns(uint){
        if(msg.sender==owner){
            return 1;
        }else{
            return 0;
        }
    }

    //demo fucntion to do task after checking ownership
    //this will throw error if you try to access this outside of ownership
    function add(uint a,uint b) public view checkownership(a,b){
        uint ans = a+b;
    }

    //modifiers to check ownership
    modifier checkownership(uint a,uint b){
        if(msg.sender == owner){
         //to do operations after this check
            _;
        }
        else{
            require (msg.sender==owner,"only owner have rights!");
        }
    }

    //structures
    //same as c++
    struct rough{
        uint age;
        string name;
    }
    //declare and assigning values as we do in python
    rough r1 = rough(19,'hamza');

    //function for getting any value
    function getstructval() public view returns (rough memory){
        return r1;
    }

    //diff of view (read storage state) and pure (not read storage state)
    //both don't pay gas fee
    function viewfun() public pure returns (uint){
        uint age=0;
        //this will give us error as r1.age is state variable
        //age=r1.age;
        return age;
    }

    //error handling
    //if error occur then previous state is hold before that transaction
    uint no;

    
    
    function setNo(uint a) public {
        if (a > 0)
            no=a;
        else{
            //using assert(bool condition) more gas
            //use for internal errors and unexpected cases
            assert(false); 
            //using require(bool condition) less gas then assert
            //we can pass msg in this
            //use for general errors
            require(false,"number can not be zero");
            //using revert()
            revert();
        }
    } 

    function getno() public view returns (uint){
        return no;
    }


    //mapping 
    //just like dict in python

    //mapping (matrix) of user giving value
    mapping(address => uint) rate;

    //function for getting values 
    //payable when you want to give some gas by user
    function setvalues() public payable{
        uint cal = rate[msg.sender] + msg.value;
        //putting value on specific address
        rate[msg.sender] = cal;
    }

    //getting paid value by giving address
    function getvalue(address add) public view returns (uint){
        return rate[add];
    }

    //timers
    //block timestamp is the time when our blockchain is created
    uint start_time=block.timestamp;
    uint end_time;

    //get time in seconds then do whatever you want
    function endtime(uint time) public {
        end_time = time;
    }

    //transfer something in account
    function withdraw(address add) public {
        if(rate[add] > 0){
            add.transfer(rate[add]);
        }
    }

}
