class CommandManager extends Module {
	static commands = { };

	static function addCommand(name, func) {
		commands[name] <- func;
	}

	</ event = "playerCommand" />
	static function onPlayerCommand(playerid, command) {
		local player = PlayerManager.getByID(playerid);

		local textpos = command.find(" ");
		local text = "";

		if(textpos != null) {
			text = command.slice(textpos + 1);
			command = command.slice(0, textpos);
		}

		local args = text.split(" ");
		args.insert(0, null);
		local func = commands[command];

		if(func != null) {
			func.acall(args);
		} else {
			player.sendMessage("Invalid command.");
		}
	}
}