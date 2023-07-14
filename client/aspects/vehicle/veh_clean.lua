exports('kit_vclean', function()
    local player = PlayerPedId()
    local vehicle = lib.getClosestVehicle(GetEntityCoords(player), 3.0, false)

    if Item.vehicle.repair and vehicle then
        Citizen.Wait(500)
        if lib.progressBar({
            duration = Item.vehicle.cleantime,
            label = 'Cleaning Vehicle',
            useWhileDead = false,
            canCancel = true,
            disable = {
                car = true,
                move = true,
            },
            anim = {
                blendIn = 3.0,
                dict = 'amb@world_human_maid_clean@',
                clip = 'base',
                blendOut = 3.0,
            },
            prop = {
                bone = 28422,
                model = `prop_sponge_01`,
                pos = vec3(0.0, 0.0, -0.01),
                rot = vec3(90.0, 0.0, 0.0)
            },
        }) then 
            print('Do stuff when complete') 
            SetVehicleDirtLevel(vehicle, 0.0)
        else 
            print('Do stuff when cancelled') 
        end
    end
end)