Citizen.CreateThread(function()
    while ESX == nil do
        Citizen.Wait(0)
    end
    ESX.RegisterServerCallback("Nehco:SafeZoneBuilder:GetPlayerGroup", function(source, cb)
        local xPlayer = ESX.GetPlayerFromId(source)
        MySQL.Async.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {
            ["@identifier"] = xPlayer.identifier
        }, function(result)
            cb(result[1].group)
        end)
    end)
end)