local NPC = {} -- DO NOT TOUCH

NPC.Name = "Brotherhood Of Steel Quartermaster Ollie Jefferson" -- just a name
NPC.Category = "Fusion: vNPC"
NPC.Base             = "npc_npc_basic_npc"
NPC.Spawnable        = true
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
    hair = {9, Vector(255 / 255, 255 / 255, 255 / 255)},
    eyecolor = 2,
    parts = {
    {
    slot = "chest",
    model = "models/player/alaska/bosscribenew/female.mdl",
    skipFlags = {HIDE_PANTS, HIDE_BODY, HIDE_HANDS}
}
}
}




local shop_id = "Brotherhood Of Steel Quartermaster"
local shop = CHAT_LIB:RegisterShop(shop_id)
shop:AddNewItem("bost45",35000)
shop:AddNewItem("bost45helmet",10000)
shop:AddNewItem("bost51",52000)
shop:AddNewItem("BOSadvancedPaladinPowerArmor",60000)
shop:AddNewItem("BOSadvancedPaladinhelmet",15000)
shop:AddNewItem("BOSenlistedarmor",6000)
shop:AddNewItem("BOSenlistedhood",1200)
shop:AddNewItem("BOSreconarmor",8500)
shop:AddNewItem("laserriflescp",1250)
shop:AddNewItem("tribeam",4800)
shop:AddNewItem("laserrifle",1000)
shop:AddNewItem("laserrcw",3150)
shop:AddNewItem("nvlaserpistol",500)
shop:AddNewItem("prestinelaserpistol",750)

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