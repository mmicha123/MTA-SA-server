local vSpawns = 	{	
    {1399.3, -18.6, 1000.7, 0, 0, 113.996},
	{1399.5996, -13.59961, 1000.7, 359.967, 359.995, 121.992},
	{1400.1, -8.8, 1000.7, 359.934, 359.989, 133.996},
	{1397.40039, -5.09961, 1000.70001, 359.934, 359.989, 155.996},
    {1390,-18.3, 1000.7, 359.934, 359.989, 181.994},
    {2472,-1785, 14, 0, 0, 0}
}

function createVehicleGarage()
    local vehicleGarageMarkerPersonalO = createMarker(2512, -1777, 14.6, 'arrow', 1.5, 255, 255, 0, 155)
    local vehicleGarageMarkerVehicleO = createMarker(2510, -1785.6, 12, 'cylinder', 3.0, 119, 109, 255, 150)
    
    local vehicleGarageBlip = createBlipAttachedTo(vehicleGarageMarkerPersonalO, 40)
    setBlipVisibleDistance(vehicleGarageBlip, 250)

    local function vehicleGarageMarkerHit(hitElement)
        local thePlayer = nil
        
        if(source == vehicleGarageMarkerPersonalO) then
            if(getElementType(hitElement) ~= "player") then 
                return
            end

            if(isPedInVehicle(hitElement)) then
                exports.message:createMessage(hitElement, "Please enter on foot", 3, 3000)
                return
            end

            thePlayer = hitElement
            setElementPosition(thePlayer, 1401, -26, 1001, false)

        elseif(source == vehicleGarageMarkerVehicleO) then
            if(getElementType(hitElement) ~= "vehicle") then
                return
            end

            thePlayer = getVehicleOccupant(hitElement, 0)

            local vehicleOwner = getElementData(hitElement, "ssE.owner")
            if(getPlayerName(thePlayer) == vehicleOwner) then
                for seat, occupant in pairs(getVehicleOccupants(hitElement)) do
                    removePedFromVehicle(occupant)
                end
                setElementData(hitElement, "ssE.owner", false)
                destroyElement(hitElement)
            end

            setElementPosition(thePlayer, 1401, -26, 1001, false)
        else 
            return 
        end


        local acc = getPlayerAccount(thePlayer)
        if(not acc or isGuestAccount(acc)) then
            return
        end

        local dim = getAccountID(acc) + 1
        setElementDimension(thePlayer, dim)
        setElementInterior(thePlayer, 1)

        createVehicleGarageInterior(thePlayer, dim)
    end
    addEventHandler("onMarkerHit", vehicleGarageMarkerPersonalO, vehicleGarageMarkerHit)
    addEventHandler("onMarkerHit", vehicleGarageMarkerVehicleO, vehicleGarageMarkerHit)

end
addEventHandler("onResourceStart", resourceRoot, createVehicleGarage)


function createVehicleGarageInterior(thePlayer, dim)
    local maxVehicles = tonumber(get("vPP"))
    
    if(not exports.account:isPromium(thePlayer)) then
        maxVehicles = maxVehicles - 2
    end
    local vehicleGarageMarkerVehicleI = createMarker(1391.5, -31, 999, 'cylinder', 3.0, 119, 109, 255, 150)
	setElementInterior(vehicleGarageMarkerVehicleI, 1)
    setElementDimension(vehicleGarageMarkerVehicleI, dim)
    
	local vehicleGarageMarkerPersonalI = createMarker(1404, -27, 1002, 'arrow', 1.5, 255, 255, 0, 155)
	setElementInterior(vehicleGarageMarkerPersonalI, 1)
    setElementDimension(vehicleGarageMarkerPersonalI, dim)
    
    local createdVehicles = {}
    local savedVehicles = getVehicle(thePlayer)


    for i, data in pairs(savedVehicles) do
        if(i > maxVehicles) then break end

        createdVehicles[i] = vehicleCreate(thePlayer, data, i)

        setElementInterior(createdVehicles[i], 1)
        setElementDimension(createdVehicles[i], dim)

        setElementData(createdVehicles[i], "ssE.ID", data.id_owner)
        setElementData(createdVehicles[i], "ssE.ID_Vehicle", data.id_vehicle)

    end
        


    local garageObjects = {}

	garageObjects[1] = createObject(11391, 1387.69995, -24, 1001, 0, 0, 0)
	garageObjects[2] = createObject(11392, 1407, -25.4, 1000, 0, 0, 349.999)
	garageObjects[3] = createObject(11387, 1405.0996, -31.7998, 1003.3, 0, 0, 0)
	garageObjects[4] = createObject(11389, 1395.7, -15.8, 1003.1, 0, 0, 0)
	garageObjects[5] = createObject(11390, 1395.6, -15.7, 1004.4, 0, 0, 0)
	garageObjects[6] = createObject(11388, 1395.6, -16.9, 1006.7, 0, 0, 0)
	garageObjects[7] = createObject(11392, 1398.3, -4.9, 1000, 0, 0, 344)
	garageObjects[8] = createObject(7891, 1404.8, -3.7, 1002.2, 0, 0, 0)
	garageObjects[9] = createObject(7891, 1404.8, -12.3, 1002.2, 0, 0, 0)
	garageObjects[10] = createObject(7891, 1391.4, -32.1, 1002.2, 0, 0, 270)
	garageObjects[11] = createObject(16378, 1402, -24.2998, 1000.7, 0, 0, 0)
	garageObjects[12] = createObject(2008, 1400, -28.9, 999.90002, 0, 0, 0)
	garageObjects[13] = createObject(2001, 1397.7, 999.90002, 1001, 0, 0, 0)


	for _, gO in pairs(garageObjects) do
		setElementDimension(gO, dim)
		setElementInterior(gO, 1)
		setElementCollisionsEnabled(gO, true)
    end
    
    

    local function vehicleGarageMarkerHitI(hitElement, matchingDimension)
        if(not matchingDimension) then return end

        if(source == vehicleGarageMarkerVehicleI) then
            if(getElementType(hitElement) ~= "vehicle") then
                return
            end

            if(getElementData(hitElement, "ssE.ID") ~= (dim-1)) then
                return
            end

            local thePlayer = getVehicleOccupant(hitElement, 0)
            
            local v, o = vehicleDeployed(thePlayer)
            if(v and o) then
                exports.message:createMessage(hitElement, "You can't have two Personal Cars at the same time out", 3, 3000)
                return
            elseif(v and not o) then
                setElementData(v, "ssE.owner", false)
                destroyElement(v)
            end

            fadeCamera(thePlayer, false, 1.0)
            removePedFromVehicle(thePlayer)
            setElementPosition(hitElement, 2515, -1783, 15.5, true)
            setElementRotation(hitElement, 0, 0, 270)
            setElementData(hitElement, "ssE.owner", getPlayerName(thePlayer))
            local vehicleID = getElementData(hitElement, "ssE.ID_Vehicle")
            setElementData(thePlayer, "ssE.vehicleMain", vehicleID)

            exports.account:savePlayerVehicleData(thePlayer, vehicleID)

            setElementDimension(hitElement, 0)
            setElementInterior(hitElement, 0)
            
            setTimer(function()
                setElementDimension(thePlayer, 0)
                setElementInterior(thePlayer, 0)

                setTimer(function()
                    fadeCamera(thePlayer, true, 0.5)
                    warpPedIntoVehicle(thePlayer, hitElement, 0)
                end, 500, 1)
            end, 1000, 1)

        elseif(source == vehicleGarageMarkerPersonalI) then
            if(getElementType(hitElement) ~= "player") then
                exports.message:createMessage(hitElement, "Please enter on foot", 3, 3000) 
                return
            end

            if(isPedInVehicle(hitElement)) then
                exports.message:createMessage(hitElement, "Please enter on foot", 3, 3000)
                return
            end

            setElementPosition(hitElement, 2512, -1778, 13.5, false)
		    setElementDimension(hitElement, 0)
	        setElementInterior(hitElement, 0)
        else
            return
        end

        if(getElementDimension(vehicleGarageMarkerVehicleI) == dim) then destroyElement(vehicleGarageMarkerVehicleI) end
		if(getElementDimension(vehicleGarageMarkerPersonalI) == dim) then destroyElement(vehicleGarageMarkerPersonalI) end

        for _, cV in pairs(createdVehicles) do
            if(cV) then 
                if(getElementDimension(cV) == dim) then 
                    setElementData(cV, "ssE.ID", false)
                    --setElementData(cV, "ssE.ID_vehicle", false)
                    destroyElement(cV) 
                end
            end
        end

        for i, gO in pairs(garageObjects) do
            if(getElementDimension(gO) == dim) then destroyElement(gO) end
        end

    end
    addEventHandler("onMarkerHit", vehicleGarageMarkerVehicleI, vehicleGarageMarkerHitI)
    addEventHandler("onMarkerHit", vehicleGarageMarkerPersonalI, vehicleGarageMarkerHitI)
end

---Helper

function vehicleCreate(thePlayer, dataV, i)
    if(not i) then i = 6 end
    local color = fromJSON(dataV.color)
    local v = createVehicle(dataV.model, vSpawns[i][1], vSpawns[i][2], vSpawns[i][3], vSpawns[i][4], vSpawns[i][5], vSpawns[i][6])
    setVehicleColor(v, color[1], color[2], color[3], color[4], color[5], color[6], color[7], color[8], color[9], color[10], color[11], color[12])
    setVehiclePlateText(v, getPlayerName(thePlayer))

    ----TODO applay Tuning (addVehicleUpgrade) check for if tuning available
    --outputDebugString(toJSON(dataV))
    
    if(dataV.tuning ~= "nya") then
        outputDebugString(dataV.tuning)

        local tuning = fromJSON(dataV.tuning)

        for _, upgrade in pairs(tuning) do
            addVehicleUpgrade(v, upgrade)
        end
    end
    
    return v
end



function vehicleDeployed(thePlayer)
    local vehicles =  getElementsByType("vehicle")
    for _, v in pairs(vehicles) do
        if(getElementData(v, "ssE.owner") == getPlayerName(thePlayer)) then 
            local counter = 0
            for _, occupant in pairs(getVehicleOccupants(v)) do
                counter = counter + 1
            end
            if(counter ~= 0) then
                return v, true
            end

            if(isVehicleBlown(v)) then
                return false, false
            end
            return v, false
        end
    end
    return false, false
end


----CMDs

------USE /cc to spawn Vehicle
function vehicleSpawn(thePlayer, cmd)
    local x, y, z = getElementPosition(thePlayer)
    local rx, ry, rz = getElementRotation(thePlayer)
    x = x - math.sin ( math.rad(rz) ) * 5 
    y = y + math.cos ( math.rad(rz) ) * 5 

    local v, o = vehicleDeployed(thePlayer)
    if(v and o) then
        exports.message:createMessage(thePlayer, "Someone is in your Vehicle can't TP the Vehicle", 3, 3000)
        return
    end

    if(v and not o) then
        if(getElementType(v) == "vehicle") then
            exports.message:createMessage(thePlayer, "Your Vehicle will be delivered", 2, 3000)
            
            setElementPosition(v, x + 1, y, z + 0.5)
            return
        end
    end

    if not (v and o) then 
        local vehicleID = getElementData(thePlayer, "ssE.vehicleMain")
        if(not vehicleID) then
            exports.message:createMessage(thePlayer, "You don't have a Vehicle selected", 1, 3000)
            return
        end

        exports.message:createMessage(thePlayer, "new Vehicle will be created", 2, 3000)
        data = getVehicle(false, vehicleID)
        vehicle = vehicleCreate(thePlayer, data)
        setElementPosition(vehicle, x + 1, y, z + 0.5)
        return
    end
end
addCommandHandler("cc", vehicleSpawn)

---testing
function tpPlayer(thePlayer, cmd)
    setElementPosition(thePlayer, 2522, -1786, 13.5, false)
    setElementDimension(thePlayer, 0)
    setElementInterior(thePlayer, 0)
end
addCommandHandler("tp", tpPlayer)