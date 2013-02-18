class PlayerManager extends Module {
	static players = List();

	static function getByID(id) {
        foreach(player in players) {
            if(player.id == id) {
                return player;
            }
        }
    }

	</ event = "playerJoin" />
	static function onPlayerJoin(playerid) {
		players.add(Player(playerid));
		return 1;
	}

	</ event = "playerDisconnect" />
	static function onPlayerDisconnect(playerid) {
		players.remove(this.getByID(playerid));
	}
}