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

        if(isPedInVehicle(hitElement)) then
            exports.message:createMessage(hitElement, "Please enter on foot", 3, 3000)
            return
        end

        local acc = getPlayerAccount(hitElement)
        if(not acc or isGuestAccount(acc)) then
            return 
        end

        triggerClientEvent(hitElement, "vehicle_showVehicleShopGUI", hitElement, get("vPP"), checkVehiclePerPlayer(getElementData(hitElement, "ssE.accID")))
    end
    addEventHandler("onMarkerHit", vehicleShopMarker, vehicleShopMarkerHit)

end
addEventHandler("onResourceStart", resourceRoot, createVehicleShop)


function buyVehicle(thePlayer, modelV, colorV)
    outputChatBox(modelV)
    outputChatBox(colorV)
    if not (modelV and colorV) then 
        return 
    end

    local price = 0
    local maxVehicles = tonumber(get("vPP"))

    if(not exports.account:isPromium(thePlayer)) then
        maxVehicles = maxVehicles - 2
    end

    if(checkVehiclePerPlayer(getElementData(thePlayer, "ssE.accID")) >= maxVehicles) then
        exports.message:createMessage(thePlayer, "You don't have enough Vehicle Slots", 1, 5000)
        exports.message:createMessage(thePlayer, "Buy Promium or Sell some Vehicles", 3, 5000)
        return
    end


    ---load vehicle Price
    local xml_File = xmlLoadFile("XML/vehiclePriceS.xml", true)
    local vehicles = xmlNodeGetChildren(xml_File)
    for _, child in pairs(vehicles) do
        local attrs = xmlNodeGetAttributes(child)
        local modelInList = getVehicleModelFromName(attrs.model)
        if(modelInList == modelV) then
            price = tonumber(attrs.price)
            break
        end
    end
    --check if vehicle was found in priceList
    if(price == 0) then
        exports.message:createMessage(thePlayer, "Vehicle has not been found", 1, 4000)
    end
    xmlUnloadFile(xml_File)

    if(price > getPlayerMoney(thePlayer)) then
        return
        exports.message:createMessage(thePlayer, "You don't have enough Money", 1, 4000)
    end

    local isVehicle = addVehicle(thePlayer, {model = modelV, color = colorV})

    if(not isVehicle) then 
        exports.message:createMessage(thePlayer, "An error has occurred can't add the Vehicle", 1, 4000)
        outputDebugString("Can't add Vehicle from Player: "..thePlayer, 1, 255, 0, 0)
        return
    end

    takePlayerMoney(thePlayer, price)
    exports.message:createMessage(thePlayer, "Your Vehicle is now in your Garage", 2, 2000)
    triggerClientEvent(thePlayer, "vehicle_updateVehicleShopGUI", thePlayer, get("vPP"), checkVehiclePerPlayer(getElementData(thePlayer, "ssE.accID")))
end
addEvent("vehicle_buyVehicle", true)
addEventHandler("vehicle_buyVehicle", getRootElement(), buyVehicle)