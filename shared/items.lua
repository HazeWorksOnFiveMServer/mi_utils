Item = {}

Item.smoking = {
    time = 25000,   -- keep at least above 12000 to finish animation
    damage = true,  -- allow damage when done smoking
    dmgamt = 64     -- amount of damage divided by max health
}

Item.bombs = {
    -- time needed to arm bomb
    armtime = 15000,
    -- explosive bomb options
    expsmin = 1, -- minimum time allow for bomb timer
    expsmax = 5, -- maximum time allow for bomb timer

    -- gas bomb options
    gassdmg = true, -- true / false to determine if player takes damage in gas
    gassdmgamt = 0.6, -- amount subtracted
    gasstime = 10000,

    -- fire bomb options
    firetime = 30000
}

Item.vehicle = {
    -- vehicle repair
    repair = true, -- allow use of repair item
    repairtime = 25000, -- time of progress bar

    clean = true, -- allow use of cleaning item
    cleantime = 25000, -- time of progress bar
}