local function InitMenu()
    SafeZone.Config.Menu._builderMenu = false
    SafeZone.Config.Menu.showMarkerZone = false
    SafeZone.Config.Menu.showBlipZone = false
    SafeZone.Config.Menu.mainCatIndex = 1
    SafeZone.Config.Menu.markerColors = 1
    SafeZone.Config.Menu.markerHeight = 1
    SafeZone.Config.Menu.markerHeightList = {}
    SafeZone.Config.Menu.radiusIndex = 1
    SafeZone.Config.Menu.coordsIndex = 1
    SafeZone.Config.Menu.blipsIndex = 1
    SafeZone.Config.Menu.blipsList = {}
    SafeZone.Config.Menu.ZoneCoords = nil

    local currentHeight = 1.0

    for i=1, 20 do
        table.insert(SafeZone.Config.Menu.markerHeightList, currentHeight)
        currentHeight = currentHeight + 1.0
    end

    for i=1, 85 do
        table.insert(SafeZone.Config.Menu.blipsList, i)
    end

    SafeZone.Config.Menu.Restrictions = {
        ["anti-weapon"] = false,
        ["anti-weaponwheel"] = false,
        ["anti-coups"] = false,
        ["anti-carkill"] = false,
    }
end

local function SafeZoneBuilderMenu()
    InitMenu()
    RMenu.Add("safe_zone_builder", "main_menu", RageUI.CreateMenu("SafeZone", "Builder"))
    RMenu:Get("safe_zone_builder", "main_menu").Closed = function()
        SafeZone.Config.Menu._builderMenu = false 
    end
    if _builderMenu then
        RageUI.CloseAll()
        SafeZone.Config.Menu._builderMenu = false
    else
        SafeZone.Config.Menu._builderMenu = true
        RageUI.Visible(RMenu:Get("safe_zone_builder", "main_menu"), true)
        Citizen.CreateThread(function()
            while SafeZone.Config.Menu._builderMenu do
                RageUI.IsVisible(RMenu:Get("safe_zone_builder", "main_menu"), function()
                    RageUI.List("Catégorie - SafeZone", {"Créer", "Liste"}, SafeZone.Config.Menu.mainCatIndex, nil, {}, true, {
                        onListChange = function(Index)
                            SafeZone.Config.Menu.mainCatIndex = Index
                        end,
                    })
                    if SafeZone.Config.Menu.mainCatIndex == 1 then
                        RageUI.Separator("Zone - Options")
                        RageUI.List("Coordonnées", {"Actuelle", "Personalisé"}, SafeZone.Config.Menu.coordsIndex, nil, {}, true, {
                            onListChange = function(Index)
                                SafeZone.Config.Menu.coordsIndex = Index
                            end,
                            onSelected = function()
                                if SafeZone.Config.Menu.coordsIndex == 1 then
                                    local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1)))
                                    SafeZone.Config.Menu.ZoneCoords = vector3(x, y, z - 1)
                                elseif SafeZone.Config.Menu.coordsIndex == 2 then
                                    local x = SafeZone.Functions.Keyboard("Position - X")
                                    local y = SafeZone.Functions.Keyboard("Position - Y")
                                    local z = SafeZone.Functions.Keyboard("Position - X")
                                    if tonumber(x) and tonumber(y) and tonumber(z) then
                                        SafeZone.Config.Menu.ZoneCoords = vector3(tonumber(x), tonumber(y), tonumber(z))
                                    else
                                        SafeZone.Functions.Notify("~r~Coordonnées non valide")
                                    end
                                end
                            end,
                        })
                        RageUI.List("Radius", SafeZone.Config.Menu.radiusList, SafeZone.Config.Menu.radiusIndex, nil, {}, true, {
                            onListChange = function(Index)
                                SafeZone.Config.Menu.radiusIndex = Index
                            end,
                        })
                        RageUI.Separator("Restrictions")
                        RageUI.Checkbox("Anti-Weapon", "Aucune arme dans la zone safe.", SafeZone.Config.Menu.Restrictions["anti-weapon"], {}, {
                            onChecked = function()
                                SafeZone.Config.Menu.Restrictions["anti-weapon"] = true
                            end,
                            onUnChecked = function()
                                SafeZone.Config.Menu.Restrictions["anti-weapon"] = false
                            end,
                        })
                        RageUI.Checkbox("Anti-WeaponWheel", "Désactive la roue des armes.", SafeZone.Config.Menu.Restrictions["anti-weaponwheel"], {}, {
                            onChecked = function()
                                SafeZone.Config.Menu.Restrictions["anti-weaponwheel"] = true
                            end,
                            onUnChecked = function()
                                SafeZone.Config.Menu.Restrictions["anti-weaponwheel"] = false
                            end,
                        })
                        RageUI.Checkbox("Anti-Coups", "Désactive les coups de poingts ect...", SafeZone.Config.Menu.Restrictions["anti-coups"], {}, {
                            onChecked = function()
                                SafeZone.Config.Menu.Restrictions["anti-coups"] = true
                            end,
                            onUnChecked = function()
                                SafeZone.Config.Menu.Restrictions["anti-coups"] = false
                            end,
                        })
                        RageUI.Checkbox("Anti-CarKill", "Active l'invicibilité.", SafeZone.Config.Menu.Restrictions["anti-carkill"], {}, {
                            onChecked = function()
                                SafeZone.Config.Menu.Restrictions["anti-carkill"] = true
                            end,
                            onUnChecked = function()
                                SafeZone.Config.Menu.Restrictions["anti-carkill"] = false
                            end,
                        })
                        RageUI.Separator("Marker")
                        RageUI.Checkbox("Afficher", nil, SafeZone.Config.Menu.showMarkerZone, {}, {
                            onChecked = function()
                                SafeZone.Config.Menu.showMarkerZone = true
                            end,
                            onUnChecked = function()
                                SafeZone.Config.Menu.showMarkerZone = false
                            end,
                        })
                        if SafeZone.Config.Menu.showMarkerZone then
                            RageUI.Separator("Marker - Options")
                            RageUI.List("Taille - Hauteur", SafeZone.Config.Menu.markerHeightList, SafeZone.Config.Menu.markerHeight, nil, {}, true, {
                                onListChange = function(Index)
                                    SafeZone.Config.Menu.markerHeight = Index
                                end,
                            })
                            RageUI.List("Couleur", SafeZone.Config.Menu.markerColorsList, SafeZone.Config.Menu.markerColors, nil, {}, true, {
                                onListChange = function(Index)
                                    SafeZone.Config.Menu.markerColors = Index
                                end,
                            })
                        end
                        RageUI.Separator("Blip")
                        RageUI.Checkbox("Afficher", nil, SafeZone.Config.Menu.showBlipZone, {}, {
                            onChecked = function()
                                SafeZone.Config.Menu.showBlipZone = true
                            end,
                            onUnChecked = function()
                                SafeZone.Config.Menu.showBlipZone = false
                            end,
                        })
                        if SafeZone.Config.Menu.showBlipZone then
                            RageUI.Separator("Blip - Options")
                            RageUI.List("Couleur", SafeZone.Config.Menu.blipsList, SafeZone.Config.Menu.blipsIndex, nil, {}, true, {
                                onListChange = function(Index)
                                    SafeZone.Config.Menu.blipsIndex = Index
                                end,
                            })
                        end
                        RageUI.Button("Confirmer et créer", SafeZone.Config.Menu.ZoneCoords == nil and "Paramètre incorrect : Coordonnées", {RightLabel = "→→"}, SafeZone.Config.Menu.ZoneCoords ~= nil, {
                            onSelected = function()
                                SafeZone.Functions.Notify("~g~Vous avez créer une nouvelle SafeZone")
                                TriggerServerEvent("Nehco:SafeZoneBuilder:Create", SafeZone.Config.Menu.ZoneCoords, SafeZone.Config.Menu.radiusList[SafeZone.Config.Menu.radiusIndex].radius, SafeZone.Config.Menu.Restrictions, SafeZone.Config.Menu.showMarkerZone, SafeZone.Config.Menu.markerHeightList[SafeZone.Config.Menu.markerHeight], SafeZone.Config.Menu.markerColorsList[SafeZone.Config.Menu.markerColors].rgba, SafeZone.Config.Menu.showBlipZone, SafeZone.Config.Menu.blipsIndex)
                                InitMenu()
                                RageUI.CloseAll()
                            end,
                        })
                    elseif SafeZone.Config.Menu.mainCatIndex == 2 then
                        for k,v in pairs(SafeZone.Zones) do
                            RageUI.Button("SafeZone N°~y~"..(v.id), nil, {RightLabel = "→ ~r~Supprimer~s~ →"}, true, {
                                onSelected = function()
                                    SafeZone.Functions.Notify("~r~Vous avez supprimé la SafeZone N°"..(v.id))
                                    TriggerServerEvent("Nehco:SafeZoneBuilder:Delete", v.id)
                                end,
                            })
                        end
                    end
                end)
                if SafeZone.Config.Menu.showMarkerZone and SafeZone.Config.Menu.ZoneCoords ~= nil then
                    local color = SafeZone.Config.Menu.markerColorsList[SafeZone.Config.Menu.markerColors].rgba
                    DrawMarker(1, SafeZone.Config.Menu.ZoneCoords, 0, 0, 0, 0, 0, 0, SafeZone.Config.Menu.radiusList[SafeZone.Config.Menu.radiusIndex].radius, SafeZone.Config.Menu.radiusList[SafeZone.Config.Menu.radiusIndex].radius, SafeZone.Config.Menu.markerHeightList[SafeZone.Config.Menu.markerHeight], color[1], color[2], color[3], color[4], 0, 0, 2, 0, 0, 0, 0)
                end
                Citizen.Wait(0)
            end
        end)
    end
end

RegisterCommand("safeZoneBuilder", function()
    local _group = false
    ESX.TriggerServerCallback("Nehco:SafeZoneBuilder:GetPlayerGroup", function(group)
        for k,v in pairs(SafeZone.Config.goupsAuthorizedMenu) do
            if group == v then
                _group = true
                break
            end
        end
        if _group then
            SafeZoneBuilderMenu()
        else
            SafeZone.Functions.Notify("~r~Vous n'avez pas accès à cette commande")
        end
    end)
end)