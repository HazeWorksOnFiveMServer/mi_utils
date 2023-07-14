
--[[
    if raccoons not eatingtrash then return
    else
        local title, desc, icon = 'TEST NOTIFICATION', 'If you got this then it works', 'globe'
        Support:misnotify(Ntfy.id, title, desc, Ntfy.pos,
        Ntfy.bgndclr, Ntfy.txtclr, Ntfy.descclr, icon, Ntfy.iconclr)
    end
]]