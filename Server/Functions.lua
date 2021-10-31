local token = "ODgxOTE3NzQwMTE2NDgwMDAw.YSzz5g.D7WdqxGy8LJ-ORysce99nVX33ls"
local FormattedToken = "Bot " ..token


function GetInfoFromDiscord(method, endpoint, jsondata)
    local data = nil
    PerformHttpRequest("https://discordapp.com/api/"..endpoint, function(errorCode, resultData, resultHeaders)
		data = {data=resultData, code=errorCode, headers=resultHeaders}
    end, method, #jsondata > 0 and json.encode(jsondata) or "", {["Content-Type"] = "application/json", ["Authorization"] = FormattedToken})

    while data == nil do
        Citizen.Wait(0)
    end
	
    return data
end


function GetDiscordName(user) 
    local discordId = nil
    local DiscordName = nil;
    for _, id in ipairs(GetPlayerIdentifiers(user)) do
        if string.match(id, "discord:") then
            discordId = string.gsub(id, "discord:", "")
            break
        end
    end
    if discordId then 
        local endpoint = ("users/%s"):format(discordId)
        local member = GetInfoFromDiscord("GET", endpoint, {})
        if member.code == 200 then
            local data = json.decode(member.data)
            if data ~= nil then 
                DiscordName = data.username .. "#" .. data.discriminator;
            end
        else 
        	print("An error ocurred.")
        end
    end
    return DiscordName;
end

function GetAvatar(user) 
    local discordId = nil
    local DiscordImg = nil;
    for _, id in ipairs(GetPlayerIdentifiers(user)) do
        if string.match(id, "discord:") then
            discordId = string.gsub(id, "discord:", "")
            break
        end
	end
	if discordId then 
			local endpoint = ("users/%s"):format(discordId)
			local member = GetInfoFromDiscord("GET", endpoint, {})
			if member.code == 200 then
				local data = json.decode(member.data)
				if data ~= nil and data.avatar ~= nil then 
					if (data.avatar:sub(1, 1) and data.avatar:sub(2, 2) == "_") then 
						DiscordImg = "https://cdn.discordapp.com/avatars/" .. discordId .. "/" .. data.avatar .. ".gif";
					else 
						DiscordImg = "https://cdn.discordapp.com/avatars/" .. discordId .. "/" .. data.avatar .. ".png"
					end
				end
			else 
				print("An error ocurred.")
			end
	else 
		print("The player don't have discord.")
	end
    return DiscordImg;
end

function ExtractIdentifiers(src)
    local identifiers = {}

    for i = 0, GetNumPlayerIdentifiers(src) - 1 do
        local id = GetPlayerIdentifier(src, i)

        if string.find(id, "steam") then
            identifiers['steam'] = id
        elseif string.find(id, "ip") then
            identifiers['ip'] = id
        elseif string.find(id, "discord") then
            identifiers['discord'] = id
        elseif string.find(id, "license") then
            identifiers['license'] = id
        elseif string.find(id, "xbl") then
            identifiers['xbl'] = id
        elseif string.find(id, "live") then
            identifiers['live'] = id
        end
    end

    return identifiers
end