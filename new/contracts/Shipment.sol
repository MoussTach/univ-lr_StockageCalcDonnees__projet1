pragma solidity ^0.4.19;

import "./Command.sol";

contract Shipment {
	struct 		Shipment {
		uint		no_ship;
		address	worker;
		string		depart_place;
		string		arrived_place;
		uint256	date_expedition;
	}
	
	mapping(Command => Shipment[]) public shipmentsByCommands;

	
	function searchCommand(Command[] commands, uint no_lot) private view returns (bool, Command) {
		Command foundCommand;
		
		for (command command : Commands) {
			if (keccak256(bytes(command.no_lot)) == keccak256(bytes(no_lot))) {
				return (true, command);
			}
		}
		return (false, foundCommand);
	}
	
	function getShipmentsByCommands(address customer, uint no_lot, string depart_Str, string arrived_Str, string date_Str) public returns (uint memory) {
		workerAdr = msg.send;
		
		Command[] commands = commandsByCustomers[customer];
		
		Command foundCommand;
		var (isPresent, foundCommand) = searchCommand(commands, no_lot);
		
		if (!isPresent) {
			revert('Error, command not found');
		}
		
		no_ShipRand = random();
		
		Shipment[] shipments = shipmentsByCommands[foundCommand];
		
		shipment.push(Shipment({
			no_ship : no_ShipRand,
			worker : workerAdr,
			depart_place : depart_Str,
			arrived_place : arrived_Str,
			date_expedition : date_Str
		}));
		
		return noShipRand;
	}
	
	
	function random() private view returns (uint) {
        	// sha3 and now have been deprecated
        	return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp)));
        	// convert hash to integer
        	// players is an array of entrants
    	}
    	
    	
    	function getShipmentsByCommands(address customer, uint no_lot) public view returns (Shipment[] memory) {
    		customer = msg.sender;
		Command[] commands = commandsByCustomers[customer];
		
		Command foundCommand;
		var (isPresent, foundCommand) = searchCommand(commands, no_lot);
		
		if (!isPresent) {
			revert('Error, command not found');
		}
		
		Shipment[] shipments = shipmentsByCommands[foundCommand];
		return shipments;
	}    	
}
