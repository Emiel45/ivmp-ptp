local vehicles = [ ];

function indexof(array, element) {
    foreach(idx, value in array) {
        if(value == element) return idx;
    }

    return -1;
}

function gen_random(max) {
    local last=42;
    local IM = 139968;
    local IA = 3877;
    local IC = 29573;
    for(;;) {  //loops forever
      yield (max * (last = (last * IA + IC) % IM) / IM);
    }
 }
 
 local rand = gen_random(20);

function onVehicleCreate(vehicleid)
{
    log("onVehicleCreate(" + vehicleid + ")");
    vehicles.push(vehicleid);
    return true;
}
addEvent("vehicleCreate", onVehicleCreate);

function onVehicleDelete(vehicleid)
{
    log("onVehicleDelete(" + vehicleid + ")");
    vehicles.remove(indexof(vehicles, vehicleid));
    return true;
}
addEvent("vehicleDelete", onVehicleDelete);

function onPlayerConnect(playerid, name, ip, serial, hasModdedGameFile)
{
    if(hasModdedGameFile) {
        log("Player has modded game files!");
        return 0;
    }

    // TODO: check for ip/serial ban

    log("Player Connected");

    return 1;
}
addEvent("playerConnect", onPlayerConnect);

function onPlayerJoin(playerid)
{
    setPlayerSpawnLocation(playerid, 86.1238, 1189.73, 14.7606, 0.0);
    sendMessageToAll(getPlayerName(playerid) + " (" + playerid + ") has joined the server.");
    return 1;
}
addEvent("playerJoin", onPlayerJoin);

function onSpawn(playerid)
{
    setPlayerModel(playerid, resume rand);
}
addEvent("playerSpawn", onSpawn);

local positions = { };

function onPlayerCommand(playerid, command)
{
    local cmd = split(command.slice(1), " ");
    cmd[0] = cmd[0].tolower();

    switch(cmd[0]) {
        case "cv":
            local pos = positions[cmd[1]];
            local modelid = cmd[2].tointeger();

            local vehicleid = INVALID_VEHICLE_ID;

            if(cmd.len() == 7) {
                local c1 = cmd[3].tointeger();
                local c2 = cmd[4].tointeger();
                local c3 = cmd[5].tointeger();
                local c4 = cmd[6].tointeger();

                vehicleid = createVehicle(modelid, pos[0], pos[1], pos[2], 0.0, 0.0, pos[3], c1, c2, c3, c4);
            } else {
                vehicleid = createVehicle(modelid, pos[0], pos[1], pos[2], 0.0, 0.0, pos[3]);
            }


            sendPlayerMessage(playerid, "Created a \"" + getVehicleName(modelid) +  "\" at " + pos[0] + ", " + pos[1] + ", " + pos[2]);
            break;

        case "dv":
            deleteVehicle(getPlayerVehicleId(playerid));
            break;

        case "sv":
            log("saving vehicles...");
            local db = xml("db.xml");

            if(!db.nodeName()) db.nodeNew(false, "root");
            db.nodeRoot();
            if(db.nodeFind("vehicles")) {
                db.nodeClear();
            } else {
                db.nodeNew(false, "vehicles");
            }

            db.nodeRoot();
            db.nodeFind("vehicles");

            for(local i = 0; i < vehicles.len(); i++) {
                db.nodeNew(false, "vehicle");

            }
            db.nodeFirstChild();

            foreach(idx, vehicleid in vehicles) {
                log("saving " + vehicleid);

                local model = getVehicleModel(vehicleid);
                
                local pos = getVehicleCoordinates(vehicleid);
                local x = pos[0];
                local y = pos[1];
                local z = pos[2];

                local rot = getVehicleRotation(vehicleid);
                local rx = rot[0];
                local ry = rot[1];
                local rz = rot[2];

                local color = getVehicleColor(vehicleid);
                local c1 = color[0];
                local c2 = color[0];
                local c3 = color[0];
                local c4 = color[0];
                
                db.nodeSetAttribute("model", model.tostring());

                db.nodeSetAttribute("x", x.tostring());
                db.nodeSetAttribute("y", y.tostring());
                db.nodeSetAttribute("z", z.tostring());

                db.nodeSetAttribute("rx", rx.tostring());
                db.nodeSetAttribute("ry", ry.tostring());
                db.nodeSetAttribute("rz", rz.tostring());

                db.nodeSetAttribute("c1", c1.tostring());
                db.nodeSetAttribute("c2", c2.tostring());
                db.nodeSetAttribute("c3", c3.tostring());
                db.nodeSetAttribute("c4", c4.tostring());

                db.nodeNext();
            }

            db.save();

            if(db.lastError()) {
                print(db.lastError());
            }

            sendPlayerMessage(playerid, "Saved " + vehicles.len() + " vehicles!");
            break;

        case "sp":
            local posname = cmd[1];
            local playerpos = getPlayerCoordinates(playerid);
            local playerrot = getPlayerHeading(playerid);

            positions[posname] <- [playerpos[0], playerpos[1], playerpos[2], playerrot];
            break;

        case "lp":
            local posname = cmd[1];
            local pos = positions[posname];

            setPlayerCoordinates(playerid, pos[0], pos[1], pos[2]);
            setPlayerHeading(playerid, pos[3]);
            break;
            
        case "pos":
            local playerpos = getPlayerCoordinates(playerid);
            local playerrot = getPlayerHeading(playerid);
            sendPlayerMessage(playerid, "x: " + playerpos[0] + " y:" + playerpos[1] + " z: " + playerpos[2] + " r: " + playerrot);
            break;

        case "ccd":
            controlCarDoors(getPlayerVehicleId(playerid), cmd[1].tointeger(), true, cmd[2].tofloat());
            break;

        case "vc":
            setVehicleComponent(getPlayerVehicleId(playerid), cmd[1].tointeger(), true);
            break;

        case "wep":
            givePlayerWeapon(playerid, cmd[1].tointeger(), cmd[2].tointeger());
            break;

        case "h":
            setPlayerHealth(playerid, cmd[1].tointeger());
            break;

        case "a":
            setPlayerArmour(playerid, cmd[1].tointeger());
            break;
            
    }
}
addEvent("playerCommand", onPlayerCommand);

function onVehicleEntryRequest( playerid, vehicleid, seatid )
{
    log("onVehicleEntryRequest(" + playerid + ", " + vehicleid + ", " + seatid + ")");
    return 1;
}
addEvent("vehicleEntryRequest", onVehicleEntryRequest);

function onVehicleEntryComplete(playerid, vehicleid, seatid)
{
    log("onVehicleEntryComplete(" + playerid + ", " + vehicleid + ", " + seatid + ")");
    if(seatid == 0)
    {
        setVehicleEngineState(vehicleid, true);
    }

    return 1;
}
addEvent("vehicleEntryComplete", onVehicleEntryComplete);

function onVehicleExitComplete(playerid, vehicleid, seatid)
{
    log("onVehicleExitComplete(" + playerid + ", " + vehicleid + ", " + seatid + ")");
    if(seatid == 0)
    {
        setVehicleEngineState(vehicleid, false);
    }

    return 1;
}
addEvent("vehicleExitComplete", onVehicleExitComplete);