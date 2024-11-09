fx_version 'cerulean'
game 'gta5'

author 'Lonf'
description 'Cemetery Robbery'


shared_scripts {
    'config.lua',
    '@ox_lib/init.lua',
    '@qbx_core/modules/lib.lua',
}

server_scripts {
    'server/server.lua',
}

client_scripts {
    'client/client.lua',
    'client/store.lua'
}

lua54 'yes'
