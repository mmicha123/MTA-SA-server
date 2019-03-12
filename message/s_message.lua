function createMessage(player, message, type, tts)
    triggerClientEvent(player, "message_create", player, message, type, tts)
end

function createMessageGlobal(message, type, tts)
    for _, p in ipairs(getElementsByType( "player")) do
        createMessage(p, message, type, tts)
    end
end