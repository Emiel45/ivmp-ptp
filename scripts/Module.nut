class Module {

    static function _newmember(idx, val, attributes, isstatic) {
        this.rawnewmember(idx, val, attributes, isstatic);

        if("event" in attributes) {
            addEvent(attributes["event"], val);
        }

        if("command" in attributes) {
        	CommandManager.addCommand(attributes["command"], val);
        }
    }

}