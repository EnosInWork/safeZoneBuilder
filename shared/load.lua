ESX = nil

Citizen.CreateThread(function()
	print("Nehco Safe Zone Builder - 5Dev : https://discord.gg/b2mzyESAYu")
    while ESX == nil do
		TriggerEvent(SafeZone.Config.ESXSharedObject, function(obj) ESX = obj end)
		Citizen.Wait(10)
	end
end)