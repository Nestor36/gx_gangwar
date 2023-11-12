--[[
 _____              ______  _      
|  __ \             |  ___|(_)     
| |  \/ _   _ __  __| |_    _  ____
| | __ | | | |\ \/ /|  _|  | ||_  /
| |_\ \| |_| | >  < | |    | | / / 
 \____/ \__,_|/_/\_\\_|    |_|/___|
]]

name 'gux_gangwar'
author 'Discord: GuxFiz'
description 'gx_gangwar'

fx_version 'cerulean'
game 'gta5'
version '0.1'

lua54 'yes'


shared_scripts {
	'@ox_lib/init.lua',
	'options.lua'
}

client_scripts {
	'src/client.lua',
	'src/functions.lua',
	'src/context.lua'
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'src/server.lua'
}

dependencies {
	'oxmysql',
	'ox_lib',
	'ox_inventory'
}

escrow_ignore {
	'options.lua'
}


-- 🐧