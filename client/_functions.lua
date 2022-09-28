SafeZone.Functions = {}

function SafeZone.Functions.Notify(text)
    SetNotificationTextEntry('STRING')
	AddTextComponentString(text)
	DrawNotification(0,1)
end

function SafeZone.Functions.Keyboard(string_args, max)
    local string = nil
    AddTextEntry("CUSTOM_AMOUNT", "~s~"..string_args)
    DisplayOnscreenKeyboard(1, "CUSTOM_AMOUNT", "", "", "", "", "", max or 20)
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        Citizen.Wait(0)
    end
    if UpdateOnscreenKeyboard() ~= 2 then
        string = GetOnscreenKeyboardResult()
        Citizen.Wait(0)
    else
        Citizen.Wait(0)
    end
    return string
end

function SafeZone.Functions.DrawText3d(coords, text)
    SetTextScale(0.3, 0.3)
    SetTextProportional(1)
    SetTextDropshadow(100, 0, 0, 0, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    SetDrawOrigin(coords, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end