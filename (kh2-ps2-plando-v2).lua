--GAME STATUS
--CHEST TALLY
-- 5 Torn Page(s)
-- 1 Ukulele Charm(s)
-- 1 Feather Charm(s)

--POPUP TALLY
-- 1 Fire spell(s)
-- 2 Blizzard spell(s)
-- 3 Cure spell(s)
-- 1 Reflect spell(s)
-- 1 Secret Ansem's Report(s) 1
-- 1 Secret Ansem's Report(s) 2
-- 1 Secret Ansem's Report(s) 3
-- 1 Secret Ansem's Report(s) 4
-- 1 Secret Ansem's Report(s) 5
-- 1 Secret Ansem's Report(s) 6
-- 1 Secret Ansem's Report(s) 7
-- 1 Secret Ansem's Report(s) 8
-- 1 Secret Ansem's Report(s) 9
-- 1 Secret Ansem's Report(s) 10
-- 1 Secret Ansem's Report(s) 11
-- 1 Secret Ansem's Report(s) 12
-- 1 Secret Ansem's Report(s) 13
-- 1 Valor Form(s)
-- 1 Wisdom Form(s)
-- 1 Master Form(s)
-- 1 Baseball Charm(s)
-- 1 Lamp Charm(s)

--FORM & SUMMON TALLY

--LEVEL TALLY
--SWORD TALLY

--SHIELD TALLY

--STAFF TALLY

--BONUS TALLY
-- 2 Fire spell(s)
-- 1 Blizzard spell(s)
-- 3 Thunder spell(s)
-- 2 Reflect spell(s)
-- 3 Magnet spell(s)

--SORA'S FINAL STATS IN CRITICAL MODE
-- HP: 56
-- MP: 120
-- Armor: 3
-- Accessory: 3
-- Item: 6
-- Drive: 9

function _OnFrame()
	World = ReadByte(Now + 0x00)
	Room = ReadByte(Now + 0x01)
	Place = ReadShort(Now + 0x00)
	Door = ReadShort(Now + 0x02)
	Map = ReadShort(Now + 0x04)
	Btl = ReadShort(Now + 0x06)
	Evt = ReadShort(Now + 0x08)
	if Place == 0xFFFF or not Obj0 then
		if Platform == 'PS2' then
			Obj0 = ReadInt(Obj0Pointer)
			Sys3 = ReadInt(Sys3Pointer)
			Btl0 = ReadInt(Btl0Pointer)
		elseif Platform == 'PC' then
			Obj0 = ReadLong(Obj0Pointer)
			Sys3 = ReadLong(Sys3Pointer)
			Btl0 = ReadLong(Btl0Pointer)
		end
	end
	Chests()
	Popups()
	BonusRewards()
	DriveForms()
	Equipment()
	LevelRewards()
	AbilityCosts()
	StartingStatus()
	Cheats()
end

function _OnInit()
	if GAME_ID == 0xF266B00B or GAME_ID == 0xFAF99301 and ENGINE_TYPE == "ENGINE" then--PCSX2
		Platform = 'PS2'
		Now = 0x032BAE0 --Current Location
		Save = 0x032BB30 --Save File
		Obj0Pointer = 0x1D5BA10 --00objentry.bin
		Sys3Pointer = 0x1C61AF8 --03system.bin
		Btl0Pointer = 0x1C61AFC --00battle.bin
		Slot1 = 0x1C6C750 --Unit Slot 1
	elseif GAME_ID == 0x431219CC and ENGINE_TYPE == 'BACKEND' then--PC
		Platform = 'PC'
		Now = 0x0714DB8 - 0x56454E
		Save = 0x09A7070 - 0x56450E
		Obj0Pointer = 0x2A22730 - 0x56450E
		Sys3Pointer = 0x2AE3550 - 0x56450E
		Btl0Pointer = 0x2AE3558 - 0x56450E
		Slot1 = 0x2A20C58 - 0x56450E
	end
end

function Events(M,B,E) --Check for Map, Btl, and Evt
	return ((Map == M or not M) and (Btl == B or not B) and (Evt == E or not E))
end


function Chests()
	-- AGRABAH
	WriteShort(Sys3+0x14526,0x0112) -- Agrabah, Dark Shard is now Drive Recovery
	WriteShort(Sys3+0x1456E,0x0006) -- Agrabah, Serenity Shard is now Mega-Ether
	WriteShort(Sys3+0x14586,0x0002) -- Bazaar, Power Shard is now Hi-Potion
	WriteShort(Sys3+0x145CE,0x0112) -- The Cave of Wonders Entrance, Power Stone is now Drive Recovery
	WriteShort(Sys3+0x1463A,0x0165) -- Treasure Room, Serenity Gem is now Serenity Shard
	-- BEAST'S CASTLE
	WriteShort(Sys3+0x14922,0x0159) -- Belle's Room, Mega Recipe is now Mythril Shard
	WriteShort(Sys3+0x1492E,0x0002) -- The East Wing, Mythril Shard is now Hi-Potion
	WriteShort(Sys3+0x1495E,0x0112) -- The West Hall, Power Shard is now Drive Recovery
	WriteShort(Sys3+0x14982,0x0083) -- The West Hall, Bright Stone is now Tent
	WriteShort(Sys3+0x149BE,0x0005) -- Secret Passage, Lucid Shard is now Mega-Potion
	WriteShort(Sys3+0x149E2,0x017E) -- The Beast's Room, Blazing Shard is now Mega-Recipe
	-- CAVERN OF REMEMBRANCE
	WriteShort(Sys3+0x151E6,0x0000) -- Depths, AP Boost is now EMPTY
	WriteShort(Sys3+0x151F2,0x0000) -- Depths, Power Crystal is now EMPTY
	WriteShort(Sys3+0x151FE,0x0000) -- Depths, Frost Crystal is now EMPTY
	WriteShort(Sys3+0x1520A,0x0000) -- Depths, Manifest Illusion is now EMPTY
	WriteShort(Sys3+0x15216,0x0000) -- Depths, AP Boost is now EMPTY
	WriteShort(Sys3+0x15222,0x0000) -- Depths Upper Level, Remembrance Gem is now EMPTY
	WriteShort(Sys3+0x1522E,0x0000) -- Mining Area, Serenity Gem is now EMPTY
	WriteShort(Sys3+0x1523A,0x0000) -- Mining Area, AP Boost is now EMPTY
	WriteShort(Sys3+0x15246,0x0000) -- Mining Area, Serenity Crystal is now EMPTY
	WriteShort(Sys3+0x15252,0x0000) -- Mining Area, Manifest Illusion is now EMPTY
	WriteShort(Sys3+0x1525E,0x0000) -- Mining Area, Serenity Gem is now EMPTY
	WriteShort(Sys3+0x1526A,0x0000) -- Mining Area, Dark Remembrance Map is now EMPTY
	WriteShort(Sys3+0x15276,0x0000) -- Engine Chamber, Serenity Crystal is now EMPTY
	WriteShort(Sys3+0x15282,0x0000) -- Engine Chamber, Remembrance Crystal is now EMPTY
	WriteShort(Sys3+0x1528E,0x0000) -- Engine Chamber, AP Boost is now EMPTY
	WriteShort(Sys3+0x1529A,0x0000) -- Engine Chamber, Manifest Illusion is now EMPTY
	WriteShort(Sys3+0x152A6,0x0000) -- Mineshaft Lower Level, AP Boost is now EMPTY
	WriteShort(Sys3+0x152BE,0x0000) -- Mineshaft Lower Level, Depths of Remembrance Map is now EMPTY
	WriteShort(Sys3+0x152CA,0x0000) -- Mineshaft Mid Level, Power Boost is now EMPTY
	WriteShort(Sys3+0x152B2,0x0000) -- Mineshaft Upper Level, AP Boost is now EMPTY
	WriteShort(Sys3+0x152D6,0x0000) -- Mineshaft Upper Level, Magic Boost is now EMPTY
	WriteShort(Sys3+0x152E2,0x0000) -- Garden of Assemblage, Garden of Assemblage Map is now EMPTY
	WriteShort(Sys3+0x152EE,0x0000) -- Garden of Assemblage, Lost Illusion is now EMPTY
	WriteShort(Sys3+0x152FA,0x0000) -- Garden of Assemblage, Proof of Nonexistence is now EMPTY
	-- DISNEY CASTLE
	WriteShort(Sys3+0x146E2,0x0003) -- Courtyard, Blazing Stone is now Ether
	WriteShort(Sys3+0x146EE,0x0002) -- Courtyard, Blazing Shard is now Hi-Potion
	-- HALLOWEEN TOWN
	WriteShort(Sys3+0x14A96,0x0002) -- Graveyard, Mythril Shard is now Hi-Potion
	WriteShort(Sys3+0x14AA2,0x0159) -- Graveyard, Serenity Gem is now Mythril Shard
	WriteShort(Sys3+0x14AC6,0x0005) -- Halloween Town Square, Energy Shard is now Mega-Potion
	WriteShort(Sys3+0x14AD2,0x0002) -- Hinterlands, Lightning Shard is now Hi-Potion
	WriteShort(Sys3+0x14AF6,0x0002) -- Candy Cane Lane, Mega Potion is now Hi-Potion
	WriteShort(Sys3+0x14B0E,0x0003) -- Candy Cane Lane, Lightning Stone is now Ether
	-- HOLLOW BASTION
	WriteShort(Sys3+0x14C6A,0x0083) -- Borough, Dark Shard is now Tent
	WriteShort(Sys3+0x14CB2,0x0002) -- Corridors, Dark Crystal is now Hi-Potion
	WriteShort(Sys3+0x14D12,0x0004) -- Crystal Fissure, Energy Crystal is now Elixir
	-- LAND OF DRAGONS
	WriteShort(Sys3+0x1442A,0x0002) -- Bamboo Grove, Dark Shard is now Hi-Potion
	WriteShort(Sys3+0x14466,0x0002) -- Mountain Trail, Lightning Shard is now Hi-Potion
	WriteShort(Sys3+0x144A2,0x0002) -- Village Cave, Dark Shard is now Hi-Potion
	WriteShort(Sys3+0x144AE,0x0002) -- Ridge, Frost Shard is now Hi-Potion
	-- OLYMPUS COLISEUM
	WriteShort(Sys3+0x14862,0x0002) -- Caverns Entrance, Lucid Shard is now Hi-Potion
	WriteShort(Sys3+0x14886,0x0002) -- The Lost Road, Bright Shard is now Hi-Potion
	WriteShort(Sys3+0x148B6,0x0083) -- Atrium, Lucid Stone is now Tent
	-- 100 ACRE WOOD
	-- PORT ROYAL
	WriteShort(Sys3+0x14B56,0x0003) -- Rampart, Dark Shard is now Ether
	WriteShort(Sys3+0x14B62,0x0003) -- Town, Dark Stone is now Ether
	WriteShort(Sys3+0x14B92,0x0003) -- Cave Mouth, Bright Shard is now Ether
	WriteShort(Sys3+0x14BCE,0x0003) -- Moonlight Nook, Serenity Gem is now Ether
	WriteShort(Sys3+0x14BDA,0x0005) -- Moonlight Nook, Power Stone is now Mega-Potion
	WriteShort(Sys3+0x14C16,0x0113) -- Seadrift Row, Serenity Gem is now High Drive Recovery
	-- PRIDE LANDS
	WriteShort(Sys3+0x14D4E,0x0003) -- Gorge, Dark Gem is now Ether
	WriteShort(Sys3+0x14D66,0x0002) -- Elephant Graveyard, Frost Gem is now Hi-Potion
	WriteShort(Sys3+0x14D7E,0x0003) -- Elephant Graveyard, Bright Stone is now Ether
	WriteShort(Sys3+0x14DBA,0x0006) -- Pride Rock, Serenity Crystal is now Mega-Ether
	WriteShort(Sys3+0x14DC6,0x0002) -- Wildebeest Valley, Energy Stone is now Hi-Potion
	WriteShort(Sys3+0x14DF6,0x0083) -- Wildebeest Valley, Lucid Gem is now Tent
	WriteShort(Sys3+0x14E0E,0x0002) -- Wastelands, Serenity Gem is now Hi-Potion
	WriteShort(Sys3+0x14E26,0x0166) -- Jungle, Serenity Gem is now Serenity Stone
	WriteShort(Sys3+0x14E3E,0x0002) -- Jungle, Serenity Crystal is now Hi-Potion
	-- SIMULATED TWILIGHT TOWN
	-- SPACE PARANOIDS
	WriteShort(Sys3+0x14A06,0x0005) -- Canyon, Dark Crystal is now Mega-Potion
	WriteShort(Sys3+0x14A2A,0x0112) -- Canyon, Frost Crystal is now Drive Recovery
	WriteShort(Sys3+0x14A36,0x0083) -- Hallway, Power Crystal is now Tent
	-- TIMELESS RIVER
	WriteShort(Sys3+0x1466A,0x0112) -- Cornerstone Hill, Frost Shard is now Drive Recovery
	WriteShort(Sys3+0x146A6,0x0002) -- Waterway, Frost Stone is now Hi-Potion
	-- TWILIGHT TOWN
	WriteShort(Sys3+0x150C6,0x0004) -- Mansion Foyer, Serenity Crystal is now Elixir
	-- THE WORLD THAT NEVER WAS
end

function Popups()
	-- AGRABAH
	WriteShort(Sys3+0x1574A,0x0000) -- Lexaeus (Absent Silhouette), Strength Beyond Strength is now EMPTY
	WriteShort(Sys3+0x15786,0x0000) -- Lexaeus (Data), Lost Illusion is now EMPTY
	-- ATLANTICA
	-- BEAST'S CASTLE
	WriteShort(Sys3+0x157C2,0x0000) -- Xaldin (Data), Defense Boost is now EMPTY
	-- DISNEY CASTLE
	WriteShort(Sys3+0x1576E,0x0000) -- Marluxia (Absent Silhouette), Eternal Blossom is now EMPTY
	WriteShort(Sys3+0x157AA,0x0000) -- Marluxia (Data), Lost Illusion is now EMPTY
	WriteShort(Sys3+0x15816,0x0000) -- Lingering Will (A), Proof of Connection is now EMPTY
	WriteShort(Sys3+0x15822,0x0000) -- Lingering Will (B), Manifest Illusion is now EMPTY
	-- HALLOWEEN TOWN
	WriteShort(Sys3+0x1573E,0x0000) -- Vexen (Absent Silhouette), Road to Discovery is now EMPTY
	WriteShort(Sys3+0x1577A,0x0000) -- Vexen (Data), Lost Illusion is now EMPTY
	-- HOLLOW BASTION
	WriteShort(Sys3+0x1583A,0x0000) -- Mushroom XIII (A), Proof of Peace is now EMPTY
	WriteShort(Sys3+0x1582E,0x0000) -- Mushroom XIII (B), Winner's Proof is now EMPTY
	WriteShort(Sys3+0x157B6,0x0000) -- Demyx (Data), AP Boost is now EMPTY
	-- LAND OF DRAGONS
	WriteShort(Sys3+0x157E6,0x0000) -- Xigbar (Data), Defense Boost is now EMPTY
	-- OLYMPUS COLISEUM
	WriteShort(Sys3+0x15756,0x0000) -- Zexion (Absent Silhouette), Book of Shadows is now EMPTY
	WriteShort(Sys3+0x15792,0x0000) -- Zexion (Data), Lost Illusion is now EMPTY
	-- OLYMPUS CUPS
	-- 100 ACRE WOOD
	-- PORT ROYAL
	WriteShort(Sys3+0x157FE,0x0000) -- Luxord (Data), AP Boost is now EMPTY
	-- PRIDE LANDS
	WriteShort(Sys3+0x157F2,0x0000) -- Saix (Data), Defense Boost is now EMPTY
	-- SIMULATED TWILIGHT TOWN
	WriteShort(Sys3+0x1580A,0x0000) -- Roxas (Data), Magic Boost is now EMPTY
	-- SPACE PARANOIDS
	WriteShort(Sys3+0x15762,0x0000) -- Larxene (Absent Silhouette), Cloaked Thunder is now EMPTY
	WriteShort(Sys3+0x1579E,0x0000) -- Larxene (Data), Lost Illusion is now EMPTY
	-- TIMELESS RIVER
	-- TWILIGHT TOWN
	WriteShort(Sys3+0x154FE,0x0000) -- The Trophy's Crystals (B), Limit Form is now EMPTY
	WriteShort(Sys3+0x157CE,0x0000) -- Axel (Data), Magic Boost is now EMPTY
	-- THE WORLD THAT NEVER WAS
	WriteShort(Sys3+0x15672,0x0000) -- Time to Sleep (A), Two Become One is now EMPTY
	WriteShort(Sys3+0x157DA,0x0000) -- Xemnas (Data), Power Boost is now EMPTY
end

function BonusRewards()
	-- AGRABAH
	--Escort Abu
	-- Bonus Slot #1
	WriteShort(Btl0+0x2B032,0x0005) -- MP:0 HP:5
	WriteInt(Btl0+0x2B038,0x00000000) -- Replacement Reward #2:EMPTY, Replacement Reward #1:EMPTY
	-- Bonus Slot #2
	-- Bonus Slot #3
	-- Bonus Slot #4
	--Volcanic Lord & Blizzard Lord
	-- Bonus Slot #1
	WriteInt(Btl0+0x2AF68,0x0000010A) -- Replacement Reward #2:EMPTY, Replacement Reward #1:Explosion
	-- Bonus Slot #2
	-- Bonus Slot #3
	-- Bonus Slot #4
	--Lexaeus (Absent Silhouette)
	-- Bonus Slot #1
	WriteInt(Btl0+0x2B3A4,0x00000000) -- Armor Slot:+0 Accessory Slot:+0 Item Slot:+0 Drive Gauge:+0
	-- Bonus Slot #2
	WriteShort(Btl0+0x2B3B2,0x0000) -- MP:0 HP:0
	-- Bonus Slot #3
	WriteInt(Btl0+0x2B3C4,0x00000000) -- Armor Slot:+0 Accessory Slot:+0 Item Slot:+0 Drive Gauge:+0
	-- BEAST'S CASTLE
	-- CAVERN OF REMEMBRANCE
	--Transport to Remembrance Nobodies III
	-- Bonus Slot #1
	WriteInt(Btl0+0x2B4C4,0x00000000) -- Armor Slot:+0 Accessory Slot:+0 Item Slot:+0 Drive Gauge:+0
	-- Bonus Slot #2
	WriteShort(Btl0+0x2B4D2,0x0000) -- MP:0 HP:0
	-- Bonus Slot #3
	WriteShort(Btl0+0x2B4E2,0x0000) -- MP:0 HP:0
	-- DISNEY CASTLE
	--Marluxia (Absent Silhouette)
	-- Bonus Slot #1
	WriteInt(Btl0+0x2B404,0x00000000) -- Armor Slot:+0 Accessory Slot:+0 Item Slot:+0 Drive Gauge:+0
	-- Bonus Slot #2
	WriteShort(Btl0+0x2B412,0x0000) -- MP:0 HP:0
	-- Bonus Slot #3
	WriteShort(Btl0+0x2B422,0x0000) -- MP:0 HP:0
	--Lingering Will
	-- Bonus Slot #1
	WriteInt(Btl0+0x2B474,0x00000000) -- Armor Slot:+0 Accessory Slot:+0 Item Slot:+0 Drive Gauge:+0
	-- Bonus Slot #2
	WriteShort(Btl0+0x2B482,0x0000) -- MP:0 HP:0
	-- Bonus Slot #3
	WriteShort(Btl0+0x2B492,0x0000) -- MP:0 HP:0
	-- HALLOWEEN TOWN
	--Prison Keeper
	-- Bonus Slot #1
	WriteShort(Btl0+0x2AC62,0x0005) -- MP:0 HP:5
	WriteInt(Btl0+0x2AC68,0x00000000) -- Replacement Reward #2:EMPTY, Replacement Reward #1:EMPTY
	-- Bonus Slot #2
	-- Bonus Slot #3
	-- Bonus Slot #4
	--The Experiment
	-- Bonus Slot #1
	WriteInt(Btl0+0x2ACE8,0x0000010B) -- Replacement Reward #2:EMPTY, Replacement Reward #1:Finishing Leap
	-- Bonus Slot #2
	-- Bonus Slot #3
	-- Bonus Slot #4
	--Vexen (Absent Silhouette)
	-- Bonus Slot #1
	WriteInt(Btl0+0x2B374,0x00000000) -- Armor Slot:+0 Accessory Slot:+0 Item Slot:+0 Drive Gauge:+0
	-- Bonus Slot #2
	WriteShort(Btl0+0x2B382,0x0000) -- MP:0 HP:0
	-- Bonus Slot #3
	WriteShort(Btl0+0x2B392,0x0000) -- MP:0 HP:0
	-- HOLLOW BASTION
	-- LAND OF DRAGONS
	-- OLYMPUS COLISEUM
	--Cerberus
	-- Bonus Slot #1
	WriteInt(Btl0+0x2AA88,0x00000107) -- Replacement Reward #2:EMPTY, Replacement Reward #1:Dodge Slash
	-- Bonus Slot #2
	--Phil's Training(Story)
	-- Bonus Slot #1
	WriteInt(Btl0+0x2B268,0x0000010E) -- Replacement Reward #2:EMPTY, Replacement Reward #1:Aerial Spiral
	--Hades
	-- Bonus Slot #1
	WriteShort(Btl0+0x2AB02,0x0A00) -- MP:10 HP:0
	WriteInt(Btl0+0x2AB08,0x0000010C) -- Replacement Reward #2:EMPTY, Replacement Reward #1:Counterguard
	-- Bonus Slot #2
	-- Bonus Slot #3
	-- Bonus Slot #4
	--Zexion (Absent Silhouette)
	-- Bonus Slot #1
	WriteInt(Btl0+0x2B3D4,0x00000000) -- Armor Slot:+0 Accessory Slot:+0 Item Slot:+0 Drive Gauge:+0
	-- Bonus Slot #2
	WriteShort(Btl0+0x2B3E2,0x0000) -- MP:0 HP:0
	-- Bonus Slot #3
	WriteInt(Btl0+0x2B3F8,0x00000000) -- Replacement Reward #2:EMPTY, Replacement Reward #1:EMPTY
	-- PORT ROYAL
	--The Interceptor Pirates
	-- Bonus Slot #1
	WriteShort(Btl0+0x2B332,0x0005) -- MP:0 HP:5
	WriteInt(Btl0+0x2B338,0x00000000) -- Replacement Reward #2:EMPTY, Replacement Reward #1:EMPTY
	-- Bonus Slot #2
	-- Bonus Slot #3
	--Grim Reaper I
	-- Bonus Slot #1
	WriteInt(Btl0+0x2B2A8,0x0000018F) -- Replacement Reward #2:EMPTY, Replacement Reward #1:Summon Boost
	-- Bonus Slot #2
	-- Bonus Slot #3
	-- Bonus Slot #4
	-- PRIDE LANDS
	-- SIMULATED TWILIGHT TOWN
	--Axel I
	-- Bonus Slot #1
	WriteInt(Btl0+0x2B4F8,0x00000000) -- Replacement Reward #2:EMPTY, Replacement Reward #1:EMPTY
	-- SPACE PARANOIDS
	--Hostile Program
	-- Bonus Slot #1
	WriteInt(Btl0+0x2AEB8,0x0000010F) -- Replacement Reward #2:EMPTY, Replacement Reward #1:Horizontal Slash
	-- Bonus Slot #2
	-- Bonus Slot #3
	-- Bonus Slot #4
	--Solar Sailor Heartless
	-- Bonus Slot #1
	WriteShort(Btl0+0x2B2F2,0x0005) -- MP:0 HP:5
	WriteInt(Btl0+0x2B2F8,0x00000000) -- Replacement Reward #2:EMPTY, Replacement Reward #1:EMPTY
	-- Bonus Slot #2
	-- Bonus Slot #3
	-- Bonus Slot #4
	--Larxene (Absent Silhouette)
	-- Bonus Slot #1
	WriteShort(Btl0+0x2B432,0x0000) -- MP:0 HP:0
	-- Bonus Slot #2
	WriteInt(Btl0+0x2B444,0x00000000) -- Armor Slot:+0 Accessory Slot:+0 Item Slot:+0 Drive Gauge:+0
	-- Bonus Slot #3
	WriteShort(Btl0+0x2B452,0x0000) -- MP:0 HP:0
	-- TIMELESS RIVER
	--Pete (Steamboat Fight)
	-- Bonus Slot #1
	WriteInt(Btl0+0x2AC08,0x00000106) -- Replacement Reward #2:EMPTY, Replacement Reward #1:Slapshot
	-- Bonus Slot #2
	-- Bonus Slot #3
	-- TWILIGHT TOWN
	--Betwixt & Between Nobodies
	-- Bonus Slot #1
	WriteShort(Btl0+0x2B362,0x0A00) -- MP:10 HP:0
	WriteInt(Btl0+0x2B368,0x00000000) -- Replacement Reward #2:EMPTY, Replacement Reward #1:EMPTY
	-- THE WORLD THAT NEVER WAS
	--Roxas
	-- Bonus Slot #1
	WriteShort(Btl0+0x2B462,0x0000) -- MP:0 HP:0
	WriteInt(Btl0+0x2B468,0x00000000) -- Replacement Reward #2:EMPTY, Replacement Reward #1:EMPTY
	--Xigbar
	-- Bonus Slot #1
	WriteShort(Btl0+0x2ADA2,0x0000) -- MP:0 HP:0
	WriteInt(Btl0+0x2ADA8,0x00000057) -- Replacement Reward #2:EMPTY, Replacement Reward #1:Magnet
	-- Bonus Slot #2
	-- Bonus Slot #3
	--Luxord
	-- Bonus Slot #1
	WriteInt(Btl0+0x2ADD8,0x00000000) -- Replacement Reward #2:EMPTY, Replacement Reward #1:EMPTY
	--Saix
	-- Bonus Slot #1
	WriteShort(Btl0+0x2ADE2,0x0000) -- MP:0 HP:0
	WriteInt(Btl0+0x2ADE4,0x00000001) -- Armor Slot:+0 Accessory Slot:+0 Item Slot:+0 Drive Gauge:+1
	-- Bonus Slot #2
	-- Bonus Slot #3
	--Xemnas
	-- Bonus Slot #1
	WriteShort(Btl0+0x2AE12,0x0A00) -- MP:10 HP:0
	--Final Xemnas
	-- Bonus Slot #1
	WriteInt(Btl0+0x2B4A4,0x00000000) -- Armor Slot:+0 Accessory Slot:+0 Item Slot:+0 Drive Gauge:+0
	-- Bonus Slot #2
end

function DriveForms()
	-- SUMMON
	-- VALOR
	WriteShort(Btl0+0x344A8,0x0064) -- 100 experience is now required to reach Valor LV2
	WriteShort(Btl0+0x344B0,0x00FF) -- 255 experience is now required to reach Valor LV3
	-- WISDOM
	-- LIMIT
	-- MASTER
	-- FINAL
	WriteShort(Btl0+0x34588,0x0014) -- 20 experience is now required to reach Final LV2
	WriteShort(Btl0+0x34590,0x003C) -- 60 experience is now required to reach Final LV3
	WriteShort(Btl0+0x34598,0x0048) -- 72 experience is now required to reach Final LV4
	WriteShort(Btl0+0x345A0,0x005A) -- 90 experience is now required to reach Final LV5
	WriteShort(Btl0+0x345A8,0x006C) -- 108 experience is now required to reach Final LV6
	WriteShort(Btl0+0x345B0,0x0096) -- 150 experience is now required to reach Final LV7
end

function Equipment()
	-- KEYBLADE
	-- Kingdom Key
	WriteShort(Sys3+0x13ED6,0x019E) -- Ability: Defender
	-- Gull Wing
	WriteInt(Sys3+0x141F8,0x00000003) -- AP:0 Defense:0 Magic:0 Strength:3
	-- Sweet Memories
	WriteShort(Sys3+0x14256,0x0197) -- Ability: Lucky Lucky
	WriteInt(Sys3+0x14258,0x00000000) -- AP:0 Defense:0 Magic:0 Strength:0
	-- Two Become One
	WriteShort(Sys3+0x142F6,0x0000) -- Ability: EMPTY
	WriteInt(Sys3+0x142F8,0x00000000) -- AP:0 Defense:0 Magic:0 Strength:0
	-- Winner's Proof
	WriteShort(Sys3+0x14306,0x0000) -- Ability: EMPTY
	WriteInt(Sys3+0x14308,0x00000000) -- AP:0 Defense:0 Magic:0 Strength:0
	-- Kingdom Key D
	WriteShort(Sys3+0x140F6,0x0000) -- Ability: EMPTY
	WriteInt(Sys3+0x140F8,0x00000000) -- AP:0 Defense:0 Magic:0 Strength:0
	-- Alpha Weapon
	WriteShort(Sys3+0x13F06,0x0000) -- Ability: EMPTY
	WriteInt(Sys3+0x13F08,0x00000000) -- AP:0 Defense:0 Magic:0 Strength:0
	-- Omega Weapon
	WriteShort(Sys3+0x13F16,0x0000) -- Ability: EMPTY
	WriteInt(Sys3+0x13F18,0x00000000) -- AP:0 Defense:0 Magic:0 Strength:0
	-- Pureblood
	WriteShort(Sys3+0x13F26,0x0000) -- Ability: EMPTY
	WriteInt(Sys3+0x13F28,0x00000000) -- AP:0 Defense:0 Magic:0 Strength:0
	-- Struggle Sword
	WriteShort(Sys3+0x14116,0x0000) -- Ability: EMPTY
	WriteInt(Sys3+0x14118,0x00000103) -- AP:0 Defense:0 Magic:1 Strength:3
	-- Struggle Wand
	WriteShort(Sys3+0x1412E,0x0000) -- Ability: EMPTY
	WriteInt(Sys3+0x14130,0x00000103) -- AP:0 Defense:0 Magic:1 Strength:3
	-- Struggle Hammer
	WriteShort(Sys3+0x14146,0x0000) -- Ability: EMPTY
	WriteInt(Sys3+0x14148,0x00000103) -- AP:0 Defense:0 Magic:1 Strength:3
	-- DONALD STAFF
	-- Meteor Staff
	WriteShort(Sys3+0x13F66,0x0197) -- Ability: Lucky Lucky
	-- Rising Dragon
	WriteShort(Sys3+0x13FA6,0x019B) -- Ability: Item Boost
	-- Shaman's Relic
	WriteShort(Sys3+0x13FC6,0x019C) -- Ability: MP Rage
	-- Nobody Lance
	WriteShort(Sys3+0x13FB6,0x019E) -- Ability: Defender
	-- Centurion+
	WriteShort(Sys3+0x14326,0x0000) -- Ability: EMPTY
	WriteInt(Sys3+0x14328,0x00000000) -- AP:0 Defense:0 Magic:0 Strength:0
	-- Save the Queen+
	WriteShort(Sys3+0x142D6,0x01A6) -- Ability: MP Hastega
	-- Plain Mushroom
	WriteInt(Sys3+0x14338,0x00000000) -- AP:0 Defense:0 Magic:0 Strength:0
	-- Plain Mushroom+
	WriteInt(Sys3+0x14348,0x00000000) -- AP:0 Defense:0 Magic:0 Strength:0
	-- Precious Mushroom
	WriteShort(Sys3+0x14356,0x0000) -- Ability: EMPTY
	WriteInt(Sys3+0x14358,0x00000000) -- AP:0 Defense:0 Magic:0 Strength:0
	-- Precious Mushroom+
	WriteShort(Sys3+0x14366,0x0000) -- Ability: EMPTY
	WriteInt(Sys3+0x14368,0x00000000) -- AP:0 Defense:0 Magic:0 Strength:0
	-- Premium Mushroom
	WriteShort(Sys3+0x14376,0x0000) -- Ability: EMPTY
	WriteInt(Sys3+0x14378,0x00000000) -- AP:0 Defense:0 Magic:0 Strength:0
	-- GOOFY SHIELD
	-- Genji Shield
	WriteShort(Sys3+0x14056,0x0197) -- Ability: Lucky Lucky
	-- Nobody Guard
	WriteShort(Sys3+0x14076,0x01A3) -- Ability: Hyper Healing
	-- Frozen Pride
	WriteInt(Sys3+0x14388,0x00000000) -- AP:0 Defense:0 Magic:0 Strength:0
	-- Frozen Pride+
	WriteShort(Sys3+0x14396,0x0000) -- Ability: EMPTY
	WriteInt(Sys3+0x14398,0x00000000) -- AP:0 Defense:0 Magic:0 Strength:0
	-- Save the King+
	WriteShort(Sys3+0x142E6,0x019C) -- Ability: MP Rage
	-- Joyous Mushroom
	WriteInt(Sys3+0x143A8,0x00000000) -- AP:0 Defense:0 Magic:0 Strength:0
	-- Joyous Mushroom+
	WriteInt(Sys3+0x143B8,0x00000000) -- AP:0 Defense:0 Magic:0 Strength:0
	-- Majestic Mushroom
	WriteShort(Sys3+0x143C6,0x0000) -- Ability: EMPTY
	WriteInt(Sys3+0x143C8,0x00000000) -- AP:0 Defense:0 Magic:0 Strength:0
	-- Majestic Mushroom+
	WriteShort(Sys3+0x143D6,0x0000) -- Ability: EMPTY
	WriteInt(Sys3+0x143D8,0x00000000) -- AP:0 Defense:0 Magic:0 Strength:0
	-- Ultimate Mushroom
	WriteShort(Sys3+0x143E6,0x0000) -- Ability: EMPTY
	WriteInt(Sys3+0x143E8,0x00000000) -- AP:0 Defense:0 Magic:0 Strength:0
	-- ALLY WEAPON
	-- ARMOR
	-- Ribbon
	WriteInt(Sys3+0x13C8C,0x50505064) -- Thunder:20% Blizzard:20% Fire:20% Physical:0%
	WriteInt(Sys3+0x13C90,0x000506450) -- Universal:20% Light:0% Dark:20%
	-- ACCESSORY
end

function LevelRewards()
	-- Level: 1
	-- No Level 1 Dream Weapon Rewards
	-- Level: 4
	WriteShort(Btl0+0x25960,0x008A) -- Sword Reward: Scan
	WriteShort(Btl0+0x25962,0x008A) -- Shield Reward: Scan
	WriteShort(Btl0+0x25964,0x008A) -- Staff Reward: Scan
	-- Level: 41
	WriteShort(Btl0+0x25BB0,0x0197) -- Sword Reward: Lucky Lucky
	WriteShort(Btl0+0x25BB2,0x019C) -- Shield Reward: MP Rage
	-- Level: 53
	WriteShort(Btl0+0x25C72,0x0197) -- Shield Reward: Lucky Lucky
	WriteShort(Btl0+0x25C74,0x019C) -- Staff Reward: MP Rage
	-- Level: 99
	-- Cannot Level to 100 so experience is not changed
	WriteShort(Btl0+0x25F50,0x019C) -- Sword Reward: MP Rage
	WriteShort(Btl0+0x25F54,0x0197) -- Staff Reward: Lucky Lucky
end

function AbilityCosts()
	-- MAGIC
	-- DRIVES AND SUMMONS
	-- PARTY LIMITS
end

function StartingStatus()
	WriteByte(Btl0+0x310D3,0x14) -- Starting HP: 20
	WriteShort(Btl0+0x310D4,0x0764) -- Starting AP: 7 Starting MP: 100
-- Starting Stuff:
	WriteShort(Btl0+0x3305C,0x0000)-- Starting with: EMPTY
	WriteShort(Btl0+0x3305E,0x0000)-- Starting with: EMPTY
	WriteShort(Btl0+0x33060,0x0000)-- Starting with: EMPTY
	WriteShort(Btl0+0x33062,0x0000)-- Starting with: EMPTY
	WriteShort(Btl0+0x33064,0x0000)-- Starting with: EMPTY
	WriteShort(Btl0+0x33066,0x0000)-- Starting with: EMPTY
	WriteShort(Btl0+0x33068,0x0000)-- Starting with: EMPTY
	WriteShort(Btl0+0x3306A,0x0000)-- Starting with: EMPTY
	WriteShort(Btl0+0x3306C,0x0000)-- Starting with: EMPTY
	WriteShort(Btl0+0x3306E,0x0000)-- Starting with: EMPTY
	WriteShort(Btl0+0x33070,0x0000)-- Starting with: EMPTY
	WriteShort(Btl0+0x33072,0x0000)-- Starting with: EMPTY
	WriteShort(Btl0+0x33074,0x0000)-- Starting with: EMPTY
	WriteShort(Btl0+0x33076,0x0000)-- Starting with: EMPTY
	WriteShort(Btl0+0x33078,0x0000)-- Starting with: EMPTY
	WriteShort(Btl0+0x3307A,0x0000)-- Starting with: EMPTY
	WriteShort(Btl0+0x3307C,0x0000)-- Starting with: EMPTY
	WriteShort(Btl0+0x3307E,0x0000)-- Starting with: EMPTY
	WriteShort(Btl0+0x33080,0x0000)-- Starting with: EMPTY
	WriteShort(Btl0+0x33082,0x0000)-- Starting with: EMPTY
	WriteShort(Btl0+0x33084,0x0000)-- Starting with: EMPTY
	WriteShort(Btl0+0x33086,0x0000)-- Starting with: EMPTY
	WriteShort(Btl0+0x33088,0x0000)-- Starting with: EMPTY
	WriteShort(Btl0+0x3308A,0x0000)-- Starting with: EMPTY
	WriteShort(Btl0+0x3308C,0x0000)-- Starting with: EMPTY
	WriteShort(Btl0+0x3308E,0x0000)-- Starting with: EMPTY
	WriteShort(Btl0+0x33090,0x0000)-- Starting with: EMPTY
	WriteShort(Btl0+0x33092,0x0000)-- Starting with: EMPTY
	WriteShort(Btl0+0x33094,0x0000)-- Starting with: EMPTY
	WriteShort(Btl0+0x33096,0x0000)-- Starting with: EMPTY
	WriteShort(Btl0+0x33098,0x0000)-- Starting with: EMPTY
	WriteShort(Btl0+0x3309A,0x0000)-- Starting with: EMPTY
end

function Cheats()
end