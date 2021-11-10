

RegisterServerEvent('Roda_ReportSystem:SendReportToDiscord')
AddEventHandler('Roda_ReportSystem:SendReportToDiscord', function(data)
    local src = source 
    local playername = GetPlayerName(src)
    local name = nil 
    local ava = nil 
    local reported = nil
    if ConfigSv.UseDiscordApi then 
         name = GetDiscordName(src)
         ava = GetAvatar(src)
    else
        name = playername
        ava = ConfigSv.LogoOfServer
    end

    local ids = ExtractIdentifiers(src)

    local discordmention =  "<@" ..ids.discord:gsub("discord:", "")..">"

    if data.idshow and data.pic then 
        reported = GetPlayerName(data.idshow)
        if reported then 
            TriggerEvent('Roda_ReportSystem:Logs', name, 'New Report', 255, '**Category of Report: ** \n '..data.checkboxes..' \n \n **User that is reported** \n ['..data.idshow..'] | '..reported..' \n \n **Motive:** \n '..data.motivo..' \n \n  **Extra Info: ** \n '..data.info..' ' , 'The user **['..src..']** '..discordmention..' report this:' , ava, data.pic)
        else 
            TriggerEvent('Roda_ReportSystem:Logs', name, 'New Report', 255, '**Category of Report: ** \n '..data.checkboxes..' \n \n **User that is reported** \n ['..data.idshow..'] **THIS ID IS INVALID** \n \n **Motive:** \n '..data.motivo..' \n \n  **Extra Info: ** \n '..data.info..' ' , 'The user **['..src..']** '..discordmention..' report this:' , ava, data.pic)
        end
    elseif not data.idshow  and data.pic then 
        TriggerEvent('Roda_ReportSystem:Logs', name, 'New Report', 255, '**Category of Report: ** \n '..data.checkboxes..' \n \n  **Motive:** \n '..data.motivo..' \n \n  **Extra Info: ** \n '..data.info..' ' , 'The user **['..src..']** '..discordmention..' report this:' , ava, data.pic )   
    end
end)

RegisterServerEvent('Roda_ReportSystem:Logs')
AddEventHandler('Roda_ReportSystem:Logs', function(name, title, color, message, tag, img, pic)
    
    local webHook = ConfigSv.Webhook

    local embedData = {
        {
            ["title"] = title,
            ["color"] = color,
            ["footer"] = {
                ["text"] = os.date("%c"),
                ["icon_url"] = ConfigSv.FooterImg
            },
            ["image"] = {
                ["url"] = pic
            },
            ["description"] = message,
        }
    }

    PerformHttpRequest(webHook, function(err, text, headers) end, 'POST', json.encode({ username = name ,embeds = embedData, content = tag, avatar_url = img}), { ['Content-Type'] = 'application/json' })
end)


RegisterCommand(ConfigSv.Command, function(source)
    local src = source 
    local name = nil 
    local ava = nil
    if ConfigSv.UseDiscordApi then 
        name = GetDiscordName(src)
        ava = GetAvatar(src)
    else
        name = ConfigSv.ServerName
        ava = ConfigSv.LogoOfServer
    end

    TriggerClientEvent('Roda_ReportSystem:openUI', source, name, ava)
end)

