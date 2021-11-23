App = {
	web3Provider: null,
	contracts: {},
	
	init: async function() {
	    	return await App.initWeb3();
	},


	initWeb3: async function() {
	
		// Modern dapp browsers...
		if (window.ethereum) {
			App.web3Provider = window.ethereum;
			try {
	    			// Request account access
	    			await window.ethereum.request({ method: "eth_requestAccounts" });;
	    		} catch (error) {
	    			// User denied account access...
	    			console.error("User denied account access")
    			}
		} else if (window.web3) {
			// Legacy dapp browsers...
			App.web3Provider = window.web3.currentProvider;
		} else {
			// If no injected web3 instance is detected, fall back to Ganache
			App.web3Provider = new Web3.providers.HttpProvider('http://localhost:7545');
		}
	
		web3 = new Web3(App.web3Provider);
		return App.initContract();
	},
	
	
	initContract: function() {
	
		$.getJSON('Command.json', function(data) {
			// Get the necessary contract artifact file and instantiate it with @truffle/contract
			var CommandArtifact = data;
			App.contracts.Command = TruffleContract(CommandArtifact);
			
			// Set the provider for our contract
			App.contracts.Command.setProvider(App.web3Provider);
			
			// Use our contract to retrieve and mark the adopted pets
			return App.resetFields();
		});	
   		return App.bindEvents();
	},


	bindEvents: function() {
		$(document).on('click', '#btnCommand', App.createCommand);
	},

	
	resetFields: function() {
		$("#formulaire").trigger("reset");
	},


	createCommand: function(event) {
		event.preventDefault();

		var commandInstance;
		
		amount = $("#amount").value;
		
		web3.eth.getAccounts(function(error, accounts) {
			if (error) {
				console.log(error);
			}
			
			//Default Account /!\ always the first
			var account = accounts[0];
			
			App.contracts.Command.deployed().then(function(instance) {
				commandInstance = instance;
				
				// Execute createCommand as a transaction by sending account
				return commandInstance.createCommand(amount, {from: account});
			}).then(function(result) {
				return App.resetFields();
			}).catch(function(err) {
				console.log(err.message);
			});
		});
	}

};

$(function() {
	$(window).load(function() {
		App.init();
	});
});
