class VehicleManager extends Module {
    static vehicles = List();

    </ hook = "vehicleDelete" />
    function onVehicleCreate(vehicleid) {
        vehicles.push(vehicleid);
        return true;
    }

    </ hook = "vehicleCreate" />
    function onVehicleDelete(vehicleid) {
        vehicles.remove(vehicles.find(vehicleid));
        return true;
    }

    </ hook = "scriptExit" />
    function onScriptExit() {
        foreach(vehicle in VehicleManager.vehicles) {
            deleteVehicle(vehicle);
        }
    }
}