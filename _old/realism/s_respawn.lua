local respawn = {
    x = 1178,
    y = -1323,
    z = 14.3,
    rot = 270,
    dim = 1,
    inte = 0
}

function onWaste(ammo, attacker, weapon, bodypart)
    fadeCamera(source, false, (get("respawnTimer")/1000 - 2))
    
    --save data
    exports.account:savePlayerBaseData(source, false)

    ---kill message
    local tempString = "suicide"
    if (attacker) then
        
		if (getElementType (attacker) == "player") then
			tempString = getPlayerName (attacker).." has killed you ("..getWeaponNameFromID(weapon)..")"
		elseif ( getElementType (attacker) == "vehicle") then
			tempString = getPlayerName(getVehicleController(attacker)).." has killed you ("..getWeaponNameFromID(weapon)..")"
		end

		if (bodypart == 9) then
			tempString = tempString.." (HEADSHOT!)"
		else
			tempString = tempString.." ("..getBodyPartName (bodypart)..")"
		end
		
    end
    exports.message:createMessage(source, tempString, 3, 5000)

    ---respawn timer
    setTimer(respawnPlayer, get("respawnTimer"), 1, source)
end
addEventHandler("onPlayerWasted", getRootElement(), onWaste)


function respawnPlayer(thePlayer)
    spawnPlayer(thePlayer, respawn.x + math.random(-3,3), respawn.y + math.random(-3,3), respawn.z, respawn.rot, 0, respawn.inte, respawn.dim )
    setElementDimension(thePlayer, 0)
    setCameraTarget(thePlayer, thePlayer)
    setElementFrozen(thePlayer, false)
    fadeCamera(thePlayer, true, 2.25)

    local skin = tonumber(getElementData(thePlayer, "ssE.skin"))
    if skin then
        setTimer(setElementModel, 100, 1, thePlayer, skin)
    end

end


addEventHandler("onPlayerSpawn", getRootElement(), function() 
    exports.account:loadPlayerBaseData(source, false)
end
);

