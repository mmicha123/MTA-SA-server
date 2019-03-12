local screenWidth, screenHeight = guiGetScreenSize()
local messageWidth, messageHeight = 300, 80
local messages = {}
local id = 1


local types = {
    [0] = "0xffffffff",   --default
    [1] = "0xffff2828",   --error
    [2] = "0xff28ff28",   --success
    [3] = "0xffffff00"    --hint
}

function createMessage(message, type, tts)
    local scale = 2.0
    if(string.len(message) > 20) then 
        scale = (string.len(message)/100 + 1) 
    end

    local msg = {id=id, message = message, color = types[type], scale = scale}
    table.insert(messages, msg)
    setTimer(destroyMessage, tts or 5000, 1, msg, id)
    
    id = id + 1
end
addEvent("message_create", true)
addEventHandler("message_create", getRootElement(), createMessage)

function destroyMessage(msg, id)
    local index = exports.common:tfind(messages, msg, id)
    if(index) then
        table.remove(messages, index)
    end
end

function renderMessage()
    for i, m in ipairs(messages) do
        local startX = 50
        local startY = (screenHeight - screenHeight / 2.6) - (i - 1) * (messageHeight + 2)

        dxDrawRectangle(startX, startY, messageWidth, messageHeight, tocolor(50, 50, 50, 100))
        dxDrawText(m.message, startX+5, startY+5, startX+messageWidth-5, startY+messageHeight-5, m.color, 
            m.scale, "arial", "center", "center", true, true, true)
    end
end
addEventHandler("onClientRender", getRootElement(), renderMessage)
