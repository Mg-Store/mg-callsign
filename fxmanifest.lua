fx_version "adamant"

description "Mg Store | mg-callsign"
author "MG"
version "1.0.0"
lua54 "yes"
game "gta5"

shared_scripts {
    '@qb-core/shared/locale.lua',
    'locales/tr.lua',
    '@ox_lib/init.lua'
}

client_script {
    'client/client.lua'
}

server_script {
    'server/server.lua'
}
