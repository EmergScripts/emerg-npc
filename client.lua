-- Path: client.lua
-- Read the Config.NPCS table and create the NPCs
local NPCs = {}

Citizen.CreateThread(function()
    while true do
        -- Wait for 1000ms (1 second) before checking if NPCs need to be spawned
        Citizen.Wait(1000)

        for k, v in pairs(Config.NPCS) do
			-- Check if the NPC is currently spawned
			if not NPCs[k] then
				-- Check if the player can see where the NPC is going to spawn
				local player = PlayerPedId()
				local playerCoords = GetEntityCoords(player)
				local rayHandle = CastRayPointToPoint(playerCoords.x, playerCoords.y, playerCoords.z, v.coords.x, v.coords.y, v.coords.z, 10, player, 0)
				local _, _, _, _, entityHit = GetRaycastResult(rayHandle)
				if entityHit == 0 then
					-- Spawn the NPC
					
				else
					-- Wait for 1000ms before checking if the player can see where the NPC is going to spawn
					Citizen.Wait(100)
				end
			end
		end
		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
    while true do
        -- Spawn NPCs if they are within 25 units of the player. Despawn NPCs if they are more than 25 units away from the player.
        Citizen.Wait(1000)

		local player = PlayerPedId()
		local playerCoords = GetEntityCoords(player)
        for k, v in pairs(Config.NPCS) do
			-- Check if the NPC is currently spawned
			if NPCs[k] then
				-- Check if the NPC is within 25 units of the player
				local npcCoords = GetEntityCoords(NPCs[k])
				local distance = #(playerCoords - npcCoords)
				if distance > 25 then
					-- Despawn the NPC
					DeletePed(NPCs[k])
					NPCs[k] = nil
				end
			else
				local distance = #(playerCoords - v.coords)
				if distance < 25 then
					-- Spawn the NPC
					RequestModel(v.model)
					while not HasModelLoaded(v.model) do
						Citizen.Wait(0)
					end
					NPCs[k] = CreatePed(4, v.model, v.coords, v.heading, false, true)

					if v.model == "mp_m_freemode_01" or v.model == "mp_f_freemode_01" then
						for i = 1, #v.props do
							SetPedPropIndex(NPCs[k], v.props[i][1], v.props[i][2], v.props[i][3], 2)
						end
						for i = 1, #v.components do
							SetPedComponentVariation(NPCs[k], v.components[i][1], v.components[i][2], v.components[i][3], 2)
						end
						
						-- Add Head Hair Random
						local hairColor = math.random(1, 5)
						SetPedComponentVariation(NPCs[k], 2, math.random(0, 45), hairColor, 2)

						-- Random Mother/Father
						local mother = math.random(1, 5)
						local father = math.random(1, 5)
						SetPedHeadBlendData(NPCs[k], mother, father, 0, mother, father, 0, 0.5, 0.5, 0.0, false)
					end

					-- Wait for it to fall to the ground
					Citizen.Wait(1000)
					SetEntityInvincible(NPCs[k], true)
					SetBlockingOfNonTemporaryEvents(NPCs[k], true)
					FreezeEntityPosition(NPCs[k], true)
					SetEntityCanBeDamaged(NPCs[k], false)
					SetEntityProofs(NPCs[k], true, true, true, true, true, true, true, true)
					
					if v.emote ~= nil then
						TaskStartScenarioInPlace(NPCs[k], v.emote, 0, true)
					end
	
					if v.debug then
						-- Print debug information
						print("Spawned NPC: " .. v.model .. " at " .. v.coords.x .. ", " .. v.coords.y .. ", " .. v.coords.z)
					end
				end
			end
        end
		Citizen.Wait(0)
    end
end)

-- Loop through Config.NPCS and check if has blip data
Citizen.CreateThread(function()
	for k, v in pairs(Config.NPCS) do
		if v.blip then
			-- Create the blip
			local blip = AddBlipForCoord(v.coords)
			SetBlipSprite(blip, v.blip.sprite)
			SetBlipDisplay(blip, v.blip.display)
			SetBlipScale(blip, v.blip.scale)
			SetBlipColour(blip, v.blip.color)
			SetBlipAsShortRange(blip, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(v.blip.name)
			EndTextCommandSetBlipName(blip)
		end
	end
end)

-- Check if near an NPC
local nearNPC = false
local nearestNPC = nil
local nearestNPCCoords = nil
local nearestNPCConfigData = nil
Citizen.CreateThread(function()
    while true do
		local foundNPC = false
        for k, v in pairs(Config.NPCS) do
            local player = PlayerPedId()
            local playerCoords = GetEntityCoords(player)
            local npcCoords = GetEntityCoords(NPCs[k])
            if Vdist(playerCoords.x, playerCoords.y, playerCoords.z, npcCoords.x, npcCoords.y, npcCoords.z) < 2.5 then
                -- Check if the player is close to the NPC
                nearNPC = true
				nearestNPC = NPCs[k]
				nearestNPCCoords = npcCoords
				nearestNPCConfigData = v
				foundNPC = true
                -- Wait for 500ms before checking if the player is close to the NPC
            end
        end
		if not foundNPC then
			nearNPC = false
			nearestNPC = nil
			nearestNPCCoords = nil
			nearestNPCConfigData = nil
		end
        Citizen.Wait(1000)
    end
end)

-- If near NPC Draw3DText
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if nearNPC and nearestNPC ~= nil and nearestNPCCoords ~= nil and nearestNPCConfigData.text ~= nil then
			Draw3DText(nearestNPCCoords.x, nearestNPCCoords.y, nearestNPCCoords.z + 1.0, nearestNPCConfigData.text, 1.2, 4, 255, 255, 255, 255)
			if IsControlJustReleased(0, 38) then
				-- Check if the NPC has a callback function
				if nearestNPCConfigData.event ~= nil then
					if nearestNPCConfigData.eventData ~= nil then
						TriggerEvent(nearestNPCConfigData.event, nearestNPCConfigData.eventData)
					else
						TriggerEvent(nearestNPCConfigData.event)
					end
				end
			end
		end
	end
end)

function Draw3DText(x,y,z, text, scl, font, r,g,b,a)
	local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	local px,py,pz=table.unpack(GetGameplayCamCoords())
	local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
	local scale = (1/dist)*scl
	local fov = (1/GetGameplayCamFov())*100
	local scale = scale*fov
	if onScreen then
		SetTextScale(0.0*scale, 0.55*scale)
		SetTextFont(font)
		SetTextProportional(1)
		SetTextColour(r, g, b, a)
		SetTextDropshadow(0, 0, 0, 0, 255)
		SetTextEdge(2, 0, 0, 0, 150)
		SetTextDropShadow()
		SetTextOutline()
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(text)
		DrawText(_x,_y)
	end
end