pragma solidity ^0.5.2;

contract Command {

	struct			CommandData {
		uint		no_lot;
		uint 		amount;
	}

	struct 		Shipment {
		uint		no_ship;
		address	worker;
		string		depart_place;
		string		arrived_place;
		uint256	date_expedition;
	}

	mapping(address => CommandData[]) public commandsByCustomers;
	mapping(uint => Shipment[]) public shipmentsByCommands;


//Command
	function createCommand(uint amountCommand) public returns(uint) {
		address customer = msg.sender;
		
		CommandData[] storage commands = commandsByCustomers[customer];
		
		uint no_lotRand = random();
		
		commands.push(CommandData(no_lotRand, amountCommand));
		return no_lotRand;
	}
	
	function searchCommand(uint no_lot) private view returns (bool, CommandData memory) {
		address customer = msg.sender;
		CommandData memory foundCommand;
		
		CommandData[] memory commands = commandsByCustomers[customer];
		
		for (uint i = 0; i < commands.length ; i++) {
			CommandData memory current = commands[i];
			if (current.no_lot == no_lot) {
				return (true, current);
			}
		}
		return (false, foundCommand);
	}
		
	
//Shipment
	function createShipment(address customer, uint no_lot, string memory depart_Str, string memory arrived_Str, uint256 date) public returns (uint) {
		address workerAdr = msg.sender;
		
		(bool isPresent, CommandData memory foundCommand) = searchCommand(no_lot);
		
		if (!isPresent) {
			revert('Error, command not found');
		}
		
		uint no_ShipRand = random();
		
		Shipment[] storage shipments = shipmentsByCommands[foundCommand.no_lot];
		
		shipments.push(Shipment(
			no_ShipRand, 
			workerAdr, 
			depart_Str, 
			arrived_Str, 
			date
		));
		
		return no_ShipRand;
	}

	function sizeShipmentsByCommands(uint no_lot)  public view returns (uint) {
		(bool isPresent, CommandData memory foundCommand) = searchCommand(no_lot);
		
		if (!isPresent) {
			revert('Error, command not found');
		}
		
		Shipment[] memory shipments = shipmentsByCommands[foundCommand.no_lot];
		return shipments.length;
	}

    	function getShipmentsByCommands_byId(uint no_lot, uint id) public view returns 
    		(uint no_ship, address worker, string memory depart_place, string memory arrived_place, uint256 date_expedition) {
		(bool isPresent, CommandData memory foundCommand) = searchCommand(no_lot);
		
		if (!isPresent) {
			revert('Error, command not found');
		}
		
		Shipment[] memory shipments = shipmentsByCommands[foundCommand.no_lot];
		return (shipments[id].no_ship, shipments[id].worker, shipments[id].depart_place, shipments[id].arrived_place, shipments[id].date_expedition);
	}   

//Other
	function random() internal view returns (uint) {
    		return uint(blockhash(block.number - 1));
	}
}
