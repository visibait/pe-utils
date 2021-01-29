fx_version 'cerulean'

game 'gta5'

lua54 'yes'

description 'Some utilites you can use for your server'

version '0.0.2'

client_scripts {
    'client/discord_cl.lua',
    'client/menu_cl.lua',
    'client/ped_cl.lua',
    'config.lua',
}

server_scripts {
    'server/callbacks_sv.lua',
}
