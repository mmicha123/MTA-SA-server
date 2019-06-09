--[[
#    give special car (424) 
#        limit speed and 
#        make user notice that he is tracked
#    track car not player!
#    track pos in nodes
#    every interval check for damage if damage delete all nodes
#        also and still in vehicle (or do not allow to exit vehicle until comand to stop tracking)
#        in not moved no need to save node (and bring players atention to do his job!!)
    if x or y is simular to oldX or oldY so normalize it

#    draw lines between last 10 saves to save on performance


    !!! i am tracking the way the player has followed in the nodes they are building something
]]--

--[[
    todo with data:
            search simular nodes no 
]]

local NODES = {}

local nodeIDcounter = 1
local nodesToDelete = 10
local nodeSaveInterval = 1000 -- in ms

local nodeUnloadInterval = 60000 -- every minute local

local vehicle = nil

local updateLast = 0

local debugShowLast = 10
local gLable = guiCreateLabel(910, 200, 154 , 100, "tracking movement", false)
guiSetVisible(gLable, false)

local vehicleDamage = false

function startTracking(v)
    if(not v) then
        return
    end

    vehicle = v
    NODES.pName = getPlayerName(getLocalPlayer())

    guiSetVisible(gLable, true)

    updateLast = getTickCount()

    addEventHandler("onClientVehicleDamage", getRootElement(), vehicleDamageHandler)
    addEventHandler("onClientRender", getRootElement(), trackVehicleMovement)
end
addEvent("trafficAI_startTracking", true)
addEventHandler("trafficAI_startTracking", root, startTracking)


function stopTracking(vehicle)
    removeEventHandler("onClientVehicleDamage", getRootElement(), vehicleDamageHandler)
    removeEventHandler("onClientRender", getRootElement(), trackVehicleMovement)
    guiSetVisible(gLable, false)
    outputChatBox("saveNodesToFile")
    saveNodesToFile()
end
addEvent("trafficAI_stopTracking", true)
addEventHandler("trafficAI_stopTracking", root, stopTracking)


function trackVehicleMovement()
    if(((getTickCount() - updateLast) >= nodeUnloadInterval)) then
        outputChatBox("saveNodesToFile")
        saveNodesToFile()
    end

    if(((getTickCount() - updateLast) >= nodeSaveInterval)) then
        --check for crash and same pos and other errors
        local NODE = {ID = 1, pos = {}, prevN = 0}
        local vP = {}

        vP.x, vP.y, vP.z = getElementPosition(vehicle)

        vP.z = math.floor(vP.z)
        
        
        if(nodeIDcounter >= 5) then
            --check if vehicle has moved
            local pN = NODES[nodeIDcounter - 1].prevN
            if(NODES[pN].pos.x == vP.x and NODES[pN].pos.y == vP.y) then
                updateLast = getTickCount()
                return
            end
        end

        --check for damage
        if(vehicleDamage) then
            exports.message:createMessage("Please don't crash while Tracking", 1, 4000)
            nodeIDcounter = nodeIDcounter - nodesToDelete
            updateLast = getTickCount()
            vehicleDamage = false
            return
        end

        NODE.ID = nodeIDcounter
        NODE.pos = vP
        NODE.prevN = nodeIDcounter - 1

        NODES[nodeIDcounter] = NODE

        nodeIDcounter = nodeIDcounter + 1
        updateLast = getTickCount()
    end

    --darw line DEBUG
    if(#NODES <= 2) then 
        return
    end

    local showPoints = 2

    if(#NODES > debugShowLast) then
        showPoints = #NODES - debugShowLast
    end

    for i = #NODES, showPoints, -1 do

        local prevI = NODES[i].prevN

        dxDrawLine3D(NODES[i].pos.x, NODES[i].pos.y, NODES[i].pos.z, NODES[prevI].pos.x, NODES[prevI].pos.y, NODES[prevI].pos.z, 0xFFFFFFFF, 2, false)
    end
end

function vehicleDamageHandler()
    vehicleDamage = true
end

function saveNodesToFile()
    local file = assert(fileCreate("trackdata_"..getTickCount()..".json"))
    fileWrite(file, toJSON(NODES))
    fileClose(file)

    NODES = {}
    nodeIDcounter = 1
end


--[[
            local prevID = NODES[nodeIDcounter - 1].prevN

            if(NODES[NODES[nodeIDcounter - 1].prevN].pos.x == vP.x and NODES[NODES[nodeIDcounter - 1].prevN].pos.y == vP.y) then
            outputChatBox("has not moved")
            updateLast = getTickCount()
            return
        end

                    for i = #NODES, #NODES - nodesToDelete, -1 do
                if(NODES[i] ~= nil) then
                    table.remove(NODES, i)
                end
            end

            setTimer(
        function()
            vehicleDamage = false
        end, nodeSaveInterval*2, 1)

        ------------
        --interpolation!
                    --check for simularities in nodes
            if(NODES[pN].pos.x - vP.x < 8 and NODES[pN].pos.x - vP.x >= 1) then
                vP.x = (NODES[pN].pos.x + vP.x) / 2
                outputChatBox("x mod "..vP.x)
            end

            if(NODES[pN].pos.y - vP.y < 8 and NODES[pN].pos.y - vP.y >= 1) then
                vP.y = (NODES[pN].pos.y + vP.y) / 2
                outputChatBox("y mod "..vP.y)
            end
]]