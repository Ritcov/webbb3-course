// SPDX-License-Identifier: MIT

pragma solidity ^0.8.21;

struct Voting {
    string option1;
    uint votes1;
    string option2;
    uint votes2;
    uint maxDate;
}

struct Vote{
    uint choice; //1 or 2
    uint date; 
}

contract Webbb3{
    address owner;
    uint public currentVoting = 1;
    Voting[] public votings;
    mapping(uint => mapping(address => Vote)) public votes;
    // 1 => 0x1 => 1        // To check someone's vote, use votes[votingIndex][0x...1]
    //      0x2 => 1        
    // 2 => 0x1 => 2


    constructor(){
        owner = msg.sender; //Contract creator wallet address
    }
    function getCurrentVoting() public view returns (Voting memory){
        return votings[currentVoting - 1];
     }

    function addVoting(string memory option1, string memory option2, uint timeToVote) public { 
        require(msg.sender == owner, "You absolutely CANNOT do that");
                                     

        if(votings.length != 0 ) currentVoting++;
        
        Voting memory newVoting;
        newVoting.option1 = option1;
        newVoting.option2 = option2;
        newVoting.maxDate = timeToVote + block.timestamp;
        votings.push(newVoting);
    }

    function addVote(uint choice) public {
        require(choice == 1 || choice == 2, "1 or 2 ONLY");
        require(getCurrentVoting().maxDate > block.timestamp, "BigWall has NOT been formed yet. Wait."); 
        require(votes[currentVoting - 1][msg.sender].date == 0, "Just one vote per wallet, champ");

        votes[currentVoting - 1][msg.sender].choice = choice;
        votes[currentVoting - 1][msg.sender].date = block.timestamp;
        
        if(choice == 1)
            votings[currentVoting - 1].votes1++;
        else   
            votings[currentVoting - 1].votes2++;

    }
}