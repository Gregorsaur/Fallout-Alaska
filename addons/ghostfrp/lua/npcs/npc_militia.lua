
local NPC = {} -- DO NOT TOUCH

NPC.Name = "Militia Quartermaster Kanan Rad" -- just a name
NPC.Category = "Fusion: vNPC"
NPC.Base 			= "npc_npc_basic_npc.lua"
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
    hair = {2, Vector(255 / 255, 255 / 255, 255 / 255)},
    eyecolor = 2,
	  parts = {
	  {
    slot = "chest",
    model = "models/ncr/colonelf.mdl",
    skipFlags = {HIDE_PANTS, HIDE_BODY}
}
}
}




local shop_id = "militia"
local shop = CHAT_LIB:RegisterShop(shop_id)
shop:AddNewItem("AlsakanExile",1000)
shop:AddNewItem("Alsakancolonel",50000)
shop:AddNewItem("Alsakanmilitiaofficer",2500)
shop:AddNewItem("AlsakanVeteranRangerUniform",5000)
shop:AddNewItem("AlsakanRangerUniform",5000)
shop:AddNewItem("AlsakanRangerHelmet",1000)
shop:AddNewItem("10mmpistol",500)
shop:AddNewItem("servicerifle",1250)

NPC.ShopID = shop_id
NPC.Dialog = {

 ["name"] = NPC.Name, --literally the npc name
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