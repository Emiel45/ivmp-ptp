class Player {
	id = 0;

	constructor(id) {
		this.id = id;
	}

	function sendMessage(string, color = 0xFFFFFFFF, allowTextFormatting = false) {
		playerSendMessage(id, string, color, allowTextFormatting);
	}
}