local screenWidth, screenHeight = guiGetScreenSize()
local windowSizeX, windowSizeY = 500, 100
local bar, bsize = 15, (windowSizeX/3)
local account_createCharWindow = {
    button = {},
    label = {},
}

local pedmodels = getValidPedModels()

function showCharWindow(forceStop)

    if(isElement(account_createCharWindow.window)) then
        destroyElement(account_createCharWindow.window)
        showCursor(false)
        guiSetInputEnabled(false)
        setPlayerHudComponentVisible("all",true)
        showChat(true)
    end
    
    if(forceStop) then return end

    setTimer(guiMode, 200, 1)

    local model = 1
    local ped = createPed(tonumber(pedmodels[model]), 1481.3, -1789, 157, 180)
    local cam = getCamera()
    
    setElementPosition(cam,  1484, -1788, 158)
    attachElements(cam, ped, 0, 4, 1, -15, 0, 180)

    account_createCharWindow.window = guiCreateWindow((screenWidth/2-windowSizeX/2), (screenHeight-windowSizeY-20), windowSizeX, windowSizeY, "choose model", false)

    account_createCharWindow.button.back = guiCreateButton(10, (bar + 10), bsize - 10, (windowSizeY-10), "<-----", false, account_createCharWindow.window)
    account_createCharWindow.button.forward = guiCreateButton((bsize + 10), (bar + 10), bsize -10, (windowSizeY-10), "----->", false, account_createCharWindow.window)
    account_createCharWindow.button.confirm = guiCreateButton((bsize * 2 + 10), (bar + 10), bsize - 10, (windowSizeY-10), "confirm", false, account_createCharWindow.window)
    
    local function back()
        model = model - 1
        if(pedmodels[model] == nil) then
            model = 1
        end
        setElementModel(ped, tonumber(pedmodels[model]))
    end
    addEventHandler("onClientGUIClick", account_createCharWindow.button.back, back, false)

    local function forward()
        model = model + 1
        if(pedmodels[model] == nil) then
            model = 1
        end
        setElementModel(ped, tonumber(pedmodels[model]))
    end
    addEventHandler("onClientGUIClick", account_createCharWindow.button.forward, forward, false)

    local function confirm()
        destroyElement(ped)
        triggerServerEvent("account_createCharackter", getLocalPlayer(), getLocalPlayer(), tonumber(pedmodels[model]))
    end
    addEventHandler("onClientGUIClick", account_createCharWindow.button.confirm, confirm, false)

end




function initShowCharWindow()
    showCharWindow(false)
end
addEvent("account_showCharGUI", true)
addEventHandler("account_showCharGUI", root, initShowCharWindow)


function closeShowCharWindow()
    showCharWindow(true)
end
addEvent("account_closeCharGUI", true)
addEventHandler("account_closeCharGUI", root, closeShowCharWindow)



function guiMode()
    showCursor(true)
    guiSetInputEnabled(true)
    setPlayerHudComponentVisible("all",false)
    showChat(false)
end