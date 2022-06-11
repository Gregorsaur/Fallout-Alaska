
local skill_def = {
    ["small_arms"] = true,
    ["big_guns"] = true,
    ["barter"] = true,
    ["science"] = true,
    ["melee"] = true,
    ["medicine"] = true,
    ["explosives"] = true,
    ["survival"] = true,
    ["energy_weps"] = true,
    ["unarmed"] = true,
}

netstream.Hook("statIncrease", function(ply, stat)
    local c = ply:getChar()
    local CanIncrease = c:getSkillLevel("skillpoints") - 1 > 0 and skill_def[stat] and c:getSkillLevel(stat) < 100

    if CanIncrease then
        c:addSkillLevel(stat, 1)
        c:addSkillLevel("skillpoints", -1)
    end 
end)
    netstream.Hook("perkIncrease", function(ply, stat)
        local c = ply:getChar()
        local st = {
            S = "str",
            P = "per",
            E = "end",
            C = "cha",
            I = "int",
            A = "agi",
            L = "luc",
        }
        st = st[stat]
        local CanIncrease = c:getSkillLevel("specialpoints") - 1 > 0 and c:getAttrib(st) < 10
        if CanIncrease then
            c:setAttrib(st, c:getAttrib(st) + 1)
            c:addSkillLevel(stat, 1)
            c:addSkillLevel("specialpoints", -1)
        end
    end)
 

 

