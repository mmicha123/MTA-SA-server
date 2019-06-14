function createTuningVehicle(thePlayer, vD, posrot)
    if(not vD.model or not thePlayer) then 
        return false
    end

    local vehicle = createVehicle()


end


--[[
    if(not i) then i = 6 end
    local color = fromJSON(dataV.color)
    local v = createVehicle(dataV.model, vSpawns[i][1], vSpawns[i][2], vSpawns[i][3], vSpawns[i][4], vSpawns[i][5], vSpawns[i][6])
    setVehicleColor(v, color[1], color[2], color[3], color[4], color[5], color[6])
    setVehiclePlateText(v, getPlayerName(thePlayer))

    ----TODO applay Tuning (addVehicleUpgrade) check for if tuning available
    --outputDebugString(toJSON(dataV))
    
    if(dataV.tuning ~= "nya") then
        outputDebugString(dataV.tuning)

        local tuning = fromJSON(dataV.tuning)

        for _, upgrade in pairs(tuning) do
            addVehicleUpgrade(v, upgrade)
        end
    end
    
    return v
]]