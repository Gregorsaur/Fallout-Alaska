FACTION.name = "Badlanders"
FACTION.desc = "Alaskan Natives"
FACTION.color = Color(254, 254, 254)
FACTION.setclass = "badlanders Enlisted"
FACTION.isDefault = false
FACTION.isGloballyRecognized = false
--[[
FACTION.weapons = {
	"cross_arms_swep",
	"cross_arms_infront_swep",
	"high_five_swep",
	"middlefinger_animation_swep",
	"point_in_direction_swep",
	"salute_swep",
	"surrender_animation_swep",
}
]]
function FACTION:onSpawn(client)
    local char = client:getChar()
    if char:isPerkOwned(33) then
        client:SetMaxHealth(200 + (client:getChar():getAttrib("end", 0)) * 5)
        client:SetHealth(200 + (client:getChar():getAttrib("end", 0)) * 5)
    else
        client:SetMaxHealth(150 + (client:getChar():getAttrib("end", 0)) * 5)
        client:SetHealth(150 + (client:getChar():getAttrib("end", 0)) * 5)
    end
end
FACTION.pay = 1
FACTION_BADLANDER = FACTION.index