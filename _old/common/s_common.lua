function isPlayerLogedIn(player)
    local account = getPlayerAccount(player)
    if not(isGuestAccount(account)) then
        return true
    end
    return false
end