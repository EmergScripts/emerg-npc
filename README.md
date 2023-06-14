
# EmergScripts Interactable NPCs
### [EmergScripts Discord](https://discord.gg/NFJufZhRxZ)

### Description
EmergScripts Interactable NPCs is a FiveM resource that enables players to interact with custom non-playable characters (NPCs) by pressing the E key. This documentation provides instructions on how to create and implement interactable NPCs in your client or server resource.

#### Why Use EmergScripts Interactable NPCs?
EmergScripts Interactable NPCs offers the following advantages:

1. Easy Customization: Interactable NPCs provides a user-friendly configuration that allows you to easily create and configure custom NPCs. You can define their appearance, text, animation, and the events triggered when a player interacts with them.

2. Integration: The resource seamlessly integrates with your existing scripts. You can trigger client events, enabling you to create more gameplay scenarios.

3. Anti-Cheat Compatibility: NPCs are created on the client side when the player is within range. This approach ensures anti-cheat compatibility as the NPCs are never synced.

#### Creating an NPC
To create an NPC, follow these steps:

1. Open the ``config.lua`` file.
2. Locate the ``Config.NPCS`` table.
3. Copy the template from "NPC Config Template" below.
4. Paste the copied code into the ``Config.NPCS`` table.
5. Restart the resource

#### NPC Config Template
```
	{
		coords = vector3(1830.26, 3683.2, 34.33),				-- Coords (Required)
		heading = 112.19,							-- Heading (Required)
		model = "mp_m_freemode_01",						-- Model (Required)
		props = {								-- Props (Only Required if using model "mp_m_freemode_01" or "mp_f_freemode_01")
         		{ 0, 130, 0 },
		},
		components = {								-- Apperance (Only Required if using model "mp_m_freemode_01" or "mp_f_freemode_01")
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

		emote = "WORLD_HUMAN_CLIPBOARD",					-- Emote/Task to Play (Line is Optional. Delete to Remove)
		
		blip = {								-- Map Blip (Line is Optional. Delete to Remove)
			sprite = 60,
			color = 38,
			scale = 0.8,
			display = 2,
			name = "Desk Officer",
		},
		
		name = "Desk Officer",							-- NPC Name (Required)
		text = "Press ~o~[E]~w~ to talk to the ~y~Desk Officer",		-- Text Above NPC (Required)
		event = "EmergScripts:DeskOfficer",					-- Client Event to Trigger (Required)
		debug = false													
	},
```

#### Components & Props ID
Components Table Row (First Number)
```
	0: Face
	1: Mask
	2: Hair
	3: Torso
	4: Leg
	5: Parachute/Bag
	6: Shoes
	7: Accessory
	8: Undershirt
	9: Kevlar
	10: Badge
	11: Torso 2
```

Props Table Row (First Number)
```
0: Hat
1: Glass
2: Ear
6: Watch
7: Bracelet
```

# Resource Implementation
#### Client Side
In your client-side script of your choice, use the following code:

```Lua
RegisterNetEvent('WhatEverNPCEventYouSet', function()
	print('I pressed E on the NPC I made!')
end)
```
