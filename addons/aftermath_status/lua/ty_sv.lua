--NETWORK STRINGS--
util.AddNetworkString("PushBuff")
util.AddNetworkString("PushBuffs")
util.AddNetworkString("DeleteAllBuffs")
util.AddNetworkString("pushBuffToUpdatedClient")
util.AddNetworkString("ixUpdateStatus")

--Helix Variable Define--



ix = nil 
timer.Create( "ix.char.is.ready", 0.1, 0, function()
    if nut then
    if nut.char then
       -- MOVED TO SH_CHARACTER GAMEMODE LUA
        isHelixReady = true
        timer.Remove( "ix.char.is.ready" )
        end end

    end )

    --METATABLE SETUP--
    local _player = FindMetaTable( "Player" )

    function _player:heal(amount) -- Since health cant be decimal this allows a pseudo decimal value that stores decimal heals in a buffer.
        char = self:getChar()
      
        char.healthBuffer = (char.healthBuffer or 0) + amount
        local healthgive = (char.healthBuffer) - ((char.healthBuffer)%1)
        if healthgive >= 1 then
            self:SetHealth(math.Clamp( self:Health() + healthgive, 0, self:GetMaxHealth()))
            char.healthBuffer = char.healthBuffer - healthgive
        elseif healthgive <= -1 then
            self:SetHealth(math.Clamp( self:Health() + healthgive, 0, self:GetMaxHealth()))
            char.healthBuffer = char.healthBuffer - healthgive
            if self:Health() < 1 then self:Kill() end
        end
    end

    function _player:maxHealth(amount)
        amount = tonumber(tostring(amount))
        local hp, maxhp = self:Health(), self:GetMaxHealth()
        local percent = hp / maxhp
        self:SetMaxHealth(amount)
        self:SetHealth(amount * percent)
        if self:Health() <= 0 then
            self:Kill()
        end
    end


    function _player:purgeEffects(SaveAfter, ForceClear, PersistCertainDrugs)
        SaveAfter = SaveAfter or false
        ForceClear = ForceClear or false
        local char = self:getChar()
        if ForceClear == true then
            local statusEffects, StatusEffectsVar = {}, {}

            if PersistCertainDrugs then
                for n, drug in pairs(char:getData("StatusVar") or {}) do
                    if TY_PERSIST[drug[1]] then
                        table.insert(statusEffects, drug)
                        StatusEffectsVar[STATE_ID_TO_STRING[drug[1]]] = drug[3]
                    end
                end
            end 
            if SaveAfter then 
          
                char:setData("StatusVar",statusEffects)
                char.statuses = StatusEffectsVar
                --char:Save()
                net.Start( "DeleteAllBuffs" )
                net.Send( self )
                if PersistCertainDrugs and #statusEffects > 0 then
                    net.Start( "PushBuffs" )
                    for i, v in pairs(statusEffects) do

                        net.WriteUInt(v[2], 32)
                        net.WriteUInt(v[1], 13)
                        net.WriteUInt(v[3], 8)

                    end
                    net.Send( self )
                end
            end
            return {}
        end
        local strx = char:getData("StatusVar") or nil
        if (strx) then
            for i, v in pairs (strx) do
                if v[2] - _getTimeSystem() < 0 then
                    table.remove(char:getData("StatusVar"), i)
                end
            end
        end
        if SaveAfter then 
            --char:Save()
         end
    end

    hook.Add("PlayerDeath", "removeDrugsOnDeath", function(player)
        --for _,v in pairs(TY_HOOKS["PlayerDeath"]) do
 
        --end
        player:purgeEffects(true, true, true)
        Debug.Print(player:Nick(), " has died, status effects are now non-existant.")
        player.resistance = 1
    end)

    function _player:removeStateByID(id, amountOfStacks)
        self:removeState(STATE_ID_TO_STRING[id], amountOfStacks)
    end

    function _player:removeState(id, amountOfStacks)
        if amountOfStacks then

        else
            hook.Call("StatusEffectRemoved", nil, self, id)
            id = STATE_STRING_TO_ID[id or "empty"]
            net.Start( "PushBuff" )
            net.WriteUInt(0, 32)
            net.WriteUInt(id, 13)
            net.WriteUInt(1, 8)
            net.Send( self )
            local states = char:getData("status")
            for i, v in pairs (states) do
                if v[1] == id then
                    states[i] = nil
                    break
                end
            end
            char:SetStatus(states)
            char:Save()

        end
    end

    function _player:addStatus(id, duration, amountOfStacks)
        self:assignState(id, duration, nil, amountOfStacks)
    end
    function _player:addStatusByID(id, duration, amountOfStacks)
        self:assignState(STATE_ID_TO_STRING[id], duration, nil, amountOfStacks)
    end

    function _player:assignState(id, duration, isRecursive, amountOfStacks)

        local char = self:getChar()
        local states = char:getData("Status") or {}
        local amountOfStacks = amountOfStacks or 1
        local selectedState = TY_BUFFS[tostring(STATE_STRING_TO_ID[id])]
        if !isRecursive then self:purgeEffects() end
        if !states then print("Can not find a characters state class") return end
        local endtime = _getTimeSystem() + (duration or 30)

        local isExist = true
        local stacks = amountOfStacks
        for i, v in pairs (states) do
            if v[1] == STATE_STRING_TO_ID[id] then

                v[2] = (v[2] > endtime and v[2]) or endtime
                endtime = v[2]
                v[3] = math.min((v[3] or 0) + amountOfStacks, selectedState.stackable or 1)
                stacks = v[3]

                isExist = false break end
            end
            if isExist then table.insert(states, {STATE_STRING_TO_ID[id], endtime, amountOfStacks}) end

            if selectedState and selectedState.inherit then
                for i, v in pairs(selectedState.inherit) do
                    self:assignState(v[1], v[2], true)
                end
            end
            if !isRecursive then
                char:setData("Status",states) 
                char:save()
            end
	
            hook.Call("statusEffectAssigned", nil, self, id, stacks)
            net.Start( "PushBuff" )
            net.WriteUInt(endtime, 32)
            net.WriteUInt(STATE_STRING_TO_ID[id or "empty"], 13)
            net.WriteUInt(stacks, 8)
            net.Send( self )
        end

        hook.Add("PlayerLoadedChar", "_OnCharacterCreated_tydrug", function(client,char)
            local c = char:getPlayer()
            net.Start( "pushBuffToUpdatedClient" )
            for _, v in pairs(char:getData("Status") or {}) do
                timer.Simple( 1, function() hook.Call("statusEffectAssigned", nil, c, v[1] or 0, v[3] or 1) end )

                net.WriteUInt(v[2], 32)
                net.WriteUInt(v[1] or 0, 13)
                net.WriteUInt(v[3] or 1, 8)
            end
            net.Send( c )
            c:SetHealth(math.min(100, c:Health()))
        end)

        hook.Add( "EntityTakeDamage", "Resistance", function( target, dmginfo )

            if ( target:IsPlayer() ) then
            local dmg = dmginfo:GetDamage()
            dmginfo:ScaleDamage( target.resistance or 1 )
            if target:isBuffActive(STATE_STRING_TO_ID["treemanherb"]) then
                target:assignState("treemanherb_damage", 6, nil, dmg)
            end
        end

    end )


    hook.Add("Tick", "process_tick_buffs", function()
        for k, ply in pairs(player.GetAll()) do

        local char = ply:getChar()
		

        if char  then
            local effects = char:getData("Status") or {}
            for i = #effects, 1, - 1 do
                local v = effects[i]
                if (v[2] or 0) < _getTimeSystem() then
                    if TY_STACKSDODECAY[v[1]] and tonumber(v[3]) > 1 then
                        effects[i][2] = _getTimeSystem() + TY_STACKSDODECAY[v[1]]
                        effects[i][3] = effects[i][3] - 1
                        net.Start( "pushBuffToUpdatedClient" )
                        net.WriteUInt(v[2], 32)
                        net.WriteUInt(v[1] or 0, 13)
                        net.WriteUInt(v[3] or 1, 8)
                        net.Send( ply )
                    else
                        table.remove(effects, i)
                    end
                    hook.Call("statusEffectRemoved", nil, ply, STATE_ID_TO_STRING[v[1]])
                end
            end
        end
    end
end)


function _player:calcuateJumpPower(buffs)
    local resist = 1
    local maxhealth = hook.Call( "GetPlayerJumpPower" ) or ty_effects.Player.JumpPower or 160
    for i, _ in pairs(buffs) do
        v = get_buff(_.id)

        if v and v.attributes and v.attributes.jumpPower then
            resist = resist * (1 + (v.attributes.jumpPower * _.stacks))
        end
    end
    self:SetJumpPower(maxhealth * resist)
end

local function updateHealth(player)
    local buffs = player:getActiveBuffs()
    player:getMaxHealth(buffs)
    player:calcuateSpeed(buffs)
    player:calcuateResistance(buffs)
    player:calcuateJumpPower(buffs)
end
hook.Add("statusEffectAssigned", "statusEffectAssigned-updateHealth", updateHealth)
hook.Add("statusEffectRemoved", "statusEffectRemoved-updateHealth", updateHealth)

hook.Add("statusEffectAssigned", "statusEffectAssigned-setOptimalServerTrue", function(player, id, stacks)
    local c = player:getChar()
    print("GIVEN")
    c.statuses = c.statuses or {}
    c.statuses[id] = stacks
end)
hook.Add("statusEffectRemoved", "statusEffectRemoved-setOptimalServerFalse", function(player, id)
    if id then
    local c = player:getChar()
    c.statuses = c.statuses or {}
    c.statuses[id] = false
end
end)

hook.Add("UpdatePseduoBuffsSpeedOnly", "statusEffectRemoved-updateHealth", function(player) 
player:calcuateSpeed(player:getActiveBuffs()) 
end)
--DEBUG BELOW



concommand.Add( "givecraft", function( ply, cmd, args )
if not ply:IsAdmin() then ply:Notify("you do not have permision to use this") return end
if SERVER then
    local char = ply:getChar()
    local inv = char:GetInventory()
    inv:Add("crafting_drug", 1, {
        ["craftingID"] = args[1]:lower(),
    })
end
end )
concommand.Add( "givedrug", function( ply, cmd, args )
if not ply:IsAdmin() then ply:Notify("you do not have permision to use this") return end
if SERVER then
    local char = ply:getChar()
    local inv = char:GetInventory()
    inv:Add("drug", 1, {
        ["drugID"] = args[1],
    })
end
end )

concommand.Add( "sethunger", function( ply, cmd, args )
if not ply:IsAdmin() then ply:Notify("you do not have permision to use this") return end
if SERVER then
    local char = ply:getChar()
    char:SetData("Hunger", tonumber(args[1]))
    updateHealth(ply)
end
end )
concommand.Add( "setthirst", function( ply, cmd, args )
if not ply:IsAdmin() then ply:Notify("you do not have permision to use this") return end
if SERVER then
    local char = ply:getChar()
    char:SetData("Thirst", tonumber(args[1]))
    updateHealth(ply)
end
end )
concommand.Add( "list", function( ply, cmd, args )
if not ply:IsAdmin() then ply:Notify("you do not have permision to use this") return end
if SERVER then

    local char = ply:getChar()
    local states = char:getData("status")
    PrintTable(states)
end
end )


 
concommand.Add( "list_drugs", function( ply, cmd, args )
if not ply:IsAdmin() then ply:Notify("you do not have permision to use this") return end
PrintTable(TY_BUFFS)

end )
 
concommand.Add( "purge", function( ply, cmd, args )
if not ply:IsAdmin() then ply:Notify("you do not have permision to use this") return end
if SERVER then

    ply:purgeEffects(true)
end
end )

concommand.Add( "purgeAll", function( ply, cmd, args )
if not ply:IsAdmin() then ply:Notify("you do not have permision to use this") return end
if SERVER then

    ply:purgeEffects(true, true)
end
end )
concommand.Add( "addstate", function( ply, cmd, args )

if SERVER then

    ply:assignState(args[1] or nil, args[2] or nil, nil, args[3])
end
end )
