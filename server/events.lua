local SafeZoneTable = {}

MySQL.ready(function()
    MySQL.Async.fetchAll("SELECT * FROM safe_zones", {
    }, function(data)
        for k,v in pairs(data) do
            SafeZoneTable[tostring(v.id)] = {
                coords = json.decode(v.coords),
                radius = v.radius,
                restrictions = json.decode(v.restrictions),
                showMarker = v.showMarker,
                markerHeight = v.markerHeight,
                markerColors = json.decode(v.markerColors),
                showBlip = v.showBlip,
                blipColor = v.blipColor,
                id = tostring(v.id),
            }
        end
    end)
end)

RegisterNetEvent("Nehco:SafeZoneBuilder:Refresh")
AddEventHandler("Nehco:SafeZoneBuilder:Refresh", function()
    local source = source
    TriggerClientEvent("Nehco:SafeZoneBuilder:OnRefresh", source, SafeZoneTable)
end)
    
RegisterNetEvent("Nehco:SafeZoneBuilder:Create")
AddEventHandler("Nehco:SafeZoneBuilder:Create", function(_coords, _radius, _restrictions, _showMarker, _markerHeight, _markerColors, _showBlip, _blipColor)
    MySQL.Async.insert("INSERT INTO safe_zones (`coords`, `radius`, `restrictions`, `showMarker`, `markerHeight`, `markerColors`, `showBlip`, `blipColor`) VALUES ('"..json.encode({x = _coords.x, y = _coords.y, z = _coords.z}).."', '".._radius.."', '"..json.encode(_restrictions).."', '"..(not _showMarker and 0 or _showMarker and 1).."', '".._markerHeight.."', '"..json.encode(_markerColors).."', '"..(not _showBlip and 0 or _showBlip and 1).."', '".._blipColor.."')", {
    }, function(id)
        SafeZoneTable[tostring(id)] = {
            coords = {x = _coords.x, y = _coords.y, z = _coords.z},
            radius = _radius,
            restrictions = _restrictions,
            showMarker = (not _showMarker and 0 or _showMarker and 1),
            markerHeight = _markerHeight,
            markerColors = _markerColors,
            showBlip = (not _showBlip and 0 or _showBlip and 1),
            blipColor = _blipColor,
            id = id,
        }
        TriggerClientEvent("Nehco:SafeZoneBuilder:OnCreate", -1, SafeZoneTable[tostring(id)])
    end)
end)

RegisterNetEvent("Nehco:SafeZoneBuilder:Delete")
AddEventHandler("Nehco:SafeZoneBuilder:Delete", function(id)
    MySQL.Async.execute("DELETE FROM safe_zones WHERE id = @id", {
        ["@id"] = id
    })
    SafeZoneTable[tostring(id)] = nil
    TriggerClientEvent("Nehco:SafeZoneBuilder:OnDelete", -1, id)
end)