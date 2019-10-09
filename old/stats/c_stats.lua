local updateInterval = 300000 --10000  300000

function init()
    oX,oY,oZ = getElementPosition(getLocalPlayer())
    distanceTraveled = 0
    weaponsFired = {[2] = 0, [3] = 0, [4] = 0, [5] = 0, [6] = 0,}
    updateLast = getTickCount()
    --triggerServerEvent("stats_updatePlayerVehicleStat", getLocalPlayer(), getLocalPlayer())
    --gLabel = guiCreateLabel(598,158,154,25,"Traveled: 0 km", false)  
end
addEventHandler("onClientResourceStart", getRootElement(), init)


--Distance Tracker
function monitoringV()
    if(getPedOccupiedVehicleSeat(getLocalPlayer()) == 0) then
		local x,y,z = getElementPosition(getLocalPlayer())
		distanceTraveled = distanceTraveled + getDistanceBetweenPoints3D(x,y,z,oX,oY,oZ)
		--guiSetText(gLabel,"Traveled: " .. math.floor(distanceTraveled) .. " km")
		oX = x
		oY = y
        oZ = z
    end
end
addEventHandler("onClientRender", getRootElement(), monitoringV)

---Weapon Tracker
function monitoringW(weapon, _, _, _, _, _, hitElement)

    if(source ~= getLocalPlayer()) then
        return
    end

    if(not isElement(hitElement)) then
        return
    end
    
    local hitType = getElementType(hitElement)
    if(hitType == "player" or hitType == "ped" or hitType == "vehicle") then
        if(hitType == "vehicle") then
            if(not getVehicleOccupant(hitElement)) then
                return
            end
        end
        local slot = getSlotFromWeapon(weapon)
        if(slot >= 2 and slot <= 6) then
            weaponsFired[slot] = weaponsFired[slot] + 1
        end
    end
end
addEventHandler("onClientPlayerWeaponFire", getRootElement(), monitoringW)


function sendPackage(force)
    if(((getTickCount() - updateLast) >= updateInterval) or force) then
        triggerServerEvent("stats_updatePlayerVehicleDist", getLocalPlayer(), getLocalPlayer(), math.floor(distanceTraveled))
        triggerServerEvent("stats_updatePlayerWeaponSkill", getLocalPlayer(), getLocalPlayer(), weaponsFired)
        distanceTraveled = 0
        weaponsFired = {[2] = 0, [3] = 0, [4] = 0, [5] = 0, [6] = 0}
        updateLast = getTickCount()
    end
end
addEventHandler("onClientRender", getRootElement(), sendPackage)

function savePlayerStats()
    sendPackage(true)
end
addEventHandler("onClientPlayerQuit", getRootElement(), savePlayerStats)

function fallOfBike(fall)
    setPedCanBeKnockedOffBike(getLocalPlayer(), fall)
end
addEvent("stats_fallOfBike", true)
addEventHandler("stats_fallOfBike", getRootElement(), fallOfBike)