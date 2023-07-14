-- models
local player = PlayerPedId()
local table_prep = lib.requestModel('v_ret_ml_tableb', 100)
local table
local loaded = false
local crds

local function loadchemtable()
    loaded = true
    crds = GetOffsetFromEntityInWorldCoords(player, 0.0, 1.0, 0.0)
    table = CreateObject(table_prep, crds.x, crds.y, crds.z-1, true, false, false)
    SetEntityHeading(table, GetEntityHeading(player))
    PlaceObjectOnGroundProperly(table)
    FreezeEntityPosition(table, true)
    SetEntityCollision(table, true, true)
end

local function removechemtable()
    if lib.progressBar({
        duration = 2000,
        label = 'Breaking Down Table',
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
        DeleteEntity(table)
        loaded = false
    end
end

exports('drugtable_chemical', function()
    if loaded then
        print('you got that shit out already')
    else
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
            loadchemtable()
            local tableops = {
                {
                    label = 'Proceess: Chemical',
                    name = 'chemkit',
                    icon = 'fa-solid fa-flask',
                    canInteract = function(_, distance)
                        return distance < 1.5 
                    end,
                    onSelect = function()
                        print('do the drigs')
                        TriggerEvent('miut:chemkit:menu')
                        
                    end
                },

                {
                    label = 'Pack Up Table',
                    name = 'remkit',
                    icon = 'fa-solid fa-broom',
                    canInteract = function(_, distance)
                        return distance < 1.5 
                    end,
                    onSelect = function()
                        print('do the drigs')
                        removechemtable()
                    end
                },
            }
            exports.ox_target:addLocalEntity(table, tableops)
        end
    end
end)

RegisterNetEvent('miut:chemkit:menu')
AddEventHandler('miut:chemkit:menu', function()

    local input = lib.inputDialog(
    'Chemical Station', 
    {
        {type = 'slider', label = 'Cannabis: amount to process', required = true, min = 1, max = 5},
    })

    if lib.progressBar({
        duration = input[1] * 1000,
        label = 'Processing',
        useWhileDead = false,
        canCancel = true,
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
        print('Do stuff when complete')
    end
end)