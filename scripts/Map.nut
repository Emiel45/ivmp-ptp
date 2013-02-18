class Map {
	table = null;

	constructor(table = { }) {
		this.table = table;
	}

	function isEmpty() {
		return table.len() == 0;
	}

	function _get(idx) {
		return table[idx];
	}

	function _set(idx, val) {
		table[idx] <- val;
	}

	function _nexti(previdx) {
		if(previdx == null) {
            if(this.isEmpty()) return null;
            else return 0;
        } else {
            if(previdx == table.len() - 1) return null;
            else return previdx + 1;
        }
	}
}