

---------VEHICLE DATABASE-----
dbC = nil

function init()
    dbC = dbConnect("sqlite", ":/vehicles.db")
    if(not dbC) then
        outputDebugString("can't connect to Vehicle DB", 1)
    end

    local qH = dbQuery(dbC, "SELECT name FROM sqlite_master WHERE type='table' AND name='t_vehicle';")

    if(qH) then 
        local testVehicleTable = dbPoll(qH, 5)
        if(not testVehicleTable[1]) then
            outputDebugString("creating t_vehicle", 3)
            dbExec(dbC, "CREATE TABLE t_vehicle(id_vehicle INTEGER PRIMARY KEY, id_owner INTEGER, id_tuning INTEGER, model INTEGER, color TEXT);")
        end
    end

    local qH = dbQuery(dbC, "SELECT name FROM sqlite_master WHERE type='table' AND name='t_tuning';")

    if(qH) then 
        local testTuningTable = dbPoll(qH, 5)
        if(not testTuningTable[1]) then
            outputDebugString("creating t_tuning", 3)
            dbExec(dbC, "CREATE TABLE t_tuning(id_tuning INTEGER PRIMARY KEY, tuning TEXT);")
        end
    end
end
addEventHandler("onResourceStart", resourceRoot, init)

---addVehicle(thePlayer, {model = model, color = toJSON{r,g,b}}) RETURN id_vehicle
function addVehicle(thePlayer, vehicle)
    if(thePlayer == nil or vehicle == nil) then return false end
    
    local acc = getPlayerAccount(thePlayer)
    if(not acc or isGuestAccount(acc)) then return false end

    local vpp = checkVehiclePerPlayer(getAccountID(acc))
    if(not vpp or vpp >= get("vPP")) then return false end

    local idTuning = addTuning()
    if(not idTuning) then return false end

    local qH = dbQuery(dbC, "INSERT INTO t_vehicle(id_owner, id_tuning, model, color) VALUES(?, ?, ?, ?);", getAccountID(acc), idTuning, vehicle.model, vehicle.color)
    
    local result, _, last_insert_id = dbPoll(qH, 10)
    if(result) then 
        return last_insert_id 
    else 
        dbFree(qH) 
    end
    
    return false
end

function addTuning()
    local qH = dbQuery(dbC, "INSERT INTO t_tuning(tuning) VALUES('nya')")
    local result, _, last_insert_id = dbPoll(qH, 10)
    if(result) then 
        return last_insert_id 
    else 
        dbFree(qH) 
    end
    return false
end

function updateVehicle(idVehicle, cmd, value)
    if not(idVehicle or cmd) then return false end
    if(cmd == "delete") then
        dbExec(dbC, "DELETE FROM t_tuning WHERE id_Vehicle = ?", idVehicle)
        return dbExec(dbC, "DELETE FROM t_vehicle WHERE id_Vehicle = ?", idVehicle)
    end

    if(not value) then return false end

    if(cmd == "model") then
        return dbExec(dbC, "UPDATE t_vehicle SET model = ? WHERE id_vehicle == ?", value, idVehicle)
    end
    if(cmd == "color") then
        return dbExec(dbC, "UPDATE t_vehicle SET color = ? WHERE id_vehicle == ?", value, idVehicle)
    end
end

---updateTuning(idVehicle, toJSON({upgrades})) RETURN if sucess
function updateTuning(idVehicle, tuning)
    if not(idVehicle or tuning) then return false end

    return dbExec(dbC, "UPDATE t_tuning SET tuning = ? WHERE id_vehicle == ?", value, idVehicle)
end

---vehicle RETURN vehicle/vehicles
function getVehicle(idVehicle)
    if(idVehicle) then
        local qH = dbQuery(dbC, "SELECT model, color, t_tuning.tuning FROM t_vehicle INNER JOIN t_tuning ON t_tuning.id_tuning = t_vehicle.id_tuning WHERE id_vehicle = ?", idVehicle)
        local result = dbPoll(qH, 10)
        if(result) then 
            return result
        else 
            dbFree(qH) 
        end
    else
        local qH = dbQuery(dbC, "SELECT model, color, t_tuning.tuning FROM t_vehicle INNER JOIN t_tuning ON t_tuning.id_tuning = t_vehicle.id_tuning")
        local result = dbPoll(qH, 10)
        if(result) then 
            return result
        else 
            dbFree(qH) 
        end
    end

    return false
end


function checkVehiclePerPlayer(id)
    if(not id) then return false end

    local qH = dbQuery(dbC, "SELECT Count(*) FROM t_vehicle WHERE id_owner ="..id)
    local count = dbPoll(qH, 10)
    if(not count) then 
        dbFree(qH) 
        return false 
    end

    return count[1]
end






















-----TEST-----
function testVehicle()
    local testVeh = createVehicle(596, 1205, -1363, 13.7, 0, 0, 0, "test")
    setVehicleHandling (testVeh, "maxVelocity", 185)
    setVehicleHandling (testVeh, "engineAcceleration", 11)
    setVehicleHandling (testVeh, "dragCoeff", 0.5)
    setVehicleHandling (testVeh, "tractionMultiplier", 0.5)
    setVehicleHandling (testVeh, "tractionLoss", 1.1)
    setVehicleHandling (testVeh, "mass", 2000)
    --setVehicleHandling (testVeh, "engineType", "electric")
    local testPed = createPed(100,  1210, -1363, 13.7)
    toggleVehicleRespawn(testVeh, true)
    setVehicleIdleRespawnDelay(testVeh, 4000)
    setVehicleRespawnPosition(testVeh, 1205, -1363, 13.7)

    setVehicleFuelTankExplodable(testVeh, true)
end
addEventHandler("onResourceStart", resourceRoot, testVehicle)
