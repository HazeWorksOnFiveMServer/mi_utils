-- server events for items
RegisterServerEvent('server:vault:open')
AddEventHandler('server:vault:open', function(choice)
    TriggerClientEvent('openvault', -1, choice)
end)