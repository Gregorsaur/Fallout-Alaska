
local NPC = {} -- DO NOT TOUCH

NPC.Name = "Enclave L.S.C.C" -- just a name
NPC.Category = "Fusion: vNPC"
NPC.Base 			= "npc_npc_basic_npc"
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
    model = "models/fallout_alaska/alaska_playermodels/enclaveofficer_female_body.mdl", "models/fallout_alaska/alaska_playermodels/enclaveofficer_female_hat.mdl",
    skipFlags = {HIDE_PANTS, HIDE_BODY, HIDE_HAIR}
}
}
}

 


local shop_id = "lscc"
local shop = CHAT_LIB:RegisterShop(shop_id)
shop:AddNewItem("EnclaveEnlisted",1200)
shop:AddNewItem("EnclaveTrooperUniform",1500)
shop:AddNewItem("Enclavehat",1000)
shop:AddNewItem("enclavepowerarmor",40000)
shop:AddNewItem("enclavepowerarmorhelmet",10000)
shop:AddNewItem("enclaveteslapowerarmor",50000)
shop:AddNewItem("enclaveteslapowerarmorhelmet",10000)
shop:AddNewItem("enclaveHellfirepowerarmor",50000)
shop:AddNewItem("enclaveHellfirepowerarmorhelmet",10000)
shop:AddNewItem("enclaveRhinopowerarmor",60000)
shop:AddNewItem("enclaveRhinopowerarmorhelmet",10000)
shop:AddNewItem("enclavet51powerarmor",42000)
shop:AddNewItem("enclavet51powerarmorhelmet",10000)
shop:AddNewItem("enclavescientist",2500)
shop:AddNewItem("enclaveagentapa",75000)
shop:AddNewItem("enclaveagentapahelmet",10000)
shop:AddNewItem("plaserrifle",1000)

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