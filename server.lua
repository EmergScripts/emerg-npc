local function emergPrint(text)
	print('^7[^2Emerg-NPC^0]^7 ' .. text)
end

local function checkForUpdates(resource)
	local url = 'https://raw.githubusercontent.com/EmergScripts/updates/main/' .. resource .. '.json'
	PerformHttpRequest(url, function(err, text, headers)
		if err == 200 then
			local data = json.decode(text)
			local version = GetResourceMetadata(GetCurrentResourceName(), 'version', 0)
			if data.currentVersion ~= version then
				emergPrint('A new version of ^2' .. data.name .. '^0 is available! (Current: ^2' .. version .. '^0, New: ^2' .. data.currentVersion .. '^0)')
				emergPrint('Changelog: ^2' .. data.changelogs[data.currentVersion].title .. '^0')
				emergPrint('Changes: ^2' .. data.changelogs[data.currentVersion].changes .. '^0')
				emergPrint('Download: ^2' .. data.download .. '^0')
			else
				emergPrint('You are running the latest version of ^2' .. data.name .. '^0!')
			end
		else
			emergPrint('Failed to check for updates!')
		end
	end, 'GET', '', { ['Content-Type'] = 'application/json' })
end

checkForUpdates('emerg-npc')