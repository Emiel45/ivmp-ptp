class List {
    elements = null;

    constructor(...) {
        this.elements = vargv;
    }

    function size() {
        return elements.len();
    }

    function isEmpty() {
        return this.size() == 0;
    }

    function add(val) {
        elements.push(val);
    }

    function addAll(parm) {
        if(parm instanceof List) {
            elements.extend(parm.elements);
        }

        if(parm instanceof Array) {
            elements.extend(parm);
        }
    }

    function remove(val) {
        local index = this.indexOf(val);

        if(index != -1) {
            elements.remove(index);
        }
    }

    function contains(val) {
        return elements.find(val) != null;
    }

    function indexOf(val) {
        local index = elements.find(val);
        return index == null ? -1 : index;
    }

    function insert(idx, val) {
        elements.insert(idx, val);
    }

    function clear() {
        elements.clear();
    }

    function _get(idx) {
        return elements[idx];
    }

    function _nexti(previdx) {
        if(previdx == null) {
            if(this.isEmpty()) return null;
            else return 0;
        } else {
            if(previdx == elements.len() - 1) return null;
            else return previdx + 1;
        }
    }

    function _tostring() {
        local str = "";

        str += "[";
        foreach(idx, val in elements) {
            if(idx == 0) str += val;
            else str += ", " + val;
        }
        str += " ]";

        return str;
    }
}