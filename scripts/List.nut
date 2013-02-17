class List {
    list = [ ];

    constructor() { }

    function size() {
        return list.len();
    }

    function isEmpty() {
        return this.size() == 0;
    }

    function add(val) {
        list.push(val);
    }

    function addAll(parm) {
        if(parm instanceof List) {
            list.extend(parm.list);
        }

        if(parm instanceof Array) {
            list.extend(parm);
        }
    }

    function insert(idx, val) {
        list.insert(idx, val);
    }

    function clear() {
        list.clear();
    }

    function _get(idx) {
        return list[idx];
    }

    function _nexti(idx) {

    }

    function _tostring() {
        local str = "";

        str += "[";
        foreach(idx, val in list) {
            if(idx == 0) str += val;
            else str += ", " + val;
        }
        str += " ]";

        return str;
    }
}