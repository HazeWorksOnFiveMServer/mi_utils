exports('smokingcig', function()
    local maxHealth = GetEntityMaxHealth(cache.ped)
	local health = GetEntityHealth(cache.ped)
    if lib.progressBar({
        duration = Item.smoking.time,
        label = 'Smoking Cigarette',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
        },
        anim = {
            scenario = 'WORLD_HUMAN_SMOKING_CLUBHOUSE',
        },
    }) then
        if not Item.smoking.damage then return
        else
            SetEntityHealth(cache.ped, math.min(maxHealth, math.floor(health - maxHealth / Item.smoking.dmgamt)))
        end
    end
end)