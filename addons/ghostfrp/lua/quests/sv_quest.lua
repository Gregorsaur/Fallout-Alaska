util.AddNetworkString("RAID_update")
RAID_MANAGER = RAID_MANAGER or {}
RAID_MANAGER.ActiveRaids = RAID_MANAGER.ActiveRaids or {}
local translate_table = {}

local function addTranslate(a, b)
    translate_table[a] = b
    translate_table[b] = a
end

hook.Add("InitializedPlugins", "Raidassfinder", function()
    -- compress the json table 
    -- nut command add raid start 
    nut.command.add("raid", {
        syntax = "[string text]",
        onRun = function(client, arguments)
            local ply_fac = nut.faction.get(client:getChar():getFaction())
            local target_fac = nut.faction.get(arguments[1])
            print(ply_fac.name, target_fac.name)

            if not (RAID_MANAGER:IsInRaid(ply_fac.name) or RAID_MANAGER:IsInRaid(target_fac.name)) then
                RAID_MANAGER:StartRaid(ply_fac.name, target_fac.name)
                --nut.chat.send(client, "rollstrength", ply_fac.name .. "/" .. target_fac.name)
            end
        end
    })

    nut.command.add("ass", {
        syntax = "[string text]",
        onRun = function(client, arguments)
            local ply_fac = nut.faction.get(client:getChar():getFaction())
            local target_fac = nut.faction.get(arguments[1])
            -- find what raid contains the fac
            local curRaid, team = RAID_MANAGER:IsInRaid(target_fac.name)

            if team then
                print(ply_fac.name, target_fac.name)
                table.insert(team, ply_fac.name)
                RAID_MANAGER:Update()
            end
        end
    })
end)

function RAID_MANAGER:Update(player)
    net.Start("RAID_update")
    local jsonTable = util.TableToJSON(self.ActiveRaids)
    -- compress the json table
    local compressed = util.Compress(jsonTable)
    net.WriteUInt(#compressed, 32)
    net.WriteData(compressed, #compressed)

    if player then
        net.Send(player)
    else
        net.Broadcast()
    end
end

function RAID_MANAGER:StartRaid(factionA, factionB)
    local raid = {}

    raid.teamA = {factionA}

    raid.teamB = {factionB}

    raid.time = CurTime() + self.Duration

    timer.Simple(self.Duration, function()
        table.RemoveByValue(self.ActiveRaids, raid)
        self:Update()
    end)

    table.insert(self.ActiveRaids, raid)
    self:Update()
    print("RAID STATUS")
end

function RAID_MANAGER:IsInRaid(a)
    for i, v in pairs(self.ActiveRaids) do
        for k, l in pairs(v.teamA) do
            if l == a then return v, v.teamA end
        end

        for k, l in pairs(v.teamB) do
            if l == a then return v, v.teamB end
        end
    end

    return false
end

return net.Receive("RAID_update", function(len, pl)
    RAID_MANAGER:Update(pl)
end), RAID_MANAGER:Update(), "interactive quest api SV", hook.Add("PlayerDeath", "GlobalDeathMessage", function(victim, inflictor, attacker)
    local atk = attacker
    if victim == atk then return end

    if attacker:IsPlayer() then
        local attacker = attacker:getChar()
        local questsActive = QUESTS:GetActiveQuests(attacker)
        QUESTS.DEBUG(false, "f")

        for i, v in pairs(questsActive) do
            for c, stage in pairs((QUESTS.Table[v] or {
                stages = {}
            }).stages) do
                if stage.type == QUEST_STAGE_KILL_PLAYERS then
                    attacker.vars.quests[v].p[c] = attacker.vars.quests[v].p[c] + 1
                    netstream.Start(atk, "quests:update", v, c, attacker.vars.quests[v].p[c])
                end
            end
        end

        attacker:save()
    end
end), hook.Add("CreateCorpseHus", "sv_quest.lua", function(corpse, target, char)
    target.attackers = target.attackers or {}

    for attacker, ___ in pairs(target.attackers) do
        if attacker and attacker:IsPlayer() then
            print("ATTACKER", attacker)
            local attacker = attacker:getChar()
            local questsActive = QUESTS:GetActiveQuests(attacker)
            QUESTS.DEBUG(false, "f")

            for i, v in pairs(questsActive) do
                for c, stage in pairs((QUESTS.Table[v] or {
                    stages = {}
                }).stages) do
                    if stage.type == QUEST_STAGE_KILL_NPC and table.HasValue(stage.list, target:GetClass()) then
                        attacker.vars.quests[v].p[c] = attacker.vars.quests[v].p[c] + 1
                        netstream.Start(attacker, "quests:update", v, c, attacker.vars.quests[v].p[c])
                    end
                end
            end

            attacker:save()
        end
    end
end)