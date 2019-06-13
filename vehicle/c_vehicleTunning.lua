local screenWidth, screenHeight = guiGetScreenSize()
local windowSizeX, windowSizeY = 300, 250

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


    addEventHandler("onClientGUIClick", tVW.button.tab1add, function()
        if(not vehicle) then return end

        local color = {}
        color[1], color[2], color[3], color[4], color[5], color[6]= getVehicleColor(vehicle, true)

        triggerServerEvent("vehicle_tuningSaveColor", getLocalPlayer(), getLocalPlayer(), toJSON(color))
    end)

    addEventHandler("onClientGUIClick", tVW.button.tab1remove, function()
        if(not vehicle) then return end
        --triggerServerEvent()
    end)

    addEventHandler("onClientGUIClick", tVW.button.tab2add, function()

    end)

    addEventHandler("onClientGUIClick", tVW.button.tab2remove, function()
        
    end)

    addEventHandler("onClientGUIClick", tVW.button.tab3add, function()

    end)

    addEventHandler("onClientGUIClick", tVW.button.tab3remove, function()
        
    end)


end

function initShowTuningeShopGUI(playerVehicleData)
    vehicleD = playerVehicleData
    vehicle = setUpVehicle()

    if(not vehicle) then return end 

    showVehicleTuningGUI(false)
end
addEvent("vehicle_showTuningShopGUI", true)
addEventHandler("vehicle_showTuningShopGUI", root, initShowTuningeShopGUI)

function setUpVehicle()

end

--[[
        GUIEditor.window[1] = guiCreateWindow(1192, 529, 301, 222, "", false)
        guiWindowSetSizable(GUIEditor.window[1], false)

        GUIEditor.tabpanel[1] = guiCreateTabPanel(10, 24, 233, 188, false, GUIEditor.window[1])

        GUIEditor.tab[1] = guiCreateTab("Tab", GUIEditor.tabpanel[1])

        GUIEditor.button[1] = guiCreateButton(10, 124, 97, 30, "", false, GUIEditor.tab[1])

        GUIEditor.button[2] = guiCreateButton(126, 124, 97, 30, "", false, GUIEditor.tab[1])

        GUIEditor.button[3] = guiCreateButton(13, 9, 210, 105, "COLOR", false, GUIEditor.tab[1])


        GUIEditor.tab[2] = guiCreateTab("Performance", GUIEditor.tabpanel[1])

        GUIEditor.button[4] = guiCreateButton(9, 128, 99, 26, "", false, GUIEditor.tab[2])
        guiSetProperty(GUIEditor.button[4], "NormalTextColour", "FFAAAAAA")
        GUIEditor.button[5] = guiCreateButton(124, 128, 99, 26, "", false, GUIEditor.tab[2])
        guiSetProperty(GUIEditor.button[5], "NormalTextColour", "FFAAAAAA")
        GUIEditor.radiobutton[1] = guiCreateRadioButton(15, 16, 192, 20, "1", false, GUIEditor.tab[2])
        guiRadioButtonSetSelected(GUIEditor.radiobutton[1], true)
        GUIEditor.radiobutton[2] = guiCreateRadioButton(15, 46, 192, 20, "2", false, GUIEditor.tab[2])
        GUIEditor.radiobutton[3] = guiCreateRadioButton(15, 76, 192, 20, "2", false, GUIEditor.tab[2])

        GUIEditor.tab[3] = guiCreateTab("Optical", GUIEditor.tabpanel[1])

        GUIEditor.button[6] = guiCreateButton(249, 173, 42, 29, "EXIT", false, GUIEditor.window[1])
        guiSetProperty(GUIEditor.button[6], "NormalTextColour", "FFAAAAAA")    
]]
