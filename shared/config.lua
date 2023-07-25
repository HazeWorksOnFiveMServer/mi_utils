-- config variables
CG = {}

-- disables vehicle radios
CG.radios = true

-- disables player idle cam
CG.idle = true

-- hides default hud components
CG.hud = true

-- reduces damage from melee weapons
CG.dmg = true

-- global variables
Debug = CG.debug
Target = exports.ox_target
Inventory = exports.ox_inventory

Ntfy = {
    id = 'notify',          -- don't worry about this
    pos ='top-right',       -- position of the notification
    bgndclr = '#76448A',    -- color of the background
    txtclr = '#ECF0F1',     -- color of the text
    descclr = '#F4D03F',    -- color of the description
    iconclr = '#F4D03F'     -- color of the icon
}
