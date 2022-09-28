-- Nehco Safe Zone Builder - 5Dev : https://discord.gg/b2mzyESAYu

SafeZone = {}
SafeZone.Config = {
    ESXSharedObject = "esx:getSharedObject",
    goupsAuthorizedMenu = {"admin", "superadmin", "_dev"},
    notifyOnEnterInZone = true,
    notifyOnExitInZone = true,
    Menu = {
        markerColorsList = {
            {label = "Noir", rgba = {0, 0, 0, 200}},
            {label = "Rouge", rgba = {255, 0, 0, 200}},
            {label = "Blanc", rgba = {255, 255, 255, 200}},
            {label = "Jaune", rgba = {255, 200, 0, 200}},
        },
        radiusList = {
            {label = "5.0", radius = 10.0},
            {label = "10.0", radius = 10.0},
            {label = "15.0", radius = 15.0},
            {label = "20.0", radius = 20.0},
            {label = "25.0", radius = 25.0},
            {label = "30.0", radius = 30.0},
            {label = "40.0", radius = 40.0},
            {label = "50.0", radius = 50.0},
            {label = "60.0", radius = 60.0},
            {label = "70.0", radius = 70.0},
            {label = "80.0", radius = 80.0},
            {label = "100.0", radius = 100.0},
            {label = "125.0", radius = 125.0},
            {label = "150.0", radius = 150.0},
            {label = "175.0", radius = 175.0},
            {label = "200.0", radius = 200.0},
            {label = "250.0", radius = 250.0},
        },
    }
}
