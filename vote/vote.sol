pragma solidity 0.4.23;

contract Vote{
    // strucutre
    struct candidator{
        string name;
        uint up_vote;

    }

    // variable
    bool is_vote;
    address owner;
    candidator[] public candidators;

    // mapping
    mapping(address => bool) voted;

    // event
    event EventAddCandidator(string name);
    event EventUpVote(string candidator, uint count);
    event EventFinishVote(bool is_vote);
    event EventVoting(address owner);

    // modifier
    modifier OnlyOwner {
        require(msg.sender == owner);
        _;
    }

    // constructor
    constructor() public{
        owner = msg.sender;
        is_vote = true;

        emit EventVoting(owner);
    }

    // candidator
    function AddCandidator(string name) public OnlyOwner{
        // if ? 
        require(is_vote);
        require(candidators.length < 5);
        candidators.push(candidator(name, 0));
        // emit event
        emit EventAddCandidator(name);
    }


    // Up vote 
    function UpVote(uint index) public {
        require(is_vote);
        require(index < candidators.length);
        require(!voted[msg.sender]);

        candidators[index].up_vote++;

        voted[msg.sender] = true;

        emit EventUpVote(candidators[index].name, candidators[index].up_vote);
    }

    // finish vote
    function FinishVote() public OnlyOwner{
        require(is_vote);
        is_vote = false;

        emit EventFinishVote(is_vote);

    }

}
