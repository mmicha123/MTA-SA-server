function startup()
    local file = xmlLoadFile("xml/pns.xml")
    for k, v in ipairs(xmlNodeGetChildren(file)) do
        local pos = split(xmlNodeGetAttribute(v, "pos"), string.byte(","))
        local marker = createMarker(pos[1], pos[2], pos[3], "cylinder")
		local blip = createBlipAttachedTo(marker, 63, 2, 255, 0, 0, 255, 0, 250)
		setBlipVisibleDistance(blip, 250)
        setElementData(marker, "pnsMarker", true)
        setGarageOpen(tonumber(xmlNodeGetAttribute(v, "garage")), true)
    end
    xmlUnloadFile(file)
end
addEventHandler("onResourceStart", getResourceRootElement(), startup)

function payNSpray(hitElement)
    if (getElementData(source, "pnsMarker") == true) then
        if (getElementType(hitElement) == "vehicle") then
            if (getElementHealth(hitElement) < 1000) then
                if (getVehicleOccupant(hitElement)) then
                    local driver = getVehicleOccupant(hitElement)
                    local charge = math.floor(
                                       1000 - getElementHealth(hitElement))
                    if (getPlayerMoney(driver) >= charge) then
                        exports.message:createMessage(driver, "Vehicle repaired for $" .. charge .. ".", 2, 3000)
                        fixVehicle(hitElement)
                        takePlayerMoney(driver, charge)
                        for k, v in ipairs(
                                        {
                                "accelerate", "enter_exit", "handbrake"
                            }) do
                            toggleControl(driver, v, false)
                        end
                        setControlState(driver, "handbrake", true)
                        fadeCamera(driver, false, 1)
                        setTimer(restoreControl, 1000, 1, driver)
                    else
                        local extraCost =
                            math.floor(charge - getPlayerMoney(driver))
                            exports.message:createMessage(driver, "You need an additional $" .. extraCost .. " for a repair.", 1, 3000)
                    end
                end
            end
        end
    end
end
addEventHandler("onMarkerHit", getRootElement(), payNSpray)

function restoreControl(driver)
    for k, v in ipairs({"accelerate", "enter_exit", "handbrake"}) do
        toggleControl(driver, v, true)
    end
    setControlState(driver, "handbrake", false)
    fadeCamera(driver, true)
end
