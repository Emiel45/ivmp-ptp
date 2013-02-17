class Module {

    static function _newmember(idx, val, attributes, isstatic) {
        this.rawnewmember(idx, val, attributes, isstatic);

        if("hook" in attributes) {
            addEvent(attributes["hook"], val);
        }
    }

}