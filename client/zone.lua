local SafeZonesBlips = {}

local function CreateBlip(x, y, z, radius, color)
    local blip = AddBlipForRadius(tonumber(x), tonumber(y), tonumber(z), tonumber(radius)) 
    SetBlipColour(blip, tonumber(color))
    table.insert(SafeZonesBlips, blip)
end

AddEventHandler("Nehco:SafeZoneBuilder:OnRefreshBlips", function()
    for k,v in pairs(SafeZonesBlips) do
        RemoveBlip(v)
    end
    for k,v in pairs(SafeZone.Zones) do
        if tonumber(v.showBlip) == 1 then
            CreateBlip(v.coords.x, v.coords.y, v.coords.z, v.radius, v.blipColor)
        end
    end
end)

local Notified = false

local function GetClosestCoords()
    local _zone = nil
    local closetCoords = nil
    local pDist = 1000
    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), true))
    for _,v in pairs(SafeZone.Zones) do
        local _dist = Vdist(v.coords.x, v.coords.y, v.coords.z, x, y, z)
        if _dist <= pDist then
            pDist = _dist
            closetCoords = v
            _zone = v
        end
    end
    return _zone
end

Citizen.CreateThread(function()
    while true do
        local currentWait = 750
        local v = GetClosestCoords()
        if v ~= nil then
            if #(GetEntityCoords(GetPlayerPed(-1)) - vector3(tonumber(v.coords.x), tonumber(v.coords.y), tonumber(v.coords.z))) <= tonumber(v.radius) then
                currentWait = 0
                if not Notified then
                    if SafeZone.Config.notifyOnEnterInZone then
                        if v.restrictions["anti-coups"] then
                            NetworkSetFriendlyFireOption(false)
                        end
                        if v.restrictions["anti-weapon"] then
                            SetCurrentPedWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_UNARMED"), true)
                        end
                        ClearPlayerWantedLevel(PlayerId())
                        SafeZone.Functions.Notify("~g~Vous êtes dans une zone safe")
                    end
                    Notified = true 
                end
                if v.restrictions["anti-carkill"] then
                    SetEntityInvincible(GetPlayerPed(-1),true)
                end
                if v.restrictions["anti-weapon"] then
                    DisablePlayerFiring(GetPlayerPed(-1), true)
                end
                if v.restrictions["anti-weaponwheel"] then
                    DisableControlAction(2, 37, true)
                    if IsDisabledControlJustPressed(2, 37) then
                        SetCurrentPedWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_UNARMED"), true)
                        SafeZone.Functions.Notify("~r~Vous ne pouvez pas sortir d'arme dans la zone safe")
                    end
                end
                if v.restrictions["anti-coups"] then
                    DisableControlAction(0, 140, true)
                    DisableControlAction(0, 106, true)
                    if IsDisabledControlJustPressed(0, 106) or IsDisabledControlJustPressed(0, 140) then
                        SetCurrentPedWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_UNARMED"), true)
                        SafeZone.Functions.Notify("~r~Vous ne pouvez pas frapper dans la zone safe")
                    end
                end
            else
                if Notified then
                    if SafeZone.Config.notifyOnExitInZone then
                        if v.restrictions["anti-coups"] then
                            NetworkSetFriendlyFireOption(true)
                        end
                        SetEntityInvincible(GetPlayerPed(-1), false)
                        SafeZone.Functions.Notify("~r~Vous êtes sorti de la zone safe")
                    end
                    Notified = false
                end
            end
            if #(GetEntityCoords(GetPlayerPed(-1)) - vector3(tonumber(v.coords.x), tonumber(v.coords.y), tonumber(v.coords.z))) <= (tonumber(v.radius) + 10.0) then
                currentWait = 0
                if tonumber(v.showMarker) == 1 then
                    local color = v.markerColors
                    DrawMarker(1, vector3(tonumber(v.coords.x), tonumber(v.coords.y), tonumber(v.coords.z)), 0, 0, 0, 0, 0, 0, tonumber(v.radius), tonumber(v.radius), tonumber(v.markerHeight), color[1], color[2], color[3], color[4], 0, 0, 2, 0, 0, 0, 0)
                end
            end
        end
        Citizen.Wait(currentWait)
    end
end)
