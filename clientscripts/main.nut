local font = GUIFont("bankgothic");
local screen = guiGetScreenSize();

function isPlayerInVehicle()
{
    if(getPlayerVehicleId(getLocalPlayer()) != INVALID_VEHICLE_ID)
        return true;
    else
        return false;
}

local dists = array(10, 0);
local lastpos = null;
local speed = 0;
function calculateSpeed()
{
    if(isPlayerInVehicle()) {
        local vehicleid = getPlayerVehicleId(getLocalPlayer());
        local pos = getVehicleCoordinates(vehicleid);

        if(lastpos != null) {
            dists.push(getDistanceBetweenPoints3D(lastpos[0], lastpos[1], lastpos[2], pos[0], pos[1], pos[2]));
            dists.remove(0);

            speed = 0;
            foreach(dist in dists) {
                speed += dist;
            }
        }

        lastpos = pos;
    }
}
local speedtimer = timer(calculateSpeed, 100, -1);

function onFrameRender()
{
    if(isPlayerInVehicle()) {
        local vehicleid = getPlayerVehicleId(getLocalPlayer());
        
        /* Health Meter */
        local health = getVehicleHealth(vehicleid) * 0.001;
        local health_color = 0x000000AA;
        health_color = health_color | (0xFF * health).tointeger() << 16;
        health_color = health_color | (0xFF * (1 - health)).tointeger() << 24;

        if(health == 0) {
            guiDrawRectangle(0.0, screen[1] - 8.0, screen[0], 8.0, health_color, false);
        } else {
            guiDrawRectangle(0.0, screen[1] - 8.0, health * screen[0], 8.0, health_color, false);
        }
        font.drawText(16.0, 16.0, "Health: " + (health * 100) + "%", false);

        /* Speed Meter */
        font.drawText(265.0, 16.0, "Speed: " + speed * 3.6 + " km/h", false);
    }
}
addEvent("frameRender", onFrameRender);
