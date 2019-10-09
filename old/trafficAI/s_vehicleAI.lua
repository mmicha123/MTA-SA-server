
function giveTracker(thePlayer, cmd)
    local x, y, z = getElementPosition(thePlayer)
    local r = getElementRotation(thePlayer)
    vehicle = createVehicle(424, x, y, z, 0, 0, r)
    setElementDimension(vehicle, getElementDimension(thePlayer))
    setElementInterior(vehicle, getElementInterior(thePlayer))
    warpPedIntoVehicle(thePlayer, vehicle)

    --edit handling
    setVehicleHandling(vehicle, "maxVelocity", 40)
end
addCommandHandler("gt", giveTracker)

function startTracking(thePlayer, cmd)
    local v = getPedOccupiedVehicle(thePlayer)
    if(v ~= vehicle) then
        exports.message:createMessage(thePlayer, "You are not in a tracking Vehicle", 1, 4000)
        return
    end

    triggerClientEvent(thePlayer, "trafficAI_startTracking", thePlayer, vehicle)

    function exitVehicle()
        exports.message:createMessage(thePlayer, "You can't exit this vehicle", 1, 4000)
        cancelEvent()
    end
    addEventHandler ("onVehicleStartExit", getRootElement(), exitVehicle)
end
addCommandHandler("startt", startTracking)

function stopTracking(thePlayer)
    triggerClientEvent(thePlayer, "trafficAI_stopTracking", thePlayer, vehicle)
    removeEventHandler("onVehicleStartExit", getRootElement(), exitVehicle)
    destroyElement(vehicle)
end
addCommandHandler("stopt", stopTracking)



function tpPlayervehicleAI(thePlayer, cmd)
    setElementPosition(thePlayer, 2614, -2219, 13.5, false)
    setElementDimension(thePlayer, 0)
    setElementInterior(thePlayer, 0)
end
addCommandHandler("tpai", tpPlayervehicleAI)
