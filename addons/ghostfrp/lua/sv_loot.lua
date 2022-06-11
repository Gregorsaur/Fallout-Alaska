local Inventory = nut.Inventory



nico = nico or {}
nico.optimize = nico.optimize or {}
nico.optimize.ServerOptimizations = true
local hook = hook
local ents = ents
local timer = timer
local ipairs = ipairs
local IsValid = IsValid
local table = table

nico.optimize.RemoveEntities = {
    ["env_fire"] = true,
    ["trigger_hurt"] = true,
    ["prop_ragdoll"] = true,
    ["prop_physics"] = true,
    ["spotlight_end"] = true,
    ["light"] = true,
    ["point_spotlight"] = true,
    ["beam"] = true,
    ["env_sprite"] = true,
    ["light_spot"] = true,
    ["func_tracktrain"] = true,
    ["point_template"] = true,
}

local function optimizeSeats()
    local EFL_NO_THINK_FUNCTION = EFL_NO_THINK_FUNCTION
    local loop, nicoSeats, nicoEnabled

    hook.Add("OnEntityCreated", "nicoSeat", function(seat)
        if seat:GetClass() == "prop_vehicle_prisoner_pod" then
            seat:AddEFlags(EFL_NO_THINK_FUNCTION)
            seat.nicoSeat = true
        end
    end)

    hook.Add("Think", "nicoSeat", function()
        if not nicoSeats or not nicoSeats[loop] then
            loop = 1
            nicoSeats = {}

            for _, seat in ipairs(ents.FindByClass("prop_vehicle_prisoner_pod")) do
                if seat.nicoSeat then
                    table.insert(nicoSeats, seat)
                end
            end
        end

        while nicoSeats[loop] and not IsValid(nicoSeats[loop]) do
            loop = loop + 1
        end

        local seat = nicoSeats[loop]

        if nicoEnabled ~= seat and IsValid(nicoEnabled) then
            local saved = nicoEnabled:GetSaveTable()

            if not saved["m_bEnterAnimOn"] and not saved["m_bExitAnimOn"] then
                nicoEnabled:AddEFlags(EFL_NO_THINK_FUNCTION)
                nicoEnabled = nil
            end
        end

        if IsValid(seat) then
            seat:RemoveEFlags(EFL_NO_THINK_FUNCTION)
            nicoEnabled = seat
        end

        loop = loop + 1
    end)

    local function nicoSeatAction(ply, seat)
        if IsValid(seat) and seat.nicoSeat then
            table.insert(nicoSeats, loop, seat)
        end
    end

    hook.Add("PlayerEnteredVehicle", "nicoSeat", nicoSeatAction)
    hook.Add("PlayerLeaveVehicle", "nicoSeat", nicoSeatAction)
end

hook.Add("Think", "902-490429042-2490", function()
    if not optimizeRan then
        if nico.optimize.ServerOptimizations then
            optimizeSeats()
            hook.Remove("PlayerTick", "TickWidgets")
            hook.Remove("Think", "CheckSchedules")
            hook.Remove("LoadGModSave", "LoadGModSave")

            local timers = {"CheckHookTimes", "HostnameThink"}

            for i = 1, #timers do
                local t = timers[i]

                if timer.Exists(t) then
                    timer.Remove(t)
                end
            end

            hook.Add("OnEntityCreated", "-", function(m)
                if m:IsWidget() then
                    hook.Add("PlayerTick", "GODisableEntWidgets2", function(m, n)
                        widgets.PlayerTick(m, n)
                    end)

                    hook.Remove("OnEntityCreated", "WidgetInit")
                end
            end)

            for k, v in pairs(ents.GetAll()) do
                if nico.optimize.RemoveEntities[v:GetClass()] then
                    v:Remove()
                end
            end

            optimizeRan = true
        end
    end
end)

hook.Add("EntityTakeDamage", "EntityDamageExample", function(target, dmginfo)
    -- get table of all attackers 
    target.attackers = target.attackers or {}
    -- get attack from dmg info
    local attacker = dmginfo:GetAttacker()

    -- if attacker is a player
    if IsValid(attacker) and attacker:IsPlayer() and target.attackers[attacker] == nil then
        -- add attacker to table
        target.attackers[attacker] = true
        print("Player " .. attacker:Nick() .. " is attacking ", target)
    end
end)


CLASS_ANCO.name = "Alaskan NCO"

hook.Add("CreateCorpseHus", "sv_loot.lua-giveXP", function(corpse, target, char)
    target.attackers = target.attackers or {}

    for i, v in pairs(target.attackers) do
        i:getChar():giveXP(7)
    end
end)

util.AddNetworkString("invite_fac")

hook.Add("InitializedPlugins", "CreateTableds", function()
    net.Receive("invite_fac", function(len, ply)
        local target_ply = net.ReadEntity()
        print(target_ply)
        target_ply:notify("You are invited to join the faction that " .. ply:Nick() .. " is in. \n Type /accept in chat.")
        target_ply.factionWish = nut.faction.get(ply:getChar():getFaction())
    end)

    hook.Add("CharacterFactionTransfered", "removeLFlag", function(character, oldFaction, faction)
        character:takeFlags("L")
    end)

    nut.command.add("accept", {
        syntax = "",
        onRun = function(client, arguments)
            print(client.factionWish)
            client:getChar():setFaction(client.factionWish.index)
            client:getChar():takeFlags("L")
        end
    })
end)

if SERVER then
    local InfAmmo = 2

    function InfiniteAmmo()
        --if true then return end
        local n = InfAmmo
        if true then return end

        --just copy and paste :3
        if n == 2 then
            for k, v in pairs(player.GetAll()) do
                weapon = v:GetActiveWeapon()

                if IsValid(weapon) then
                    local maxClip = weapon:GetMaxClip1()
                    local maxClip2 = weapon:GetMaxClip2()
                    local primAmmoType = weapon:GetPrimaryAmmoType()
                    local secAmmoType = weapon:GetSecondaryAmmoType()
                    if maxClip == -1 and maxClip2 == -1 then end --maxClip = 100  --maxClip2 = 100

                    if maxClip <= 0 and primAmmoType ~= -1 then
                        maxClip = 1
                    end

                    if maxClip2 == -1 and secAmmoType ~= -1 then
                        maxClip2 = 1
                    end

                    if primAmmoType ~= -1 and maxClip ~= 1 then
                        v:SetAmmo(maxClip, primAmmoType, true)
                    end

                    if secAmmoType ~= -1 and secAmmoType ~= primAmmoType and maxClip2 ~= 1 then
                        v:SetAmmo(maxClip2, secAmmoType, true)
                    end
                end
            end
        end
    end
end

hook.Add("Think", "InfiniteAmmo", InfiniteAmmo)

local roachItems = function()
    local itm = {}
    table.insert(itm, "rawroach|" .. 1)

    return itm
end

--[[
local ENT = scripted_ents.GetStored("npc_vj_f3r_radroach").t
ENT.GenItems = function() return roachItems() end
local ENT = scripted_ents.GetStored("npc_vj_fo3_glowroach").t
ENT.GenItems = function() return roachItems() end
local ENT = scripted_ents.GetStored("npc_vj_fo3_nukaroach").t
ENT.GenItems = function() return roachItems() end
local ENT = scripted_ents.GetStored("npc_tf2_ghost").t
ENT.GenItems = function() return roachItems() end

function ENT:OnKilled(dmginfo)
    hook.Run("CreateEntityRagdoll", self)
    self:Remove()
end
 ]]
hook.Add("TFA_PostPrimaryAttack", "AmmoMaster", function(swep) end) -- swep.nCounter = (swep.nCounter or 0) + 1 -- print(swep.nCounter) -- if swep.nCounter>4 and math.random(swep.nCounter,6) == 6 then  -- print("PROC")  -- swep:SetClip1((swep:Clip1() + 1)) -- swep.nCounter = 0  -- end