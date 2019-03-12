function createVehicleShop()
    ---createing marker and stuf
    local vehicleShopMarker = createMarker(552, -1281, 16, 'cylinder', 2.0, 119, 109, 255, 150)
    local vehicleShopBlip = createBlipAttachedTo(vehicleShopMarker, 55) 
	setBlipVisibleDistance(vehicleShopBlip, 250)
	setElementInterior(vehicleShopMarker, 0)
    setElementDimension(vehicleShopMarker, 0) 
    


    local function vehicleShopMarkerHit(hitElement)
        if(getElementType(hitElement) ~= "player") then 
            return
        end

        if(not isPedInVehicle(hitElement)) then
            exports.message:createMessage(hitElement, "Please enter on foot", 3, 3000)
            return
        end

        triggerClientEvent(hitElement, "vehicle_showVehicleShopGUI", hitElement)
    end
    addEventHandler("onMarkerHit", vehicleShopMarker, vehicleShopMarkerHit)

end
addEventHandler("onResourceStart", resourceRoot, createVehicleShop)