print("(Loaded) Quantum Super Broadcast (QSB) Script - Global Warning Mode")

local Roles = { ROLE_DEVELOPER = 51 }

registerLuaCommand({
    command = "qsb",
    roleRequired = Roles.ROLE_DEVELOPER,
    description = "Send a Quantum Super Broadcast to all players."
})

onPlayerCommandCallback(function(world, player, fullCommand)
    local command, message = fullCommand:match("^(%S+)%s*(.*)")
    if command ~= "asb" then return false end

    if not player:hasRole(Roles.ROLE_DEVELOPER) then
        player:onConsoleMessage("`4Unknown command. `oEnter /? for a list of valid commands.")
        return true
    end

    if not message or message == "" then
        player:onConsoleMessage("`oUsage: /qsb <`$message``>")
        return true
    end

    player:onConsoleMessage("`cQuantum - Broadcast [`wFrom "..player:getName().."`c]: `^"..message)

    local count = 0
    for _, p in ipairs(getServerPlayers()) do
        p:sendVariant({
            "OnAddNotification",
            "interface/science_button.rttex",
            "[`c"..player:getName().."`o]\n`^"..message,
            "audio/hub_open.wav",
            0
        })
        count = count + 1
    end

    player:onConsoleMessage("`2Quantum message transmitted to `w"..count.."`2 players through entangled channels.")
    print("[QSB] Quantum Super Broadcast by "..player:getName().." → "..count.." players: "..message)

    return true

end)
