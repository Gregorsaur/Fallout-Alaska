PLUGIN.name = "Stamina"
PLUGIN.author = "Chessnut + Evan"
PLUGIN.desc = "Adds a stamina system to limit running."

if (SERVER) then
    function UPDATE_CHARACTER_STAMINA(client)
        if IsValid(client) then
            local char = client:getChar()
            client.MaxStamina = 100
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

    function PLUGIN:PostPlayerLoadout(client)
        timer.Simple(1, function()
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
                local value = math.Clamp(current + offset, 0, client:getLocalVar("maxStm"))

                if (current ~= value) then
                    client:setLocalVar("stm", value)

                    if (value == 0 and not client:getNetVar("brth", false)) then
                        client:SetRunSpeed(nut.config.get("walkSpeed"))
                        client:setNetVar("brth", true)
                        hook.Run("PlayerStaminaLost", client)
                    elseif (value >= 50 and client:getNetVar("brth", false)) then
                        client:SetRunSpeed(runSpeed)
                        client:setNetVar("brth", nil)
                    end
                end
            end)
        end)
    end

    local playerMeta = FindMetaTable("Player")

    function playerMeta:restoreStamina(amount)
        local current = self:getLocalVar("stm", 0)
        local value = math.Clamp(current + amount, 0, self:getLocalVar("maxStm"))
        self:setLocalVar("stm", value)
    end
end