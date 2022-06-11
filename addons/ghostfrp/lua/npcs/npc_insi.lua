
local NPC = {} -- DO NOT TOUCH

NPC.Name = "X04"
NPC.Category = "Fusion: vNPC"
NPC.Base 			= "npc_basic_npc"
NPC.Spawnable		= true
NPC.PrintName = NPC.Name 
NPC.data = { 
    bones = {
        [1] = Vector(1, 1, 1),
    },
    move_bones = {
        [1] = Vector(0, 0, 0),
    },
    skin = Vector(2, 2, 2),
    facial_hair = 0,
    hair = {3, Vector(255 / 255, 255 / 255, 255 / 255)},
    eyecolor = 2,
	parts = {
	{
    slot = "chest",
    model = "models/thespireroleplay/humans/group104/female.mdl",
    skipFlags = {HIDE_PANTS, HIDE_BODY}
}
}
}




local shop_id = "test_01"
local shop = CHAT_LIB:RegisterShop(shop_id)
shop:AddNewItem("weapon_revolver",100)



NPC.ShopID = shop_id
NPC.Dialog = {

 ["name"] = NPC.Name,
  ["1"] = {
 
  response = "what was you saying again?", -- this is if we want the chat to loop back to the start
  action = "say",
  data = "hello!",
  choices = "shop"
  },

    ["shop"] = { 
  response = "Shop",
  action = "open_shop",
  data = shop_id,
  choices = ""
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