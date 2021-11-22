pragma solidity ^0.4.19;

contract Command {

	struct			Command {
		uint		no_lot;
		uint 		amount;
	}


	mapping(address => Command[]) public commandsByCustomers;

	function createCommand(uint amountCommand) public returns(uint) {
		customer = msg.sender;
		Command[] commands = commandsByCustomers[customer];
		
		no_lotRand = random();
		
		commands.push(Command({
			no_lot: no_lotRand,
			amount: amountCommand,
		}));
		
		return no_lotRand;
	}
	
	
	function random() private view returns (uint) {
        	// sha3 and now have been deprecated
        	return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp)));
        	// convert hash to integer
        	// players is an array of entrants
    	}
    	
    	
    	function getCommandsOfCustomer() public view returns (Command[] memory) {
    		customer = msg.sender;
		Command[] commands = commandsByCustomers[customer];
		
		return commands;
	}
}
