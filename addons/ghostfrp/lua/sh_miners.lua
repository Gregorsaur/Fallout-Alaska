print("Im in the cave looking for diamonds, you're in the cave looking for minors")

-- get all hud paint calls and store them in a table
hook.Remove("HUDPaint", "DrawRTTexture")
concommand.Add("fix", function() 
local hud_paint_calls = {}
local i = 0 
for k,v in pairs(hook.GetTable().HUDPaint) do
    i = i + 1
    --print(i, k, " Removed")
    PrintTable({i, k, v})
    if i == 41 then
     hook.Remove("HUDPaint", k)
      
        else 
            table.insert(hud_paint_calls, {k,v})
 
    end
 
end 
end)
--PrintTable(hud_paint_calls)


if SERVER then
    util.AddNetworkString("miners_smelt_deposit")
    util.AddNetworkString("miners_smelt_withdraw")
end

MINERS = {} --global dictionary

MINERS.SmeltTime = {
    copper = 5
}

MINERS.ItemSmelt = {}

function MINERS:AddNewOreItem(id, itemName, duration, usIre)
    local ITEM = nut.item.list[id] or nut.item.register(id, nil, nil, nil, true)
    ITEM.name = itemName .. (usIre and " Ingot" or " Ore")

    if usIre == nil then
        timer.Simple(FrameTime(), function()
            MINERS:AddNewOreItem(id .. "ingot", itemName, duration, true)
        end)
    end

    ITEM.weight = weight or 0.001
    ITEM.Weapon = ent
    ITEM.desc = "NULL"
    ITEM.category = "MISC"
    MINERS.SmeltTime[id] = duration or 10
    ITEM.model = "models/props_junk/rock001a.mdl"
    ITEM.type = "MISC"
    ITEM.STARVATION = 0
    ITEM.CacheStruct = false
    ITEM.functions.drop.onCanRun = function(item) return false end
    ITEM.isStackable = true
    ITEM.maxQuantity = 1

    function ITEM:DrawLabel()
    end

    ITEM.Duration = duration or 30

    function ITEM:struct()
        return {
            {1, "SMELT TIME: " .. self.Duration .. "s"},
        }
    end

    ITEM.functions.use = {
        onRun = function(n, e) return false end,
        onCanRun = function(item) return true end
    }

    return nut.item.list[id]
end

function MINERS_()
    MINERS:AddNewOreItem("miner_copper", "Copper", 15)
    MINERS.ItemSmelt["miner_copper"] = "miner_copperingot"
    MINERS.SmeltTime["miner_copper"] = 15
    MINERS.ItemSmelt["food_mre"] = "miner_copper"
    MINERS.SmeltTime["food_mre"] = 5
end

hook.Add("InitializedPlugins", "AddNewOreItem", function()
    MINERS_()
end)

if nut then
    MINERS_()
end

--creates the UI 
function MINERS:CreateUI()
    local wang_ = Material("wang_slider.png")

    local function FOBIND(s, w, h)
        surface.SetDrawColor(pip_color.r, pip_color.g, pip_color.b, 50)
        surface.DrawRect(0, 0, w, h)
        surface.DrawShadow(0, 0, w - 2, 4, pip_color)
        surface.DrawShadow(0, 4, 4, 16, pip_color)
        surface.DrawShadow(0, h - 22, 4, 16, pip_color)
        surface.DrawShadow(w - 6, 4, 4, 16, pip_color)
        surface.DrawShadow(w - 6, h - 22, 4, 16, pip_color)
        surface.DrawShadow(0, h - 6, w - 2, 4, pip_color)
        surface.SetFont("$Bold_font")

        if s.DESC then
            NzGUI.DrawShadowText(s.DESC, 0, -36, pip_color)
        end
    end

    local function CreateFalloutCombo(parent, previewfunc, pos, offset)
        offset = offset or 4
        pos = pos or 0.25
        local DComboBox = vgui.Create("DComboBox", parent)

        previewfunc = previewfunc or function(dataCache, k)
            dataCache.hair[1] = k
        end

        DComboBox.DisplayName = {}
        DComboBox.l = 0.75

        function DComboBox:GenerateItems()
        end

        DComboBox.OpenMenu = function(self, pControlOpener)
            self:GenerateItems()
            if pControlOpener and pControlOpener == self.TextEntry then return end
            -- Don't do anything if there aren't any options..
            if #self.Choices == 0 then return end

            -- If the menu still exists and hasn't been deleted
            -- then just close it and don't open a new one.
            if IsValid(self.Menu) then
                self.Menu:Remove()
                self.Menu = nil
            end

            self.Menu = DermaMenu(false, self)

            if self:GetSortItems() then
                local sorted = {}

                for k, v in pairs(self.Choices) do
                    local val = tonumber(v) or v

                    if string.len(val) > 1 and not tonumber(val) and val:StartWith("#") then
                        val = language.GetPhrase(val:sub(2))
                    end

                    table.insert(sorted, {
                        id = k,
                        data = v,
                        label = val
                    })
                end

                for k, v in SortedPairsByMemberValue(sorted, "label") do
                    local option = self.Menu:AddOption(v.data, function()
                        self:ChooseOption(v.data, v.id)
                    end)

                    self.Menu:SetPadding(12)
                    self.Menu:Rebuild()
                    self.Menu:SetPadding(4)

                    function option:PerformLayout(w, h)
                        self:SizeToContents()
                        self:SetWide(self:GetWide() + 128)
                        local w = math.max(self:GetParent():GetWide(), self:GetWide())
                        self:SetSize(w, 36)
                        DButton.PerformLayout(self, w, h)
                    end

                    local n = option.Label or option.label
                    option:SetText("")

                    option.Paint = function(s, w, h)
                        surface.SetDrawColor(pip_color.r, pip_color.g, pip_color.b, s:IsHovered() and 255 or 0)
                        surface.DrawRect(0, 0, w, h)
                        draw.DrawText(self.DisplayName[k], "$MAIN_Font16", w / 2, 8, Color(0, 0, 0), TEXT_ALIGN_CENTER)

                        if s:IsHovered() then
                            dataCache = table.Copy(data)
                            previewfunc(dataCache, k, s)
                            -- icon.Entity:ApplyMorph(dataCache)
                        end

                        s.Null = s:IsHovered()
                    end

                    if self.ChoiceColor[v.id] then
                        option:SetTextColor(self.ChoiceColor[v.id])
                    end
                end
            end

            local x, y = self:LocalToScreen(0, self:GetTall())
            self.Menu:SetMinimumWidth(self:GetWide() * 0.35)
            self.Menu.Paint = FOBIND
            self.Menu.DESC = ""
            self.Menu:Open(ScrW() / 2 + 200, ScrH() / 2 - 200, false, self)
            self.Menu.OnRemove = function() end
        end

        DComboBox.ChoiceColor = {}
        --DComboBox:Dock(TOP)
        DComboBox:DockMargin(10, 10, 10, 10)
        DComboBox.D = DComboBox.D or "Hairstyle: "

        DComboBox.Paint = function(s, w, h)
            draw.DrawText(s.D .. CHARACTER_CREATION_PANEL.Model.Hairstyles["name_" .. s:GetValue()], "$MAIN_Font16", w / 2, 4, Color(0, 0, 0), TEXT_ALIGN_CENTER)
        end

        DComboBox:SetFGColor(0, 0, 0, 0)
        DComboBox:SetTextColor(Color(0, 0, 0, 0))
        DComboBox:SetValue(1)

        DComboBox.AddChoice = function(self, value, data, select, icon, textcolor)
            local i = table.insert(self.Choices, value)

            if data then
                self.Data[i] = data
                self.DisplayName[i] = data
            end

            if icon then
                self.ChoiceIcons[i] = icon
            end

            if select then
                self:ChooseOption(value, i)
            end

            return i
        end

        DComboBox.Clear = function(self)
            self:SetText("")
            self.Choices = {}
            self.Data = {}
            self.DisplayName = {}
            self.ChoiceIcons = {}
            self.ChoiceColor = {}
            self.selected = nil

            if self.Menu then
                self.Menu:Remove()
                self.Menu = nil
            end
        end

        return DComboBox
    end

    -- create a VGUI but if it already exists remove it 
    if VGUI and VGUI:IsValid() then
        VGUI:Remove()
    end

    VGUI = vgui.Create("DFrame")
    VGUI:SetSize(400, 400)
    VGUI:SetTitle("")
    VGUI:SetVisible(true)
    VGUI:SetDraggable(false)
    VGUI:Center()
    VGUI:ShowCloseButton(true)
    VGUI:MakePopup()
    VGUI.target = 0
    local ClaimButton = vgui.Create("DButton", VGUI)
    local TimeOfMenuSpawnW = CurTime()
    local TimeOfMenuSpawn = os.time()
    VGUI.isAct = false
    local DermaNumSlider = VGUI:Add("DNumSlider")
    DermaNumSlider:Dock(TOP)
    DermaNumSlider:DockMargin(0, 220, 0, 0)
    DermaNumSlider:SetMin(0) -- Set the minimum number you can slide to
    DermaNumSlider:SetMax(25) -- Set the maximum number you can slide to
    DermaNumSlider:SetDecimals(2) -- Decimal places - zero for whole number
    DermaNumSlider:SetTall(32)
    DermaNumSlider:SetValue(0)
    DermaNumSlider:SetText("              AMOUNT") -- Set the text above the slider
    DermaNumSlider.Label:SetTextColor(Color(0, 0, 0, 0))

    DermaNumSlider.Slider.Knob.Paint = function(panel, w, h)
        DermaNumSlider.Label:SetFont("$MAIN_Font16")
        DermaNumSlider.Label:SetFGColor(Color(0, 0, 0))
        surface.SetDrawColor(pip_color)
        surface.DrawRect(w * 0.1, 0, w * 0.8, h)
    end

    local _ = 15
    local _2 = _ / 2

    for i, DermaNumSliderx in pairs({DermaNumSlider}) do
        DermaNumSliderx.Slider.Paint = function(panel, w, h)
            surface.SetDrawColor(pip_color)
            local height = h - _
            surface.DrawOutlinedRect(0, _2, w, height)
            surface.DrawOutlinedRect(1, _2 + 1, w - 2, height - 2)
            surface.SetMaterial(wang_)
            local old = DisableClipping(true)
            surface.DrawTexturedRect(-height, height * 0.45, height, height)
            surface.DrawTexturedRectUV(w, height * 0.45, height, height, 1, 1, 0, 0)
            DisableClipping(old)
        end

        DermaNumSliderx.Slider.Knob.Paint = function(panel, w, h)
            DermaNumSliderx.Label:SetFont("$MAIN_Font16")
            DermaNumSliderx.Label:SetFGColor(Color(0, 0, 0))
            surface.SetDrawColor(pip_color)
            surface.DrawRect(w * 0.1, 0, w * 0.8, h)
        end

        DermaNumSliderx.Slider.Paint = function(panel, w, h)
            surface.SetDrawColor(pip_color)
            local height = h - _
            surface.DrawOutlinedRect(0, _2, w, height)
            surface.DrawOutlinedRect(1, _2 + 1, w - 2, height - 2)
            surface.SetMaterial(wang_)
            local old = DisableClipping(true)
            surface.DrawTexturedRect(-height, height * 0.45, height, height)
            surface.DrawTexturedRectUV(w, height * 0.45, height, height, 1, 1, 0, 0)
            DisableClipping(old)
        end
    end

    local model = CreateFalloutCombo(VGUI, function(dataCache, k)
        dataCache = dataCache
    end)

    local c = DermaNumSlider.GetValue
    DermaNumSlider.GetValue = function(self) return math.floor(c(self)) end

    function VGUI.Paint(self, w, h)
        FOBIND(self, w, h)
        --  draw.RoundedBox(0, 0, 0, w, h, Color(pip_color.r, pip_color.g, pip_color.b, 50))
        draw.SimpleText("SMELTERY", "$MAIN_Font24", self:GetWide() / 2, 24, Color(0, 0, 0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        --surface.DrawRect(32, 330, w - 64, 8)
        surface.SetDrawColor(pip_color)
        local SmeltData = LocalPlayer():getChar():getData("smelt", nil)
        VGUI.isAct = SmeltData
        DermaNumSlider:SetMin(1)
        DermaNumSlider:SetMax(LocalPlayer():getChar():getInv():getItemCount(ARRAY_OF_CUR_SMELTABLES[model:GetValue()])) -- Set the maximum number you can slide to
        -- clamp value to max
        DermaNumSlider:SetValue(math.Clamp(DermaNumSlider:GetValue(), 1, LocalPlayer():getChar():getInv():getItemCount(ARRAY_OF_CUR_SMELTABLES[model:GetValue()])))

        if model:GetValue() == "1" then
            ClaimButton.text = "NOTHING TO SMELT"
        else
            ClaimButton.text = "SMELT" .. " " .. DermaNumSlider:GetValue()
        end

        if SmeltData then
            local Decimals = (CurTime() - TimeOfMenuSpawn) % 1
            -- use CurTime() mixed with os.time to get decimals of time
            local itemDuration = MINERS.SmeltTime[SmeltData[2]]
            local Amount = SmeltData[3]
            -- using startTime, current time, and item duration, figure out how many times the item has been smelted
            local CTime = CurTime()
            CTime = os.time()
            local TimeOfMenuSpawnW = SmeltData[1]
            draw.SimpleText("SMELTING: " .. nut.item.list[SmeltData[2]].name, "$MAIN_Font24", 32, 300, Color(0, 0, 0), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
            local itemsSmeleted = math.Clamp(math.floor((CTime - TimeOfMenuSpawnW) / itemDuration), 0, Amount) --math.floor(%itemDuration)// --math.floor((curTime - startTime) / itemDuration)   
            local progress = ((CTime - TimeOfMenuSpawnW) % itemDuration) / itemDuration -- itemDuration
            --  print(progress)
            -- finterp self.target to smooth out the progress bar
            self.target = progress --Lerp(FrameTime() * 10, self.target, progress)

            if (Amount - itemsSmeleted) == 0 then
                self.target = 1
            end

            draw.SimpleText(Amount - itemsSmeleted .. " LEFT", "$MAIN_Font16", 32, 320, Color(0, 0, 0), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
            ClaimButton.text = "Claim " .. itemsSmeleted .. " " .. nut.item.list[SmeltData[2]].name
            surface.DrawRect(32, 330, (w - 64) * self.target, 8)
        end
    end

    ClaimButton:SetText("")
    ClaimButton.text = "CLAIM (3)"
    ClaimButton:Dock(BOTTOM)
    ClaimButton:SetTall(32)
    ClaimButton:DockMargin(27, 8, 27, 8)

    function ClaimButton:Paint()
        surface.SetDrawColor(pip_color)
        surface.DrawRect(0, 0, self:GetWide(), self:GetTall())
        draw.SimpleText(self.text, "$MAIN_Font24", self:GetWide() / 2, self:GetTall() / 2, Color(24, 24, 24), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end

    ClaimButton.DoClick = function()
        if not VGUI.isAct then
            net.Start("miners_smelt_deposit")
            net.WriteString(ARRAY_OF_CUR_SMELTABLES[model:GetValue()])
            net.WriteInt(DermaNumSlider:GetValue(), 32)
            net.SendToServer()
        else
            net.Start("miners_smelt_withdraw")
            net.SendToServer()
        end
    end

    model:SetSize(128, 128)
    model:SetPos(200 - 64, 100)
    model:AddChoice(0, "Male")
    model:AddChoice(1, "Female")
    timer.Simple(FrameTime(), function() end)

    function model:GenerateItems()
        model:Clear()
        ARRAY_OF_CUR_SMELTABLES = {}
        local ply = LocalPlayer()
        local char = ply:getChar()
        local inv = char:getInv()
        local items = inv:getItems()

        for i, v in pairs(items) do
            if MINERS.ItemSmelt[v.uniqueID] and not ARRAY_OF_CUR_SMELTABLES[v.name] then
                ARRAY_OF_CUR_SMELTABLES[v.name] = v.uniqueID
                model:AddChoice(v.name, v.name)
            end
        end
    end

    model.Paint = function(s, w, h)
        FOBIND(s, w, h)

        local tbl = {
            [1] = "Male",
            [2] = "Female"
        }

        draw.DrawText(s:GetValue(), "$MAIN_Font16", w / 2, h / 2 - 8, Color(0, 0, 0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
end

if SERVER then
    player.GetAll()[1]:getChar():setData("smelt", nil)

    net.Receive("miners_smelt_withdraw", function(len, ply)
        local char = ply:getChar()
        local SmeltData = char.vars.data.smelt
        if SmeltData == nil then return end
        local Amount = SmeltData[3]
        local CTime = os.time()
        local TimeOfMenuSpawnW = SmeltData[1]
        local ITEMTYPE = SmeltData[2]
        print(ITEMTYPE)
        local itemDuration = MINERS.SmeltTime[ITEMTYPE]
        local itemsSmeleted = math.Clamp(math.floor((CTime - TimeOfMenuSpawnW) / itemDuration), 0, Amount)
        SmeltData[1] = os.time()
        SmeltData[3] = SmeltData[3] - itemsSmeleted

        for i = 1, itemsSmeleted do
            local plyInv = char:getInv()

            plyInv:add(ITEMTYPE):next(function(res)
                if IsValid(ply) then
                    local append = ply:notify(nut.item.list[ITEMTYPE].name .. " Obtained")
                end
            end)
        end

        if SmeltData[3] == 0 then
            SmeltData = nil
        end

        char:setData("smelt", SmeltData)
    end)

    net.Receive("miners_smelt_deposit", function(len, ply)
        print("e")
        local char = ply:getChar()
        local SmeltData = char.vars.data.smelt
        --if SmeltData ~= nil then return end
        local itemID = net.ReadString()
        -- remove itemID from inventory
        local plyInv = char:getInv()
        local amt = net.ReadInt(32)

        if plyInv:getItemCount(itemID) > 0 then
            for i = 1, amt do
                plyInv:remove(itemID):next(function() end)
            end

            SmeltData = {}
            SmeltData[1] = os.time()
            SmeltData[2] = MINERS.ItemSmelt[itemID]
            SmeltData[3] = amt
            char:setData("smelt", SmeltData)
        end
    end)
end