fx_version "adamant"
games {"gta5"}

client_scripts {
    "lib/RMenu.lua",
    "lib/menu/RageUI.lua",
    "lib/menu/Menu.lua",
    "lib/menu/MenuController.lua",
    "lib/components/*.lua",
    "lib/menu/elements/*.lua",
    "lib/menu/items/*.lua",
    "lib/menu/panels/*.lua",
    "lib/menu/windows/*.lua",
}

shared_scripts {
    "shared/*.lua"
}

client_scripts {
    "client/*.lua",
}

server_scripts {
    "@mysql-async/lib/MySQL.lua",
    "server/*.lua",
}