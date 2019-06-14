---getVehicleUpgradeOnSlot to save the upgared in toJSON(dies das)
---https://wiki.multitheftauto.com/wiki/GetVehicleUpgradeOnSlot

---https://wiki.multitheftauto.com/wiki/Vehicle_Upgrades
local enteredMarkerData = {}

function createTuningShop()
    local tuningShopMarker = createMarker(564, -1278, 16, 'cylinder', 2.0, 119, 109, 255, 150)
    local tuningShopBlip = createBlipAttachedTo(tuningShopMarker, 42) 
	setBlipVisibleDistance(tuningShopBlip, 250)
	setElementInterior(tuningShopMarker, 0)
    setElementDimension(tuningShopMarker, 0)
    


    local function tuningShopMarkerHit(hitElement)
        if(getElementType(hitElement) ~= "vehicle") then
            exports.message:createMessage(hitElement, "Please enter in owned Vehicle", 3, 3000)
            return
        end

        thePlayer = getVehicleController(hitElement)

        local vehicleOwner = getElementData(hitElement, "ssE.owner")

        if(getPlayerSerial(thePlayer) ~= vehicleOwner) then
            exports.message:createMessage(hitElement, "Please enter in owned Vehicle", 3, 3000)
            return
        end

                    
        local playerVehicleID = getElementData(thePlayer, "ssE.vehicleMain")
        if(not playerVehicleID) then
            return
        end

        local playerVehicleData = getVehicle(thePlayer, playerVehicleID)
        if(not playerVehicleData) then
            return
        end

        enteredMarkerData[thePlayer] = {thePlayer, hitElement, playerVehicleID} --(player, vehicle, vehicleID relative to player)

        triggerClientEvent(thePlayer, "vehicle_showTuningShopGUI", thePlayer, playerVehicleData)
        
        for seat, occupant in pairs(getVehicleOccupants(hitElement)) do
            removePedFromVehicle(occupant)
        end

        --setElementData(hitElement, "ssE.owner", false)
        --destroyElement(hitElement)

        --position change and move camera--



        --setElementData(thePlayer, "ssE.vehicleMain", vehicleID) id im player match suchen aka index für datenbank
        ---getElementData(hitElement, "ssE.ID_Vehicle") id im vehicle 
    end
    addEventHandler("onMarkerHit", tuningShopMarker, tuningShopMarkerHit)
end
addEventHandler("onResourceStart", resourceRoot, createTuningShop)


local function tuningSaveColor(thePlayer, color)
    local idVehicle = enteredMarkerData[thePlayer][3]
    local exec = updateVehicle(idVehicle, "color", color)
    if(not exec) then
        exports.message:createMessage(hitElement, "Error while saving the Color please report to Admin", 1, 5000)
    end
end
addEvent("vehicle_tuningSaveColor", true)
addEventHandler("vehicle_tuningSaveColor", getRootElement(), tuningSaveColor)


--HELPER

