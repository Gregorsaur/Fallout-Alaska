surface.CreateFont("Cream", {
    font = "Relate",
    extended = false,
    size = 32,
    weight = 800,
    blursize = 0,
    scanlines = 0,
    antialias = true,
    underline = false,
    italic = false,
    strikeout = false,
    symbol = false,
    rotary = false,
    shadow = false,
    additive = false,
    outline = false,
})

surface.CreateFont("MAIN_Font32", {
    font = "Roboto Condensed",
    extended = false,
    size = 24,
    weight = 500,
    blursize = 0,
    scanlines = 0,
    antialias = true,
})

local ICONS = {
    medical = "",
    cooking = Material("vault_boy/craft/cooker3")
}

local PAGE = 1
local maxAmountOfItems = 0
local CurrentItem = nil
local perPage = 6
local itemSelected = 0
local KEY_E_Event_DOWN_THIS_FRAME = false
local debounce_timer = 0
local TYPEOFFRAMEOPEN = 0
local itemThisCraftingFrameCached = false
local matBlurScreen = Material("pp/blurscreen")

if IsValid(CraftingFrame) then
    CraftingFrame:Remove()
end

local NullPaint = function() end

ApplyNullPaint = function(n)
    n.Paint = NullPaint
end

function RECIPES:CreateCraftingFrame(Type)
    if IsValid(CraftingFrame) then
        CraftingFrame:Remove()
    end

    DRAW_INTERACTABLE = false
    maxAmountOfItems = 0
    CurrentItem = nil
    perPage = 6
    itemSelected = 0
    debounce_timer = 0
    TYPEOFFRAMEOPEN = 2
    CraftingFrame = vgui.Create("DPanel")
    CraftingFrame:SetPos(ScrW() * 0.15, ScrH() - 600)
    local width = ScrW() * 0.7
    CraftingFrame:SetSize(width, 380)
    CraftingFrame.RemoveO = CraftingFrame.Remove
    local icon = vgui.Create("DModelPanel")

    function CraftingFrame:Remove()
        icon:Remove()
        CraftingFrame.RemoveO(self)
    end

    local sbox = 400
    icon:SetSize(sbox, sbox)
    icon:SetPos(ScrW() * 0.5 - (sbox * 0.5), 64)
    icon:SetModel("models/mosi/fallout4/props/drink/nukacola.mdl") -- you can only change colors on playermodels
    local pos = icon.Entity:GetPos()
    icon:SetLookAt(pos - Vector(0, 2, 0) - (icon.Entity:GetRight() * -5))
    icon:SetCamPos(pos - (icon.Entity:GetUp() * -25))
    icon:SetFOV(60)

    function icon:PaintOver(width, height)
        surface.DrawOutlinedRect(0, 0, width, height)
    end

    function icon:PostDrawModel(ent)
        halo.Add({ent}, pip_color, 5, 5, 5, true)
    end

    function icon:LayoutEntity(e)
        local ang = Angle(0, 0, 0)
        ang:RotateAroundAxis(ang:Right(), CurTime() * 6)
        ang:RotateAroundAxis(ang:Forward(), 90)
        e:SetAngles(ang) -- disables default rotation

        return true
    end

    --we need to set it to a Vector not a Color, so the values are normal RGB values divided by 255.
    function icon.Entity:GetPlayerColor()
        return Vector(1, 0, 0)
    end

    local shadow = Color(0, 0, 0, 255)

    function surface.DrawShadow(x, y, w, h, c)
        surface.SetDrawColor(shadow)
        surface.DrawRect(x, y, w + 2, h + 2)
        surface.SetDrawColor(c)
        surface.DrawRect(x, y, w, h)
    end

    function surface.DrawHandleR(x, y, w, h)
    end

    CraftingFrame:NoClipping(true)

    function CraftingFrame:Paint(w, h)
        local Fraction = 1
        local x, y = self:LocalToScreen(0, 0)
        local wasEnabled = DisableClipping(true)
        -- Menu cannot do blur
        surface.SetMaterial(matBlurScreen)
        surface.SetDrawColor(255, 255, 255, 255)
        matBlurScreen:SetFloat("$blur", 2)
        matBlurScreen:Recompute()

        -- Todo: Make this available to menu Lua
        if render then
            render.UpdateScreenEffectTexture()
        end

        -- surface.DrawTexturedRect(x * -1, y * -1, ScrW(), ScrH())
        DisableClipping(wasEnabled)
        surface.SetDrawColor(pip_color.r * 0.6, pip_color.g * 0.6, pip_color.b * 0.6, 50)
        surface.DrawRect(0, 0, w, h)
        local c = pip_color
        surface.DrawShadow(0, 0, 18, 4, c)
        local gapsize = 18 + 130
        surface.SetFont("$MAIN_Font")
        surface.DrawShadow(gapsize, 0, w - gapsize, 4, c)
        surface.DrawShadow(0, 4, 4, 16, c)
        surface.DrawShadow(w - 4, 4, 4, 16, c)
        surface.DrawShadow(0, h - 16, 4, 16, c)
        NzGUI.DrawShadowText("RECIPES", 22, -28, pip_color)
        local headerBefore = 42
        gapsize = 208
        surface.DrawShadow(0, -headerBefore, 17, 4, c)
        surface.DrawShadow(gapsize, -headerBefore, w - gapsize, 4, c)
        surface.DrawShadow(0, 4 - headerBefore, 4, 16, c)
        surface.DrawShadow(w - 4, 4 - headerBefore, 4, 16, c)
        surface.DrawShadow(w - 4, h - 16, 4, 16, c)
        surface.DrawShadow(0, h, w, 4, c)
        local cont = 0

        for ____, _______ in pairs(itemThisCraftingFrameCached) do
            cont = cont + 1
        end

        cont = itemCOUNTTHISFRAME
        print(cont, maxAmountOfItems, perPage, "itemThisCraftingFrameCached")
        local maxpages = math.ceil(cont / perPage)
        local t = " [ E) CRAFT    PAGE:" .. PAGE .. "/" .. maxpages .. "   TAB) BACK ] "
        surface.SetFont("Morton Medium@48")
        local tw, th = surface.GetTextSize(t)
        surface.SetDrawColor(pip_color.r, pip_color.g, pip_color.b, 20)
        surface.DrawRect(w / 2 - (tw / 2), h + 50, tw, th)
        NzGUI.DrawShadowText(t, w / 2 - (tw / 2), h + 50, c)
    end

    Class = CraftingFrame:Add("DPanel")
    Class:Dock(RIGHT)
    Class:SetWide(width * 0.1)
    local f = Material("vault_boy/craft/welding")

    function Class:Paint(w, h)
        if CurrentItem and CurrentItem[4] then
            -- NzGUI.DrawShadowText("REQ: Medical 3", 0, 8)
            local skillID = CurrentItem[4][1]
            surface.SetMaterial(ICONS[skillID])
            surface.DrawTexturedRect(w * 0.15, h - w + 30, w * 0.7, w * 0.7)
            local display = SKILLS_DESC[skillID][1]
            surface.SetDrawColor(pip_color)
            surface.DrawRect(8, h - 36, w - 16, 14)
            surface.SetFont("MAIN_Font32")
            NzGUI.DrawShadowText("Progress To Next Level", 8, 320)
            surface.SetFont("Cream")
            surface.SetDrawColor(pip_color_accent)
            local lb, ub = LocalPlayer():getChar():getSkillXP(skillID), LocalPlayer():getChar():getSkillXPForLevel(skillID)
            surface.DrawRect(8, h - 36, (w - 16) * (lb / ub), 14)
            -- NzGUI.DrawShadowText(LocalPlayer():getChar():getSkillXP(skillID) .. " / " ..LocalPlayer():getChar():getSkillXPForLevel(skillID), 0, 8)
            NzGUI.DrawShadowText("Required: " .. CurrentItem[4][2] .. " " .. display, 0, 8)
        end
    end

    Stats = CraftingFrame:Add("DPanel")
    Stats:Dock(LEFT)
    Stats:SetWide(width * 0.45)
    Stats:NoClipping(true)
    itemCOUNTTHISFRAME = 0

    function Stats:Paint(w, h)
        local items = RECIPES:GetAllItemsFromCategory(Type)
        itemThisCraftingFrameCached = {}
        if items == nil then return end
        itemCOUNTTHISFRAME = 0

        for k, v in pairs(items) do
            itemCOUNTTHISFRAME = itemCOUNTTHISFRAME + 1
        end

        maxAmountOfItems = itemCOUNTTHISFRAME
        local yOffset = 0
        local itemSelected = itemSelected + 1
        surface.SetFont("Morton Medium@48")
        local i = 0
        local start = 0

        if itemSelected < 0 or PAGE <= 0 then
            PAGE = 1
            maxAmountOfItems = itemCOUNTTHISFRAME
            CurrentItem = nil
            itemSelected = 1
        end

        for _, v in pairs(items) do
            start = start + 1

            if perPage * PAGE >= start and perPage * (PAGE - 1) < start then
                if v[5] == nil or v[5](LocalPlayer(), LocalPlayer():getChar()) then
                    i = i + 1
                    table.insert(itemThisCraftingFrameCached, v)
                    local append = ""

                    if v[3] and v[3] > 1 then
                        append = " (" .. v[3] .. ")"
                    end

                    if i == itemSelected then
                        surface.DrawShadow(16, 32 + yOffset, w - 18, 48, pip_color)
                        NzGUI.DrawText(v:GetName() .. append, 24, 32 - 5 + yOffset, Color(0, 0, 0))
                        CurrentItem = v
                        icon:SetModel(nut.item.list[v[1]].model)

                        if KEY_E_Event_DOWN_THIS_FRAME then
                            KEY_E_Event_DOWN_THIS_FRAME = false
                            net.Start("CRAFTING")
                            net.WriteString(RECIPES.NumericalPath[v.id])
                            net.SendToServer()
                        end
                    else
                        NzGUI.DrawShadowText(v:GetName() .. append, 24, 32 - 4 + yOffset, pip_color)
                    end

                    yOffset = yOffset + 52
                    -- maxAmountOfItems = i
                else
                    itemCOUNTTHISFRAME = itemCOUNTTHISFRAME - 1
                end
            end
        end
    end

    Regeants = CraftingFrame:Add("DPanel")
    Regeants:Dock(FILL)
    local grayout = Color(225, 225, 225, 255)

    function Regeants:Paint(w, h)
        if CurrentItem == nil then return end
        surface.SetFont("Morton Medium@48")
        local i = -1
        surface.SetDrawColor(pip_color.r, pip_color.g, pip_color.b, 255)
        local characterInv = LocalPlayer():getChar():getInv()

        for _, v in pairs(CurrentItem[2]) do
            i = i + 1
            local itemAmounts = characterInv:getItemCount(CurrentItem:GetRegantID(i + 1))
            local regeantAmt = CurrentItem:GetRegantAmount(i + 1)
            local DoGrayOut = itemAmounts < regeantAmt
            surface.SetDrawColor(pip_color.r, pip_color.g, pip_color.b, 25)
            surface.DrawRect(8, 32 + (i * 42), w - 16, 38, color)
            surface.SetDrawColor(pip_color.r, pip_color.g, pip_color.b, 255)
            surface.DrawRect(8, 32 + (i * 42), (w - 16) * itemAmounts / regeantAmt, 38, color)
            surface.SetDrawColor(color_white)
            NzGUI.DrawText(CurrentItem:GetRegantName(i + 1) .. " " .. itemAmounts .. "/" .. regeantAmt, 24, 32 - 7 + (i * 42), DoGrayOut and grayout or shadow)
        end
    end
end

local RESTORE_RECIPE_MENU_CATEGORIES = {}

function RECIPES:CreateCraftingMenu(Categories)
    RESTORE_RECIPE_MENU_CATEGORIES = Categories

    if IsValid(CraftingFrame) then
        CraftingFrame:Remove()
    end

    DRAW_INTERACTABLE = false
    maxAmountOfItems = 0
    CurrentItem = nil
    perPage = 6
    itemSelected = 0
    debounce_timer = 0
    TYPEOFFRAMEOPEN = 1
    CraftingFrame = vgui.Create("DPanel")
    CraftingFrame:SetPos(ScrW() * 0.15, ScrH() - 600)
    local width = ScrW() * 0.7
    CraftingFrame:SetSize(width, 380)
    local shadow = Color(0, 0, 0, 255)
    Stats = CraftingFrame:Add("DPanel")
    Stats:Dock(LEFT)
    Stats:SetWide(width * 0.45)
    Stats:NoClipping(true)
    local shadow = Color(0, 0, 0, 255)

    function surface.DrawShadow(x, y, w, h, c)
        surface.SetDrawColor(shadow)
        surface.DrawRect(x, y, w + 2, h + 2)
        surface.SetDrawColor(c)
        surface.DrawRect(x, y, w, h)
    end

    function surface.DrawHandleR(x, y, w, h)
    end

    CraftingFrame:NoClipping(true)

    function CraftingFrame:Paint(w, h)
        local Fraction = 1
        local x, y = self:LocalToScreen(0, 0)
        local wasEnabled = DisableClipping(true)
        surface.SetMaterial(matBlurScreen)
        surface.SetDrawColor(255, 255, 255, 255)
        matBlurScreen:SetFloat("$blur", 2)
        matBlurScreen:Recompute()

        -- Todo: Make this available to menu Lua
        if render then
            render.UpdateScreenEffectTexture()
        end

        -- surface.DrawTexturedRect(x * -1, y * -1, ScrW(), ScrH())
        DisableClipping(wasEnabled)
        surface.SetDrawColor(pip_color.r * 0.6, pip_color.g * 0.6, pip_color.b * 0.6, 50)
        surface.DrawRect(0, 0, w, h)
        local c = pip_color
        surface.DrawShadow(0, 0, 18, 4, c)
        local gapsize = 205
        surface.SetFont("$MAIN_Font")
        surface.DrawShadow(gapsize, 0, w - gapsize, 4, c)
        surface.DrawShadow(0, 4, 4, 16, c)
        surface.DrawShadow(w - 4, 4, 4, 16, c)
        surface.DrawShadow(0, h - 16, 4, 16, c)
        surface.DrawShadow(w - 4, h - 16, 4, 16, c)
        surface.DrawShadow(0, h, w, 4, c)
        NzGUI.DrawShadowText("CATEGORIES", 22, -28, pip_color)
        local t = " [ E) SELECT       TAB) QUIT ] "
        surface.SetFont("Morton Medium@48")
        local tw, th = surface.GetTextSize(t)
        surface.SetDrawColor(pip_color.r, pip_color.g, pip_color.b, 20)
        surface.DrawRect(w / 2 - (tw / 2), h + 50, tw, th)
        NzGUI.DrawShadowText(t, w / 2 - (tw / 2), h + 50, c)
    end

    function Stats:Paint(w, h)
        local items = Categories
        itemThisCraftingFrameCached = items
        local yOffset = 0
        local itemSelected = itemSelected + 1
        surface.SetFont("Morton Medium@48")
        local i = 0
        local start = 0

        for _, v in pairs(items) do
            start = start + 1

            if perPage * PAGE >= start and perPage * (PAGE - 1) < start then
                i = i + 1

                if i == itemSelected then
                    surface.DrawShadow(16, 32 + yOffset, w - 18, 48, pip_color)
                    NzGUI.DrawText(v, 24, 32 - 5 + yOffset, Color(0, 0, 0))
                    CurrentItem = v

                    if KEY_E_Event_DOWN_THIS_FRAME then
                        KEY_E_Event_DOWN_THIS_FRAME = false
                        RECIPES:CreateCraftingFrame(v)
                    end
                else
                    NzGUI.DrawShadowText(v, 24, 32 - 4 + yOffset, pip_color)
                end

                yOffset = yOffset + 52
                maxAmountOfItems = 12
            end
        end
    end
end

local CACHED_PLUGIN

--
net.Receive("CRAFTING", function(len, ply)
    RECIPES:CreateCraftingMenu(net.ReadTable())
    PAGE = 1
    maxAmountOfItems = 0
    CurrentItem = nil
    perPage = 6
    itemSelected = 0

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
end)

hook.Add("InputMouseApply", "FreezeTurningDueToCrafting", function(cmd)
    if TYPEOFFRAMEOPEN == 1 or TYPEOFFRAMEOPEN == 2 then
        cmd:SetMouseX(0)
        cmd:SetMouseY(0)

        return true
    end
end)

hook.Add("PlayerBindPress", "!PlayerBindPressCraft", function(ply, bind, pressed, num)
    if TYPEOFFRAMEOPEN == 1 or TYPEOFFRAMEOPEN == 2 then
        bind = bind:lower()

        if num == KEY_TAB and debounce_timer < CurTime() and pressed then
            debounce_timer = CurTime() + 0.01
            PAGE = 1
            maxAmountOfItems = 0
            CurrentItem = nil
            perPage = 6
            itemSelected = 0

            if TYPEOFFRAMEOPEN == 2 then
                TYPEOFFRAMEOPEN = 1
                RECIPES:CreateCraftingMenu(RESTORE_RECIPE_MENU_CATEGORIES)
            else
                CraftingFrame:Remove()
                DRAW_INTERACTABLE = true

                if CACHED_PLUGIN then
                    hook.Add("PlayerBindPress", CACHED_PLUGIN, function(N, client, bind, pressed)
                        if CACHED_PLUGIN:PlayerBindPress(LocalPlayer(), bind, pressed) == true then return true end
                    end)
                end

                TYPEOFFRAMEOPEN = 0
            end

            return true
        end

        if num == KEY_E then
            KEY_E_Event_DOWN_THIS_FRAME = pressed

            return true
        end

        if num == MOUSE_WHEEL_UP or num == MOUSE_WHEEL_DOWN then
            if debounce_timer < CurTime() then
                local cont = 0

                for ____, _______ in pairs(itemThisCraftingFrameCached) do
                    cont = cont + 1
                end

                cont = maxAmountOfItems
                local maxpages = math.ceil(cont / perPage)
                debounce_timer = CurTime() + FrameTime()
                itemSelected = itemSelected - (num == MOUSE_WHEEL_UP and 1 or -1)
                local cached_value = ((PAGE - 1) * perPage) + itemSelected + 1

                if cached_value <= 0 then
                    PAGE = maxpages
                    itemSelected = (cont % perPage) - 1

                    return true
                elseif cached_value > cont then
                    itemSelected = 0
                    PAGE = 1
                end

                if itemSelected == 6 then
                    itemSelected = 0
                    PAGE = PAGE + 1
                elseif itemSelected == -1 then
                    itemSelected = 5
                    PAGE = PAGE - 1
                end
            end

            return true
        end

        if bind:find("+forward") or bind:find("+moveleft") or bind:find("+moveright") or (bind:find("+jump") and not (num == MOUSE_WHEEL_DOWN or num == MOUSE_WHEEL_UP)) or bind:find("+back") or bind:find("+attack") or bind:find("+attack2") then return true end
    end
end)