-- name: [CS] \\#FF79AA\\Kirby \\#FFFF3C\\Deluxe!
-- description: Play as the pink puffball warrior with a moveset inspired by \\#FFFF3C\\Kirby and the Forgotten Land (2022)\\#DBDBDB\\, comes with both "Normal" and "Classic" costumes!\n\nKirby is owned by HAL Laboratory, Inc., voice clips from existing works (K64, SSB, SSBM) by Makiko Ohmoto.\n\n\\#ff7777\\This Pack requires Character Select\nto use as a Library!

if not _G.charSelectExists then
    djui_popup_create("\\#ffffdc\\\n\"[CS] Kirby Deluxe!\"\nRequires the Character Select Mod\nto use as a Library!\n\nPlease turn on the Character Select Mod\nand Restart the Room!", 6)
    return 0
end

local csVersion = _G.charSelect.version_get_full()
if csVersion.major < 16 then
	djui_popup_create("\\#ffffdc\\\n\"[CS] Kirby Deluxe!\"\nRequires Character Select v1.16+!\n\nPlease update the Mod\nand Host a new Room!", 6)
	return 0
end

if VERSION_NUMBER < 40 then
	djui_popup_create("\\#ffffdc\\\n\"[CS] Kirby Deluxe!\"\nRequires SM64 Coop DX v1.4+!\n\nPlease update the Application\nand Host a new Room!", 6)
	return 0
end

define_custom_obj_fields({oHasKirbySucked = 's32', oKirbySuckPlayer = 's32'})

local E_MODEL_KIRBY = smlua_model_util_get_id("kirby_geo") 
local E_MODEL_KIRBY_RETRO = smlua_model_util_get_id("kirby_retro_geo") 

local TEX_GRAFFITI_KIRBY = get_texture_info("kirby-graffiti")
local TEX_CUSTOM_LIFE_ICON = get_texture_info("kirby-icon") 

KIRBY_COPY_SOUND = audio_sample_load("SOUND_COPY.ogg")
KIRBY_OBJECT_SOUND = audio_sample_load("SOUND_OBJECT.ogg")
KIRBY_LAND_SOUND = audio_sample_load("SOUND_LAND.ogg")
KIRBY_STEP_SOUND = audio_sample_load("SOUND_STEP.ogg")
KIRBY_HIT_SOUND = audio_sample_load("SOUND_HITENEMY.ogg")
KIRBY_INHALE_SOUND = audio_stream_load("SOUND_INHALE.ogg")
audio_stream_set_looping(KIRBY_INHALE_SOUND, true)
audio_stream_set_loop_points(KIRBY_INHALE_SOUND, 0.543*16000, 1.123*16000)
local KIRBY_VOICETABLE = {
	[CHAR_SOUND_OKEY_DOKEY] =         'VOICE_LETSAGO2.ogg', 
	[CHAR_SOUND_HELLO] =              {'VOICE_LETSAGO4.ogg', 'VOICE_LETSAGO.ogg', 'VOICE_LETSAGO3.ogg', 'VOICE_LETSAGO2.ogg'}, 
	[CHAR_SOUND_LETS_A_GO] =          'VOICE_LETSAGO2.ogg', 
	[CHAR_SOUND_PUNCH_YAH] =          'SOUND_LAUNCH_STAR.ogg', 
	[CHAR_SOUND_PUNCH_WAH] =          'SOUND_SWALLOW.ogg', 
	[CHAR_SOUND_PUNCH_HOO] =          'SOUND_EXHALE.ogg', 
	[CHAR_SOUND_YAH_WAH_HOO] =        'SOUND_JUMP.ogg', 
	[CHAR_SOUND_HOOHOO] =             'SOUND_PUFF.ogg', 
	[CHAR_SOUND_YAHOO_WAHA_YIPPEE] =  'VOICE_LETSAGO3.ogg', 
	[CHAR_SOUND_UH] =                 'VOICE_LEDGE.ogg', 
	[CHAR_SOUND_UH2] =                'VOICE_ATTACK.ogg', 
	[CHAR_SOUND_UH2_2] =              'SOUND_SLIDE_KICK.ogg', 
	[CHAR_SOUND_DOH] =                'VOICE_HURT.ogg', 
	[CHAR_SOUND_OOOF] =               'VOICE_HURT2.ogg', 
	[CHAR_SOUND_OOOF2] =              'VOICE_HURT.ogg', 
	[CHAR_SOUND_HAHA] =               'VOICE_ATTACK.ogg', 
	[CHAR_SOUND_HAHA_2] =             'VOICE_ATTACK.ogg', 
	[CHAR_SOUND_YAHOO] =              'SOUND_JUMP.ogg', 
	[CHAR_SOUND_DOH] =                'VOICE_HURT.ogg', 
	[CHAR_SOUND_WHOA] =               'VOICE_WHOA.ogg', 
	[CHAR_SOUND_EEUH] =               'VOICE_LIFT.ogg', 
	[CHAR_SOUND_WAAAOOOW] =           'VOICE_FALL.ogg', 
	[CHAR_SOUND_TWIRL_BOUNCE] =       'VOICE_ATTACK.ogg', 
	[CHAR_SOUND_GROUND_POUND_WAH] =   'VOICE_ATTACK.ogg', 
	[CHAR_SOUND_WAH2] =               'VOICE_BIG_THROW.ogg', 
	[CHAR_SOUND_HRMM] =               'VOICE_LIFT.ogg', 
	[CHAR_SOUND_HERE_WE_GO] =         'VOICE_LETSAGO2.ogg', 
	[CHAR_SOUND_SO_LONGA_BOWSER] =    'VOICE_BOWSER.ogg', 

	[CHAR_SOUND_ATTACKED] =     {'VOICE_HURT.ogg', 'VOICE_HURT3.ogg', 'VOICE_HURT2.ogg'}, 
	[CHAR_SOUND_PANTING] =      'VOICE_PANT.ogg', 
	[CHAR_SOUND_ON_FIRE] =      'VOICE_BURNING.ogg', 

	[CHAR_SOUND_DYING] =    'VOICE_DYING.ogg', 
	[CHAR_SOUND_DROWNING] = 'VOICE_HURT2.ogg', 
	[CHAR_SOUND_MAMA_MIA] = 'VOICE_DYING2.ogg' 
}

local KIRBY_PALETTES = {
	{
		name = "Kirby Pink",
		[PANTS] = "FF79AA", [SHIRT] = "FF79AA", [GLOVES] = "FF79AA", [HAIR] = "FF79AA", [SKIN] = "FF79AA", [CAP] = "FF79AA",
		[SHOES] = "FF0032", [EMBLEM] = "FFFF00"
	}, {
		name = "Keeby Yellow",
		[PANTS] = "FFC800", [SHIRT] = "FFC800", [GLOVES] = "FFC800", [HAIR] = "FFC800", [SKIN] = "FFC800", [CAP] = "FFC800",
		[SHOES] = "E16100", [EMBLEM] = "FFFF00"
	}, {
		name = "Red",
		[PANTS] = "E4003E", [SHIRT] = "E4003E", [GLOVES] = "E4003E", [HAIR] = "E4003E", [SKIN] = "E4003E", [CAP] = "E4003E",
		[SHOES] = "7F0040", [EMBLEM] = "FFFF00"
	}, {
		name = "Blue",
		[PANTS]  = "46E1FF", [SHIRT] = "46E1FF", [GLOVES] = "46E1FF", [HAIR] = "46E1FF", [SKIN] = "46E1FF", [CAP] = "46E1FF",
		[SHOES] = "004BFF", [EMBLEM] = "FFFF00"
	}, {
		name = "Green",
		[PANTS] = "4CE046", [SHIRT] = "4CE046", [GLOVES] = "4CE046", [HAIR] = "4CE046", [SKIN] = "4CE046", [CAP] = "4CE046",
		[SHOES] = "246842", [EMBLEM] = "FFFF00"
	}, {
		name = "Orange",
		[PANTS] = "F88400", [SHIRT] = "F88400", [GLOVES] = "F88400", [HAIR] = "F88400", [SKIN] = "F88400", [CAP] = "F88400",
		[SHOES] = "F84800", [EMBLEM] = "FFFF00"
	}, {
		name = "Snow",
		[PANTS] = "D8FFFF", [SHIRT] = "D8FFFF", [GLOVES] = "D8FFFF", [HAIR] = "D8FFFF", [SKIN] = "D8FFFF", [CAP] = "D8FFFF",
		[SHOES] = "F8371F", [EMBLEM] = "FFFF00"
	}, {
		name = "Carbon",
		[PANTS] = "444C4C", [SHIRT] = "444C4C", [GLOVES] = "444C4C", [HAIR] = "444C4C", [SKIN] = "444C4C", [CAP] = "444C4C",
		[SHOES] = "F86900", [EMBLEM] = "FFFF00"
	}, {
		name = "Sapphire",
		[PANTS] = "7488F8", [SHIRT] = "7488F8", [GLOVES] = "7488F8", [HAIR] = "7488F8", [SKIN] = "7488F8", [CAP] = "7488F8",
		[SHOES] = "4908CC", [EMBLEM] = "FFFF00"
	}, {
		name = "Grape",
		[PANTS] = "B674C8", [SHIRT] = "B674C8", [GLOVES] = "B674C8", [HAIR] = "B674C8", [SKIN] = "B674C8", [CAP] = "B674C8",
		[SHOES] = "A72090", [EMBLEM] = "FFFF00"
	}, {
		name = "Emerald",
		[PANTS] = "6DF89F", [SHIRT] = "6DF89F", [GLOVES] = "6DF89F", [HAIR] = "6DF89F", [SKIN] = "6DF89F", [CAP] = "6DF89F",
		[SHOES] = "F88C00", [EMBLEM] = "FFFF00"
	}, {
		name = "Chocolate",
		[PANTS] = "C65C35", [SHIRT] = "C65C35", [GLOVES] = "C65C35", [HAIR] = "C65C35", [SKIN] = "C65C35", [CAP] = "C65C35",
		[SHOES] = "991015", [EMBLEM] = "FFFF00"
	}, {
		name = "Cherry",
		[PANTS] = "FF56A5", [SHIRT] = "FF56A5", [GLOVES] = "FF56A5", [HAIR] = "FF56A5", [SKIN] = "FF56A5", [CAP] = "FF56A5",
		[SHOES] = "18B64A", [EMBLEM] = "FFFF00"
	}, {
		name = "Chalk",
		[PANTS] = "CDCDCD", [SHIRT] = "CDCDCD", [GLOVES] = "CDCDCD", [HAIR] = "CDCDCD", [SKIN] = "CDCDCD", [CAP] = "CDCDCD",
		[SHOES] = "727272", [EMBLEM] = "FFFF00"
	}, {
		name = "Mirror Shadow",
		[PANTS] = "6D6D7C", [SHIRT] = "6D6D7C", [GLOVES] = "6D6D7C", [HAIR] = "6D6D7C", [SKIN] = "6D6D7C", [CAP] = "6D6D7C",
		[SHOES] = "2A2A3D", [EMBLEM] = "FFFF00"
	}, {
		name = "Ivory",
		[PANTS] = "EAC28A", [SHIRT] = "EAC28A", [GLOVES] = "EAC28A", [HAIR] = "EAC28A", [SKIN] = "EAC28A", [CAP] = "EAC28A",
		[SHOES] = "A15C11", [EMBLEM] = "FFFF00"
	}, {
		name = "Lime",
		[PANTS] = "64FF00", [SHIRT] = "64FF00", [GLOVES] = "64FF00", [HAIR] = "64FF00", [SKIN] = "64FF00", [CAP] = "64FF00",
		[SHOES] = "DB7918", [EMBLEM] = "FFFF00"
	}, {
		name = "White",
		[PANTS] = "E5E5E5", [SHIRT] = "E5E5E5", [GLOVES] = "E5E5E5", [HAIR] = "E5E5E5", [SKIN] = "E5E5E5", [CAP] = "E5E5E5",
		[SHOES] = "B2B2B2", [EMBLEM] = "FFFF00"
	}, {
		name = "Lavender",
		[PANTS] = "C786E7", [SHIRT] = "C786E7", [GLOVES] = "C786E7", [HAIR] = "C786E7", [SKIN] = "C786E7", [CAP] = "C786E7",
		[SHOES] = "715CC2", [EMBLEM] = "FFFF00"
	},
}

local KIRBY_HEALTHMETER = {
    label = {
        left = get_texture_info("LeftHealth"),
        right = get_texture_info("RightHealth"),
    },
    pie = {
        [1] = get_texture_info("Pie1"),
        [2] = get_texture_info("Pie2"),
        [3] = get_texture_info("Pie3"),
        [4] = get_texture_info("Pie4"),
        [5] = get_texture_info("Pie5"),
        [6] = get_texture_info("Pie6"),
        [7] = get_texture_info("Pie7"),
        [8] = get_texture_info("Pie8"),
    }
}

function kirbyWing_JJJ(node, matStackIndex)
	local leftWing = node.next
	local rightWing = node.next.next
	local ringWing = node.next.next.next
	
	local bodyState = geo_get_body_state()

	if bodyState.capState & 2 ~= 0 then
		leftWing.flags = leftWing.flags | GRAPH_RENDER_ACTIVE
		rightWing.flags = rightWing.flags | GRAPH_RENDER_ACTIVE
		ringWing.flags = ringWing.flags | GRAPH_RENDER_ACTIVE
	else
		leftWing.flags = leftWing.flags & ~GRAPH_RENDER_ACTIVE
		rightWing.flags = rightWing.flags & ~GRAPH_RENDER_ACTIVE
		ringWing.flags = ringWing.flags & ~GRAPH_RENDER_ACTIVE
	end
end

function kirbyInhale_JJJ(node, matStackIndex)
	local asSwitchNode = cast_graph_node(node)
	local m = geo_get_mario_state()
	local idx = m.playerIndex
	local toNode = 0
	if m.action == ACT_KIRBY_INHALE or (m.action == ACT_JUMP_KICK and m.marioObj.header.gfx.animInfo.animFrame < 10) or (m.action == ACT_WATER_PUNCH and m.marioObj.header.gfx.animInfo.animFrame < 5) then
		toNode = 1
	elseif gPlayerSyncTable[idx].kirbyMouthCounter_JJJ > 0 or m.action == ACT_KIRBY_PUFF then
		toNode = 2
	end
	asSwitchNode.selectedCase = toNode
end

function kirbyMouth_JJJ(node, matStackIndex)
	local asSwitchNode = cast_graph_node(node)
	local m = geo_get_mario_state()
	asSwitchNode.selectedCase = gPlayerSyncTable[m.playerIndex].kirbyMouthState
end

local kirbyCaps = {
	normal = smlua_model_util_get_id("kirby_cap_geo"),
	wing = smlua_model_util_get_id("kirby_cap_wing_geo"),
	metal = smlua_model_util_get_id("kirby_cap_metal_geo"),
	metalWing = smlua_model_util_get_id("kirby_cap_metal_wing_geo")
}

for i = 1, #KIRBY_PALETTES do
	charSelect.character_add_palette_preset(E_MODEL_KIRBY, KIRBY_PALETTES[i], KIRBY_PALETTES[i].name)
	charSelect.character_add_palette_preset(E_MODEL_KIRBY_RETRO, KIRBY_PALETTES[i], KIRBY_PALETTES[i].name)
end

kirbyCharID = _G.charSelect.character_add("Kirby", "The fearless hero of Planet Popstar! His naïveté may lead him to act on sheer impulse, but this pink puffball will do whatever it takes to protect their friends from evil, hopefully he'll get a slice of cake afterward as a reward!", "JayJayJay!", "FF79AA", E_MODEL_KIRBY, CT_MARIO, TEX_CUSTOM_LIFE_ICON)
_G.charSelect.character_add_health_meter(kirbyCharID, KIRBY_HEALTHMETER)

kirbyRetroCosID = _G.charSelect.character_add_costume(kirbyCharID, "Kirby (Classic)", "The one that started it all! Coming in like a warm spring breeze in the early 90s, this helper-turned-hero's got the agility and bravery to take on the nefarious King De-... Bowser?! ... Ah, forget it, you know what they say, can't go wrong with taking on the classics every once in a while!", "JayJayJay!", "FF79AA", E_MODEL_KIRBY_RETRO, CT_MARIO, TEX_CUSTOM_LIFE_ICON)
_G.charSelect.character_add_costume_health_meter(kirbyCharID, kirbyRetroCosID, KIRBY_HEALTHMETER)

_G.charSelect.character_add_caps(E_MODEL_KIRBY, kirbyCaps)
_G.charSelect.character_add_voice(E_MODEL_KIRBY, KIRBY_VOICETABLE)
_G.charSelect.character_add_animations(E_MODEL_KIRBY, kirbyAnims.anims, kirbyAnims.eyes)

_G.charSelect.character_add_caps(E_MODEL_KIRBY_RETRO, kirbyCaps)
_G.charSelect.character_add_voice(E_MODEL_KIRBY_RETRO, KIRBY_VOICETABLE)

_G.charSelect.character_add_animations(E_MODEL_KIRBY_RETRO, kirbyAnims.anims, kirbyAnims.eyes)
_G.charSelect.character_add_menu_instrumental(kirbyCharID, audio_stream_load("menu.ogg"))
_G.charSelect.character_add_graffiti(kirbyCharID, TEX_GRAFFITI_KIRBY)

local function run_func_or_get_var(x, ...) if type(x) == "function" then return x(...) else return x end end

hook_event(HOOK_MARIO_UPDATE, function (m) -- Based on original "Character Select" code by Squishy, made to provide compatibility with mouth states.
	local idx = m.playerIndex
	local modelId = _G.charSelect.character_get_current_number(idx)
	
	if modelId ~= kirbyCharID then return end
	
	local animInfo = m.marioObj.header.gfx.animInfo
	
	gPlayerSyncTable[idx].kirbyMouthState = 0
	local mouthState = kirbyAnims.mouth and run_func_or_get_var(kirbyAnims.mouth[animInfo.animID], m, animInfo.animFrame)
	if mouthState then
		gPlayerSyncTable[idx].kirbyMouthState = mouthState
	end
end)