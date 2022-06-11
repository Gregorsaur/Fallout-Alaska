-- SERVER
util.AddNetworkString("pipboy")
util.AddNetworkString("pipboy_fix")
util.PrecacheModel("models/props_junk/watermelon01.mdl")
util.AddNetworkString("pipboy_toggle")

net.Receive("pipboy_toggle", function(len, ply)
    if net.ReadBool() then
        ply:ManipulateBoneAngles(ply:LookupBone("ValveBiped.Bip01_L_Forearm"), Angle(90, 0, -280))
        ply:forceSequence("g_scan_IDapexArms", 0, nil)
        --ply:SetMoveType( MOVETYPE_WALK) 
    else
        ply:ManipulateBoneAngles(ply:LookupBone("ValveBiped.Bip01_L_Forearm"), Angle(0, 0, 0))
        ply:forceSequence("g_scan_IDapexArms", 0, 0.001)
    end
end)

net.Receive("pipboy", function(len, ply)
    net.Start("pipboy")
    print("SENDING ENCRY PIP")
    net.WriteString("models/pipboy.mdl")
    net.WriteString("!")
    net.WriteString("ManipulateBonePosition")
    net.WriteString("ManipulateBoneAngles")
    net.WriteString("ValveBiped.Bip01_R_UpperArm")
    net.WriteString("ValveBiped.Bip01_R_UpperArm")
    net.WriteString("ValveBiped.Bip01_L_UpperArm")
    net.WriteString("ValveBiped.Bip01_L_Forearm")
    net.WriteString("ValveBiped.Bip01_L_Hand")
    net.Send(ply)
end)

for i, v in pairs(player.GetAll()) do
    v:notify("You are currently being hunted")
end

hook.Add("PlayerLoadedChar", "resetPipboy", function(client, char, data)
    net.Start("pipboy_fix")
    net.Send(client)
end)

hook.Add("PostCleanupMap", "otm_door_removal_pairedareaportal_cleanup_variable_2", function()
    for _, otm_i in ipairs(ents.FindByClass("func_areaportal")) do
    end
end)

--   otm_i:Fire("Open")
--    otm_i:SetSaveValue("target", "")
for _, otm_i in ipairs(ents.FindByClass("func_areaportal")) do
end

--otm_i:Fire("Open")
-- otm_i:SetSaveValue("target", "")
hook.Add("AdjustCreationData", "AddSkills", function(client, data, newData)
    print("NBI")
    print(client, "AUTH")
    PrintTable(data)
end)

local function registerNUT()
    nut.char.registerVar("trait", {
        field = "_trait",
        default = 0,
        isLocal = true,
        noDisplay = true
    })

    nut.command.add("charsettraitid", {
        adminOnly = true,
        syntax = "<string name> <int trait>",
        onRun = function(client, arguments)
            if not arguments[2] then return L("invalidArg", client, 2) end
            local target = nut.command.findPlayer(client, arguments[1])

            if IsValid(target) and target:getChar() then
                target:getChar():setTrait(arguments[2] or 0)
            end
        end
    })

    --[[

nut.command.add("charresetspecial", {
	adminOnly = true,
	syntax = "<string name> <int trait>",
	onRun = function(client, arguments)
		if (!arguments[2]) then
			return L("invalidArg", client, 2)
		end

		local target = nut.command.findPlayer(client, arguments[1])

		if (IsValid(target) and target:getChar()) then
			target:getChar():setTrait(arguments[2] or 0)
		end
	end
})
]]
    netstream.Hook("charCreate", function(client, data)
        local newData = {}
        PrintTable(data)
        local maxChars = hook.Run("GetMaxPlayerCharacter", client) or nut.config.get("maxChars", 5)
        local charList = client.nutCharList
        local charCount = table.Count(charList)
        if charCount >= maxChars then return netstream.Start(client, "charAuthed", "maxCharacters") end

        for k, v in pairs(data) do
            local info = nut.char.vars[k]

            if not info or (not info.onValidate and info.noDisplay) then
                data[k] = nil
            end
        end

        for k, v in SortedPairsByMemberValue(nut.char.vars, "index") do
            local value = data[k]

            if v.onValidate then
                local result = {v.onValidate(value, data, client)}

                if result[1] == false then
                    return netstream.Start(client, "charAuthed", unpack(result, 2))
                else
                    if result[1] ~= nil then
                        data[k] = result[1]
                    end

                    if v.onAdjust then
                        v.onAdjust(client, data, value, newData)
                    end
                end
            end
        end

        data.steamID = client:SteamID64()
        hook.Run("AdjustCreationData", client, data, newData)
        data = table.Merge(data, newData)

        nut.char.create(data, function(id)
            if IsValid(client) then
                nut.char.loaded[id]:sync(client)
                netstream.Start(client, "charAuthed", client.nutCharList)
                --  MsgN("Created character '" .. id .. "' for " .. client:steamName() .. ".")
                hook.Run("OnCharCreated", client, nut.char.loaded[id])
            end
        end)
    end)

    --local c = player.GetAll()[1]:getChar()
    --c:setSkillLevel("level", 1)
    --c:addSkillXP("level", 100)
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

    concommand.Add("repair", function(ply, cmd, args)
        local char = ply:getChar()
        local data = char:getTrait() or 0
        data = data + 1

        timer.Simple(0.1, function()
            local switch = data

            -- Carry Weight 
            if switch == 7 then
                local p = PERKS[18]
                local c = char:getData("p" .. p.bitmaskIndex, 0)
                val = bit.bor(c, p.bitmaskCalc)
                char:setData("p" .. p.bitmaskIndex, val)
            end
        end)
    end)

    hook.Add("PlayerLoadedChar", "Canbalism", function(client, char) end)

    netstream.Hook("unlockPerk", function(ply, i)
        local char = ply:getChar()
        local p = PERKS[i]
        local c = char:getData("p" .. p.bitmaskIndex, 0)
        local val
        local weCanDoThis = true
        char:setSkillLevel("perkpoints",1) 
        if char:getSkillLevel("perkpoints") <= 0 then
            print("You have no perk points left")

            return
            else 
        

        for i, v in pairs(p.requirements) do
            local isValid = CheckSkill({i, v}, ply)

            if not isValid then
                weCanDoThis = false

                return
            end
        end

        --weCanDoThis = true
        if not weCanDoThis then return end

        if bit.band(c, p.bitmaskCalc) == p.bitmaskCalc then
            val = bit.band(c, bit.bnot(p.bitmaskCalc)) -- Remove 4 from mybits
            if p.onLevel then end --p.onLevel(char, -1)
        else
            val = bit.bor(c, p.bitmaskCalc)

            if p.onLevel then
                p.onLevel(char, 1)
            end

            char:addSkillLevel("perkpoints", -1)
            char:setData("p" .. p.bitmaskIndex, val)
        end
        end
    end)

netstream.Hook("unlockPerk", function(ply, i)
    local char = ply:getChar()
    local p = PERKS[i]
    local c = char:getData("p" .. p.bitmaskIndex, 0)
    local val
    local weCanDoThis = true

    if char:getSkillLevel("perkpoints") or 0 <= 0 then 
        print("You have no perk points left")
        return 
    end


    for i, v in pairs(p.requirements) do
        local isValid = CheckSkill({i, v},ply)

        if not isValid then
            weCanDoThis = false
        end
    end
    weCanDoThis = true
	if not weCanDoThis then return end
    if bit.band(c, p.bitmaskCalc) == p.bitmaskCalc then
      -- val = bit.band(c, bit.bnot(p.bitmaskCalc)) -- Remove 4 from mybits

      -- if p.onLevel then
      --     p.onLevel(char, -1)
      -- end
    else
        val = bit.bor(c, p.bitmaskCalc)

        if p.onLevel then
            p.onLevel(char, 1)
        end
    end

    char:setData("p" .. p.bitmaskIndex, val)
end)
    hook.Add("EntityTakeDamage", "PERKS[30]", function(target, dmginfo)
        --and wep:Clip1() == 0
        local ply = dmginfo:GetAttacker()
        local roll = math.random(1, 4)

        --print(roll)
        if (dmginfo:GetAttacker():IsPlayer() and ply:getChar():isPerkOwned(30) and ply:GetActiveWeapon():Clip1() == 0) and roll == 1 then
            dmginfo:ScaleDamage(3)
            netstream.Start(ply, "luck")
        end
    end)

    hook.Add("EntityTakeDamage", "PERKS[31]", function(target, dmginfo)
        local ply = dmginfo:GetAttacker()

        if dmginfo:GetAttacker():IsPlayer() and ply:getChar():isPerkOwned(42) and ply:getChar().luckcooldownfordouble == nil and math.random(1, 50) == 1 then
            dmginfo:ScaleDamage(2)
            netstream.Start(ply, "luck")
            ply:getChar().luckcooldownfordouble = true

            timer.Simple(15, function()
                ply:getChar().luckcooldownfordouble = nil
            end)
        end
    end)

    hook.Add("EntityTakeDamage", "PERKS[45]", function(target, dmginfo)
        if target:IsPlayer() and target:getChar():isPerkOwned(45) then
            dmginfo:ScaleDamage(0.94)
        end
    end)

    -- Radiation
    hook.Add("EntityTakeDamage", "PERKS[41]", function(target, dmginfo)
        if target:IsPlayer() and target:getChar():isPerkOwned(41) and target:getChar():getData("rad") >= target:GetMaxHealth() * 0.5 then
            dmginfo:ScaleDamage(0.8)
        end
    end)

    hook.Add("EntityTakeDamage", "PERKS[49]", function(target, dmginfo)
        if target:IsPlayer() and target:getChar():isPerkOwned(49) and target:GetVelocity():Length() < 5 then
            dmginfo:ScaleDamage(0.8)
        end
    end)

    hook.Add("EntityTakeDamage", "PERKS[50]", function(target, dmginfo)
        --and wep:Clip1() == 0
        if dmginfo:GetAttacker():IsPlayer() and dmginfo:GetAttacker():getChar() and dmginfo:GetAttacker():getChar():isPerkOwned(50) then
            target.cfire = math.Clamp((target.cfire or 0) + 1, 0, 20)
            dmginfo:ScaleDamage(1 + (target.cfire / 4))
        end
    end)
end

if nut or NUT or Nut then
    registerNUT()
end

hook.Add("InitializedPlugins", "InitializedPlugins_SV_POLK", registerNUT)

concommand.Add("syn", function(ply, cmd, args)
    ply:getChar():setData("isInsi", not (ply:getChar():getData("isInsi", false) or false))
    ply:notify(ply:getChar():getData("isInsi", false) and "TRUE" or "false")
end)

hook.Add("PlayerDeath", "XP_OnDeath", function(victim, inflictor, attacker)
    if attacker:IsPlayer() then
        attacker:getChar():giveXP(math.random(1, 25))
    end
end)