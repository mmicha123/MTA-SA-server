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

function applyAllTuning(tData)

end
addEvent("vehicle_applyTuning", true)
addEventHandler("vehicle_applyTuning", getRootElement(), applyAllTuning)

function saveTuning(tData)

end
addEvent("vehicle_saveTuning", true)
addEventHandler("vehicle_saveTuning", getRootElement(), saveTuning)

--tuningData = {handling = {}, visual = {}}
--HANDLING = {"name" = value}





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
function applyTuning(vehicle, tuningD)
    if(not tuningD or vehicle) then return end
    
    local perf = {}
    if(tuningD.package == 1) then 
        perf.accel = 2
        perf.vel = 10
        perf.iner = -10
        perf.trMul = 0.05
        perf.trLoss = 0.02
        perf.bDec = 0.05
        perf.bBia = 0.1
    elseif(tuningD.package == 2) then 
        perf.accel = 6
        perf.vel = 20
        perf.iner = -20
        perf.trMul = 0.1
        perf.trLoss = 0.03
        perf.bDec = 0.1
        perf.bBia = 0.175
    elseif(tuningD.package == 3) then 
        perf.accel = 8
        perf.vel = 30
        perf.iner = -30
        perf.trMul = 0.15
        perf.trLoss = 0.04
        perf.bDec = 0.15
        perf.bBia = 0.25
    end

    if(perf) then
        
    end
end
