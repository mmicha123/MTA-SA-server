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

        triggerClientEvent(hitElement, "vehicle_showTuningShopGUI", hitElement, get("vPP"), checkVehiclePerPlayer(getElementData(hitElement, "ssE.accID")))
    end
    addEventHandler("onMarkerHit", tuningShopMarker, tuningShopMarkerHit)
end
addEventHandler("onResourceStart", resourceRoot, createTuningShop)
