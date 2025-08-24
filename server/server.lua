local QBCore = exports['qb-core']:GetCoreObject()

RegisterCommand("işaretle", function(source, args)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)

    if xPlayer.PlayerData.job.name ~= "police" then
        TriggerClientEvent('ox_lib:notify', src, {
            description = Lang:t('notify.job'),
            type = 'error'
        })
        return
    end

    if not args[1] then
        TriggerClientEvent('ox_lib:notify', src, {
            description = Lang:t('notify.detail'),
            type = 'error'
        })
        return
    end

    local targetCallsign = args[1]
    local foundPlayer = nil

    for _, playerId in pairs(QBCore.Functions.GetPlayers()) do
        local player = QBCore.Functions.GetPlayer(tonumber(playerId))
        if player then
            local metadata = player.PlayerData.metadata
            if metadata and metadata["callsign"] and metadata["callsign"] == targetCallsign then
                foundPlayer = tonumber(playerId)
                break
            end
        end
    end

    if foundPlayer then
        TriggerClientEvent("markcallsign:markPlayer", src, GetEntityCoords(GetPlayerPed(foundPlayer)), targetCallsign)
    else
        TriggerClientEvent('ox_lib:notify', src, {
            description = Lang:t('notify.notfound'),
            type = 'error'
        })
    end
end)

local CurrentVersion = GetResourceMetadata(GetCurrentResourceName(), "version", 0) or "v1.0.0"
local expectedResourceName = "mg-callsign"

if GetCurrentResourceName() ~= expectedResourceName then
    print("^1Please do not change the folder name ! '" .. expectedResourceName .. "' ")
end

local function checkVersion()
    PerformHttpRequest("https://api.github.com/repos/Mg-Store/mg-callsign/releases/latest", function(statusCode, response)
        local NewVersion = statusCode == 200 and json.decode(response).tag_name or nil
        if NewVersion and CurrentVersion ~= NewVersion then
            print("^1#########################################")
            print("^3[" .. expectedResourceName .. "] - New update available now!")
            print("^7Current version: ^1" .. CurrentVersion)
            print("^7New version: ^2" .. NewVersion)
            print("^3Download it now on the github: https://github.com/Mg-Store/mg-callsign/releases")
            print("^1#########################################")
        else
            print("^2Your script has the latest version.")
        end
    end, "GET", "", {["User-Agent"] = "FiveM-server"})
end

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        checkVersion()
    end
end)