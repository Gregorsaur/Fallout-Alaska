local PLUGIN = PLUGIN

function PLUGIN:DoPlayerDeath(victim, attacker, dmg)
    local char = victim:getChar()
    if (not char) then return end
    local corpse = PLUGIN:MakeCorpseFromVictim(victim)

    if (IsValid(corpse)) then
        hook.Run("OnCorpseCreated", corpse, victim, char)

        if (victim:IsOnFire()) then
            corpse:Ignite(8)
        end
    end
end

function PLUGIN:PlayerDeath(victim, inflictor, attacker)
    local OldRagdoll = victim:GetRagdollEntity()

    if (IsValid(OldRagdoll)) then
        OldRagdoll:Remove()
    end
end

-- Aplly victim movement on corpse
function PLUGIN:SetupBones(corpse, victim)
    local victim_vel = victim:GetVelocity() / 5
    local num = corpse:GetPhysicsObjectCount() - 1

    for i = 0, num do
        local physObj = corpse:GetPhysicsObjectNum(i)

        if (IsValid(physObj)) then
            if (victim_vel) then
                physObj:SetVelocity(victim_vel)
            end

            local boneId = corpse:TranslatePhysBoneToBone(i)

            if (boneId) then
                local pos, ang = victim:GetBonePosition(boneId)
                physObj:SetPos(pos)
                physObj:SetAngles(ang)
            end
        end
    end
end

-- Make a little cube to carry the corpse from Hands swep
function PLUGIN:MakeHandle(ent)
    ent:SetCollisionGroup(COLLISION_GROUP_WEAPON)
    local prop = ents.Create("prop_physics")
    prop:SetModel("models/hunter/blocks/cube025x025x025.mdl")
    prop:SetPos(ent:GetPos())
    prop:SetCollisionGroup(COLLISION_GROUP_WORLD)
    prop:SetNoDraw(true)
    prop:Spawn()
    prop:Activate()
end

function PLUGIN:CreateEntityRagdoll(owner, ragdoll)
    self:MakeCorpseFromVictim(owner)

    if IsValid(ragdoll) then
        ragdoll:Remove()
    end
end

--ents.FindByClass("tfa_ammo_ar2")[1]:SetNW2String("n", "Shit Stained Box")
--ents.FindByClass("tfa_ammo_ar2")[1]:SetNW2String("corpse", util.TableToJSON({"food_raw_roach|5"}))
--ents.FindByClass("tfa_ammo_ar2")[1].Inventory={"food_raw_roach|5"}
-- Create a corpse from a victim
function PLUGIN:MakeCorpseFromVictim(victim)
    local corpse = ents.Create("prop_ragdoll")
    corpse:SetNW2Int("corpse", true)

    corpse.Inventory = {"Caps|" .. math.floor(12 / (math.random() * 120 + 2)) + 1}

    if victim.GenItems then
        for i, v in pairs(victim:GenItems() or {}) do
            table.insert(corpse.Inventory, v)
        end
    end

    for i, v in pairs(hook.Run("genItemsForRagdoll", victim) or {}) do
        table.insert(corpse.Inventory, v)
    end

    corpse:SetNW2String("n", victim:GetClass() or "NOT SET")
    corpse:SetNW2String("corpse", util.TableToJSON(corpse.Inventory))

    if victim:IsPlayer() then
        local char = victim:getChar()

        if (char) then
            --corpse:SetNW2Int("corpseChrId", char:getID())
            corpse:SetNW2String("n", char:getName())
            corpse:SetNW2Int("id", char:getID())
        end
    end

    --victim:CloneVarsOn(corpse)
    corpse:SetModel(victim:GetModel())
    corpse:SetSkin(victim:GetSkin())
    corpse:Spawn()
    corpse:Activate()
	hook.Run("CreateCorpseHus",corpse,victim ,char)
    timer.Simple(25, function()
        corpse:Remove()
    end)

    PLUGIN:SetupBones(corpse, victim)
    PLUGIN:MakeHandle(corpse)

    return corpse
end