-- EmergScripts NPC Resource

--[[
	This script will create NPCs at the locations specified in the config.lua file.
	You can interact with the NPCs by pressing E.
	You can also add your own custom NPCs by adding them to the config.lua file.
]]--

-- Path: config.lua

-- NPC Config
Config = {}

Config.NPCS = {
	{
		coords = vector3(1847.35, 3687.70, 34.26),
		heading = 117.14,
		model = "s_m_y_sheriff_01",
		-- Name
		name = "Jailor",
		-- This is the text that will be displayed when you press E on the NPC
		text = "Press ~o~[E]~w~ to talk to the ~y~Jailor",
		-- This is the event that will be triggered when you press E on the NPC
		event = "npc:jailor",
		debug = false
	},
	{
		coords = vector3(1830.26, 3683.2, 34.33),
		heading = 112.19,
		model = "mp_m_freemode_01",
		props = {
            { 0, 130, 0 },		-- Hat
		},
		components = {
			{ 1, 0, 0 },
			{ 3, 165, 0 },
			{ 4, 25, 1 },
			{ 5, 0, 0 },
			{ 6, 82, 0 },
			{ 7, 6, 0 },
			{ 8, 40, 0 },
			{ 9, 1, 0 },
			{ 10, 0, 0 },
			{ 11, 200, 0 },
		},

		emote = "WORLD_HUMAN_CLIPBOARD",
		
		blip = {
			sprite = 60,
			color = 38,
			scale = 0.8,
			display = 2,
			name = "Desk Officer",
		},
		-- Name
		name = "Desk Officer",
		-- This is the text that will be displayed when you press E on the NPC
		text = "Press ~o~[E]~w~ to talk to the ~y~Desk Officer",
		-- This is the event that will be triggered when you press E on the NPC
		event = "EmergScripts:DeskOfficer",
		debug = false
	},
	{
		coords = vector3(473.33, -1015.15, 26.27),
		heading = 4.16,
		model = "mp_m_freemode_01",
		props = {
            { 0, 3, 1 },		-- Hat
		},
		components = {
			{ 1, 0, 0 },
			{ 3, 166, 0 },
			{ 4, 25, 2 },
			{ 5, 31, 0 },
			{ 6, 2, 0 },
			{ 7, 8, 0 },
			{ 8, 40, 0 },
			{ 9, 0, 0 },
			{ 10, 0, 0 },
			{ 11, 190, 4 },
		},
		-- Name
		name = "Finger Printer",
		-- This is the text that will be displayed when you press E on the NPC
		text = "Press ~o~[E]~w~ to talk to the ~y~Finger Printer",
		-- This is the event that will be triggered when you press E on the NPC
		event = "EmergScripts:Fingerprint",
		debug = false
	},
	{
		coords = vector3(1963.07, 3750.70, 32.26),
		heading = 303.51,
		model = "g_m_y_armgoon_02",
		-- Name
		name = "Weed Dealer",
		-- This is the text that will be displayed when you press E on the NPC
		text = "Press ~o~[E]~w~ to talk to the ~y~Weed Dealer",
		-- This is the event that will be triggered when you press E on the NPC
		event = "EmergScripts:WeedExample",

		blip = {
			sprite = 140,
			color = 2,
			scale = 0.8,
			display = 4,
			name = "Weed Dealer",
		},

		debug = false
	},
}