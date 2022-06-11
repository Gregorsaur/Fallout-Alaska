FACTION.name = "Wastelander"
FACTION.desc = "The Survivors of the waste"
FACTION.color = Color(254, 254, 254)
FACTION.isDefault = true
FACTION.Items = {"rags"}
FACTION.models = {"models/thespireroleplay/humans/group004/male_01.mdl", "models/thespireroleplay/humans/group004/male_01g.mdl", "models/thespireroleplay/humans/group004/male_02.mdl", "models/thespireroleplay/humans/group004/male_03.mdl", "models/thespireroleplay/humans/group004/male_04.mdl", "models/thespireroleplay/humans/group004/male_05.mdl", "models/thespireroleplay/humans/group004/male_06.mdl", "models/thespireroleplay/humans/group004/male_07.mdl", "models/thespireroleplay/humans/group004/male_08.mdl", "models/thespireroleplay/humans/group004/male_09.mdl", "models/thespireroleplay/humans/group004/male_10.mdl", "models/thespireroleplay/humans/group004/male_11.mdl", "models/thespireroleplay/humans/group004/male_12.mdl", "models/thespireroleplay/humans/group004/male_13.mdl", "models/thespireroleplay/humans/group004/male_14.mdl", "models/thespireroleplay/humans/group004/male_15.mdl", "models/thespireroleplay/humans/group004/male_16.mdl", "models/thespireroleplay/humans/group004/male_17.mdl", "models/thespireroleplay/humans/group004/male_18.mdl", "models/thespireroleplay/humans/group004/female_01.mdl", "models/thespireroleplay/humans/group004/female_01g.mdl", "models/thespireroleplay/humans/group004/female_02.mdl", "models/thespireroleplay/humans/group004/female_03.mdl", "models/thespireroleplay/humans/group004/female_05.mdl", "models/thespireroleplay/humans/group004/female_04.mdl", "models/thespireroleplay/humans/group004/female_06.mdl", "models/thespireroleplay/humans/group004/female_07.mdl", "models/thespireroleplay/humans/group004/female_08.mdl", "models/thespireroleplay/humans/group004/female_09.mdl", "models/thespireroleplay/humans/group004/female_10.mdl", "models/thespireroleplay/humans/group004/female_10.mdl", "models/thespireroleplay/humans/group004/female_11.mdl", "models/thespireroleplay/humans/group004/female_11.mdl", "models/thespireroleplay/humans/group004/female_12.mdl",}

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
FACTION_WASTELANDER = FACTION.index