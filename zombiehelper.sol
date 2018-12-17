pragma solidity ^0.4.25;

import "./zombiefeeding.sol";

contract ZombieHelper is ZombieFeeding {

  modifier aboveLevel(uint _level, uint _zombieId) {
    require(zombies[_zombieId].level >= _level);
    _;
  }
  // check valid level using modifier 
   // If a zombie is above level 1 then they can change their name
  function changeName(uint _zombieId, string _newName) external aboveLevel(2, _zombieId) { 
    require(msg.sender == zombieToOwner[_zombieId]);
    zombies[_zombieId].name = _newName;
  }
   // If a zombie is aboe 19th level then they can change their dna also
  function changeDna(uint _zombieId, uint _newDna) external aboveLevel(20, _zombieId) {
    require(msg.sender == zombieToOwner[_zombieId]);
    zombies[_zombieId].dna = _newDna;
  }

  //In our getZombiesByOwner function, we want to return a uint[] array with 
  // all the zombies a particular user owns.
   function getZombiesByOwner(address _owner) external view returns(uint[]) {
    uint[] memory result = new uint[](ownerZombieCount[_owner]);
    // Start here
     uint counter = 0;
    for (uint i = 0; i < zombies.length; i++) {
      if (zombieToOwner[i] == _owner) { // If a particular zombie belongs to given owner use index
        result[counter] = i;
        counter++;
      }
    }
    return result;
    
  }

}
