function createTuningVehicle(thePlayer, vD)
    
    if(vD == nil or not thePlayer) then
        outputDebugString("no vehicle Data")
        return false
    end

    local vehicle = createVehicle(vD.model, 2472, -1785, 14, 0, 0, 0, getPlayerName(thePlayer))

    local color = fromJSON(vD.color)
    setVehicleColor(vehicle, color[1], color[2], color[3], color[4], color[5], color[6], color[7], color[8], color[9])

    local promium = getElementData(thePlayer, "ssE.promiumUser")

    if(vD.performance ~= "nya") then
        local per = fromJSON(vD.performance)
        applyTuningPerformance(vehcile, "motor", per[1], promium)
        applyTuningPerformance(vehcile, "turbo", per[2], promium)
        applyTuningPerformance(vehcile, "brakes", per[3], promium)
        applyTuningPerformance(vehcile, "weight", per[4], promium)
    end

    if(vD.optical ~= "nya") then
        local opt = fromJSON(vD.optical)
        applyTuningPerformance(vehcile, "clean", opt[17])
    end

    return vehicle
end

function applyTuningPerformance(vehicle, cmd, data, promium)
    if(not (vehicle or cmd or data)) then
        return 
    end

    local model = getElementModel(vehicle)

    if(cmd == "motor") then
        local maxVelocityO = getOriginalHandling(vehicle)["maxVelocity"]
        setVehicleHandling(vehicle, "maxVelocity", maxVelocityO)

        local engineAccelerationO = getOriginalHandling(vehicle)["engineAcceleration"]
        setVehicleHandling(vehicle, "engineAcceleration", maxVelocityO)

        if(data == 1) then
            setVehicleHandling(vehicle, "maxVelocity", maxVelocityO + 10)
            setVehicleHandling(vehicle, "engineAcceleration", engineAccelerationO + 2)
        elseif(data == 2) then
            setVehicleHandling(vehicle, "maxVelocity", maxVelocityO + 20)
            setVehicleHandling(vehicle, "engineAcceleration", engineAccelerationO + 6)
        elseif(data == 3 and promium) then
            setVehicleHandling(vehicle, "maxVelocity", maxVelocityO + 30)
            setVehicleHandling(vehicle, "engineAcceleration", engineAccelerationO + 8)
        end

        return true
    elseif(cmd == "turbo") then
        local engineInertiaO = getOriginalHandling(vehicle)["engineInertia"]
        setVehicleHandling(vehicle, "engineInertia", engineInertiaO)

        if(data == 1) then
            setVehicleHandling(vehicle, "engineInertia", engineInertiaO - 10)
        elseif(data == 2) then
            setVehicleHandling(vehicle, "engineInertia", engineInertiaO - 20)
        elseif(data == 3 and promium) then
            setVehicleHandling(vehicle, "engineInertia", engineInertiaO - 30)
        end

        return true
    elseif(cmd == "tires") then
        local tractionMultiplierO = getOriginalHandling(vehicle)["tractionMultiplier"]
        setVehicleHandling(vehicle, "tractionMultiplier", tractionMultiplierO)

        local tractionLossO = getOriginalHandling(vehicle)["tractionLoss"]
        setVehicleHandling(vehicle, "tractionLoss", tractionLossO)

        if(data == 1) then
            setVehicleHandling(vehicle, "tractionMultiplier", tractionMultiplierO + 0.05)
            setVehicleHandling(vehicle, "tractionLoss", tractionLossO + 0.02)
        elseif(data == 2) then
            setVehicleHandling(vehicle, "tractionMultiplier", tractionMultiplierO + 0.1)
            setVehicleHandling(vehicle, "tractionLoss", tractionLossO + 0.03)
        elseif(data == 3 and promium) then
            setVehicleHandling(vehicle, "tractionMultiplier", tractionMultiplierO + 0.15)
            setVehicleHandling(vehicle, "tractionLoss", tractionLossO + 0.04)
        end

        return true
    elseif(cmd == "brakes") then
        local brakeDecelerationO = getOriginalHandling(vehicle)["brakeDeceleration"]
        setVehicleHandling(vehicle, "brakeDeceleration", brakeDecelerationO)

        local brakeBiasO = getOriginalHandling(vehicle)["brakeBias"]
        setVehicleHandling(vehicle, "brakeBias", brakeBiasO)

        if(data == 1) then
            setVehicleHandling(vehicle, "brakeDeceleration", brakeDecelerationO + 0.05)
            setVehicleHandling(vehicle, "brakeBias", brakeBiasO + 0.1)
        elseif(data == 2) then
            setVehicleHandling(vehicle, "brakeDeceleration", brakeDecelerationO + 0.1)
            setVehicleHandling(vehicle, "brakeBias", brakeBiasO + 0.175)
        elseif(data == 3 and promium) then
            setVehicleHandling(vehicle, "brakeDeceleration", brakeDecelerationO + 0.15)
            setVehicleHandling(vehicle, "brakeBias", brakeBiasO + 0.25)
        end

        return true
    elseif(cmd == "weight") then
        local massO = getOriginalHandling(vehicle)["mass"]
        setVehicleHandling(vehicle, "mass", massO)

        if(data == 1) then
            setVehicleHandling(vehicle, "mass", massO - 100)
        elseif(data == 2) then
            setVehicleHandling(vehicle, "mass", massO - 200)
        elseif(data == 3 and promium) then
            setVehicleHandling(vehicle, "mass", massO - 300)
        end
        return true
    end

    return false

end

function applyTuningOptical(vehicle, cmd, data)
    if(not (vehicle or cmd or data)) then
        return 
    end

    if(cmd == "clean") then

    else 

    end
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


    {2472,-1785, 14, 0, 0, 0}


    -----
    "ssE.promiumUser" == ture or false
]]