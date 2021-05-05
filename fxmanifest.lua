fx_version 'cerulean'

game 'gta5'

lua54 'yes'

description 'Some utilites you can use for your server'

version '0.0.2'

client_scripts {
    'config.lua',
    'client/*.lua'
}

server_scripts {
    'server/callbacks_sv.lua',
}
