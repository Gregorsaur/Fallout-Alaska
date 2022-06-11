local PLUGIN = PLUGIN

local cur_corpse_vars = {"Entity", "Inventory", "Money", "Name"}

-- Create all corpse accessors
for _, v in pairs(cur_corpse_vars) do
    local name = "Corpse" .. v
    AccessorFunc(PLUGIN, name, name)
end

-- Set to nil all corpse vars
function PLUGIN:EraseCorpseVars()
    for _, v in pairs(cur_corpse_vars) do
        PLUGIN["SetCorpse" .. v](PLUGIN, nil)
    end
end

PLUGIN.nextTrace = PLUGIN.nextTrace or 0

function PLUGIN:KeyPress(_, key)
end

function PLUGIN:HUDPaint()
end

LOCAL_PLAYER_IS_LOOTING = false
LOCAL_PLAYER_LOOTING_ISUPDATE = false
CACHED_PLUGIN = CACHED_PLUGIN or nil
local SELECTED_ITEM_ID = nil
local LOCAL_PLAYER_SELECT_NUM = 1
local cachedCorpseLoot = nil
local cachedStringCorpse = nil
local resetCache = true

hook.Add("HUDPaint", "PLU_CORPSE", function()
	if NOCLIP_PARDON and NOCLIP_PARDON > CurTime() then return end
    local data = {}
    client = LocalPlayer()
    data.filter = client
    data.start = client:GetShootPos()
    data.endpos = data.start + client:GetAimVector() * 80
    local entLooked = util.TraceLine(data).Entity
    LOCAL_PLAYER_IS_LOOTING = (IsValid(entLooked) and entLooked:IsCorpse())

    if LOCAL_PLAYER_LOOTING_ISUPDATE ~= LOCAL_PLAYER_IS_LOOTING then
        LOCAL_PLAYER_SELECT_NUM = 0
        resetCache = true

        if LOCAL_PLAYER_IS_LOOTING then
            if CACHED_PLUGIN == nil then
                for i, v in pairs(hook.GetTable("PlayerBindPress")["PlayerBindPress"]) do
                    if type(i) == "table" and i.folder == "nutscript/plugins/wepselect.lua" then
                        CACHED_PLUGIN = i
                        break
                    end
                end
            end

            if CACHED_PLUGIN then
                hook.Remove("PlayerBindPress", CACHED_PLUGIN)
            end
        else
            if CACHED_PLUGIN then
                hook.Add("PlayerBindPress", CACHED_PLUGIN, function(N, client, bind, pressed)
                    if CACHED_PLUGIN:PlayerBindPress(LocalPlayer(), bind, pressed) == true then return true end
                end)
            end
        end

        LOCAL_PLAYER_LOOTING_ISUPDATE = LOCAL_PLAYER_IS_LOOTING
    end

    if LOCAL_PLAYER_IS_LOOTING then
        surface.SetFont("$MAIN_Font")
        local corpse_name = entLooked:GetNW2String("n", "notsetonclient")
        corpse_name = language.GetPhrase(corpse_name)

        if resetCache or #cachedStringCorpse ~= #entLooked:GetNW2String("corpse") then
            cachedStringCorpse = entLooked:GetNW2String("corpse")
            cachedCorpseLoot = util.JSONToTable(entLooked:GetNW2String("corpse"))
            resetCache = false
        end

        local items = cachedCorpseLoot
        -- items = {"Booze", "Dog Meat", "Caps (3)"}
        local getTextWidth, txtheight = surface.GetTextSize(corpse_name)
        txtheight = 42
        surface.SetDrawColor(pip_color.r, pip_color.g, pip_color.b, 55)
        local height = #items * 42
        local itemOffsetHeight = 8
        local scr07 = math.ceil(ScrW() * 0.7)
        local scrh04 = ScrH() * 0.4
        height = height + 18
        NzGUI.DrawShadowText(corpse_name, ScrW() * 0.7 + 200 - (getTextWidth / 2), scrh04 - 42)

        if #items == 0 then
            surface.SetFont("Morton Medium@32")
            if client:getChar():isPerkOwned(18) and client:Crouching() then 
                NzGUI.DrawShadowText("H) EAT", ScrW() * 0.7 + 200 - (getTextWidth / 2), scrh04 + 8)
            end
            NzGUI.DrawShadowText("EMPTY", ScrW() * 0.7 + 200 - (getTextWidth / 2), scrh04 - 12)
        else
            surface.DrawRect(scr07, scrh04, 400, height + 2)
            -- BORDER STUFF BLACK OUTLINE
            surface.SetDrawColor(0, 0, 0, 255)
            surface.DrawRect(scr07, scrh04, 6, height)
            surface.DrawRect(scr07 + 396, scrh04, 6, height)
            surface.DrawRect(scr07, scrh04, 14, 6) --TOP ARMS
            surface.DrawRect(scr07 + 388, scrh04, 14, 6)
            surface.DrawRect(scr07, scrh04 + height - 4, 14, 6) -- BOTTOM ARMS
            surface.DrawRect(scr07 + 388, scrh04 + height - 4, 14, 6)
            -- BORDER STUFF
            surface.SetDrawColor(pip_color.r, pip_color.g, pip_color.b, 255)
            surface.DrawRect(scr07, scrh04, 4, height)
            surface.DrawRect(scr07 + 396, scrh04, 4, height)
            surface.DrawRect(scr07, scrh04, 12, 4) --TOP ARMS
            surface.DrawRect(scr07 + 388, scrh04, 12, 4)
            surface.DrawRect(scr07, scrh04 + height - 4, 12, 4) -- BOTTOM ARMS
            surface.DrawRect(scr07 + 388, scrh04 + height - 4, 12, 4)
            -- END BORDER STUFF
            LOCAL_PLAYER_SELECT_NUM = LOCAL_PLAYER_SELECT_NUM % (#items)
            local selected = LOCAL_PLAYER_SELECT_NUM + 1

            for i, v in pairs(items) do
                local result = {}

                for match in (v .. "|"):gmatch("(.-)" .. "|") do
                    table.insert(result, match)
                end

                if nut.item.list[result[1]] then
                    result[1] = nut.item.list[result[1]].name
                end

                result[2] = tonumber(result[2])

                if selected == i then
                    surface.DrawRect(ScrW() * 0.7 + 15, scrh04 + (txtheight * (i - 1)) + itemOffsetHeight + 2, 370, 42)
                    surface.SetDrawColor(pip_color.r, pip_color.g, pip_color.b, 55)
                    SELECTED_ITEM_ID = v
                end

                draw.SimpleText(result[1] .. (result[2] ~= 1 and (" (" .. result[2] .. ")") or ""), "$MAIN_Font32", ScrW() * 0.7 + 200, scrh04 + (txtheight * (i - 1) + 8) + itemOffsetHeight, Color(0, 0, 0, 255), TEXT_ALIGN_CENTER)
            end

            local display = "E) LOOT    R) LOOT ALL"
            local doEat = client:getChar():isPerkOwned(18) and client:Crouching()
            display = display .. (doEat and "   H) EAT" or "    H) BURN")
            local wx, wy = surface.GetTextSize(display)
            NzGUI.DrawShadowText(display, ScrW() * 0.7 + 200 - (wx * 0.5), scrh04 + height + 8)
        end
    end
end)

local debounce_timer = 0

hook.Add("PlayerBindPress", "!PlayerBindPress", function(ply, bind, pressed, num)
	if NOCLIP_PARDON and NOCLIP_PARDON > CurTime() then return end
    if LOCAL_PLAYER_IS_LOOTING and pressed then
        if num == MOUSE_WHEEL_UP or num == MOUSE_WHEEL_DOWN then
            if debounce_timer < CurTime() then
                debounce_timer = CurTime() + FrameTime()
                LOCAL_PLAYER_SELECT_NUM = LOCAL_PLAYER_SELECT_NUM - (num == MOUSE_WHEEL_UP and 1 or -1)
            end

            return true
        elseif num == KEY_E then
            netstream.Start("loot_corpse", SELECTED_ITEM_ID)
			if VManip then VManip:PlayAnim("interactslower") end
            return true
        elseif num == KEY_R then
            netstream.Start("loot_corpse", "all")
			if VManip then VManip:PlayAnim("interactslower") end
            --netstream.Start("loot_corpse", "all")
            return true
        elseif num == KEY_H then
			if VManip then VManip:PlayAnim("interactfast2") end
            netstream.Start("loot_corpse", client:getChar():isPerkOwned(18) and client:Crouching()  and "EAT" or "FIRE" )
            return true
        end
    end
end)