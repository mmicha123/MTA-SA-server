local screenWidth, screenHeight = guiGetScreenSize()
local windowSizeX, windowSizeY = 450, 300

local vehicle_createVehicleWindow = {
    gridlist = {},
    button = {},
    label = {}
}
local maxVehicle, myVehicle = 1, 1

local vehicle = nil

function showVehicleShopGUI(forceStop)
    if(isElement(vehicle_createVehicleWindow.window)) then
        destroyElement(vehicle_createVehicleWindow.window)
        showCursor(false)
        guiSetInputEnabled(false)
        setPlayerHudComponentVisible("all",true)
        showChat(true)
        if(isElement(vehicle_createVehicleWindow.windowConfirm)) then
            destroyElement(vehicle_createVehicleWindow.windowConfirm)
        end
    end
    
    if(forceStop) then return end

    setTimer(function()
        showCursor(true)
        guiSetInputEnabled(true)
        setPlayerHudComponentVisible("all", false)
        --showChat(false)
    end, 200, 1)


    ---create Vehicle set vehicle position set camera....

 
    ---create GUI

    vehicle_createVehicleWindow.window = guiCreateWindow(screenWidth - 500, screenHeight/2 - 150, windowSizeX, windowSizeY, "Vehicle Shop", false)
    guiWindowSetSizable(vehicle_createVehicleWindow.window, false)


    vehicle_createVehicleWindow.gridlist.vehicles = guiCreateGridList(10, 30, 225, 570, false, vehicle_createVehicleWindow.window)
    guiGridListAddColumn(vehicle_createVehicleWindow.gridlist.vehicles, "Vehicle", 0.5)
    guiGridListAddColumn(vehicle_createVehicleWindow.gridlist.vehicles, "Price", 0.5)

    vehicle_createVehicleWindow.label.info = guiCreateLabel(255, 30, 100, 20, "Your Info", false, vehicle_createVehicleWindow.window)
    guiSetFont(vehicle_createVehicleWindow.label.info, "default-bold-small")
    vehicle_createVehicleWindow.label.money = guiCreateLabel(255, 50, 100, 20, "Money: "..getPlayerMoney().."$", false, vehicle_createVehicleWindow.window)
    vehicle_createVehicleWindow.label.slots = guiCreateLabel(255, 70, 200, 20, "Slots: "..myVehicle.." out of "..maxVehicle.." are in use", false, vehicle_createVehicleWindow.window)
    
    vehicle_createVehicleWindow.label.vinfo = guiCreateLabel(255, 100, 100, 20, "Vehicle Info", false, vehicle_createVehicleWindow.window)
    guiSetFont(vehicle_createVehicleWindow.label.vinfo, "default-bold-small")
    vehicle_createVehicleWindow.label.price = guiCreateLabel(255, 120, 100, 20, "Price: ?$", false, vehicle_createVehicleWindow.window)
	vehicle_createVehicleWindow.label.speed = guiCreateLabel(255, 140, 200, 20, "Max. Speed: ?", false, vehicle_createVehicleWindow.window)
	vehicle_createVehicleWindow.label.accel = guiCreateLabel(255, 160, 200, 20, "Acceleration: ?", false, vehicle_createVehicleWindow.window)

    vehicle_createVehicleWindow.button.color = guiCreateButton(255, 200, 100, 30, "Select Color", false, vehicle_createVehicleWindow.window)
	vehicle_createVehicleWindow.button.buy = guiCreateButton(255, 250, 100, 30, "Buy Vehicle", false, vehicle_createVehicleWindow.window)
	vehicle_createVehicleWindow.button.exit = guiCreateButton(380, 250, 40, 30, "EXIT", false, vehicle_createVehicleWindow.window)


	vehicle_createVehicleWindow.windowConfirm = guiCreateWindow((screenWidth - 300) / 2, (screenHeight - 100) / 2, 300, 100, "", false)
	guiSetVisible(vehicle_createVehicleWindow.windowConfirm, false)
	guiWindowSetSizable(vehicle_createVehicleWindow.windowConfirm, false)


	vehicle_createVehicleWindow.label.confirm = guiCreateLabel(10, 30, 370, 15, "Are you shure you want to buy that Vehicle?", false, vehicle_createVehicleWindow.windowConfirm)
    vehicle_createVehicleWindow.button.confirmYes = guiCreateButton(20, 60, 45, 30, "Yes", false, vehicle_createVehicleWindow.windowConfirm)
    vehicle_createVehicleWindow.button.confirmNo = guiCreateButton(235, 60, 45, 30, "No", false, vehicle_createVehicleWindow.windowConfirm) 

    ---load priselist
    local xml_File = xmlLoadFile("xml/vehiclePriceC.xml", true)

    local vNodes = xmlNodeGetChildren(xml_File)
    for _, child in pairs(vNodes) do
        local attrs = xmlNodeGetAttributes(child)
        local i = guiGridListAddRow(vehicle_createVehicleWindow.gridlist.vehicles)
        local smodel = attrs.model
        guiGridListSetItemText(vehicle_createVehicleWindow.gridlist.vehicles, i, 1, smodel:sub(1,1):upper()..smodel:sub(2), false, false)
        guiGridListSetItemText(vehicle_createVehicleWindow.gridlist.vehicles, i, 2, attrs.price, false, true)
    end
    xmlUnloadFile(xml_File)
   
    ---add Event Handler

    local function selectVehicleShop()
        local r, c = guiGridListGetSelectedItem(vehicle_createVehicleWindow.gridlist.vehicles)
        local selected = guiGridListGetItemText(vehicle_createVehicleWindow.gridlist.vehicles, r, c)
        if(selected) then
            if(vehicle) then 
                destroyElement(vehicle)
            end
            vehicle = createVehicle(getVehicleModelFromName(selected), 545, -1280, 17.5, 0, 0, 0) --last value
            setElementFrozen(vehicle, true)

            local handling = getVehicleHandling(vehicle)
            --outputConsole(toJSON(handling))
            guiSetText(vehicle_createVehicleWindow.label.price, "Price: "..guiGridListGetItemText(vehicle_createVehicleWindow.gridlist.vehicles, r, c+1).."$")
            guiSetText(vehicle_createVehicleWindow.label.speed, "Max. Speed: "..handling["maxVelocity"])
            guiSetText(vehicle_createVehicleWindow.label.accel, "Acceleration: "..handling["engineAcceleration"])
        end
    end
    addEventHandler("onClientGUIClick", vehicle_createVehicleWindow.gridlist.vehicles, selectVehicleShop)

    local function colorVehicleShop()
        if(not vehicle) then
            exports.message:createMessage("Select a Vehicle", 1, 2000)
            return 
        end

        exports.cpicker:openPicker(getLocalPlayer())

        local rO, gO, bO = getVehicleColor(vehicle, true)

        local function changeColor(element, hex, r, g, b)
            setVehicleColor(vehicle, r, g, b)
        end
        addEventHandler("onColorPickerChange", root, changeColor)

        local function changeColorOK(element, hex, r, g, b)
            setVehicleColor(vehicle, r, g, b)
        end
        addEventHandler("onColorPickerOK", root, changeColorOK)

        local function changeColorCancel()
            setVehicleColor(vehicle, rO, gO, bO)
        end
        addEventHandler("onColorPickerCancel", root, changeColorCancel)

    end
    addEventHandler("onClientGUIClick", vehicle_createVehicleWindow.button.color, colorVehicleShop)

    local function exitVehicleShop()
        showVehicleShopGUI(true)
    end
    addEventHandler("onClientGUIClick", vehicle_createVehicleWindow.button.exit, exitVehicleShop)
    
    local function buyVehicleShop()
        guiSetVisible(vehicle_createVehicleWindow.windowConfirm, true)

        local function buyVehicleShopConfirm()
            if(not vehicle) then
                exports.message:createMessage("Select a Vehicle", 1, 2000)
                return
            end
            local color = {}
            color[1], color[2], color[3], color[4], color[5], color[6], color[7], color[8], color[9], color[10], color[11], color[12] = getVehicleColor(vehicle, true)
            
            triggerServerEvent("vehicle_buyVehicle", getLocalPlayer(), getLocalPlayer(), getElementModel(vehicle), toJSON(color))
            guiSetVisible(vehicle_createVehicleWindow.windowConfirm, false)
        end
        addEventHandler("onClientGUIClick", vehicle_createVehicleWindow.button.confirmYes, buyVehicleShopConfirm)

        local function buyVehicleShopCancel()
            guiSetVisible(vehicle_createVehicleWindow.windowConfirm, false)
        end
        addEventHandler("onClientGUIClick", vehicle_createVehicleWindow.button.confirmNo, buyVehicleShopCancel)
    end
    addEventHandler("onClientGUIClick", vehicle_createVehicleWindow.button.buy, buyVehicleShop)

end


function updateVehicleShopGUI(maxV, myV)
    showVehicleShopGUI(true)
	maxVehicle = maxV
    myVehicle = myV
    showVehicleShopGUI(false)
end
addEvent("vehicle_updateVehicleShopGUI", true)
addEventHandler("vehicle_updateVehicleShopGUI", root, updateVehicleShopGUI)


function initShowVehicleShopGUI(maxV, myV)
    maxVehicle = maxV
    myVehicle = myV
    showVehicleShopGUI(false)
end
addEvent("vehicle_showVehicleShopGUI", true)
addEventHandler("vehicle_showVehicleShopGUI", root, initShowVehicleShopGUI)

--addEventHandler("onClientResourceStart", resourceRoot, show)



function closeShowVehicleShopGUI()
    showCharWindow(true)
end
addEvent("vehicle_closeVehicleShopGUI", true)
addEventHandler("vehicle_closeVehicleShopGUI", root, closeShowVehicleShopGUI)

