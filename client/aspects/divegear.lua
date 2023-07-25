local player = PlayerPedId()
local maskmodel, tankmodel = 
lib.requestModel('p_d_scuba_mask_s', 100), 
lib.requestModel('p_s_scuba_tank_s', 100)
local mask, tank
local equip = { mask = 0, tank = 0, used = false }

local systemon = function()
    while not HasModelLoaded(maskmodel)
    and not HasModelLoaded(tankmodel) do
        Citizen.Wait(10)
    end
    if not equip.used then
        if lib.progressBar({
            duration = 5000,
            label = 'Equipping Dive Gear',
            useWhileDead = false,
            canCancel = true,
            disable = {
                car = true,
                move = true,
            },
            anim = {
                dict = 'clothingshirt',
                clip = 'try_shirt_positive_d'
            },
        }) then
            tank = CreateObject(tankmodel, 1.0, 1.0, 1.0, true, true, false)
            local bone1 = GetPedBoneIndex(player, 24818)
            AttachEntityToEntity(tank, player, bone1, -0.25, -0.25, 0.0,
            180.0, 90.0, 0.0, true, true, false, false, 2, true)
            equip.tank = tank
    
            mask = CreateObject(maskmodel, 1.0, 1.0, 1.0, true, true, false)
            local bone2 = GetPedBoneIndex(player, 12844)
            AttachEntityToEntity(mask, player, bone2, 0.0, 0.0, 0.0,
            180.0, 90.0, 0.0, true, true, false, false, 2, true)
            equip.mask = mask
    
            SetEnableScuba(player, true)
            SetPedMaxTimeUnderwater(player, 150.00)
            equip.used = true
        end
    end
end

local systemoff = function()
    if equip.used then
        if lib.progressBar({
            duration = 5000,
            label = 'Removing Dive Gear',
            useWhileDead = false,
            canCancel = true,
            disable = {
                car = true,
                move = true,
            },
            anim = {
                dict = 'clothingshirt',
                clip = 'try_shirt_positive_d'
            },
        }) then
            DetachEntity(equip.tank, false, true)
            DeleteEntity(equip.tank)
            equip.tank = 0

            DetachEntity(equip.mask, false, true)
            DeleteEntity(equip.mask)
            equip.mask = 0

            SetEnableScuba(player, false)
            SetPedMaxTimeUnderwater(player, 20.00)
            equip.used = false
        end
    end
end

exports('divegear', function()
    if Item.divegear.restrict then
        if not equip.used then
            if IsPedSwimming(player) or IsPedSwimmingUnderWater(player) then
                lib.notify({
                    id = Ntfy.id,
                    title = 'You can\'t mess with your gear',
                    description = 'Get to land if you want to equip the diving gear',
                    position = Ntfy.pos,
                    style = {
                        backgroundColor = Ntfy.bgndclr,
                        color = Ntfy.txtclr,
                        ['.description'] = {
                          color = Ntfy.descclr
                        }
                    },
                    icon = 'ban',
                    iconColor = Ntfy.iconclr
                })
            else
                systemon()
            end
        elseif equip.used then
            if IsPedSwimming(player) or IsPedSwimmingUnderWater(player) then
                lib.notify({
                    id = Ntfy.id,
                    title = 'You can\'t mess with your gear',
                    description = 'Get to land if you want to remove the diving gear',
                    position = Ntfy.pos,
                    style = {
                        backgroundColor = Ntfy.bgndclr,
                        color = Ntfy.txtclr,
                        ['.description'] = {
                          color = Ntfy.descclr
                        }
                    },
                    icon = 'ban',
                    iconColor = Ntfy.iconclr
                })
            else
                systemoff()
            end
        else return end
    elseif not Item.divegear.restrict then
        if not equip.used then
            systemon()
        elseif equip.used then
            systemoff()
        end
    else return end
end)

