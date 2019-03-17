function login(player, username, password, save)
    if(username and password) then
        local account = getAccount(username, password)
        if(account ~= false) then
            logIn(player, account, password)
            exports.message:createMessage(player, "Login successful", 2, 2000)
            triggerClientEvent(player, "account_closeGUI", resourceRoot)
            
            if save == true then
                triggerClientEvent(player, "saveLoginToXML", getRootElement(), username, password)
            else
                triggerClientEvent(player, "resetSaveXML", getRootElement(), username, password)
            end
        else
            exports.message:createMessage(player, "username or password wrong", 1, 5000)
        end
    else
        exports.message:createMessage(player, "Please type your username and password", 2, 5000)
    end
end
addEvent("account_login", true)
addEventHandler("account_login", getRootElement(), login)

function register(player, username, password)
    if(username and password) then
        local account = addAccount(username, password, true)
        if(account) then
            exports.message:createMessage(player, "Register successful now login", 2, 2000)
            setAccountData(account, "ss.firstTime", "0")
        else
            exports.message:createMessage(player, "Register error", 1, 5000)
        end
    else
        exports.message:createMessage(player, "Please type your username and password", 2, 5000)
    end
end
addEvent("account_register", true)
addEventHandler("account_register", getRootElement(), register)


local spawn = {
    x = 1743,
    y = -1848,
    z = 13.7,
    rot = 270
}

function onLogin(_, acc)
    if not source then return end
    if(tonumber(getAccountData(acc, "ss.firstTime")) <= 0) then
        fadeCamera(source, true)
        triggerClientEvent(source, "account_showCharGUI", getRootElement())
        setAccountData(acc, "ss.firstTime", "1")
    else
        local data = loadPlayerBaseData(source, true)

        if(data) then
            setElementData(source, "ssE.team", data.team)

            spawnPlayer(source, data.x, data.y, data.z, data.rot, data.skin, data.inte, data.dim)
            setPlayerMoney(source, data.money, true)
            setPedArmor(source, data.armor)
            setElementHealth(source, data.health)
            setPlayerWantedLevel(source, data.wanted)
        else
            spawnPlayer(source, 0, 0, 5, 0, 1, 0, 0)
            exports.message:createMessage(source, "Error occurred in your data", 1, 2000)
        end
        local firstTime = tonumber(getAccountData(acc, "ss.firstTime")) + 1
        setAccountData(acc, "ss.firstTime", firstTime)

        fadeCamera(source, true)
        setCameraTarget(source, source)
        showChat(source, true)
    end

    triggerEvent("account_loggedIn", root, source)
end
addEventHandler("onPlayerLogin", getRootElement(), onLogin)

function createCharackter(thePlayer, model)
    spawnPlayer(source, spawn.x, spawn.y, spawn.z, spawn.rot, model, 0, 0)
    --setElementModel(thePlayer, model)
    savePlayerBaseData(source, false)
    triggerClientEvent(thePlayer, "account_closeCharGUI", getRootElement())
    setCameraTarget(thePlayer, thePlayer)
    fadeCamera(thePlayer, true)
end
addEvent("account_createCharackter", true)
addEventHandler("account_createCharackter", getRootElement(), createCharackter)


function onLeave()
    if not (source) then return end
    savePlayerBaseData(source, true)
end
addEventHandler("onPlayerQuit", getRootElement(), onLeave)
addEventHandler("onPlayerLogout", getRootElement(), onLeave)



function savePlayerBaseData(thePlayer, pos)
    local acc = getPlayerAccount(thePlayer)
    if(acc and not isGuestAccount(acc)) then

        ----Weapons and Ammo
        for i = 0, 12 do
            setAccountData(acc, "ss.weaponType"..tostring(i), getPedWeapon(thePlayer, i))
            setAccountData(acc, "ss.weaponAmmo"..tostring(i), getPedTotalAmmo(thePlayer, i))
        end

        ---Weapon Stats
        for i = 69, 79 do
            setAccountData(acc, "ss.weaponStat"..tostring(i), getPedStat(thePlayer, i))
        end

        ---Stats 
        setAccountData(acc, "ss.statVehicleDistance", getElementData(thePlayer, "ssE.statVehicleDistance"))

        --User Data
        if(pos) then
            local x,y,z = getElementPosition(thePlayer)
            setAccountData(acc, "ss.x", x)
            setAccountData(acc, "ss.y", y)
            setAccountData(acc, "ss.z", z)
            setAccountData(acc, "ss.rot", getPedRotation(thePlayer))
            setAccountData(acc, "ss.inte", getElementInterior(thePlayer))
            setAccountData(acc, "ss.dim", getElementDimension(thePlayer))
        end

        setAccountData(acc, "ss.skin", getElementModel(thePlayer))
        setElementData(thePlayer, "ssE.skin", getElementModel(thePlayer), false)
        setAccountData(acc, "ss.health", getElementHealth(thePlayer))
        setAccountData(acc, "ss.armor", getPedArmor(thePlayer))
        setAccountData(acc, "ss.money", getPlayerMoney(thePlayer))
        setAccountData(acc, "ss.wanted", getPlayerWantedLevel(thePlayer))

        local playerTeam = getPlayerTeam(thePlayer)
        if(playerTeam) then
            local playerTeamName = getTeamName(tmpTeam)
            if(playerTeamName == getElementData(thePlayer, "ss.team")) then
                setAccountData(acc, "ss.team", playerTeamName)
            end
        end
    end
end


function loadPlayerBaseData(thePlayer, userData)
    local data = {}
    local acc = getPlayerAccount(thePlayer)
    if(acc and not isGuestAccount(acc)) then

        setElementData(thePlayer, "ssE.accID", tonumber(getAccountID(acc)))

        ---vehicle Datat

        local vehicleID = getAccountData(acc, "ss.vehicleMain")
        if(vehicleID) then
            setElementData(thePlayer, "ssE.vehicleMain", tonumber(vehicleID))
        end

        ---Weapons and Ammo
        for i = 0, 12 do
            local weapon = getAccountData(acc, "ss.weaponType"..tostring(i))
            local ammo = getAccountData(acc, "ss.weaponAmmo"..tostring(i))
            
            if(weapon) then
                setElementData(thePlayer, "ssE.weapon"..tostring(i), weapon)
                if(ammo) then
                    giveWeapon(thePlayer, weapon, ammo)
                    setElementData(thePlayer, "ssE.ammo"..tostring(i), ammo)
                else
                    giveWeapon(thePlayer, weapon, 1)
                end
            end
        end

        ---Weapon Stats
        for i = 69, 79 do
            if(getAccountData(acc, "ss.weaponStat"..tostring(i))) then
                setPedStat(thePlayer, i, tonumber(getAccountData(acc, "ss.weaponStat"..tostring(i))))
            end
        end

        ---Stats
        local vehicleDistance = tonumber(getAccountData(acc, "ss.statVehicleDistance"))
        if(vehicleDistance) then
            setElementData(thePlayer, "ssE.statVehicleDistance", vehicleDistance)
        end
    
        --Promium
        setElementData(thePlayer, "ssE.promiumUser", isPromium(thePlayer))

        ---User Data
        if(userData) then
            data.x = tonumber(getAccountData(acc, "ss.x"))
            data.y = tonumber(getAccountData(acc, "ss.y"))
            data.z = tonumber(getAccountData(acc, "ss.z"))
            data.rot = tonumber(getAccountData(acc, "ss.rot"))
            data.inte = tonumber(getAccountData(acc, "ss.inte"))
            data.dim = tonumber(getAccountData(acc, "ss.dim"))

            data.skin = tonumber(getAccountData(acc, "ss.skin"))
            data.health = tonumber(getAccountData(acc, "ss.health"))
            data.armor = tonumber(getAccountData(acc, "ss.armor"))
            data.money = tonumber(getAccountData(acc, "ss.money"))
            data.wanted = tonumber(getAccountData(acc, "ss.wanted"))
            data.team = getAccountData(acc, "ss.team")
        end
    end

    return data
end


function savePlayerVehicleData(thePlayer, vehicleID)
    if(not vehicleID) then return false end
    local acc = getPlayerAccount(thePlayer)
    if(acc and not isGuestAccount(acc)) then
        setAccountData(acc, "ss.vehicleMain", vehicleID)
        return true
    else 
        return false
    end
end


-----------Promium-----------


function setPromium(thePlayer, command, nick)
    if(not isAdmin(thePlayer)) then return end
    local user = getPlayerFromName(nick)
    if(user) then
        local userStatus = isPromium(user)
        if(userStatus) then
            exports.message:createMessage(thePlayer, "Player is already PromiumUser", 3, 2000)
        else
            local acc = getPlayerAccount(user)
            if(acc and not isGuestAccount(acc)) then
                local tmp = setAccountData(acc, "ss.promiumUser", "benis")
                if(tmp) then
                    exports.message:createMessage(thePlayer, "Player has been set to PromiumUser", 2, 2000)
                    exports.message:createMessage(user, "You are now PromiumUser", 2, 4000)
                end
            end
            
        end
    end
   
end
addCommandHandler("setPromium", setPromium)

function removePromium(thePlayer, command, nick)
    if(not isAdmin(thePlayer)) then return end
    local user = getPlayerFromName(nick)
    if(user) then
        local acc = getPlayerAccount(user)
        if(acc and not isGuestAccount(acc)) then
            local tmp = setAccountData(acc, "ss.promiumUser", false)
            if(tmp) then
                exports.message:createMessage(thePlayer, "Player is no longer PromiumUser", 2, 2000)
                exports.message:createMessage(user, "You are not longer PromiumUser", 1, 4000)
            end
        end
    end
end
addCommandHandler("removePromium", removePromium)

function isPromium(thePlayer)
    local acc = getPlayerAccount(thePlayer)
    if(acc and not isGuestAccount(acc)) then
        local accPromiumUser = getAccountData(acc, "ss.promiumUser")
        if(accPromiumUser == "benis") then
            return true
        end
    end
    return false
end

function isAdmin(thePlayer)
    if(getElementType(thePlayer) == "console") then return true end
    local acc = getPlayerAccount(thePlayer)
    if(not isGuestAccount(acc) and isObjectInACLGroup("user."..getAccountName(acc), aclGetGroup("Admin"))) then
        return true
    end
    return false
end