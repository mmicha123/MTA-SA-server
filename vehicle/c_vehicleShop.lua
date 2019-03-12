local screenWidth, screenHeight = guiGetScreenSize()
local windowSizeX, windowSizeY = 450, 300

local vehicle_createVehicleWindow = {
    button = {},
    label = {}
}

function showVehicleShopGUI(forceStop)
    if(isElement(vehicle_createVehicleWindow.window)) then
        destroyElement(vehicle_createVehicleWindow.window)
        showCursor(false)
        guiSetInputEnabled(false)
        setPlayerHudComponentVisible("all",true)
        showChat(true)
    end
    
    if(forceStop) then return end

    setTimer(function()
        showCursor(true)
        guiSetInputEnabled(true)
        setPlayerHudComponentVisible("all", false)
        showChat(false)
    end, 200, 1)


    ---create Vehicle set vehicle position set camera....

 
    ---create GUI

    vehicle_createVehicleWindow.window = guiCreateWindow(screenWidth - 500, screenHeight/2 - 150, windowSizeX, windowSizeY, "Vehicle Shop", false)
   
    vehicle_createVehicleWindow.gridlist = guiCreateGridList(10, 30, 225, 570, false, vehicle_createVehicleWindow.window)
    guiGridListAddColumn(vehicle_createVehicleWindow.gridlist, "Vehicle", 0.5)
    guiGridListAddColumn(vehicle_createVehicleWindow.gridlist, "Price", 0.5)

    vehicle_createVehicleWindow.label.info = guiCreateLabel(255, 30, 100, 20, "Your Info", false, vehicle_createVehicleWindow.window)
    guiSetFont(vehicle_createVehicleWindow.label.info, "default-bold-small")
    vehicle_createVehicleWindow.label.money = guiCreateLabel(255, 50, 100, 20, "Money: ?$", false, vehicle_createVehicleWindow.window)
    vehicle_createVehicleWindow.label.slots = guiCreateLabel(255, 70, 200, 20, "Slots: ? out of ? are in use", false, vehicle_createVehicleWindow.window)
    
    vehicle_createVehicleWindow.label.vinfo = guiCreateLabel(255, 100, 100, 20, "Vehicle Info", false, vehicle_createVehicleWindow.window)
    guiSetFont(vehicle_createVehicleWindow.label.vinfo, "default-bold-small")
    vehicle_createVehicleWindow.label.price = guiCreateLabel(255, 120, 100, 20, "Price: ?$", false, vehicle_createVehicleWindow.window)
	vehicle_createVehicleWindow.label.speed = guiCreateLabel(255, 140, 200, 20, "Max. Speed: ?", false, vehicle_createVehicleWindow.window)
	vehicle_createVehicleWindow.label.accel = guiCreateLabel(255, 160, 200, 20, "Acceleration: ?", false, vehicle_createVehicleWindow.window)

    ---load prizelist
    --[[
	buttonSelectColor = guiCreateButton(255, 200, 100, 30, "Select Color", false, windowMain)
	buttonBuyVehicle = guiCreateButton(255, 250, 100, 30, "Buy Vehicle", false, windowMain)
	buttonExit = guiCreateButton(380, 250, 40, 30, "EXIT", false, windowMain)


	windowConfirm = guiCreateWindow((xres - 300) / 2, (yres - 100) / 2, 300, 100, "", false)
	guiSetVisible(windowConfirm, false)
	guiWindowSetSizable(windowConfirm, false)


	labelConfirm = guiCreateLabel(10, 30, 370, 15, "Are you shure you want to buy that Vehicle?", false, windowConfirm)
    buttonConfirmYes = guiCreateButton(20, 60, 45, 30, "Yes", false, windowConfirm)
    buttonConfirmNo = guiCreateButton(235, 60, 45, 30, "No", false, windowConfirm) 

    local xml_File = xmlLoadFile("xml/vehiclePriceC.xml", true)

    local vNodes = xmlNodeGetChildren(xml_File)
    for _, child in pairs(vNodes) do
        local attrs = xmlNodeGetAttributes(child)
        local i = guiGridListAddRow(gridlistVehicles)
        local smodel = attrs.model
        --guiGridListSetItemText(gridlistVehicles, i, 1, smodel:sub(1,1):upper()..smodel:sub(2), false, false)
        --guiGridListSetItemText(gridlistVehicles, i, 2, attrs.price, false, true)
    end
    xmlUnloadFile(xml_File)
    ]]--
   ---add Event Handler


end

function initShowVehicleShopGUI()
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

