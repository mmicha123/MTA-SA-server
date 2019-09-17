function notifyPlayer(player, title, sender, message, icon, flashing)
	triggerClientEvent(player, "notify_notifyPlayer", player, title, sender, message, icon, flashing)
end

function notifyGlobal(title, sender, message, icon, flashing)
	triggerClientEvent(getElementsByType( "player"), "notify_notifyPlayer", title, sender, message, icon, flashing)
end


function start(thePlayer)
	setPlayerWantedLevel(thePlayer, 5)
end
addEvent("account_loggedIn", true)
addEventHandler("account_loggedIn", getRootElement(), start)



addCommandHandler("notify", function(thePlayer, _,color)
	notifyPlayer(thePlayer, "Title test", getPlayerName(thePlayer), "message Test", tonumber(color), false)
end)