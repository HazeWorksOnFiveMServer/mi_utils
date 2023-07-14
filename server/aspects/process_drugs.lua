
-- processing chemicals
RegisterNetEvent('miut:chemicals:process')
AddEventHandler('miut:chemicals:process', function(input)
    local total = Inventory:GetItem(source, 'bank_bag', input)
    if not total then
        Inventory:RemoveItem(source, 'bank_bag', input)
    end
end)
