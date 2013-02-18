class VehicleManager extends Module {
    static vehicles = List();

    static function getByID(id) {
        foreach(vehicle in vehicles) {
            if(vehicle.id == id) {
                return vehicle;
            }
        }
    }

    static function createVehicle(modelid, x, y, z, rx = 0.0, ry = 0.0, rz = 0.0, color1 = 0, color2 = 0, color3 = 0, color4 = 0, respawn_delay = 0) {
        local vehicleid = createVehicle(modelid, x, y, z, rx, ry, rz, color1, color2, color3, color4, respawn_delay);
        setVehicleRotation(vehicleid, rx, ry, rz);

        local vehicle = Vehicle(vehicleid);
        vehicles.push(vehicle);

        return vehicle;
    }

    static function removeVehicle(vehicle) {
        deleteVehicle(vehicle.id);
        vehicles.remove(vehicle);
    }

    </ command = "createvehicle" />
    static function commandCreateVehicle(name,) {
        
    }

    </ event = "scriptExit" />
    static function onScriptExit() {
        foreach(vehicle in VehicleManager.vehicles) {
            vehicle.remove();
        }
    }
}