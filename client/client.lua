RegisterNetEvent("markcallsign:markPlayer", function(coords, callsign)
    SetNewWaypoint(coords.x, coords.y)
    TriggerEvent('QBCore:Notify', "Callsign '" .. callsign .. "' haritada işaretlendi!", "success")
end)
