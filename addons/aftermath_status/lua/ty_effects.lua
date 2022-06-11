TYPE = {}
TYPE.ABSOLUTE = 1
TYPE.PERCENTAGE = 2
 
local DRUG_INDEX_OFFSET = 0
INTOLERANCE = {"intolerance", 3600}

hook.Add( "ty_update_drug_index", "_ty_update_drug_index", function()
    TY_PSUEDO_BUFFS = {} 
TY_STACKSDODECAY = {}
TY_HOOKS = {}
TY_PERSIST={}
    DRUG_INDEX_OFFSET = 0
    if buff == nil then return end
    local buff_debug01 = buff("empty", DRUG_INDEX_OFFSET + 1)
    buff_debug01.description = "Empty/String"
 
    local buff_debug02 = buff("none", DRUG_INDEX_OFFSET + 2)
    buff_debug02.description = "Altered thoughts, feelings, and awareness, causes slight damage reduction"
    buff_debug02.name = "LSD"

    local debuff_sweat = debuff("sweating", DRUG_INDEX_OFFSET + 3)
    debuff_sweat.description = "Your body is sweating, this is causing you to lose hydration quicker."
    debuff_sweat.name = "Sweating"
    debuff_sweat.maxDuration = 120
    debuff_sweat.icon = "wicons/05_1.png"

    local debuff_sickness = debuff("sickness", DRUG_INDEX_OFFSET + 4) -- Oh, ah, ah, ah, ah
    debuff_sickness.description = "Decreases your health by 10%"
    debuff_sickness.name = "Sickness"
    debuff_sickness.attributes = {["health"] = -0.1}
    debuff_sickness.icon = "wicons/02_3.png"
    debuff_sickness.stackable = 10

    local buff_adrenaline = buff("adrenaline", DRUG_INDEX_OFFSET + 5)
    buff_adrenaline.description = "Reduces your damage taken by 15%\nincreases your movement speed by 15%\nIncreases Health by 15%\nAlso allows you to sprint when you lack the ablity to do so."
    buff_adrenaline.itemDescription = "Epinephrine, also known as adrenaline, is a hormone and neurotransmitter generally associated with the fight-or-flight response of the sympathetic nervous system."
    buff_adrenaline.name = "Adrenaline"
    buff_adrenaline.displayName = "Epinephrine"
    buff_adrenaline.model = "models/neeewpackofprops/drug11.mdl"
    buff_adrenaline.inherit = {{"sweating", 100}}
    buff_adrenaline.attributes = {["health"] = 0.15, ["speed"] = 0.15, ["resistance"] = 0.15, ["stopDisableSprint"] = true}
    buff_adrenaline.icon = "wicons/DivineSpirit.png"

    local debuff_blurryvision = debuff("blurryvision", DRUG_INDEX_OFFSET + 6)
    debuff_blurryvision.description = "Your vision is being hindered by "
    debuff_blurryvision.name = "Blurry vision"
    debuff_blurryvision.stackable = 3
    debuff_blurryvision.icon = "wicons/Hibernation.png"
    debuff_blurryvision.drawVFX = function(stacks)
        --s-urface.SetMaterial( Material("pp/DrawBloom")	 )
        --surface.DrawTexturedRect(0,0, ScrW(), ScrH() )
        local tab = {}
        tab[ "$pp_colour_addr" ] = 0
        tab[ "$pp_colour_addg" ] = 0
        tab[ "$pp_colour_addb" ] = 0
        tab[ "$pp_colour_brightness" ] = ({ - 0.9, - 0.5, - 0.2})[ - stacks]
        tab[ "$pp_colour_contrast" ] = ({0.9, 0.5, 0.2})[stacks]
        tab[ "$pp_colour_colour" ] = 1
        tab[ "$pp_colour_mulr" ] = 0
        tab[ "$pp_colour_mulg" ] = 0
        tab[ "$pp_colour_mulb" ] = 0
        DrawColorModify( tab )
    end
    local mat2 = Material( "pp/blurscreen" )
    debuff_blurryvision.draw = function(stacks)
        surface.SetMaterial( mat2 )
        surface.SetDrawColor( 255, 255, 255 )
        mat2:SetFloat( "$blur", 2^stacks )
        mat2:Recompute()
        if render then render.UpdateScreenEffectTexture() end
        surface.DrawTexturedRect( 0, 0, ScrW(), ScrH() )
    end

    local buff_kolto = buff("kolto", DRUG_INDEX_OFFSET + 7)
    buff_kolto.description = "Heals you for 161 over 23 seconds." --23
    buff_kolto.name = "Kolto"
    buff_kolto.icon = "wicons/AbolishMagic.png"
    buff_kolto:push("PlayerTick", function(player) player:heal(FrameTime() * 7) end)

    local buff_cz_x = buff("cz-x", DRUG_INDEX_OFFSET + 8)
    buff_cz_x.description = "Heals you for 80 over 20 seconds."
    buff_cz_x.name = "CZ-X-5438-A"
    buff_cz_x.icon = "wicons/20_potion_potion.png"
    buff_cz_x:push("PlayerTick", function(player) player:heal(FrameTime() * 3) end)

    local buff_cz_x_c = buff("cz-x-c", DRUG_INDEX_OFFSET + 9)
    buff_cz_x_c.description = "Heals you for 100 over 50 seconds."
    buff_cz_x_c.name = "CZ-X-5438-C"
    buff_cz_x_c.icon = "wicons/15_potion_potion.png"
    buff_cz_x_c:push("PlayerTick", function(player) player:heal(FrameTime() * 2) end)
    buff_cz_x_c.stackable = 12
    buff_cz_x_c:decayStack(1)


    local debuff_millaflower = debuff("millaflower", DRUG_INDEX_OFFSET + 10)
    debuff_millaflower.description = {"You feel at ease", "you feel sleepy", "You feel intoxicated", "You feel really sleepy", "Your heart feels weak and like it's going to fail"}
    debuff_millaflower.name = "Millaflower"
    debuff_millaflower.stackable = 5
    debuff_millaflower.icon = "wicons/GiftEarthmother.png"
    debuff_millaflower:push("PlayerTick",
        function(player, stacks)
            if stacks > 4 then
                local char = player:getChar()
                if !char.millaflowerTick or (char.millaflowerTick) < CurTime() then
                    local player = char:GetPlayer() --()
                    char.millaflowerTick = CurTime() + 5
                    if math.random(0, 31) == 1 then
                        player:Kill()
                    end
                end
            end
        end)
        local mat3 = Material( "pp/blurscreen" )
        debuff_millaflower.draw = {[4] = function(stacks)
            surface.SetMaterial( mat2 ) surface.SetDrawColor( 255, 255, 255 );mat3:SetFloat( "$blur", 2^stacks );mat3:Recompute()if render then render.UpdateScreenEffectTexture() end;surface.DrawTexturedRect( 0, 0, ScrW(), ScrH() )
            debuff_millaflower.draw[5] = debuff_millaflower.draw[4]
        end}

        local debuff_intolerance = debuff("intolerance", DRUG_INDEX_OFFSET + 11)
        debuff_intolerance.description = "Consuming certain drugs causes your body to build an intolerance, intolerance can cause death. Intolerance slowly decays."
        debuff_intolerance.name = "Intolerance"
        debuff_intolerance.icon = "wicons/AntiShadow.png"
        debuff_intolerance.stackable = 12
        debuff_intolerance:decayStack(25)

        local buff_spice_ryll = buff("ryll", DRUG_INDEX_OFFSET + 55, false)
        buff_spice_ryll.description = "Ryll is a weak form of spice that prevents the amount of damage you take by 10%."
        buff_spice_ryll.name = "Ryll"
        buff_spice_ryll.icon = "wicons/Powder_Mithril.png" 
        buff_spice_ryll.inherit = {INTOLERANCE}
        DRUG_INDEX_OFFSET = 125
   local debuff_hungry = debuff("broken left leg", DRUG_INDEX_OFFSET + 13, true)
        debuff_hungry.description = "You have broken your left leg, your movement speed is reduced by 40%"
        debuff_hungry.name = "Broken Left Leg"
        debuff_hungry.icon = "Broken Left Leg"
        debuff_hungry.attributes = {["speed"] = -0.4, }
        debuff_hungry.check = function(player) local char = player:getChar() return char and char:getData("hp_leg_left", 0) >= 299 end
              local debuff_hungry = debuff("broken right leg", DRUG_INDEX_OFFSET + 14, true)
        debuff_hungry.description = "You have broken your right leg, your movement speed is reduced by 40%"
        debuff_hungry.name = "Broken Right Leg"
        debuff_hungry.icon = "wicons/Fork&Knife.png"
        debuff_hungry.attributes = {["speed"] = -0.4, }
        debuff_hungry.check = function(player) local char = player:getChar() return char and char:getData("hp_leg_right", 0) > 299 end
        DRUG_INDEX_OFFSET = 0
 
        local debuff_hungry = debuff("thirsty", DRUG_INDEX_OFFSET + 14, true)
        debuff_hungry.description = "You are thirsty, your movement speed is reduced by 30% and you are not able to sprint."
        debuff_hungry.name = "Thirsty"
        debuff_hungry.icon = "wicons/Potion_Empty.png"
        debuff_hungry.attributes = {["speed"] = -0.3, ["disableSprint"] = true}
        debuff_hungry.check = function(player) local char = player:getChar() return char and char.isThirsty end

        local isFatigued = debuff("fatigue", DRUG_INDEX_OFFSET + 15, true)
        isFatigued.description = "You are fatigued, you are not able to sprint."
        isFatigued.name = "Fatigued"
        isFatigued.icon = "wicons/TimeStop.png"
        isFatigued.attributes = {["disableSprint"] = true, }
        isFatigued.check = function(p) local char = p:getChar() return (CLIENT and char and char.isFatigued and p:GetRunSpeed() == p:GetWalkSpeed()) or (SERVER and char and char.isFatigued) end

        local buff_Sweetblossom = debuff("sweetblossom", DRUG_INDEX_OFFSET + 16)
        buff_Sweetblossom.description = {"The sweetblossom eases your mind which allows for 25% extra health,\nwhile reducing your movement speed by 10%",
        "The sweetblossom eases your mind even further which allows for 50% extra health,\nwhile reducing your movement speed by 20%", }
        buff_Sweetblossom.name = "Sweetblossom"
        buff_Sweetblossom.icon = "wicons/Potion_01.png"
        buff_Sweetblossom.stackable = 2
        buff_Sweetblossom.attributes = {["health"] = 0.25, ["speed"] = -0.1}

        local buff_hydration = debuff("hydration", DRUG_INDEX_OFFSET + 17)
        buff_hydration.description = "Hydration tablets are tablets designed to keep beings hydrated in situations with no access to fresh water for periods of time.\nYour thirst decays slower."
        buff_hydration.name = "Hydration Tablets"
        buff_hydration.icon = "wicons/TrueSilver_01.png"

        local TreemanHerb = buff("treemanherb", DRUG_INDEX_OFFSET + 18)
        TreemanHerb.description = "You take 75% less damage but when you take damage, the full amount gets given to you over 6 seconds. Taking damage resets the time on all stacks."
        TreemanHerb.name = "Treeman's herbs"
        TreemanHerb.icon = "wicons/MithrilFiligree.png"
        TreemanHerb.attributes = {["resistance"] = 0.75}

        local TreemanHerbDebuff = debuff("treemanherb_damage", DRUG_INDEX_OFFSET + 19)
        TreemanHerbDebuff.description = function(stacks) return "You're taking "..stacks.."hp over 6 seconds" end
        TreemanHerbDebuff.name = "Treeman's herbs"
        TreemanHerbDebuff.icon = "wicons/MithrilFiligree.png"
        TreemanHerbDebuff:push("PlayerTick", function(player, stacks) 
		if (player.TreemanherbCooldown or 0 ) <= CurTime()  then player:heal(-(stacks*0.2)/6) player.TreemanherbCooldown=CurTime()+0.2 end
		end)  
        TreemanHerbDebuff.stackable = 250

        local Chromostring = buff("Chromostring", DRUG_INDEX_OFFSET + 20)
        Chromostring.description = ""
        Chromostring.name = "Treeman's herbs"
        Chromostring.icon = "wicons/MithrilFiligree.png"
        Chromostring:push("PlayerTick", function(player, stacks) player:heal(-(FrameTime() / 5) * stacks) end)
        Chromostring.stackable = 250

        --Deraformine--
        local Deraformine = buff("deraformine", DRUG_INDEX_OFFSET + 21)
        Deraformine.description = "If you are brought below zero health, you get brought to 25 health and get 75 health over 6 seconds, you also get adrenaline for 30 seconds.\nDeraformine also causes deraformine sickness which prevents it from working for 10m."
        Deraformine.name = "Deraformine"
        Deraformine.icon = "wicons/Heroism.png"

        local Deraformine_heal = buff("deraformine_heal", DRUG_INDEX_OFFSET + 22)
        Deraformine_heal.description = "Heals you for 25 every 2 seconds."
        Deraformine_heal.name = "Deraformine"
        Deraformine_heal.icon = "wicons/IntensifyRage.png"
        Deraformine_heal:push("PlayerTick", 
		function(player) 
		if (player.deraformine_heal or 0 ) <= CurTime()  then player:heal(25/10) player.deraformine_heal=CurTime()+0.2 end
		end)
        Deraformine_heal.inherit = {{"adrenaline", 30}, {"deraformine_sickness", 600}}



        local Deraformine_sickness = debuff("deraformine_sickness", DRUG_INDEX_OFFSET + 23)
        Deraformine_sickness.description = "Prevents Deraformine from preventing death."
        Deraformine_sickness.name = "Deraformine"
        Deraformine_sickness:setPersist(true)
        Deraformine_sickness.icon = "wicons/Heroism.png"
        Deraformine:push("EntityTakeDamage", function (player, s, dmginfo)
            if player:Health() - dmginfo:GetDamage() <= 0 and (not player:isBuffActive(Deraformine_sickness.networkID) ) then player:SetHealth(25) player:removeState("deraformine") player:assignState("deraformine_heal", 6) end return true end)
 
                local chuggerschaw = buff("chuggerschaw", DRUG_INDEX_OFFSET + 24)
                chuggerschaw.description = "Improves your alchemy skill by 10"
                chuggerschaw.name = "Chugger's Chaw"
                chuggerschaw.icon = "wicons/15_potion_potion.png"

                local Coagulant = buff("coagulant", DRUG_INDEX_OFFSET + 25)
                Coagulant.description = "Coagulant allows for your blood to clot quicker causing you to replenish your health."
                Coagulant.name = "Chugger's Chaw"
                Coagulant.icon = "wicons/15_potion_potion.png"
                Coagulant:push("PlayerTick", function(player) player:heal(FrameTime() * 0.5) end)

                local glitterstim = buff("glitterstim", DRUG_INDEX_OFFSET + 26)
                glitterstim.description = "Your can jump 25% higher"
                glitterstim.name = "Glitterstim"
                glitterstim.icon = "wicons/Powder_Iron.png"
                glitterstim.inherit = {INTOLERANCE}
                glitterstim.attributes = {["jumpPower"] = 0.25}

 
            end)
			
			
			
			
            hook.Call("ty_update_drug_index")
