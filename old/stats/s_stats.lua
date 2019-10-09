local maxTier = 10
local mulWeapon = 0.01

local weaponToStats = {
    [2] = {69, 70, 71}, 
    [3] = {72, 73, 74},
    [4] = {75, 76}, 
    [5] = {77, 78}, 
    [6] = {79}
}

---update evry 5min
---for max tier
---weapon hits with/without Promium :               50.000/100.000
---km travel with Vehicle with/without Promium :    5.000/10.000



-----Vehicle Stats-----

function updatePlayerVehicleStat(thePlayer, totalDist)

    if(not totalDist) then
        totalDist = tonumber(getElementData(thePlayer, "ssE.statVehicleDistance"))
        if(not totalDist) then
            totalDist = 1
        end
    end

    local tier = totalDist / 1000

    if(exports.account:isPromium(thePlayer)) then
       tier = tier * 2
    end

    if(tier >= maxTier) then 
        tier = 10
        triggerClientEvent(thePlayer, "stats_fallOfBike", getRootElement(), false)
    end

    setElementData(thePlayer, "ssE.statVehicleTier", tier)
end
addEvent("account_loggedIn", true)
addEventHandler("account_loggedIn", getRootElement(), updatePlayerVehicleStat)


function updatePlayerVehicleDist(thePlayer, amount)
    if(amount > 0 and amount <= 50000) then
        amount = amount / 1000
        local vehicleDistance = tonumber(getElementData(thePlayer, "ssE.statVehicleDistance"))
        if(vehicleDistance) then
            vehicleDistance = vehicleDistance + amount
            setElementData(thePlayer, "ssE.statVehicleDistance", vehicleDistance)
        else 
            setElementData(thePlayer, "ssE.statVehicleDistance", amount)
        end
        
        updatePlayerVehicleStat(thePlayer, vehicleDistance)
    end
end
addEvent("stats_updatePlayerVehicleDist", true)
addEventHandler("stats_updatePlayerVehicleDist", getRootElement(), updatePlayerVehicleDist)

function applyVstatBonus(thePlayer, seat, _)
    
    if(seat ~= 0) then 
        return 
    end

    local vHealth = getElementHealth(source)
    --outputChatBox(vHealth)

    if(vHealth <= 650 or vHealth > 1000 or getElementData(source, "ssE.statsVehicleApplied")) then 
        return
    end

    local tier = getElementData(thePlayer, "ssE.statVehicleTier")

    if(not tier or tier == 0) then
        return
    end

    local tmp = vHealth * (tier / 10)
    setElementHealth(source, vHealth + tmp)
    --outputChatBox(vHealth + tmp)
    setElementData(source, "ssE.statsVehicleApplied", true)

end
addEventHandler("onVehicleEnter", getRootElement(), applyVstatBonus)

function removeVstatBonus()
    if(getElementData(source, "ssE.statsVehicleApplied")) then
        setElementData(source, "ssE.statsVehicleApplied", false)
    end
end
addEventHandler("onVehicleExplode", getRootElement(), removeVstatBonus)

------Player Stats-----

function updatePlayerWeaponSkill(thePlayer, wList)

    if(exports.account:isPromium(thePlayer)) then
        mulWeapon = mulWeapon * 2
    end

    for i, _ in pairs(wList) do
        if(wList[i] > 0) then
            for _, stat in pairs(weaponToStats[i]) do
                local playerSkill = getPedStat(thePlayer, stat)
                --outputChatBox(stat.." has: "..playerSkill)
                if((playerSkill + wList[i] * mulWeapon) >= 1000) then
                    setPedStat(thePlayer, stat, 1000)
                else
                    setPedStat(thePlayer, stat, playerSkill + (wList[i] * mulWeapon))
                end
            end
        end
    end
    mulWeapon = 0.01
end
addEvent("stats_updatePlayerWeaponSkill", true)
addEventHandler("stats_updatePlayerWeaponSkill", getRootElement(), updatePlayerWeaponSkill)

------DEBUG---------

function showVstats(thePlayer)
    outputChatBox("statVehicleDistance "..getElementData(thePlayer, "ssE.statVehicleDistance"), thePlayer)
    outputChatBox("statVehicleTier "..getElementData(thePlayer, "ssE.statVehicleTier"), thePlayer)
    outputChatBox("isPromium "..tostring(exports.account:isPromium(thePlayer)), thePlayer)
end
addCommandHandler("showVstats", showVstats)


function setDist(thePlayer, cmd, amount)
    setElementData(thePlayer, "ssE.statVehicleDistance", amount)
    updatePlayerVehicleStat(thePlayer)
    showVstats(thePlayer)
end
addCommandHandler("setDist", setDist)


function showStats(thePlayer)
    outputChatBox("your AK skill "..getPedStat(thePlayer, 77), thePlayer)
    showVstats(thePlayer)
end
addCommandHandler("showStats", showStats)

