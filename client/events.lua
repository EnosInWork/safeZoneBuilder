SafeZone.Zones = {}

RegisterNetEvent("Nehco:SafeZoneBuilder:OnRefresh")
AddEventHandler("Nehco:SafeZoneBuilder:OnRefresh", function(_zones)
    SafeZone.Zones = _zones
    TriggerEvent("Nehco:SafeZoneBuilder:OnRefreshBlips")
end)

RegisterNetEvent("Nehco:SafeZoneBuilder:OnCreate")
AddEventHandler("Nehco:SafeZoneBuilder:OnCreate", function(_zone)
    SafeZone.Zones[_zone.id] = _zone
    TriggerEvent("Nehco:SafeZoneBuilder:OnRefreshBlips")
end)

RegisterNetEvent("Nehco:SafeZoneBuilder:OnDelete")
AddEventHandler("Nehco:SafeZoneBuilder:OnDelete", function(id)
    SafeZone.Zones[id] = nil
    TriggerEvent("Nehco:SafeZoneBuilder:OnRefreshBlips")
end)

Citizen.CreateThread(function()
    TriggerServerEvent("Nehco:SafeZoneBuilder:Refresh")
end)