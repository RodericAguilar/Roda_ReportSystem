RegisterNUICallback("exit" , function(data, cb)
    SetNuiFocus(false, false)
    cb(200)
end)


RegisterNetEvent('Roda_ReportSystem:openUI')
AddEventHandler('Roda_ReportSystem:openUI', function(name, ava)
    SetNuiFocus(true, true)
    SendNUIMessage({
        trans = true;
        name = name;
        ava = ava;
    })
end)

RegisterNUICallback('submit', function(data, cb)
    SetNuiFocus(false, false)
    print(json.encode(data))
    TriggerServerEvent('Roda_ReportSystem:SendReportToDiscord', data)
    cb(200)
end)
