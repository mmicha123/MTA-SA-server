local screenWidth, screenHeight = guiGetScreenSize()
local windowSizeX, windowSizeY = 500, 350

local tVW = {
    button = {},
    tab = {},
    radio = {}
}

local prices = {
    p = {10000, 35000, 50000}
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

    tVW.button.EXIT = guiCreateButton(windowSizeX - 50, windowSizeY - 60, 40, 30, "EXIT", false, tVW.window)
    
    tVW.tab.tabpanel = guiCreateTabPanel(10, 25, windowSizeX - 70, windowSizeY - 10, false, tVW.window)

    tVW.tab[1] = guiCreateTab("Color", tVW.tab.tabpanel)
    tVW.button.color1 = guiCreateButton(10, 10, 210, 55, "COLOR 1", false, tVW.tab[1])
    tVW.button.color2 = guiCreateButton(10, 75, 210, 55, "COLOR 2", false, tVW.tab[1])

    tVW.button.tab1add = guiCreateButton(10, 145, 100, 30, "ADD", false, tVW.tab[1])
    tVW.button.tab1remove = guiCreateButton(120, 145, 100, 30, "REMOVE", false, tVW.tab[1])

    tVW.tab[2] = guiCreateTab("Performance", tVW.tab.tabpanel)

    tVW.radio.p1 = guiCreateRadioButton(10, 10, 200, 20, "Normal Upgrade "..prices.p[1].." $", false, tVW.tab[2])
    tVW.radio.p1 = guiCreateRadioButton(10, 50, 200, 20, "Hightech Upgrade "..prices.p[2].." $" , false, tVW.tab[2])
    tVW.radio.p1 = guiCreateRadioButton(10, 90, 200, 20, "Promium Upgrade "..prices.p[3].." $", false, tVW.tab[2])

    tVW.button.tab2add = guiCreateButton(10, 145, 100, 30, "ADD", false, tVW.tab[2])
    tVW.button.tab2remove = guiCreateButton(120, 145, 100, 30, "REMOVE", false, tVW.tab[2])

    tVW.tab[3] = guiCreateTab("Optical", tVW.tab.tabpanel)

    tVW.button.tab3add = guiCreateButton(10, 145, 100, 30, "ADD", false, tVW.tab[3])
    tVW.button.tab3remove = guiCreateButton(120, 145, 100, 30, "REMOVE", false, tVW.tab[3])

    addEventHandler("onClientGUIClick", tVW.button.EXIT, function()
        showVehicleTuningGUI(true)
    end)

    local function color1()
        if(not vehicle) then return end

        exports.cpicker:openPicker(getLocalPlayer())

        local rO1, gO1, bO1, rO2, gO2, bO2 = getVehicleColor(vehicle, true)

        local function changeColor(element, hex, r, g, b)
            setVehicleColor(vehicle, r, g, b, rO2, gO2, bO2)
        end
        addEventHandler("onColorPickerChange", root, changeColor)

        local function changeColorOK(element, hex, r, g, b)
            setVehicleColor(vehicle, r, g, b, rO2, gO2, bO2)
        end
        addEventHandler("onColorPickerOK", root, changeColorOK)

        local function changeColorCancel()
            setVehicleColor(vehicle, rO1, gO1, bO1, rO2, gO2, bO2)
        end
        addEventHandler("onColorPickerCancel", root, changeColorCancel)
    end
    addEventHandler("onClientGUIClick", tVW.button.color1, color1)

    local function color2()
        if(not vehicle) then return end

        exports.cpicker:openPicker(getLocalPlayer())

        local rO1, gO1, bO1, rO2, gO2, bO2 = getVehicleColor(vehicle, true)

        local function changeColor(element, hex, r, g, b)
            setVehicleColor(vehicle, rO1, gO1, bO1, r, g, b)
        end
        addEventHandler("onColorPickerChange", root, changeColor)

        local function changeColorOK(element, hex, r, g, b)
            setVehicleColor(vehicle, rO1, gO1, bO1, r, g, b)
        end
        addEventHandler("onColorPickerOK", root, changeColorOK)

        local function changeColorCancel()
            setVehicleColor(vehicle, rO1, gO1, bO1, rO2, gO2, bO2)
        end
        addEventHandler("onColorPickerCancel", root, changeColorCancel)
    end
    addEventHandler("onClientGUIClick", tVW.button.color2, color2)

end

function initShowTuningeShopGUI(playerVehicleData)
    vehicleD = playerVehicleData
    vehicle = setUpVehicle()

    if(not vehicle) then return end 

    showVehicleTuningGUI(false)
end
addEvent("vehicle_showTuningShopGUI", true)
addEventHandler("vehicle_showTuningShopGUI", root, initShowTuningeShopGUI)
