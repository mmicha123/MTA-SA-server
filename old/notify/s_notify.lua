function notifyPlayer(player, title, sender, message, icon, flashing)
	triggerClientEvent(player, "notify_notifyPlayer", player, title, sender, message, icon, flashing)
end

function notifyGlobal(title, sender, message, icon, flashing)
	triggerClientEvent(getElementsByType( "player"), "notify_notifyPlayer", source, title, sender, message, icon, flashing)
end
