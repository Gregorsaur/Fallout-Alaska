RAID_MANAGER = RAID_MANAGER or {}
RAID_MANAGER.Duration = 60*15


print("interactive quest api SV")
QUESTS = {}
QUESTS.Table = {}
 
QUESTS.DEBUG = function(isError, ...)
    MsgC(Color(255, 100, 255), "[Wayfinder:] ", isError and Color(255, 100, 100) or Color(100, 100, 255), ..., "\n")
end

local print = function(...)
    QUESTS.DEBUG(false, ...)
end

hook.Add("InitializedPlugins", "GM:CREATECHARAPP2", function()
    nut.char.registerVar("quests", {
        default = {},
        isLocal = false,
        noDisplay = true,
        field = "_quests",
        onSet = function(character, key, value, noReplication, receiver)
            character.vars.quests = key
            if SERVER then end --character:updateOnServer()
            netstream.Start(character:getPlayer(), "questUpdate", character:getID(), key)
        end,
        onGet = function(character, key, default) return character.vars.quests or {} end
    })

    if CLIENT then
        netstream.Hook("questUpdate", function(id, key)
            local character = nut.char.loaded[id]

            if character then
                character.vars.quests = key or {}
            end
        end)
		
netstream.Hook("quests:update", function(questID, StageID, Score)
	local character = LocalPlayer():getChar()
    character.vars.quests = character.vars.quests or {}
	print(questID, StageID, Score)
    character.vars.quests[questID].p[StageID] = Score
end)

    end
end)



QUEST_STAGE_KILL_NPC = 1
QUEST_STAGE_KILL_PLAYERS = 2
QUEST_STAGE_OBTAIN_ITEM = 3
quest_meta = {}
quest_meta.__index = quest_meta

function quest_meta:DefineDescription(m)
    self.description = m

    return self
end

function quest_meta:GivePlayerQuest(char)
    if CLIENT then return end
    print("===", self)

    local x = {
        0, p = {}
    }

    for i, v in pairs(self.stages) do
        x.p[i] = 0
    end

  
    char.vars.quests[self.id] = x
    PrintTable(char.vars.quests)
    char:setQuests(char.vars.quests, true)
    print(char:save())
end

hook.Add("CharacterPostSave", "checkSafe", function()
    print("FEFAEFAEFAF")
end)

function quest_meta:DefineTitle(m)
    self.title = m

    return self
end

function quest_meta:AddStage(type, list, amountneeded, display)
    local tbl = {}
    tbl.type = type
    tbl.list = list
    tbl.amountneeded = amountneeded
    tbl.display = display
    table.insert(self.stages, tbl)

    return self
end

function QUESTS:CreateQuest(uid, resetdaily)
    QUESTS.Table[uid] = {
        id = uid,
        resetDaily = resetdaily or false,
        stages = {}
    }

    setmetatable(QUESTS.Table[uid], quest_meta)
    print("ee")

    return QUESTS.Table[uid]
end

function QUESTS:GetActiveQuests(user)
    local quests = {}

    for i, v in pairs(user.vars.quests) do
        if v.state ~= -1 then
            table.insert(quests, i)
        end
    end

    return quests
end 

QUEST_BUTCHERPETE = QUESTS:CreateQuest(2):DefineTitle("[Daily] Butcher Pete, Pt.1"):DefineDescription([[Hey everybody, did the news get around
About a guy named Butcher Pete
Oh, Pete just flew into this town.]]):AddStage(QUEST_STAGE_KILL_NPC, {"npc_vj_f3r_ghoul"}, 0, " Ghouls Killed")
QUEST_BUTCHERPETE2 = QUESTS:CreateQuest(4):DefineTitle("Butcher Pete, Pt.2"):DefineDescription([[Hey everybody, did the news get around
About a guy named Butcher Pete
Oh, Pete just flew into this town.]]):AddStage(QUEST_STAGE_KILL_PLAYERS, {"npc_vj_f3r_ghoul"}, 2000, " Players Killed")
QUEST_BUTCHERPETEFORESKIN = QUESTS:CreateQuest(3):DefineTitle("Butcher Pete, Fortnite"):DefineDescription([[Hey everybody, did the news get around
About a guy named Butcher Pete
Oh, Pete just flew into this town.]]):AddStage(QUEST_STAGE_KILL_NPC, {"npc_vj_f3r_ghouzl"}, 1, " Pete's Foreskin Found")
for i, v in pairs(player.GetAll()) do
    -- PFC John Smith     Evi Rainer
   -- if v:Nick() == "Evi Rainer" then
    --  QUEST_BUTCHERPETE:GivePlayerQuest(v:getChar())
   -- end
end
if SERVER then 
concommand.Add("forenite", function(ply,...)
// get ply' entity at linetrace and get the char of that entity
local ent = ply:GetEyeTrace().Entity
local char = ply:getChar()

QUEST_BUTCHERPETEFORESKIN:GivePlayerQuest(char)
 end)
 end