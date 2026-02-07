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

struct Participant {
    uint number;
    string name;
    uint age;
    string foto;        //Challange 1. [EASY] foto participant image
    string ig;
    address wallet;
    string descripion;
}

struct ParticipantEliminated {
    uint order;
    string name;

}



contract Webbb3{
    address owner;
    uint public currentVoting = 1;
    Voting[] public votings;
    Participant[] public participants;
    ParticipantEliminated[] public participantsEliminated;
    

    mapping(uint => mapping(address => Vote)) public votes;
    // 1 => 0x1 => 1        // To check someone's vote, use votes[votingIndex][0x...1]
    //      0x2 => 1        
    // 2 => 0x1 => 2
    mapping(string => address) participantsMapping;
    mapping(string => address) participantsAlive;
    
    


    constructor(){
        owner = msg.sender; //Contract creator wallet address
    }
    function getCurrentVoting() public view returns (Voting memory){
        return votings[currentVoting - 1];
     }
    // challenge 3: [NORMAL] participant registration
    function addParticipant( uint number,  //the number of the participant (in alphabet order)
                             string memory name,
                             uint age,
                             string memory foto, //URL participan foto
                             string memory ig,  //how they call him
                             address wallet,    //they sould have a wallet
                             string memory description  //What they have to say in few words.
                            
                             ) public {
        require(msg.sender == owner, "Why you dont make YOUR ONW bbshow?");

        Participant memory newParticipant;
        newParticipant.number = number;
        newParticipant.name = name;
        newParticipant.foto = foto;
        newParticipant.age = age;
        newParticipant.ig = ig;
        newParticipant.wallet= wallet;
        newParticipant.descripion = description;

        if(participants.length < 16)
            participants.push(newParticipant);
            participantsMapping[name] = wallet;
            participantsAlive[name] = wallet;
    }
 

    function addVoting(string memory option1, string memory option2, uint timeToVote) public { 
        require(msg.sender == owner, "You absolutely CANNOT do that");
        

        //if(votings.length != 0 ) currentVoting++;
        
        Voting memory newVoting;
        newVoting.option1 = option1;
        newVoting.option2 = option2;
        newVoting.maxDate = timeToVote + block.timestamp;
        address participantAddress1 = participantsMapping[option1];
        address participantAddress2 = participantsMapping[option2];
        require(participantAddress1 != address(0), "I don't regonize the FIRST one.");
        require(participantAddress2 != address(0), "I don't regonize the SECOND one.");
        require(participantsAlive[option1] != address(0) &&
                participantsAlive[option2] != address(0),
                "Only avalible players, please."); // challenge 4: Do not allow the registration of eliminated participants.
        votings.push(newVoting);
    }

    
    function addVote(uint choice) public {
        require(choice == 1 || choice == 2, "1 or 2 ONLY");
        require(getCurrentVoting().maxDate > block.timestamp, "BigWall has NOT been formed yet. Wait."); 
        //require(votes[currentVoting - 1][msg.sender].date == 0, "Just one vote per wallet, champ"); challenge 5: more vote for wallet address

        votes[currentVoting - 1][msg.sender].choice = choice;
        votes[currentVoting - 1][msg.sender].date = block.timestamp;
        
        if(choice == 1)
            votings[currentVoting - 1].votes1++;
        else   
            votings[currentVoting - 1].votes2++;

    }

    function defineVoting(uint votingNumber) public {
        require(msg.sender == owner, "Your VOTE is your way to define something. Vote!");
        require(votingNumber == currentVoting, "Even you can not do that. You know.");
        require(getCurrentVoting().maxDate < block.timestamp, "It's not over yet. Slowdawn friend!");

        string memory loser;
        
        if(votings[currentVoting - 1].votes1 > votings[currentVoting - 1].votes2)
            loser = votings[currentVoting - 1].option1;
        else
            loser = votings[currentVoting - 1].option2;
        ParticipantEliminated memory newLoser;
        newLoser.name = loser;
        newLoser.order = currentVoting;
        participantsEliminated.push(newLoser);
        delete participantsAlive[loser];
        currentVoting++;

    }
    // challenge 2 [EASY] return de winner voting.
    function getVotingResult (uint votingNumber) public view returns (string memory){
        require(votingNumber < currentVoting, "We don't predctive the future here boy");
        return participantsEliminated[votingNumber - 1].name;

    }


}
