-- explosive bomb - comparative size to gas pump explosion
local timer = false
local model = lib.requestModel('tr_prop_tr_bag_bombs_01a')
local crds = GetOffsetFromEntityInWorldCoords(cache.ped, 0.0, 0.6, 0.0)
local objcrds = crds
local head = GetEntityHeading(cache.ped)
local defused = false
local bomb

exports('bomb_fire', function()
    if lib.progressBar({
        duration = Item.bombs.armtime,
        label = 'Planting Bomb',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
        },
        anim = {
            scenario = 'CODE_HUMAN_MEDIC_TEND_TO_DEAD',
        },
    }) then

        bomb = CreateObject(model, crds.x, crds.y, crds.z, true, false, false)
        SetEntityHeading(bomb, head)
        PlaceObjectOnGroundProperly(bomb)
        FreezeEntityPosition(bomb, true)
        SetEntityCollision(bomb, true, true)
        SetEntityAsMissionEntity(bomb, true, true)

        local input = lib.inputDialog(
        'Set Bomb Timer', {{type = 'slider', label = 'Timer', required = true, min = 1, max = 5}})
        
        timer = true
        SetTimeout(input[1] * 10000, function()
            timer = false
            if not defused then
                Citizen.Wait(500)
                AddOwnedExplosion(cache.ped, objcrds.x, objcrds.y, objcrds.z-1, 0, 20.0, true, false, 0.2)
                StartScriptFire(objcrds.x, objcrds.y, objcrds.z-1, 20, false)
                DeleteEntity(bomb)
            end
        end)
        Citizen.Wait(Item.bombs.firetime)
        StopFireInRange(objcrds.x, objcrds.y, objcrds.z, 5)
    end
end)

