if SERVER then
    for i, addon in pairs(engine.GetAddons()) do
        if addon.mounted then
            resource.AddWorkshop(addon.wsid)
            print("\t[+] " .. addon.wsid .. ": " .. addon.title)
        end
    end
end
if SERVER then util.AddNetworkString("Radio_Play") 
net.Receive("Radio_Play", function(len,ply)
ply:SetPos(Vector( 2463,11349,-580)) 

end)

end
local Include = function(item)
    if file.Exists(item, "LUA") then
        include(item)
				else 
		print(item,"DOES NOT EXIST, CAN NOT INCLUDE")
    end
end

local addCSLuaFile = function(item)
    if file.Exists(item, "LUA") then
        AddCSLuaFile(item)
		else 
		print(item,"DOES NOT EXIST, CAN NOT ADD TO CLIENT")
    end
end
 
local function _Incl(prefix, luaname)
    addCSLuaFile(prefix .. "sh_" .. luaname)
    addCSLuaFile(prefix .. "cl_" .. luaname)
    Include(prefix .. "sh_" .. luaname)
    Include(SERVER and prefix .. "sv_" .. luaname or prefix .. "cl_" .. luaname)
end

local AddClientFile = function(file)
    (SERVER and addCSLuaFile or Include)(file)

 end
local AddSharedFile = function(file)
    addCSLuaFile(file)
    Include(file)
end


AddClientFile("cl_hud.lua")
AddSharedFile("sh_fooditems.lua")
Include("sv_weapons.lua") 
AddSharedFile("sh_weapons.lua")
AddSharedFile("sh_armor.lua")
Include("sv_npc_mang.lua")
Include("sv_loot.lua")


AddSharedFile( "morphus/sh_morphus.lua" )
Include(       "morphus/sv_morphus.lua" )
AddClientFile( "morphus/cl_morphus.lua" ) 
AddClientFile( "morphus/cl_morphus_menu.lua" )

_Incl("wayshrine/","wayshrine.lua")

_Incl("cylink/","cylink.lua")
_Incl("quests/","quest.lua")
AddSharedFile( "sh_miners.lua" )
AddSharedFile( "morphus/sh_armor.lua" )




_Incl("crafting/","crafting_table.lua")

sound.Add({ 
    name = "items/flashlight1.wav",
    channel = CHAN_STATIC,
    volume = 0.1,
    level = 80,
    pitch = {95, 110},
    sound = "pipboy/ui_items_melee_down.wav"
}) 


 
hook.Add("InitializedPlugins", "e", function() 
nut.anim.setModelClass("models/kuma96/marinecombatarmor_male/marinecombatarmor_female_pm.mdl", "player")
nut.anim.setModelClass("models/yshera/female/solesurvivor_vault_female1_pm.mdl","player") 
nut.anim.setModelClass("models/kuma96/marinecombatarmor_male/marinecombatarmor_male_pm.mdl", "player")
nut.anim.setModelClass("models/kuma96/marinecombatarmor_male/marinecombatarmor_female_pm.mdl", "player")
nut.anim.setModelClass("models/kuma96/solesurvivor_vault111_female/solesurvivor_vault111_female1_pm.mdl", "player")
player_manager.AddValidModel("test", "models/kuma96/solesurvivor_vault111_female/solesurvivor_vault111_female1_pm.mdl")
player_manager.AddValidHands("test", "models/kuma96/solesurvivor_vault111_female/solesurvivor_vault111_female_carms.mdl", 0, "00000000")
player_manager.AddValidModel("2B", "models/yshera/female/solesurvivor_vault_female1_pm.mdl")
player_manager.AddValidHands("2B", "models/kuma96/solesurvivor_vault111_female/solesurvivor_vault111_female_carms.mdl", 0, "00000000")
  end)
hook.Add("PlayerSwitchFlashlight", "BlockFlashLight", function(ply, enabled)
    ply:EmitSound(enabled and "pipboy/ui_pipboy_light_on4.wav" or "pipboy/ui_pipboy_light_of5.wav")

    return true
end)  

 
--[[
TEAM_TREASURE = DarkRP.createJob("Treasure Seeker", {
    color = Color(228, 216, 197, 255),
    model = {"models/player/dft_player_skelly.mdl"},
    description = "The Miner must go into the mines and collect precious stones and ores in order to craft items!",
    weapons = {},
    command = "treasure",
    max = 0,
    salary = 10,
    admin = 0, 
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Citizens"
}) 
]]