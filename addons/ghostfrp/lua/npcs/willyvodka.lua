
local NPC = {} -- DO NOT TOUCH

NPC.Name = "Willy Vodka The Wastelander Merchant" -- just a name
NPC.Category = "Fusion: vNPC"
NPC.Base 			= "npc_npc_basic_npc.lua"
NPC.Spawnable		= true
NPC.PrintName = NPC.Name
local APP = util.JSONToTable([[{"hair":[1.0,"[0.2188 0.1875 0.125]","[0.2188 0.1875 0.125]"],"parts":{"torso":{"skipFlags":[32.0,1.0,8.0,4.0,2.0],"model":"models/fallout_alaska/alaska_playermodels/enclave_power_armor_body.mdl","slot":"torso"},"helmet":{"skipFlags":[4.0,2.0,34.0],"model":"models/fallout_alaska/alaska_playermodels/enclave_power_armor_helmet.mdl","slot":"helmet"}},"bones":[],"eyecolor":6.0,"move_bones":[],"facial_hair":0.0,"ghoul":0.0}]])
NPC.data = APP





NPC.ShopID = shop_id
NPC.Dialog = {

 ["name"] = NPC.Name, --literally the npc name
  ["1"] = {
 
  response = "what was you saying again?", -- this is if we want the chat to loop back to the start
  action = "say",
  data = "hello!",
  choices = "shop"
  },


    ["bye"] = { 
  response = "Goodbye.",
  action = "close",
  },

}  




-- IGNORE BELOW
if CY_LINK_LOADED then
	scripted_ents.Register( NPC, "npc_"..debug.getinfo(1, "S").source:sub(2):match("(.+)%.lua"):sub(#"npc_addons/ghostfrp/lua/npc"-1)..".lua" )
end
return NPC -- DO NOT TOUCH 2. Electric Boogaloo