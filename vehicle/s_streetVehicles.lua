vehicleNormalIds = {445,496,422,401,575,518,589,507,562,585,419,521,462,533,565,526,463,492,545,400,410,551,500,
                    516,467,461,404,600,426,436,547,489,479,567,535,580,561,560,550,566,420,558,540,412,421,529,554}

vehicleSportIds = {602,429,402,541,415,480,587,411,603,506,555}

function spawnStreetVehicle()
    local xml_File = xmlLoadFile("xml/streetVehicleSpawns.xml", true)

    local spawns = xmlNodeGetChildren(xml_File)
    for k, child in pairs(spawns) do
        local vehicle = nil
        local attrs = xmlNodeGetAttributes(child);
        --spawn normal Cars
        if(attrs.type == "Sentinel") then
            vehicle = createVehicle(vehicleNormalIds[math.random(1, #vehicleNormalIds)], attrs.posX, attrs.posY, attrs.posZ, attrs.rotX, attrs.rotY, attrs.rotZ, "CIV-"..k)
        else
            vehicle = createVehicle(vehicleSportIds[math.random(1, #vehicleSportIds)], attrs.posX, attrs.posY, attrs.posZ, attrs.rotX, attrs.rotY, attrs.rotZ, "CIV-"..k)
        end
        setVehicleRespawnPosition(vehicle, attrs.posX, attrs.posY, attrs.posZ)
        setVehicleRespawnRotation(vehicle, attrs.rotX, attrs.rotY, attrs.rotZ)
        setElementData(vehicle, "ssEV.streetVehicle", true)
    end
end
addEventHandler("onResourceStart", resourceRoot, spawnStreetVehicle)


function vehicleExplode()
    if(getElementData(source, "ssEV.streetVehicle") == true) then
        setTimer(function(veh)
            respawnVehicle(veh)
            if(exports.common:contains(vehicleNormalIds, getElementModel(veh))) then
                setElementModel(veh, vehicleNormalIds[math.random(1, #vehicleNormalIds)])
            else
                setElementModel(veh, vehicleSportIds[math.random(1, #vehicleSportIds)])
            end
        end, 4000, 1, source)
    end
end
addEventHandler("onVehicleExplode", getRootElement(), vehicleExplode)