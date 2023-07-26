-- reference
RegisterServerEvent('miutil:item:give')
AddEventHandler('miutil:item:give', function(source, item, amount)
    Inventory:AddItem(source, item, amount)
end)

