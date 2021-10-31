

RegisterServerEvent('Roda_ReportSystem:SendReportToDiscord')
AddEventHandler('Roda_ReportSystem:SendReportToDiscord', function(data)
    local src = source 
    local name = GetDiscordName(src)
    local ava = GetAvatar(src)
    local ids = ExtractIdentifiers(src)
    local discordmention =  "<@" ..ids.discord:gsub("discord:", "")..">"
    if data.idshow then 
    TriggerEvent('Roda_ReportSystem:Logs', name, 'New Report', 255, '**Category of Report: ** \n '..data.checkboxes..' \n \n **Id of Reported:** \n '..data.idshow..' \n \n **Motive:** \n '..data.motivo..' \n \n  **Extra Info: ** \n '..data.info..' ' , 'The user **['..src..']** '..discordmention..' report this:' , ava )
    else
        TriggerEvent('Roda_ReportSystem:Logs', name, 'New Report', 255, '**Category of Report: ** \n '..data.checkboxes..' \n \n  **Motive:** \n '..data.motivo..' \n \n  **Extra Info: ** \n '..data.info..' ' , 'The user **['..src..']** '..discordmention..' report this:' , ava )

    end
end)

RegisterServerEvent('Roda_ReportSystem:Logs')
AddEventHandler('Roda_ReportSystem:Logs', function(name, title, color, message, tag, img)
    
    local webHook = ConfigSv.Webhook

    local embedData = {
        {
            ["title"] = title,
            ["color"] = color,
            ["footer"] = {
                ["text"] = os.date("%c"),
                ["icon_url"] = ConfigSv.FooterImg
            },
            ["description"] = message,
        }
    }

    PerformHttpRequest(webHook, function(err, text, headers) end, 'POST', json.encode({ username = name ,embeds = embedData, content = tag, avatar_url = img}), { ['Content-Type'] = 'application/json' })
end)


RegisterCommand(ConfigSv.Command, function(source)
    local src = source 
    local name = GetDiscordName(src)
    local ava = GetAvatar(src)
    TriggerClientEvent('Roda_ReportSystem:openUI', source, name, ava)
end)