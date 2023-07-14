-- models
local player = PlayerPedId()
local table_prep = lib.requestModel('v_ret_ml_tableb')
local table_weed = lib.requestModel('bkr_prop_weed_table_01a')
local table_meth = lib.requestModel('bkr_prop_meth_table01a')
local table_coke = lib.requestModel('bkr_prop_coke_table01a')
local table_empty = lib.requestModel('bkr_prop_weed_table_01b')
local table, kit
local kitload = false
local crds = GetOffsetFromEntityInWorldCoords(cache.ped, 0.0, 1.0, 0.0)
local objcrds = crds

exports('drugtable_empty', function()
    if lib.progressBar({
        duration = 2000,
        label = 'Setting Up Table',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
            move = true,
        },
        anim = {
            scenario = 'CODE_HUMAN_MEDIC_TEND_TO_DEAD',
        },
    }) then 
        print('Do stuff when complete') 
        table = CreateObject(table_empty, crds.x, crds.y, crds.z-1, true, false, false)
        SetEntityHeading(table, GetEntityHeading(cache.ped))
        PlaceObjectOnGroundProperly(table)
        FreezeEntityPosition(table, true)
        SetEntityCollision(table, true, true)
        SetEntityAsMissionEntity(table, true, true)

        local tableops = {
            {
                label = 'Load Chemical Kit',
                name = 'chemkit',
                icon = 'fa-solid fa-flask',
                canInteract = function(_, distance)
                    return distance < 1.5 and not kitload
                end,
                onSelect = function()
                    TriggerEvent('drugtable_drugkit_chem')
                end
            },
            {
                label = 'Load Weed Kit',
                name = 'weedkit',
                icon = 'fa-solid fa-cannabis',
                canInteract = function(_, distance)
                    return distance < 1.5 and not kitload
                end,
                onSelect = function()

                end
            },
            {
                label = 'Load Meth Kit',
                name = 'methkit',
                icon = 'fa-solid fa-bong',
                canInteract = function(_, distance)
                    return distance < 1.5 and not kitload
                end,
                onSelect = function()

                end
            },
            {
                label = 'Load Coke Kit',
                name = 'cokekit',
                icon = 'fa-solid fa-leaf',
                canInteract = function(_, distance)
                    return distance < 1.5 and not kitload
                end,
                onSelect = function()

                end
            },
            {
                label = 'Empty Table',
                name = 'emptykit',
                icon = 'fa-solid fa-broom',
                canInteract = function(_, distance)
                    return distance < 1.5 and kitload
                end,
                onSelect = function()

                end
            },
        }
        exports.ox_target:addLocalEntity(table, tableops)
    end
end)

AddEventHandler('drugtable_drugkit_empty', function()
    if lib.progressBar({
        duration = 2000,
        label = 'Clearing Table',
        useWhileDead = false,
        canCancel = false,
        disable = {
            car = true,
            move = true,
        },
        anim = {
            blendIn = 3.0,
            dict = 'mini@repair',
            clip = 'fixing_a_player',
            blendOut = 3.0,
        },
    }) then 
        print('yee')
    end
end)

AddEventHandler('drugtable_drugkit_chem', function()
    if lib.progressBar({
        duration = 2000,
        label = 'Setting Up Kit',
        useWhileDead = false,
        canCancel = false,
        disable = {
            car = true,
            move = true,
        },
        anim = {
            blendIn = 3.0,
            dict = 'mini@repair',
            clip = 'fixing_a_player',
            blendOut = 3.0,
        },
    }) then 
        DeleteEntity(table)
        kit = CreateObject(table_prep, objcrds.x, objcrds.y, objcrds.z-1, true, false, false)
        SetEntityHeading(kit, GetEntityHeading(cache.ped))
        PlaceObjectOnGroundProperly(kit)
        FreezeEntityPosition(kit, true)
        SetEntityCollision(kit, true, true)
        SetEntityAsMissionEntity(kit, true, true)
    end
end)

AddEventHandler('drugtable_drugkit_weed', function()
    if lib.progressBar({
        duration = 2000,
        label = 'Setting Up Kit',
        useWhileDead = false,
        canCancel = false,
        disable = {
            car = true,
            move = true,
        },
        anim = {
            blendIn = 3.0,
            dict = 'mini@repair',
            clip = 'fixing_a_player',
            blendOut = 3.0,
        },
    }) then 
        print('yee')
    end
end)

AddEventHandler('drugtable_drugkit_coke', function()
    if lib.progressBar({
        duration = 2000,
        label = 'Setting Up Kit',
        useWhileDead = false,
        canCancel = false,
        disable = {
            car = true,
            move = true,
        },
        anim = {
            blendIn = 3.0,
            dict = 'mini@repair',
            clip = 'fixing_a_player',
            blendOut = 3.0,
        },
    }) then 
        print('yee')
    end
end)

AddEventHandler('drugtable_drugkit_meth', function()
    if lib.progressBar({
        duration = 2000,
        label = 'Setting Up Kit',
        useWhileDead = false,
        canCancel = false,
        disable = {
            car = true,
            move = true,
        },
        anim = {
            blendIn = 3.0,
            dict = 'mini@repair',
            clip = 'fixing_a_player',
            blendOut = 3.0,
        },
    }) then 
        print('yee')
    end
end)