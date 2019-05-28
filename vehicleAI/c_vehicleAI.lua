--[[
    give special car (424) 
        limit speed and 
        make user notice that he is tracked
    track car not player!
    track pos in nodes
    every interval check for damage if damage delete all nodes
        also and still in vehicle (or do not allow to exit vehicle until comand to stop tracking)
        in not moved no need to save node (and bring players atention to do his job!!)
    if x or y is simular to oldX or oldY so normalize it

    draw lines between last 10 saves to save on performance


    !!! i am tracking the way the player has followed in the nodes they are building something
]]--

--[[
    todo with data:
            search simular nodes no 
]]



local updateInterval = 500
local uploadInterval = 5000


local pos = {}

function init()
    updateLast = getTickCount()
    gLabel = guiCreateLabel(598, 158, 154 , 25, "tracking movement", false)
    --setVehicleHandling(theVehicle, "maxVelocity", 40)
end
addEventHandler("onClientResourceStart", getRootElement(), init)



function trackVehicleMovement()
    local theVehicle = getPedOccupiedVehicle(getLocalPlayer())
    if( not theVehicle) then
        return
    end

    if(((getTickCount() - updateLast) >= updateInterval)) then
        
        calcSpeed(theVehicle)
        local x, y, z = getElementPosition(getLocalPlayer())
        local test = {x, y, z}
        table.insert(pos, test)

        --outputChatBox(pos[#pos][1])
        updateLast = getTickCount()
    end


    --debug draw lines
    local oX, oY, oZ = 0, 0, 0

    for _, p in pairs(pos) do 
        dxDrawLine3D(oX, oY, oZ, p[1], p[2], p[3], 0xFFFFFFFF, 2, false)
        oX, oY, oZ = p[1], p[2], p[3]
    end

end
addEventHandler("onClientRender", getRootElement(), trackVehicleMovement)

function calcSpeed(theVehicle)
    local speedx, speedy, speedz = getElementVelocity(theVehicle)
    local actualSpeed = (speedx^2 + speedy^2 + speedz^2) ^ (0.5) * 100 * 1.609344
    outputChatBox(actualSpeed)
    return actualSpeed
end