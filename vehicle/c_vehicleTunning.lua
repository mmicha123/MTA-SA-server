local screenWidth, screenHeight = guiGetScreenSize()
local windowSizeX, windowSizeY = 500, 350

local tVW = {
    button = {},
    tab = {},
    radio = {}
}

local vehicle = nil
local vehicleD = nil

function showVehicleTuningGUI(forceStop)

    if(isElement(tVW.window)) then
        destroyElement(tVW.window)
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
        setPlayerHudComponentVisible("money", true)
        --showChat(false)
    end, 200, 1)

    ---move Vehicle and setup room for tuning

    ---create GUI

    tVW.window = guiCreateWindow(screenWidth - 500, screenHeight/2 - 150, windowSizeX, windowSizeY, "Tuning Shop", false)
    guiWindowSetSizable(tVW.window, false)

    tVW.button.CONFIRM = guiCreateButton(10, windowSizeY - 60, 150, 40, "CONFIRM", false, tVW.window)
    tVW.button.REMOVE = guiCreateButton(170, windowSizeY - 60, 150, 40, "REMOVE", false, tVW.window)
    tVW.button.EXIT = guiCreateButton(330, windowSizeY - 60, 150, 40, "EXIT", false, tVW.window)
    
    tVW.tab.tabpanel = guiCreateTabPanel(10, 25, windowSizeX / 2, windowSizeY - 100, false, tVW.window)

    tVW.tab[1] = guiCreateTab("Color", tVW.tab.tabpanel)
    tVW.button.color1 = guiCreateButton(10, 10, (windowSizeX / 2) - 20, 55, "COLOR 1", false, tVW.tab[1])
    tVW.button.color2 = guiCreateButton(10, 75, (windowSizeX / 2) - 20, 55, "COLOR 2", false, tVW.tab[1])
    tVW.button.color3 = guiCreateButton(10, 150, (windowSizeX / 2) - 20, 55, "COLOR 3", false, tVW.tab[1])

    tVW.tab[2] = guiCreateTab("Performance", tVW.tab.tabpanel)


    tVW.tab[3] = guiCreateTab("Optical", tVW.tab.tabpanel)


    tVW.gridList = guiCreateGridList((windowSizeX / 2) + 20, 25, windowSizeX - 10, windowSizeY - 100, false, tVW.window)
    guiGridListAddColumn(tVW.gridList, "[ ]", 0.1)
    guiGridListAddColumn(tVW.gridList, "Upgrade", 0.4)
    guiGridListAddColumn(tVW.gridList, "Price", 0.6)

    for i = 1, 28 do
        local index = guiGridListAddRow(tVW.gridList)
        if(i <= 12) then
            guiGridListSetItemText(tVW.gridList, index, 2, tuningParts[i], false, false)
        else
            guiGridListSetItemText(tVW.gridList, index, 2, getVehicleUpgradeSlotName(i - 12), false, false) 
        end
    end
    --initToGridList()
    
    addEventHandler("onClientGUIClick", tVW.button.EXIT, function()
        showVehicleTuningGUI(true)
    end)

    local function color1()
        if(not vehicle) then return end

        exports.cpicker:openPicker(getLocalPlayer())

        local rO1, gO1, bO1, rO2, gO2, bO2, rO3, gO3, bO3 = getVehicleColor(vehicle, true)

        local function changeColor(element, hex, r, g, b)
            setVehicleColor(vehicle, r, g, b, rO2, gO2, bO2, rO3, gO3, bO3)
        end
        addEventHandler("onColorPickerChange", root, changeColor)

        local function changeColorOK(element, hex, r, g, b)
            setVehicleColor(vehicle, r, g, b, rO2, gO2, bO2, rO3, gO3, bO3)
        end
        addEventHandler("onColorPickerOK", root, changeColorOK)

        local function changeColorCancel()
            setVehicleColor(vehicle, rO1, gO1, bO1, rO2, gO2, bO2, rO3, gO3, bO3)
        end
        addEventHandler("onColorPickerCancel", root, changeColorCancel)
    end
    addEventHandler("onClientGUIClick", tVW.button.color1, color1)

    local function color2()
        if(not vehicle) then return end

        exports.cpicker:openPicker(getLocalPlayer())

        local rO1, gO1, bO1, rO2, gO2, bO2, rO3, gO3, bO3 = getVehicleColor(vehicle, true)

        local function changeColor(element, hex, r, g, b)
            setVehicleColor(vehicle, rO1, gO1, bO1, r, g, b, rO3, gO3, bO3)
        end
        addEventHandler("onColorPickerChange", root, changeColor)

        local function changeColorOK(element, hex, r, g, b)
            setVehicleColor(vehicle, rO1, gO1, bO1, r, g, b, rO3, gO3, bO3)
        end
        addEventHandler("onColorPickerOK", root, changeColorOK)

        local function changeColorCancel()
            setVehicleColor(vehicle, rO1, gO1, bO1, rO2, gO2, bO2, rO3, gO3, bO3)
        end
        addEventHandler("onColorPickerCancel", root, changeColorCancel)
    end
    addEventHandler("onClientGUIClick", tVW.button.color2, color2)

    local function color3()
        if(not vehicle) then return end

        exports.cpicker:openPicker(getLocalPlayer())

        local rO1, gO1, bO1, rO2, gO2, bO2, rO3, gO3, bO3 = getVehicleColor(vehicle, true)

        local function changeColor(element, hex, r, g, b)
            setVehicleColor(vehicle, rO1, gO1, bO1, rO2, gO2, bO2, r, g, b)
        end
        addEventHandler("onColorPickerChange", root, changeColor)

        local function changeColorOK(element, hex, r, g, b)
            setVehicleColor(vehicle, rO1, gO1, bO1, rO2, gO2, bO2, r, g, b)
        end
        addEventHandler("onColorPickerOK", root, changeColorOK)

        local function changeColorCancel()
            setVehicleColor(vehicle, rO1, gO1, bO1, rO2, gO2, bO2, rO3, gO3, bO3)
        end
        addEventHandler("onColorPickerCancel", root, changeColorCancel)
    end
    addEventHandler("onClientGUIClick", tVW.button.color3, color3)

end

function initShowTuningeShopGUI(playerVehicleData)
    if(playerVehicleData == nil) then
        return
    end

    vehicleD = playerVehicleData
    vehicle = createTuningVehicle(getLocalPlayer(), playerVehicleData)
    setElementPosition(vehicle, 560, -1271, 17.5) --test pos

    if(not vehicle) then return end 

    showVehicleTuningGUI(false)
end
addEvent("vehicle_showTuningShopGUI", true)
addEventHandler("vehicle_showTuningShopGUI", root, initShowTuningeShopGUI)

--[[

function initToGridList() ------- not shure !!!!!
    if(vD.performance ~= "nya") then
        local per = fromJSON(vehicleD.performance) 

        if(vehicleD.performance.motor ~= 0 and vehicleD.performance.motor ~= nil) then
            guiGridListSetItemText(tVW.gridList, 5, 1, vehicleD.performance.motor, false, false)
        end

        if(vehicleD.performance.turbo ~= 0 and vehicleD.performance.turbo ~= nil) then
            guiGridListSetItemText(tVW.gridList, 6, 1, vehicleD.performance.turbo, false, false)
        end

        if(vehicleD.performance.tires ~= 0 and vehicleD.performance.tires ~= nil) then
            guiGridListSetItemText(tVW.gridList, 7, 1, vehicleD.performance.tires, false, false)
        end

        if(vehicleD.performance.brakes ~= 0 and vehicleD.performance.brakes ~= nil) then
            guiGridListSetItemText(tVW.gridList, 8, 1, vehicleD.performance.brakes, false, false)
        end

        if(vehicleD.performance.mass ~= 0 and vehicleD.performance.mass ~= nil) then
            guiGridListSetItemText(tVW.gridList, 9, 1, vehicleD.performance.mass, false, false)
        end
    end

    if(vD.optical ~= "nya") then
        local opt = fromJSON(vD.optical)
        for _, u in ipairs(opt.upgrades) do
            
        end
    end
end
]]--
--guiGridListSetItemText(tVW.gridList, index, 2, tuningParts[i], false, false)
