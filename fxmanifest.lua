-- FX Information
fx_version 'cerulean'
use_experimental_fxv2_oal 'yes'
lua54 'yes'
game 'gta5'

-- Resource Information
name 'mi_supportutils'
author 'MI_Agimir'
version '1.0.0'
repository 'https://github.com/MIAgimir/mi_supportutils'
description 'For support with streaming assets pertaining to M.I. Resources'

-- dependancies
dependencies {
    'ox_inventory',
    'ox_target'
}

-- Manifest
shared_scripts {
	'@ox_lib/init.lua',
    'shared/items.lua',
    'shared/config.lua',
}

client_scripts {
    '@ox_core/imports/client.lua',
    'client/aspects/**/*.lua',
    'client/utils/*.lua',
    'client/main.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    '@ox_core/imports/server.lua',
    'server/events.lua',
    'server/main.lua'
}