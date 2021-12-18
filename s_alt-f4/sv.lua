RegisterServerEvent('s_alt:sync',function(coords, pid)
    TriggerClientEvent('s_alt:sync', -1, coords, pid)
end)