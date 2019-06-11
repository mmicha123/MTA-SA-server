---getVehicleUpgradeOnSlot to save the upgared in toJSON(dies das)
---https://wiki.multitheftauto.com/wiki/GetVehicleUpgradeOnSlot

---https://wiki.multitheftauto.com/wiki/Vehicle_Upgrades


function createTuningShop()
    local tuningShopMarker = createMarker(552, -1281, 16, 'cylinder', 2.0, 119, 109, 255, 150)
    local tuningShopBlip = createBlipAttachedTo(tuningShopMarker, 42) 
	setBlipVisibleDistance(tuningShopBlip, 250)
	setElementInterior(tuningShopMarker, 0)
    setElementDimension(tuningShopMarker, 0)
    


    local function tuningShopMarkerHit(hitElement)
        if(getElementType(hitElement) ~= "vehicle") then
            exports.message:createMessage(hitElement, "Please enter in owned Vehicle", 3, 3000)
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
        else
            exports.message:createMessage(hitElement, "Please enter in owned Vehicle", 3, 3000)
        end

        triggerClientEvent(hitElement, "vehicle_showTuningShopGUI", hitElement)
    end
    addEventHandler("onMarkerHit", tuningShopMarker, tuningShopMarkerHit)
end
addEventHandler("onResourceStart", resourceRoot, createTuningShop)
