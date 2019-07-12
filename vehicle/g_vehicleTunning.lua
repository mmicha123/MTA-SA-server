tuningParts = {
    [1] = "Color 1",
    [2] = "Color 2",
    [3] = "Color 3",
    [4] = "------",
    [5] = "Motor",
    [6] = "Turbo",
    [7] = "Tires",
    [8] = "Brakes",
    [9] = "Mass",
    [10] = "------",
    [11] = "Clean",
    [12] = "------"
}


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
        applyTuningPerformance(vehcile, "motor", per.motor, promium)
        applyTuningPerformance(vehcile, "turbo", per.turbo, promium)
        applyTuningPerformance(vehcile, "tires", per.tires, promium)
        applyTuningPerformance(vehcile, "brakes", per.brakes, promium)
        applyTuningPerformance(vehcile, "mass", per.mass, promium)
    end

    if(vD.optical ~= "nya") then
        local opt = fromJSON(vD.optical)
        for _, u in ipairs(opt.upgrades) do
            addVehicleUpgrade(vehicle, u)
        end
        
        if(opt.clean) then
            applyCleannes(vehicle)
        end
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
    elseif(cmd == "mass") then
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

function applyCleannes(vehicle)

end