local categories = {"ALL", "AID", "FOOD", "WEAPONS", "ARMOR", "MISC", "QUEST"}

local cachedpos = {}
local cachedsizes = {}
local inventory = {}
local player = LocalPlayer()
inventory.focus = 1
local Scroll_POS = 0

local function sum(t)
    local s = 0

    for k, v in pairs(t) do
        s = s + v
    end

    return s
end

local gui = nil

function clearinv()
    player = LocalPlayer()
    local inventory = player:getChar():getInv()
    local items = {}
    local iteminstances = {}
    local stackCounter = 0

    for i, v in pairs(inventory:getItems()) do
        local item = nut.item.list[v.uniqueID]

        if item.Stackable then
            if items[item.uniqueID] then
                table.insert(items[item.uniqueID], v)
            else
                items[item.uniqueID] = {v}
            end
        else
            items[item.uniqueID] = (items[item.uniqueID] and items[item.uniqueID] or 0) + 1
        end

        local tbl = iteminstances[item.uniqueID] or {}
        table.insert(tbl, v.id)
        iteminstances[item.uniqueID] = tbl
        --item.functions.drop
    end

    tablet.Inventory = {
        items = items,
        instances = iteminstances
    }
end

local og = {
    ["$pp_colour_addr"] = 0,
    ["$pp_colour_addg"] = 0,
    ["$pp_colour_addb"] = 0,
    ["$pp_colour_brightness"] = 0,
    ["$pp_colour_contrast"] = 1,
    ["$pp_colour_colour"] = 0,
    ["$pp_colour_mulr"] = 0,
    ["$pp_colour_mulg"] = 0,
    ["$pp_colour_mulb"] = 0
}

local function GetITEMS()
    local inventory, Inventory = LocalPlayer():getChar():getInv(), {}
    local items = {}
    local iteminstances = {}

    for i, v in pairs(inventory:getItems()) do
        local item = nut.item.list[v.uniqueID]
        items[item.uniqueID] = (items[item.uniqueID] and items[item.uniqueID] or 0) + 1
        local tbl = iteminstances[item.uniqueID] or {}
        table.insert(tbl, v.id)
        iteminstances[item.uniqueID] = tbl
        --item.functions.drop
    end

    return {
        items = items,
        instances = iteminstances
    }
end

FUSION_ITEM_BUTTON_SIZE = {
    w = 550,
    h = 36,
    ho = 36
}

local ITEMDESCOFFSET = {
    x = 675,
    xT = 680,
    w = 320
}

local InventoryModelView
--we need to set it to a Vector not a Color, so the values are normal RGB values divided by 255.
local indexx = math.random(1, 100000000)
local iTexFlags = bit.bor(1, 262144, 32768, 8388608, 2048, 4, 8)
local tex = GetRenderTargetEx("texture_woA" .. indexx, 256, 256, RT_SIZE_OFFSCREEN, MATERIAL_RT_DEPTH_NONE, 0, 0, IMAGE_FORMAT_RGBA16161616) --[[IMPORTANT]]

local myMat = CreateMaterial("test3x2" .. indexx, "UnlitGeneric", {
    ["$basetexture"] = tex:GetName(),
    ["$translucent"] = "1",
    ["$vertexcolor"] = 1
})

local Mask_Tex = GetRenderTargetEx("mask4-" .. indexx, 256, 256, RT_SIZE_OFFSCREEN, MATERIAL_RT_DEPTH_SEPARATE, 4096, 0, IMAGE_FORMAT_RGBA16161616) --[[IMPORTANT]]
local mat_color = Material("pp/colour")
mat_color:SetFloat("$translucent", "1")

local function RenderColorBlendSpace()
    local tab = {
        ["$pp_colour_addr"] = 0,
        ["$pp_colour_addg"] = 0,
        ["$pp_colour_addb"] = 0,
        ["$pp_colour_brightness"] = -0.01,
        ["$pp_colour_contrast"] = 5,
        ["$pp_colour_colour"] = 0,
        ["$pp_colour_mulr"] = 0,
        ["$pp_colour_mulg"] = 0,
        ["$pp_colour_mulb"] = 0
    }

    for k, v in pairs(tab) do
        mat_color:SetFloat(k, v)
    end

    local pre = mat_color:GetTexture("$fbtexture")
    local txname = Mask_Tex:GetName()
    mat_color:SetTexture("$fbtexture", Mask_Tex:GetName())
    surface.SetMaterial(mat_color)
    surface.DrawTexturedRect(0, 0, 400, 300)
    mat_color:SetTexture("$fbtexture", pre)
end

local function PopBollc()
    render.PushRenderTarget(Mask_Tex)
    cam.Start2D()
    render.ClearDepth()
    render.Clear(0, 0, 0, 0, true, true)
    render.SetWriteDepthToDestAlpha(false)
    InventoryModelView:PaintManual()
    render.SetWriteDepthToDestAlpha(true)
    cam.End2D()
    render.PopRenderTarget()
    render.PushRenderTarget(tex)
    cam.Start2D()
    RenderColorBlendSpace()
    cam.End2D()
    render.PopRenderTarget()
end

local tab = {
    ["$pp_colour_addr"] = 6 / 255,
    ["$pp_colour_addg"] = 12 / 255,
    ["$pp_colour_addb"] = 12 / 255,
    ["$pp_colour_brightness"] = 0,
    ["$pp_colour_contrast"] = 0.52,
    ["$pp_colour_colour"] = 0.8,
    ["$pp_colour_mulr"] = 4 / 255,
    ["$pp_colour_mulg"] = 16 / 255,
    ["$pp_colour_mulb"] = 16 / 255
}

local function drawItem(item3, y, pip_color, amt, ITEM_INSTANCE_RRA)
    --if item then PrintTable(tablet.Inventory.data) end 
    surface.SetDrawColor(pip_color)
    --surface.DrawOutlinedRect(-420, 0, 400, 55)
    local item = nut.item.list[item3]
    local cc = amt == 1 and "" or " (" .. amt .. ")"
    local fn, click, draww = NzGUI:DrawTextButtonWithDelayedHover(string.upper(item:getName()) .. cc, "Morton Medium@42", 86, 116 + (y * FUSION_ITEM_BUTTON_SIZE.ho), FUSION_ITEM_BUTTON_SIZE.w, FUSION_ITEM_BUTTON_SIZE.h, 1, color_white, color_black, 0, pip_color)
    local inst = nut.item.list[item3]

    if fn and InventoryModelView and InventoryModelView.Entity then
        surface.SetDrawColor(pip_color_accent.r, pip_color_accent.g, pip_color_accent.b, 100)
        surface.DrawRect(86, 120 + (y * FUSION_ITEM_BUTTON_SIZE.ho), FUSION_ITEM_BUTTON_SIZE.w, FUSION_ITEM_BUTTON_SIZE.h)
        InventoryModelView.Angle = inst.Angle or angle_zero
        local headpos = InventoryModelView.Entity:GetPos()
        InventoryModelView:SetLookAt(headpos)
        InventoryModelView:SetCamPos(headpos - Vector(-15, 0, 0))
        draww()
        PopBollc()
        -- if inst.Icon then
        InventoryModelView:SetModel(inst.model or "models/props_junk/cardboard_box001a.mdl")
        local m = myMat
        surface.SetMaterial(m)
        local x, y = 256, 256

        if x and y then
            local ratio = x / y
            local size = 256
            local width = 256
            surface.DrawTexturedRect(ITEMDESCOFFSET.x, 35, size, size)
            draw.NoTexture()
        end

        local heightOfBoxes = 24
        local heightOfBoxesPadding = 2
        --end
        surface.DrawRect(ITEMDESCOFFSET.x, 230, ITEMDESCOFFSET.w + 2, heightOfBoxes)
        draw.SimpleText("VALUE: " .. (inst.value or 0), "Morton Medium@32", ITEMDESCOFFSET.xT, 225, color_white, TEXT_ALIGN_LEFT)
        surface.DrawRect(ITEMDESCOFFSET.x, 230 + heightOfBoxes + heightOfBoxesPadding, ITEMDESCOFFSET.w + 2, heightOfBoxes)
        draw.SimpleText("TYPE: " .. (inst.category or "MISC"), "Morton Medium@32", ITEMDESCOFFSET.xT, 225 + heightOfBoxes + heightOfBoxesPadding, color_white, TEXT_ALIGN_LEFT)
        surface.DrawRect(ITEMDESCOFFSET.x, 230 + heightOfBoxes + heightOfBoxes + heightOfBoxesPadding + heightOfBoxesPadding, ITEMDESCOFFSET.w + 2, heightOfBoxes)
        draw.SimpleText("WEIGHT: " .. (item.weight or "0"), "Morton Medium@32", ITEMDESCOFFSET.xT, 230 + heightOfBoxes + heightOfBoxes, color_white, TEXT_ALIGN_LEFT)

        --surface.DrawRect(ITEMDESCOFFSET.x, 499 + heightOfBoxes + heightOfBoxes + heightOfBoxesPadding + heightOfBoxesPadding, ITEMDESCOFFSET.w + 2, heightOfBoxes)
        --draw.SimpleText("Body Dr: " .. (item.resisbody or "0"), "Morton Medium@32", ITEMDESCOFFSET.xT, 499 + heightOfBoxes + heightOfBoxes, color_white, TEXT_ALIGN_LEFT)
        --surface.DrawRect(ITEMDESCOFFSET.x, 525 + heightOfBoxes + heightOfBoxes + heightOfBoxesPadding + heightOfBoxesPadding, ITEMDESCOFFSET.w + 2, heightOfBoxes)
        --draw.SimpleText("Head Dr: " .. (item.resishead or "0"), "Morton Medium@32", ITEMDESCOFFSET.xT, 525 + heightOfBoxes + heightOfBoxes, color_white, TEXT_ALIGN_LEFT)
        
        local heightOffset = 0
        local prevWidth = 0
        local endMargin = 2
        local buildup = 0
        local buildupAmount = 0
        local start =  251 + heightOfBoxes + heightOfBoxes + heightOfBoxesPadding + heightOfBoxesPadding
        if inst.struct then
            for i, v in pairs(inst:struct()) do
                buildupAmount = buildupAmount + 1
                buildup = buildup + math.abs(v[1])

                if buildup == 1 then
                    endMargin = buildupAmount * 2 - 4
                end

                if v[1] < 0 then
                    draw.SimpleText(v[2], "Morton Medium@32", ITEMDESCOFFSET.xT + prevWidth - endMargin - (ITEMDESCOFFSET.w * v[1] * 0.5) - 10, start + heightOffset, color_white, TEXT_ALIGN_CENTER)
                else
                    surface.DrawRect(ITEMDESCOFFSET.x + prevWidth, start+5 + heightOffset, ITEMDESCOFFSET.w * v[1] - endMargin, heightOfBoxes)
                    draw.SimpleText(v[2], "Morton Medium@32", ITEMDESCOFFSET.xT + prevWidth - endMargin, start + heightOffset, color_white, TEXT_ALIGN_LEFT)

                    if v[3] then
                        surface.SetTextColor(v[3])
                        surface.DrawText(v[4])
                    end
                end

                prevWidth = prevWidth + ITEMDESCOFFSET.w * v[1] + 2

                if buildup == 1 then
                    heightOffset = heightOffset + heightOfBoxes + heightOfBoxesPadding
                    prevWidth = 0
                    endMargin = 0
                    buildup = 0
                    buildupAmount = 0
                end
            end
        end

        if IsUseDown then
            IsUseDown = false
            local Inventory = GetITEMS()
            local v = ITEM_INSTANCE_RRA or LocalPlayer():getChar():getInv().items[Inventory.instances[item3][1]]
            netstream.Start("invAct", "use", v.id, v:getID(), v.id)

            if v.functions.use.onRunClient then
                v.functions.use.onRunClient(v)
            end
        elseif IsReloadUse then
            IsReloadUse = false
            local Inventory = GetITEMS()
            local v = ITEM_INSTANCE_RRA or LocalPlayer():getChar():getInv().items[Inventory.instances[item3][1]]
            netstream.Start("invAct", "drop", v.id, v:getID(), v.id)
        end
    else
        draww()
    end

    if inst.DrawLabel then
        inst.DrawLabel(ITEM_INSTANCE_RRA, 86, 116 + (y * FUSION_ITEM_BUTTON_SIZE.ho))
    end
end

hook.Add("ItemDataChanged", "ItemDataChanged", function()
    clearinv()
end)

hook.Add("InventoryItemRemoved", "invDatainvData", function()
    clearinv()
end)

hook.Add("ItemInitialized", "ItemInitializedItemInitialized", function()
    timer.Simple(0, clearinv)
end)

last_item_page_draw_amt = 0
local color_gray = Color(255, 255, 255, 25)
local color_bright_Gray = Color(255, 255, 255, 55)
firsttime = true

local function DrawInventoryPage()
    if firsttime then
        firsttime = false
        clearinv()

        for i = 1, #categories do
            surface.SetFont("Morton Medium@48")
            local width, _ = surface.GetTextSize(categories[i] .. " ")
            cachedsizes[i] = width
            cachedpos[i] = (cachedpos[i - 1] or 0) + (cachedsizes[i - 1] or 0)
        end
    end

    if tablet.Inventory == nil then
        clearinv()
    end

    for i = 1, #categories do
        if NzGUI:DrawTextButton(categories[i], "Morton Medium@48", 60 + cachedpos[i], 50, cachedsizes[i], 34, 0, inventory.focus == i and color_white or ((inventory.focus == i - 1 or inventory.focus == i + 1) and color_bright_Gray) or color_gray, pip_color) then
            inventory.focus = i
        end
    end

    local _ = 0
    local cache = tablet.Inventory.cache

    if tablet.Inventory.cacheKeys == nil then
        local temp_build = {}
        local temp_build_key = {}
        local ind = 0

        for i, v in pairs(tablet.Inventory.items) do
            ind = ind + 1
            temp_build[nut.item.list[i]:getName()] = i
            temp_build_key[ind] = nut.item.list[i]:getName()
        end

        table.sort(temp_build_key, function(a, b) return a:upper() < b:upper() end)
        local temp_build_sorted = temp_build_key
        local convertTable = {}

        for i = 1, #temp_build_sorted do
            convertTable[i] = temp_build[temp_build_sorted[i]]
        end

        --tablet.Inventory.cache = CurTime()+3
        tablet.Inventory.cacheKeys = convertTable
    end

    local cache = tablet.Inventory.cacheKeys
    local stack = {}
    local keypos = 1

    for c = 1, #cache do
        local i = cache[c]
        local v = tablet.Inventory.items[i]

        --for i, v in pairs(tablet.Inventory.items) do
        if inventory.focus == 1 or nut.item.list[i].category == categories[inventory.focus] then
            if nut.item.list[i].Stackable then
                for _unstack, dostack in pairs(tablet.Inventory.items[i]) do
                    stack[keypos] = {i, _, pip_color, 1, dostack}

                    keypos = keypos + 1
                    _ = _ + 1
                end
            else
                stack[keypos] = {i, _, pip_color, tablet.Inventory.items[i]}

                keypos = keypos + 1
                _ = _ + 1
            end
        end
    end

    last_item_page_draw_amt = #stack or 0
    Scroll_POS = math.Clamp(Scroll_POS or 0, 0, last_item_page_draw_amt - 15)
    local Scroll_POS = Scroll_POS + 1
    -- reverse stack table
    local baby_i = 0

    for i = Scroll_POS, Scroll_POS + 14 do
        if stack[i] then
            stack[i][2] = baby_i
            baby_i = baby_i + 1
            drawItem(unpack(stack[i]))
        end
    end

    -- Draw Scrollbar
    surface.SetDrawColor(pip_color)
    surface.DrawOutlinedRect(643, 120, 10, 540)
    Scroll_POS = Scroll_POS - 1
    local p1 = math.Clamp(Scroll_POS / #stack, 0, 1)
    local p2 = math.Clamp(15 / #stack, 0, 1)
    surface.DrawRect(643, 120 + (p1 * 540), 10, p2 * 540)
    PIP_DRAW_FOOTER()
end

local wth, ht = ScrW(), ScrH()

hook.Add("pip_changepage", "inv_", function(from, to)
    if to == "INV" then
        if IsValid(InventoryModelView) then
            InventoryModelView:Remove()
        end

        local debounce_timer = 0

        hook.Add("PlayerBindPress", "!PlayerBindPressInv", function(ply, bind, pressed, num)
            if num == MOUSE_WHEEL_UP or num == MOUSE_WHEEL_DOWN then
                if debounce_timer < CurTime() then
                    debounce_timer = CurTime() + FrameTime()
                    Scroll_POS = math.Clamp(Scroll_POS - (num == MOUSE_WHEEL_UP and 1 or -1), 0, last_item_page_draw_amt - 15)
                end

                return true
            end
        end)

        InventoryModelView = vgui.Create("DModelPanel")
        InventoryModelView:SetSize(200, 200)
        InventoryModelView:SetModel("models/player/alyx.mdl") -- you can only change colors on playermodels
        InventoryModelView:SetPaintedManually(true)
        InventoryModelView.Angle = Angle(0, 0, 0)

        function InventoryModelView:LayoutEntity(Entity)
            Entity:SetAngles(Angle(InventoryModelView.Angle.x, RealTime() * 10 % 360, InventoryModelView.Angle.z))
        end

        hook.Add("HUDPaint", "inv_r", function()
            render.SetViewPort(ScrW() * 0.2, ScrH() * 0.775, wth, ht)
            local t = "[ E) USE       R) DROP ]"
            surface.SetFont("Morton Medium@48")
            local tw, th = surface.GetTextSize(t)
            surface.SetDrawColor(pip_color.r, pip_color.g, pip_color.b, 20)
            surface.DrawRect(0, 0, tw, th)
            NzGUI.DrawShadowText(t, 0, 0, c)
            render.SetViewPort(0, 0, wth, ht)
        end)
    else
        hook.Remove("HUDPaint", "inv_r")
        hook.Remove("PlayerBindPress", "!PlayerBindPressInv")
    end
end)

local debounce_timer = 0
pipboy:AddRenderPage("INV", DrawInventoryPage)
local DrawPly = {}

function DrawPly.PERKS()
    local perks = {}
    local char = LocalPlayer():getChar()

    if cached_desc == nil then
        cached_desc = {}

        for i, v in pairs(PERKS) do
            cached_desc[v.display] = textWrap(v.desc, "Morton Medium@32", 350)
        end
    end

    for i, v in pairs(PERKS) do
        if char:isPerkOwned(i) then
            table.insert(perks, v)
        end
    end

    for i, v in pairs(perks) do
        local i = i - 1
        local y = math.floor(i / 2)
        local x = i % 2 * 256
        local fn, click, draww = NzGUI:DrawTextButtonWithDelayedHover(v.display:upper(), "Morton Medium@32", 64 + x, 116 + y * 32, 225, 32, 1, color_white)
        local c = pip_color

        if fn then
            c = color_black
            deltSt = deltSt == 0 and CurTime() or deltSt
            surface.SetDrawColor(pip_color)
            surface.DrawRect(64 + x, 120 + (y * 32), 225, 26)
            surface.SetMaterial(v.image)
            surface.SetDrawColor(pip_color)
            draw.DrawNonParsedText(cached_desc[v.display], "Morton Medium@32", 600, 400, pip_color, 0)
            surface.DrawTexturedRect(626, 128, 256, 256)
        end

        draww(c)
    end
end

DrawPly["HEAT SIGNATURES"] = function()
    local height = 36
    local width = 400
    local ply = LocalPlayer()
    local character = ply:getChar()
end

local headers = {"HEAT SIGNATURES", "DATABASE"}

local offset = {0, 252, 225, 335}

local offset2 = {200, 120, 100, 100}

SELECTED_HEADER = "HEAT SIGNATURES"

local draw_overview = function(pip_color2)
    for i, v in pairs(headers) do
        local vb, fn = NzGUI:DrawTextButton(v, "Morton Medium@48", 64 + offset[i], 64, offset2[i], 32, 1, v == SELECTED_HEADER and pip_color or pip_color_accent)

        if vb then
            SELECTED_HEADER = v
        end
    end

    if DrawPly[SELECTED_HEADER] then
        DrawPly[SELECTED_HEADER]()
    end

    local lb, ub = LocalPlayer():getChar():getSkillXP("level"), LocalPlayer():getChar():getSkillXPForLevel("level")
end

pipboy:AddRenderPage("INFO", draw_overview)