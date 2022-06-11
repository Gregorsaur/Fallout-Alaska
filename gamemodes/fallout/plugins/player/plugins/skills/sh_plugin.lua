PLUGIN.name = "Skills"
PLUGIN.author = "Ev"
PLUGIN.desc = "Skills instead of attributes"
SKILLS_LEVEL = 1
SKILLS_XP = 2
SKILLS_DESC = SKILLS_DESC or {}

SKILLS_DESC["medical"] = {"Medical", Material(""),}

-- Name
-- Icon
SKILLS_DESC["cooking"] = {"Cooking", Material(""),}

-- Name
-- Icon
local char_mt = nut.meta.character

if CLIENT then
    netstream.Hook("charSkills", function(id, key, value)
        local character = nut.char.loaded[id]

        if (character) then
            character.vars.Skills = character.vars.Skills or {}
            character:getSkills()[key] = value
        end
    end)
end

function PLUGIN:NutScriptTablesLoaded()
    --print("======================SKILLS==========================")
    local ignore = function() end
    -- nut.db.query("ALTER TABLE nut_characters ADD COLUMN _skills TEXT"):catch(ignore)
end

function PLUGIN:PluginLoaded()
    do
        local gm = GAMEMODE or GM

        function gm.GetSkillDesc()
            return SKILLS_DESC
        end
    end

    nut.char.registerVar("skills", {
        default = {},
        isLocal = true,
        noDisplay = true,
        field = "_skills",
        onSet = function(character, key, value, noReplication, receiver)
            local skills = character:getSkills()
            local client = character:getPlayer()
            skills[key] = value

            if (not noReplication and IsValid(client)) then
                netstream.Start(receiver or client, "charSkills", character:getID(), key, value)
            end

            character.vars.skills = skills
        end,
        onGet = function(character, key, default)
            local skills = character.vars.skills or {}

            if (key) then
                if (not skills) then
                    return {default}
                end

                local value = skills[key]

                return value == nil and default or value
            else
                return default or skills
            end
        end
    })

    function char_mt:setSkillLevel(skill, level)
        local tbl = self:getSkills(skill)

        if type(tbl) ~= "table" then
            tbl = {
                [SKILLS_LEVEL] = level,
                [SKILLS_XP] = 0
            }
        end

        tbl[SKILLS_LEVEL] = level
        self:setSkills(skill, tbl)
    end

    function char_mt:addSkillLevel(skill, level)
        local tbl = self:getSkills(skill)

        if type(tbl) ~= "table" then
            tbl = {
                [SKILLS_LEVEL] = level,
                [SKILLS_XP] = 0
            }
        end

        tbl[SKILLS_LEVEL] = tbl[SKILLS_LEVEL] + (level == nil and 1 or level)
        self:setSkills(skill, tbl)
    end

    function char_mt:setSkillXP(skill, xp)
        local tbl = self:getSkills(skill)

        if type(tbl) ~= "table" then
            tbl = {
                [SKILLS_LEVEL] = 1,
                [SKILLS_XP] = 0
            }
        end

        tbl[SKILLS_XP] = xp
        self:setSkills(skill, tbl)
    end

    function char_mt:setSkillXP(skill, xp)
        local tbl = self:getSkills(skill)

        if type(tbl) ~= "table" then
            tbl = {
                [SKILLS_LEVEL] = 1,
                [SKILLS_XP] = 0
            }
        end

        tbl[SKILLS_XP] = xp
        self:setSkills(skill, tbl)
    end

    function char_mt:getSkillLevel(skill)
        local tbl = self:getSkills(skill)
        if type(tbl) ~= "table" then return 1 end

        return self:getSkills(skill)[SKILLS_LEVEL]
    end

    function char_mt:getSkillXP(skill)
        local tbl = self:getSkills(skill)
        if type(tbl) ~= "table" then return 0 end

        return self:getSkills(skill)[SKILLS_XP]
    end

    function char_mt:getSkillXPForLevel(skill)
        local tbl = self:getSkills(skill) or {
            [SKILLS_LEVEL] = 1,
            [SKILLS_XP] = 0
        }

        return hook.Run("SKILL_XP_CURVE", (skill), tbl[SKILLS_LEVEL]) or (tbl[SKILLS_LEVEL] * 25 + 25)
    end

    function char_mt:addSkillXP(skill, xp)
        local tbl = self:getSkills(skill, {
            [SKILLS_LEVEL] = 1,
            [SKILLS_XP] = 0
        })

        PrintTable(tbl)
        tbl[SKILLS_XP] = tbl[SKILLS_XP] + xp
        local xpCurve = hook.Run("SKILL_XP_CURVE", (skill), tbl[SKILLS_LEVEL]) or (tbl[SKILLS_LEVEL] * 25 + 25)
        local levelUP = false

        while (tbl[SKILLS_XP] >= xpCurve) do
            tbl[SKILLS_LEVEL] = tbl[SKILLS_LEVEL] + 1
            tbl[SKILLS_XP] = tbl[SKILLS_XP] - xpCurve
            xpCurve = hook.Run("SKILL_XP_CURVE", (skill), tbl[SKILLS_LEVEL]) or (tbl[SKILLS_LEVEL] * 25 + 25)
            hook.Run("SKILL_LEVEL_UP", self, skill, tbl[SKILLS_LEVEL])
            levelUP = true
        end

        print(skill, tbl)
        PrintTable(tbl)
        self:setSkills(skill, tbl)

        if levelUP then
            self:save()
        end
    end
	    function char_mt:giveXP( xp)
		self:addSkillXP("level", xp) 
    end
end

hook.Add("SKILL_XP_CURVE", "level_curve", function(curve, level)
    local lvl = {75, 100, 150, 200, 300, 400, 550, 750, 1000, 1150, 1350, 1500, 1650, 1800, 2000, 2250, 2500, 2750, 3000, 3300, 3600, 3900, 4200, 4600, 5000, 5400, 5800, 6200, 6600, 7000, 7500, 8000, 8500, 9000, 9500, 10000, 10100, 10300, 10500, 10700, 11000, 11600, 12000, 12700, 13200, 13500, 14000, 14500, 15000, 15500, 16000, 16500, 17000, 17500, 18000,}

    return lvl[level]*2
end)

hook.Add("SKILL_LEVEL_UP", "SKILL_LEVEL_UPSKILL_LEVEL_UP", function(char, skill, level)
    if skill == "level" then
        if level % 5 == 0 then
     
            char:addSkillLevel("perkpoints", 1)
        end

        local switch = char:getTrait() or 0
        char:addSkillLevel("skillpoints", switch == 7 and 4 or 2)
    end
end)

PERKS = {}
local Material = Material

if SERVER then
    Material = function() end
end

local isSpecial = {
    ["str"] = true,
    ["agi"] = true,
    ["per"] = true,
    ["luc"] = true,
    ["int"] = true,
    ["cha"] = true,
    ["end"] = true
}

function CheckSkill(n, player)
    player = player or LocalPlayer()

    if isSpecial[n[1]] then
        return player:getChar():getAttrib(n[1]) >= n[2]
    else
        return player:getChar():getSkillLevel(n[1]) >= n[2]
    end
end

function char_mt:isPerkOwned(skill)
    local p = PERKS[skill]
    local c = self:getData("p" .. p.bitmaskIndex, 0)

    return bit.band(c, p.bitmaskCalc) == p.bitmaskCalc
end

function CalcJumpheight(player, char)
    local perk1Height = char:isPerkOwned(44) and 1.35 or 1
    player:SetJumpPower(200 * perk1Height)
end

if SERVER then
    function PLUGIN:PostPlayerLoadout(client)
        hook.Run("PostPlayerLoadout_",(client))
        local char = client:getChar()

        timer.Simple(0.1, function()
            CalcJumpheight(client, char)
        end)
    end
end

PERKS[1] = {
    display = "Educated",
    desc = [[+5 Science, +5 Energy Weapons]],
    requirements = {
        level = 5
    },
    onLevel = function(char, m)
        char:setSkillLevel("science", char:getSkillLevel("science") + (5 * m))
        char:setSkillLevel("big_guns", char:getSkillLevel("big_guns") + (5 * m))
    end
}

PERKS[2] = {
    display = "Travel Light",
    desc = [[Having equipped light armor or no armor makes you run 15% faster]],
    requirements = {
        level = 5
    },
}

-- NOT DONE
PERKS[3] = {
    display = "Intense Training",
    desc = [[+1 S.P.E.C.I.A.L. Points]],
    requirements = {
        level = 5
    },
    onLevel = function(char, m)
        char:setSkillLevel("specialpoints", char:getSkillLevel("specialpoints") + (m == 1 and 1 or 0))
    end
}

-- NOT DONE
PERKS[4] = {
    display = "Little Leaguer",
    desc = [[+10 Melee]],
    requirements = {
        level = 5,
        str = 4
    },
    onLevel = function(char, m)
        char:setSkillLevel("melee", char:getSkillLevel("melee") + (10 * m))
    end
}

PERKS[5] = {
    display = "Mister Sandman",
    desc = [[Instantly Kill a Sleeping person if you walk up to them]],
    requirements = {
        level = 5
    },
}

-- NOT DONE
PERKS[6] = {
    display = "Demolition Expert",
    desc = [[+15 points to Explosives]],
    requirements = {
        level = 10,
        per = 5
    },
    onLevel = function(char, m)
        char:setSkillLevel("explosives", char:getSkillLevel("explosives") + (15 * m))
    end
}

PERKS[7] = {
    display = "Doomsday Prepper",
    desc = [[+5 Survival]],
    requirements = {
        level = 10,
        ["end"] = 3
    },
    onLevel = function(char, m)
        char:setSkillLevel("survival", char:getSkillLevel("survival") + (5 * m))
    end
}

PERKS[8] = {
    display = "Medic",
    desc = [[+10 Medicine]],
    requirements = {
        level = 10,
        int = 6
    },
    onLevel = function(char, m)
        char:setSkillLevel("medicine", char:getSkillLevel("medicine") + (10 * m))
    end
}

PERKS[9] = {
    display = "Rad Resistance",
    desc = [[+25% radiation resistance permanently]],
    requirements = {
        level = 10,
        ["end"] = 5
    },
}

-- NOT DONE
PERKS[10] = {
    display = "Gun Slinger",
    desc = [[+10 Small Guns]],
    requirements = {
        level = 10,
        ["end"] = 5
    },
    onLevel = function(char, m)
        char:addSkillLevel("small_arms", 10 * m)
    end
}

PERKS[11] = {
    display = "Life Giver",
    desc = [[+15 HP]],
    requirements = {
        level = 10,
        ["end"] = 5
    },
}

-- NOT DONE
PERKS[12] = {
    display = "Gun Nut",
    desc = [[+5 Big Guns; +5 Small Guns]],
    requirements = {
        level = 10,
        ["per"] = 5
    },
    onLevel = function(char, m)
        char:addSkillLevel("big_guns", 5 * m)
        char:addSkillLevel("small_arms", 5 * m)
    end
}

PERKS[13] = {
    display = "Average Laser Enjoyer",
    desc = [[+10 Energy Weapons]],
    requirements = {
        level = 10,
        ["int"] = 5
    },
    onLevel = function(char, m)
        char:addSkillLevel("energy_weps", 10 * m)
    end
}

PERKS[14] = {
    display = "Hard Bargain",
    desc = [[+5 Barter]],
    requirements = {
        level = 10,
        ["cha"] = 3
    },
    onLevel = function(char, m)
        char:addSkillLevel("barter", 5 * m)
    end
}

PERKS[15] = {
    display = "Action Boy",
    desc = [[+20 AP Points]],
    requirements = {
        level = 10,
        ["agi"] = 3
    },
    onLevel = function(client, m)
        timer.Simple(0.2, function()
            UPDATE_CHARACTER_STAMINA(client:getPlayer())
        end)
    end
}

hook.Add("getMaxStam", "PERK[15]", function(char) return char:isPerkOwned(15) and 15 or 0 end)

-- NOT DONE
PERKS[16] = {
    display = "Strong Back",
    desc = [[+50 carry weight]],
    requirements = {
        level = 15,
        ["str"] = 6
    },
}

-- NOT DONE
PERKS[17] = {
    display = "Hematophage",
    desc = [[Bloodpacks heal 25 HP opposed to 1 HP]],
    requirements = {
        level = 15,
        ["end"] = 4,
        ["int"] = 5,
    },
}

-- NOT DONE
PERKS[18] = {
    display = "Cannibalism",
    desc = [[Eat dead bodies'n shit]],
    requirements = {
        level = 15,
    },
}

-- NOT DONE
PERKS[19] = {
    display = "Commando",
    desc = [[+5 Survival; +5 Small Guns]],
    requirements = {
        level = 15,
        ["end"] = 3,
        ["per"] = 3,
    },
    onLevel = function(char, m)
        char:addSkillLevel("small_arms", 5 * m)
        char:addSkillLevel("survival", 5 * m)
    end
}

PERKS[20] = {
    display = "Rocky II",
    desc = [[+10 Unarmed]],
    requirements = {
        level = 15,
        ["str"] = 5,
    },
    onLevel = function(char, m)
        char:addSkillLevel("unarmed", 10 * m)
    end
}

PERKS[21] = {
    display = "Camel's Hump",
    desc = [[Your water depletes much slower]],
    requirements = {
        level = 15,
        ["end"] = 6
    },
}

-- NOT DONE
PERKS[22] = {
    display = "Rationer",
    desc = [[Food drains at a much slower rate]],
    requirements = {
        level = 15,
        ["end"] = 6
    },
}

-- NOT DONE
PERKS[23] = {
    display = "Marathon Runner",
    desc = [[AP drain rate reduced by 30%]],
    requirements = {
        level = 15,
        ["agi"] = 6
    },
    onLevel = function(client, m)
        timer.Simple(0.2, function()
            UPDATE_CHARACTER_STAMINA(client:getPlayer())
        end)
    end
}

hook.Add("getStamDecay", "PERK[23]", function(char) return char:isPerkOwned(23) and 0.7 or 1 end)

-- NOT DONE
--
PERKS[24] = {
    display = "Homeschooled",
    desc = [[+10 Science]],
    requirements = {
        level = 15,
        ["int"] = 6
    },
    onLevel = function(char, m)
        char:addSkillLevel("science", 10 * m)
    end
}

PERKS[25] = {
    display = "Action Man",
    desc = [[+30 AP Points]],
    requirements = {
        level = 20,
        ["agi"] = 5
    },
    onLevel = function(client, m)
        timer.Simple(0.2, function()
            UPDATE_CHARACTER_STAMINA(client:getPlayer())
        end)
    end
}

hook.Add("getMaxStam", "PERK[25]", function(char) return char:isPerkOwned(25) and 30 or 0 end)

PERKS[26] = {
    display = "Cyborg",
    desc = [[+10 Science; +5 Energy Weapons]],
    requirements = {
        level = 20,
        ["int"] = 6,
        ["end"] = 2
    },
    onLevel = function(char, m)
        char:addSkillLevel("science", 10 * m)
        char:addSkillLevel("energy_weps", 5 * m)
    end
}

PERKS[27] = {
    display = "Surgeon",
    desc = [[+15 Medicine]],
    requirements = {
        level = 20,
        ["int"] = 7
    },
    onLevel = function(char, m)
        char:addSkillLevel("medicine", 15 * m)
    end
}

PERKS[28] = {
    display = "Plasma Connoisseur",
    desc = [[+10 Energy Weapons]],
    requirements = {
        level = 20,
        ["int"] = 6
    },
    onLevel = function(char, m)
        char:addSkillLevel("energy_weps", 10 * m)
    end
}

PERKS[29] = {
    display = "Ah, The Negotiator",
    desc = [[+10 Barter]],
    requirements = {
        level = 20,
        ["cha"] = 5
    },
    onLevel = function(char, m)
        char:addSkillLevel("barter", 10 * m)
    end
}

PERKS[30] = {
    display = "One In The Chamber",
    desc = [[There is a 25% chance the final bullet deals 300% extra damage]],
    requirements = {
        level = 20,
        ["luc"] = 7
    },
}

PERKS[31] = {
    display = "Bloody Mess",
    desc = [[+15 Big Guns]],
    requirements = {
        level = 25,
        ["str"] = 5,
        ["luc"] = 2,
    },
    onLevel = function(char, m)
        char:addSkillLevel("big_guns", 15 * m)
    end
}

PERKS[32] = {
    display = "Long Haul",
    desc = [[Being over encumbered, you now walk 100% faster]],
    requirements = {
        level = 25,
        ["str"] = 7,
        ["agi"] = 3,
    },
}

PERKS[33] = {
    display = "Messiah",
    desc = [[+35 HP]],
    requirements = {
        level = 25,
        ["end"] = 7
    },
}

PERKS[34] = {
    display = "I’m Somewhat Of A Scientist Myself",
    desc = [[+10 Medicine, +10 Science]],
    requirements = {
        level = 25,
        ["int"] = 8
    },
    onLevel = function(char, m)
        char:addSkillLevel("medicine", 10 * m)
        char:addSkillLevel("science", 10 * m)
    end
}

PERKS[35] = {
    display = "Rad Absorption",
    desc = [[-1 Rad every 120 seconds]],
    requirements = {
        level = 30,
        ["agi"] = 6
    },
}

timer.Create("PERKS[35]_RAD", 120, 0, function()
    for i, v in pairs(player.GetAll()) do
        local char = v:getChar()

        --if char:isPerkOwned(35) then
        --    char:setData("rad", math.max(0, char:getData("rad", 0) - 1))
        --end
    end
end)

-- NOT DONE
PERKS[36] = {
    display = "Nuka Chemist",
    desc = [[Unlock Nuka Cola Recipe]],
    requirements = {
        level = 30,
        ["int"] = 6,
        survival = 50
    },
}

PERKS[37] = {
    display = "Lead Belly",
    desc = [[-50% radiation taken from food and water]],
    requirements = {
        level = 30,
        ["end"] = 6
    },
}

-- NOT DONE
PERKS[38] = {
    display = "Ammo Conserver",
    desc = [[When firing bullets there is a 5% chance for that bullet to not be consumed.]],
    requirements = {
        level = 30,
        ["luc"] = 6
    },
}

PERKS[39] = {
    display = "Silver Tongued",
    desc = [[+15 barter]],
    requirements = {
        level = 30,
        ["cha"] = 8
    },
    onLevel = function(char, m)
        char:addSkillLevel("barter", 15 * m)
    end
}

PERKS[40] = {
    display = "Action Chad",
    desc = [[+50 AP Points]],
    requirements = {
        level = 35,
        ["agi"] = 6
    },
    onLevel = function(client, m)
        timer.Simple(0.2, function()
            UPDATE_CHARACTER_STAMINA(client:getPlayer())
        end)
    end
}

hook.Add("getMaxStam", "PERK[40]", function(char) return char:isPerkOwned(40) and 50 or 0 end)

-- NOT DONE
PERKS[41] = {
    display = "Isodoped",
    desc = [[20% damage reduction when you have 50% or more radiation.]],
    requirements = {
        level = 35,
        ["end"] = 9
    },
}

-- NOT DONE
PERKS[42] = {
    display = "Double Tap",
    desc = [[When you shoot, there is a 2% Chance the bullet will do Double Damage]],
    requirements = {
        level = 35,
        ["luc"] = 8
    },
}

PERKS[43] = {
    display = "Enguard!",
    desc = [[When taken melee damage if you have a melee weapon equipped you reflect 5% of this back.]],
    requirements = {
        level = 40,
        ["agi"] = 8
    },
}

-- NOT DONE
PERKS[44] = {
    display = "Jack Rabbit",
    desc = [[Jump height increased by 35%]],
    requirements = {
        level = 45,
        ["agi"] = 8,
        ["end"] = 4,
    },
    onLevel = function(client, m)
        timer.Simple(0.1, function()
            CalcJumpheight(client:getPlayer(), client)
        end)
    end
}

-- NOT DONE
PERKS[45] = {
    display = "Toughness",
    desc = [[+6% Damage Resistance]],
    requirements = {
        level = 45,
        ["end"] = 6
    },
}

-- NOT DONE NEXT
PERKS[46] = {
    display = "Silent Running",
    desc = [[Running without power armor no longer makes sound.]],
    requirements = {
        level = 45,
        ["agi"] = 6
    },
}

hook.Add("PlayerFootstep", "PERKS 46", function(ply, pos, foot, sound, volume, rf)
    if ply:getChar():isPerkOwned(46) then return true end
end)

PERKS[47] = {
    display = "Nerves of Steel",
    desc = [[Run 15% faster]],
    requirements = {
        level = 45,
        ["agi"] = 6
    },
    onLevel = function(client,m)
        timer.Simple(0.2, function()
            UPDATE_CHARACTER_STAMINA(client:getPlayer())
        end)
    end
}

hook.Add("getRunMultiplier", "PERKS[47]", function(ply) return ply:isPerkOwned(47) and 1.15 or 1 end)

-- NOT DONE
PERKS[48] = {
    display = "Nerd Rage!",
    desc = [[At 15% Health or Less, Damage Resistance increases to 50%, this damage is not applied to damage that would bring you to the 15% threshold.]],
    requirements = {
        level = 45,
        ["int"] = 8
    },
}

PERKS[49] = {
    display = "Rooted",
    desc = [[When standing still, gain 20% Damage Resistance]],
    requirements = {
        level = 50,
        ["str"] = 7,
        ["end"] = 5,
    },
}

PERKS[50] = {
    display = "Concentrated Fire",
    desc = [[Dealing damage to an enemy applies a stack of "Concentrated Fire"
<color=255,100,100>Concentrated Fire increases the damage an enemy takes by 0.25% per stack, upto a max of 5%</color>]],
    requirements = {
        level = 50,
        ["luc"] = 6,
        ["per"] = 6,
    },
}

-- NOT DONE
for i, v in pairs(PERKS) do
    v.bitmask = i - 1
    v.bitmaskCalc = 2 ^ (v.bitmask % 32)
    v.bitmaskIndex = math.floor(v.bitmask / 32)
    v.image = v.image or Material("perks/" .. i .. ".png")
end