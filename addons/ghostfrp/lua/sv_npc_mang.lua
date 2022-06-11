    function UPDATE_CHARACTER_STAMINA(client)
        if IsValid(client) then
            local char = client:getChar()
            client.MaxStamina = 200
            client.StaminaFatigueReduction = 1
            client.getRunMultiplier = 1
            for i, v in pairs(hook.GetTable().getMaxStam or {}) do
                client.MaxStamina = client.MaxStamina + v(char)
            end

            for i, v in pairs(hook.GetTable().getStamDecay or {}) do
                client.StaminaFatigueReduction = client.StaminaFatigueReduction * v(char)
            end
            for i, v in pairs(hook.GetTable().getRunMultiplier or {}) do
                client.getRunMultiplier = client.getRunMultiplier * v(char)
            end
            client:setLocalVar("maxStm", client.MaxStamina)
        end
    end
    hook.Add( "PlayerSpawn", "_Stamina", function(client) 
        print("PlayerSpawn")
        timer.Simple(4, function()
            UPDATE_CHARACTER_STAMINA(client)
            client:setLocalVar("stm", client:getLocalVar("maxStm"))
            local uniqueID = "nutStam" .. client:SteamID()
            local offset = 0
            local runSpeed = client:GetRunSpeed() - 5

            timer.Create(uniqueID, 0.25, 0, function()
                if (not IsValid(client)) then
                    timer.Remove(uniqueID)

                    return
                end
                local runspeed = nut.config.get("runSpeed") or 150
                local character = client:getChar()
                if (client:GetMoveType() == MOVETYPE_NOCLIP or not character) then return end
                local bonus = client.getRunMultiplier --character.getAttrib and character:getAttrib("stm", 0) or 0
          
                runSpeed = runspeed * bonus
                client:SetRunSpeed(runSpeed)
                if (client:WaterLevel() > 1) then
                    runSpeed = runSpeed * 0.775
                end

                if (client:isRunning()) then
                    local bonus = character.getAttrib and character:getAttrib("end", 0) or 0
                    offset = (-2 + (bonus / 60)) * (client.StaminaFatigueReduction)
   
                elseif (offset > 0.5) then
                    offset = 1
                else
                    offset = 1.75
                end

                if (client:Crouching()) then
                    offset = offset + 1
                end
                
                local current = client:getLocalVar("stm", 0)
                if offset > 0 then 
                offset = offset * 5 
                end
                local value = math.Clamp(current + offset, 0, client:getLocalVar("maxStm"))

                if (current ~= value) then
                    client:setLocalVar("stm", value)

                    if (value == 0 and not client:getNetVar("brth", false)) then
                       -- client:SetRunSpeed(nut.config.get("walkSpeed"))
                        client:setNetVar("brth", true)
                        hook.Run("PlayerStaminaLost", client)
                    elseif (value >= 50 and client:getNetVar("brth", false)) then
                       -- client:SetRunSpeed(runSpeed)
                        client:setNetVar("brth", nil)
                    end
                end
            end)
        end)
    end)

    local playerMeta = FindMetaTable("Player")

    function playerMeta:restoreStamina(amount)
        local current = self:getLocalVar("stm", 0)
        local value = math.Clamp(current + amount, 0, self:getLocalVar("maxStm"))
        self:setLocalVar("stm", value)
    end










MAX_HP_LIMB = 300

hook.Add("GetFallDamage", "a", function(ply, speed)
    local char = ply:getChar()
    print("hp_leg_left", char:getData("hp_leg_left", 0))
    char:setData("hp_leg_left", math.Clamp(char:getData("hp_leg_left", 0) + 20, 0, MAX_HP_LIMB))
    char:setData("hp_leg_right", math.Clamp(char:getData("hp_leg_right", 0) + 20, 0, MAX_HP_LIMB))
    char:setData("hp_leg_left", 0)
    char:setData("hp_leg_right", 0)
    hook.Run("UpdatePseduoBuffsSpeedOnly", ply)
end)

if nut and nut.plugin.list.playerinjuries then
    hook.Remove("GetFallDamage", nut.plugin.list.playerinjuries)
end

print("NPC_MANG LOADED")

hook.Add("PlayerSpawnedNPC", "leveloverride", function(p, npc)
    npc:SetNWInt("lvl", math.random(50, 50))
end)

hook.Add("ScaleNPCDamage", "ScaleNPCDamageExample", function(npc, hitgroup, dmginfo) end) -- print(hitgroup) -- if hitgroup == 101 then --     dmginfo:ScaleDamage(3.5) -- end
local ply = FindMetaTable("Player")

function ply:TakeRadDamage(x)
    local char = self:getChar()
    char:setData("rads", math.Clamp(char:getData("rads", 0) + x, 0, 100000))
    self:SetHealth(math.min(self:Health(), self:GetMaxHealth() - self:GetRads()))
end

function Rad_C()
    return 0.25
end

function Rad_C()
    return 0.25
end

function ply:HealRadDamage(x)
    local char = self:getChar()
    char:setData("rads", math.Clamp(char:getData("rads", 0) - x, 0, 100000))
    self:SetHealth(math.min(self:Health(), self:GetMaxHealth() - self:GetRads()))
end

function ply:Heal(x)
    self:SetHealth(math.min(self:Health() + x, self:GetMaxHealth() - self:GetRads()))
end

function ply:GetRadsRaw(x)
    local char = self:getChar()

    return char:getData("rads", 0) or 0
end

function ply:GetRads(x)
    local char = self:getChar()
    --(char:getData("rads", 0) or 0) * self:Rad_C()

    return 0
end

function ply:SetRads(x)
    local char = self:getChar()
    char:setData("rads", x)
    self:SetHealth(math.min(self:Health(), self:GetMaxHealth() - self:GetRads()))
end

ply.OldHP = ply.OldHP or ply.SetHealth

function ply:setHealth(x)
    self:SetHealth(ply, x)
end

local lastTick = 0

hook.Add("EntityTakeDamage", "rads", function(target, dmginfo)
    if target:IsPlayer() then
        local char = target:getChar()
        lastTick = CurTime()

        if dmginfo:IsDamageType(DMG_RADIATION) then
            target:TakeRadDamage(1)
            target:EmitSound("pipboy/radiation/b/ui_pipboy_radiation_b_0" .. math.random(1, 3) .. ".wav")
            dmginfo:ScaleDamage(0)
            local tim = target:AccountID() .. "rad_timer"

            if timer.Exists(tim) then
                timer.Start(tim)
            else
                timer.Create(tim, 1, 1, function()
                    netstream.Start(target, "RADDMG", 0)
                end)

                netstream.Start(target, "RADDMG", 1)
            end
        end
    end
end)

hook.Add("PlayerSpawn", "radReset", function(p, npc)
    timer.Simple(0.1, function()
        p:SetRads(math.Clamp(p:GetRads(), 0, p:GetMaxHealth() * 0.9))
    end)
end)

local function SetupMapLua()
    MapLua = ents.Create("lua_run")
    MapLua:SetName("triggerhook")
    MapLua:Spawn()

    for k, v in pairs(ents.FindByClass("trigger_teleport")) do
        v:Remove()
    end

    for k, v in pairs(ents.FindByClass("trigger_hurt")) do
        print(v)
        v:SetTrigger(true)

        function v:StartTouch(entity)
            print(entity, "TOUCH")
        end
    end
end

hook.Add("StartTouch", "StartTouchStartTouchStartTouch", function() end)

--SetupMapLua()
--hook.Add("InitPostEntity", "SetupMapLua", SetupMapLua)
--hook.Add("PostCleanupMap", "SetupMapLua", SetupMapLua)
hook.Add("OnTeleport", "TestTeleportHook", function()
    local activator, caller = ACTIVATOR, CALLER
end)

-- print(activator, caller) 
hook.Add("ScalePlayerDamage", "Stoic", function(ply, hitgroup, dmginfo)
    print("STOIC CHECK")

    if ply:getChar():getTrait() == 12 then
        dmginfo:ScaleDamage(0.95)
    end
end)

local function GetDamageEvent(char, onlyhead)
    onlyhead = onlyhead or false
    local _ = 0

    for i, v in pairs(char:getInv().items) do
        if v:getData("equip") then
            _ = _ + (v.resishead or 0)
            _ = _ + (v.resisbody or 0)
        end
    end

    return math.max(1 - (_ / 100), 0.2)
end

hook.Add("ScalePlyDmg", "ScalePlyDmg", function()
    print("WE SCALING RETARDS")
end)

hook.Add("ScalePlayerDamage", "HandleScalingPerLimb", function(ply, hitgroup, dmginfo)
    print("NZERA", ply, hitgroup, dmginfo)
end)

hook.Add("EntityTakeDamage", "ScalePlayerDamage", function(target, dmginfo)
    local ply = target

    if ply and ply:IsPlayer() then
        local char = ply:getChar()

        if char then
            dmginfo:ScaleDamage(GetDamageEvent(ply:getChar(), false)) -- Less damage when shot anywhere else
        end
    end
end)

hook.Add("EntityTakeDamage", "EntityDamageExample", function(target, dmginfo)
    if target:IsPlayer() then end --dmginfo:ScaleDamage( GetDamageEvent(target:getChar()) ) 
end)