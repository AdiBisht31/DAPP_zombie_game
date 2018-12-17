pragma solidity ^0.4.25;
import "./ownable.sol";

contract ZombieFactory is ownable {

    event NewZombie(uint zombieId, string name, uint dna);

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;
    uint cooldownTime= 1 days;


    struct Zombie {
        string name;
        uint dna;
        uint32 level;// 
        uint32 readyTime; // COOLDOWN TIME after it feeds or attack
    }

    Zombie[] public zombies;

    // Let's make our game multi-player by giving the zombies in our database an owner.

     mapping (uint => address) public zombieToOwner; //one that keeps track of the address that owns a zombie,
     mapping (address => uint) ownerZombieCount;  // another that keeps track of how many zombies an owner has.

    function _createZombie(string _name, uint _dna) private {
                
        uint id = zombies.push(Zombie(_name, _dna, 1, uint32(now + cooldownTime))) - 1;
        ZombieToOwner[id]=msg.sender;
        ownerZombieCount[msg.sender]++;
        emit NewZombie(id, _name, _dna);
    } 

    function _generateRandomDna(string _str) private view returns (uint) {
        uint rand = uint(keccak256(abi.encodePacked(_str)));
        return rand % dnaModulus;
    }

    function createRandomZombie(string _name) public {
        require(ownerZombieCount[msg.sender]==0);// Create zombie once
        uint randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }

}
contract ZombieFeeding is ZombieFactory
{


}
