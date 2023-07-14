-- explosive bomb - comparative size to gas pump explosion
exports('bomb_gass', function()
    local timer = false
    local defused = false
    local bomb, bombzone, gas, gaszone
    local model = lib.requestModel('tr_prop_tr_bag_bombs_01a')
    local crds = GetOffsetFromEntityInWorldCoords(cache.ped, 0.0, 0.6, 0.0)
    local objcrds = crds
    local head = GetEntityHeading(cache.ped)

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
            if Item.bombs.gassdmg then
                gaszone = lib.zones.sphere({
                    coords = vec3(crds.x, crds.y, crds.z-0.8),
                    radius = 5,
                    debug = Debug,
                    inside = function()
	                    local health = GetEntityHealth(cache.ped)
                        SetEntityHealth(cache.ped, health - Item.bombs.gassdmgamt)
                        Citizen.Wait(200) 
                    end
                })
            end
            if not defused then
                Citizen.Wait(500)
                local dict = "core"
                local particleName = "exp_grd_bzgas_smoke"
                
                RequestNamedPtfxAsset(dict)
                while not HasNamedPtfxAssetLoaded(dict) do
                    Citizen.Wait(0)
                end
                local a = 0
                while a < 1 do
                    UseParticleFxAssetNextCall(dict)
                    gas = StartParticleFxLoopedAtCoord(particleName, objcrds.x, objcrds.y, objcrds.z, 
                    head, 0.0, 0.0, 2.0, false, false, false, false)
                    a = a + 1
                    Citizen.Wait(Item.bombs.gasstime)
                end
                StopParticleFxLooped(gas, true)
                gaszone:remove()
                DeleteEntity(bomb)
                exports.ox_target:removeZone(bombzone)
            end
        end)
    end

    bombzone = exports.ox_target:addBoxZone({
        coords = vec3(objcrds.x, objcrds.y, objcrds.z-1),
        size = vec3(0.7, 0.5, 0.6),
        rotation = head,
        debug = Debug,
        options = {
            {
                name = 'disarmb1',
                icon = 'fa-solid fa-scissors',
                label = 'Disarm Bomb',
                onSelect = function()
                    defused = true
                    StopParticleFxLooped(gas, true)
                    gaszone:remove()
                    DeleteEntity(bomb)
                    exports.ox_target:removeZone(bombzone)
                end,
                canInteract = function(_, distance)
                    return distance < 2.0
                end
            }
        }
    })
end)