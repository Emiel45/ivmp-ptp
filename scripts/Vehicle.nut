class Vehicle {
	id = 0;

	constructor(modelid, x, y, z, rx = 0.0, ry = 0.0, rz = 0.0, color1 = 0, color2 = 0, color3 = 0, color4 = 0, respawn_delay = 0) {
		this.id = createVehicle(modelid, x, y, z, rx, ry, rz, color1, color2, color3, color4, respawn_delay);
		setVehicleRotation(id, rx, ry, rz);
	}

	constructor(id) {
		this.id = id;
	}

	function remove() {
		deleteVehicle(id);
	}
}