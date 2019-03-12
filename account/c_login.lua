local screenWidth, screenHeight = guiGetScreenSize()
local account_loginWindow = {
    button = {},
    label = {},
    edit = {}
}

   
function showLoginWindow(forceStop)
    if(isElement(account_loginWindow.window)) then
        destroyElement(account_loginWindow.window)
        destroyElement(account_loginWindow.image)
        if(account_loginWindow.sound) then
            stopSound(account_loginWindow.sound)
        end
        showCursor(false)
        guiSetInputEnabled(false)
        setPlayerHudComponentVisible("all",true)
        showChat(true)
    end
    
    if(forceStop) then return end

    
    showCursor(true)
    guiSetInputEnabled(true)
    setPlayerHudComponentVisible("all",false)
    showChat(false)

    account_loginWindow.sound = playSound("gfx/music/aud.mp3", true )
    setSoundVolume(account_loginWindow.sound, 0.2)

    account_loginWindow.image = guiCreateStaticImage(0, 0, screenWidth, screenHeight, "gfx/img/wallpaper.png", false )
    
    account_loginWindow.window = guiCreateWindow(40, (screenHeight - 190) / 2, 325, 190, "LOGIN", false)
    guiWindowSetMovable(account_loginWindow.window, false)
    guiWindowSetSizable(account_loginWindow.window, false)

    account_loginWindow.label.username = guiCreateLabel(40, 30, 90, 15, "Username", false, account_loginWindow.window)
    guiLabelSetHorizontalAlign(account_loginWindow.label.username, "center", false)
    guiLabelSetVerticalAlign(account_loginWindow.label.username, "center")

    account_loginWindow.label.password = guiCreateLabel(40, 100, 90, 15, "Password", false, account_loginWindow.window)
    guiLabelSetHorizontalAlign(account_loginWindow.label.password, "center", false)
    guiLabelSetVerticalAlign(account_loginWindow.label.password, "center")

    account_loginWindow.edit.username = guiCreateEdit(50, 55, 165, 30, "", false, account_loginWindow.window)
    guiEditSetMaxLength(account_loginWindow.edit.username, 25)

    account_loginWindow.edit.password = guiCreateEdit(50, 120, 165, 30, "", false, account_loginWindow.window)
    guiEditSetMaxLength(account_loginWindow.edit.password, 25)
    guiEditSetMasked(account_loginWindow.edit.password, true)
    
    account_loginWindow.button.login = guiCreateButton(220, 55, 110, 30, "Login", false, account_loginWindow.window)
    guiSetProperty(account_loginWindow.button.login, "NormalTextColour", "FFAAAAAA")

    account_loginWindow.button.register = guiCreateButton(220, 120, 110, 30, "Register?", false, account_loginWindow.window)
    guiSetProperty(account_loginWindow.button.register, "NormalTextColour", "FFAAAAAA")

    account_loginWindow.savelogin = guiCreateCheckBox(50, 160, 165, 15, "Remember Login", false, false, account_loginWindow.window)

    local username, password = loadLoginFromXML()

    if(username or password) then
        guiCheckBoxSetSelected(account_loginWindow.savelogin, true)
        guiSetText(account_loginWindow.edit.username, tostring(username))
        guiSetText(account_loginWindow.edit.password, tostring(password))
    else
        guiCheckBoxSetSelected(account_loginWindow.savelogin, false)
    end

    guiSetVisible(account_loginWindow.window, true)

    local function prossesLogin()
        local username = guiGetText(account_loginWindow.edit.username)
        local password = guiGetText(account_loginWindow.edit.password)
        triggerServerEvent("account_login", getLocalPlayer(), getLocalPlayer(), username, password, guiCheckBoxGetSelected(account_loginWindow.savelogin))
    end
    addEventHandler("onClientGUIClick", account_loginWindow.button.login, prossesLogin, false)


    local function prossesRegister()
        local username = guiGetText(account_loginWindow.edit.username)
        local password = guiGetText(account_loginWindow.edit.password)
        triggerServerEvent("account_register", getLocalPlayer(), getLocalPlayer(), username, password)
    end
    addEventHandler("onClientGUIClick", account_loginWindow.button.register, prossesRegister, false)
    
    
end

--addEvent("account_showGUI", true)
--addEventHandler("account_showGUI", root, showLoginWindow)



addEventHandler("onClientResourceStart", resourceRoot, 
    function()
        showLoginWindow(false)
    end
)


function closeGUI()
    showLoginWindow(true)
end
addEvent("account_closeGUI", true)
addEventHandler("account_closeGUI", root, closeGUI)


----------------------------------------------------------------------------------------------------------------------------------------------

function loadLoginFromXML()
    local xml_save_log_File = xmlLoadFile("gfx/xml/userdata.xml")
    if not xml_save_log_File then
        xml_save_log_File = xmlCreateFile("gfx/xml/userdata.xml", "login")
    end
    local usernameNode = xmlFindChild(xml_save_log_File, "username", 0)
    local passwordNode = xmlFindChild(xml_save_log_File, "password", 0)
    if usernameNode and passwordNode then
        return xmlNodeGetValue(usernameNode), xmlNodeGetValue(passwordNode)
    else
        return false, false
    end
    xmlUnloadFile(xml_save_log_File)
end

----------------------------------------------------------------------------------------------------------------------------------------------

function saveLoginToXML(username, password)
    local xml_save_log_File = xmlLoadFile("gfx/xml/userdata.xml")
    if not xml_save_log_File then
        xml_save_log_File = xmlCreateFile("gfx/xml/userdata.xml", "login")
    end
    if (username ~= "") then
        local usernameNode = xmlFindChild(xml_save_log_File, "username", 0)
        if not usernameNode then
            usernameNode = xmlCreateChild(xml_save_log_File, "username")
        end
        xmlNodeSetValue(usernameNode, tostring(username))
    end
    if (password ~= "") then
        local passwordNode = xmlFindChild(xml_save_log_File, "password", 0)
        if not passwordNode then
            passwordNode = xmlCreateChild(xml_save_log_File, "password")
        end
        xmlNodeSetValue(passwordNode, tostring(password))
    end
    xmlSaveFile(xml_save_log_File)
    xmlUnloadFile(xml_save_log_File)
end
addEvent("saveLoginToXML", true)
addEventHandler("saveLoginToXML", getRootElement(), saveLoginToXML)

----------------------------------------------------------------------------------------------------------------------------------------------

function resetSaveXML()
    local xml_save_log_File = xmlLoadFile("gfx/xml/userdata.xml")
    if not xml_save_log_File then
        xml_save_log_File = xmlCreateFile("gfx/xml/userdata.xml", "login")
    end
    if (username ~= "") then
        local usernameNode = xmlFindChild(xml_save_log_File, "username", 0)
        if not usernameNode then
            usernameNode = xmlCreateChild(xml_save_log_File, "username")
        end
        xmlNodeSetValue(usernameNode, "")
    end
    if (password ~= "") then
        local passwordNode = xmlFindChild(xml_save_log_File, "password", 0)
        if not passwordNode then
            passwordNode = xmlCreateChild(xml_save_log_File, "password")
        end
        xmlNodeSetValue(passwordNode, "")
    end
    xmlSaveFile(xml_save_log_File)
    xmlUnloadFile(xml_save_log_File)
end
addEvent("resetSaveXML", true)
addEventHandler("resetSaveXML", getRootElement(), resetSaveXML)
