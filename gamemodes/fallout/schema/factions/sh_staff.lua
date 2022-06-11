FACTION.name = "Staff"
FACTION.desc = "Staff"
FACTION.color = Color(0, 0, 0)
FACTION.isDefault = false
FACTION.pay = 10
FACTION.isGloballyRecognized = false
FACTION.Items = {"rags"}
FACTION.weapons = {"weapon_physgun", "weapon_physcannon", "gmod_tool"}

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

FACTION_STAFF = FACTION.index