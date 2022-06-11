
hook.Add("InitializedPlugins", "override_nut_notifcation", function()
    hook.Add("ItemShowEntityMenu", "fallout_ent", function(client)
        local entity = LocalPlayer():GetEyeTrace().Entity
        netstream.Start("invAct", "take", entity)

        return true
    end)

      local ENT = scripted_ents.Get("nut_item")
    local toScreen = FindMetaTable("Vector").ToScreen
    local colorAlpha = ColorAlpha

    function ENT:onDrawEntityInfo(alpha)
        local itemTable = self.getItemTable(self)

        if (itemTable) then
           local name = itemTable.getName and itemTable:getName() or L(itemTable.name)
            self.Interactable = {name, "Take"}
        end
  
        if true then return end -- NZPATCH APPLIED USE INTERACTABLE CLASS INSTEAD :))

        if (itemTable) then
            local oldData = itemTable.data
            itemTable.data = self.getNetVar(self, "data", {})
            itemTable.entity = self
            local position = toScreen(self.LocalToWorld(self, self.OBBCenter(self)))
            local x, y = position.x, position.y
            local description = itemTable.getDesc(itemTable)
            cam.Start2D()
            surface.SetFont("$MAIN_Font")
            local name = itemTable.getName and itemTable:getName() or L(itemTable.name)
            local txt_w, txt_h = surface.GetTextSize(name)
            local txt_w2, txt_h2 = surface.GetTextSize("E) Take")
            local XPos = ScrW() * 0.7
            NzGUI.DrawShadowText(name, XPos - (txt_w / 2), ScrH() / 2 - 32)
            NzGUI.DrawShadowText("E) Take", XPos - (txt_w2 / 2), ScrH() / 2 + 6)
            -- nut.util.drawText(, , colorAlpha(nut.config.get("color"), alpha), 1, 1, nil, alpha * 0.65)
            cam.End2D()
            y = y + 12
            itemTable.entity = nil
            itemTable.data = oldData
        end
    end
 
    scripted_ents.Register(ENT, "nut_item")
    -- List of notice panels.
    nut.notices = nut.notices or {}
    local nutTall = 42
    local nutxPos, nutYPos = 35, 35

    -- Move all notices to their proper positions.
    local function OrganizeNotices()
        local scrW = 5

        for k, v in ipairs(nut.notices) do
            if IsValid(v) then
                v:MoveTo(nutxPos, (k - 1) * (nutTall + 4) + nutYPos, 0.15, (k / #nut.notices) * 0.25)
            end
        end
    end

    -- Create a notification panel.
    local duration = 4

    function nut.util.notify(message)
        local notice = vgui.Create("nutNotice")
        local i = table.insert(nut.notices, notice)
        local scrW = 5
        notice:SetWide(512)
        notice:SetTall(42)
        notice:SetText("   " .. message)
        notice:SetPos(nutxPos, (i - 1) * (nutTall + 4) + nutYPos)
        notice.start = CurTime() + 0.25
        notice.endTime = CurTime() + duration
        -- Add the notice we made to the list.
        -- Show the notification in the console.
        MsgC(Color(0, 255, 255), message .. "\n")
        -- Once the notice appears, make a sound and message.
        timer.Simple(0.15, function() end) --LocalPlayer():EmitSound(unpack(SOUND_NOTIFY))

        timer.Simple(duration, function()
            --  if (IsValid(notice)) then 
            table.RemoveByValue(nut.notices, notice)
            notice:Remove()
            OrganizeNotices()
        end)

        --end
        OrganizeNotices()
    end

    local PANEL = {}
    local gradient = nut.util.getMaterial("vgui/gradient-d")

    function PANEL:Init()
        self:SetSize(512, 42)
        self:SetContentAlignment(4)
        self:SetExpensiveShadow(1, Color(0, 0, 0, 255))
        self:SetFont("$Notify_Font")
        self:SetTextColor(pip_color)
        self:SetDrawOnTop(true)
        self:NoClipping(true)
    end

    function DEFUNC_DRAW(self, w, h)
        local height = h
        local width = w
        surface.SetDrawColor(pip_color.r * 0.8, pip_color.g * 0.8, pip_color.b * 0.8, 85e0)
        surface.DrawRect(0, 0, w, h)
        surface.SetDrawColor(0, 0, 0, 25)
        surface.SetDrawColor(0, 0, 0, 255)
        surface.DrawRect(0, 0, 6, height + 2)
        surface.DrawRect(w - 4, 0, 6, height + 2)
        surface.DrawRect(0, 0, 14, 6) --TOP ARMS
        surface.DrawRect(w - 12, 0, 14, 6)
        surface.DrawRect(0, height - 4, 14, 6) -- BOTTOM ARMS
        surface.DrawRect(w - 12, 0 + height - 4, 14, 6)
        -- BORDER STUFF
        surface.SetDrawColor(pip_color.r, pip_color.g, pip_color.b, 255)
        surface.DrawRect(0, 0, 4, height)
        surface.DrawRect(w - 4, 0, 4, height)
        surface.DrawRect(0, 0, 12, 4) --TOP ARMS
        surface.DrawRect(w - 12, 0, 12, 4)
        surface.DrawRect(0, 0 + height - 4, 12, 4) -- BOTTOM ARMS
        surface.DrawRect(w - 12, 0 + height - 4, 12, 4)
    end

    function PANEL:Paint(w, h)
        DEFUNC_DRAW(self, w, h)
    end

    vgui.Register("nutNotice", PANEL, "DLabel")
end)

hook.Add("ShouldHideBars", "hideBars", function() return true end)



hook.Add("CanDrawAmmoHUD", "hideAmmo2", function() return true end)
hook.Add("CanDrawAmmoHUD", "hideAmmo2", function() return false end) 
hook.Add("ShouldDrawCrosshair", "hideCrosshair", function() return false end)
    local ENT = scripted_ents.Get("nut_item")
    local toScreen = FindMetaTable("Vector").ToScreen
    local colorAlpha = ColorAlpha

    function ENT:onDrawEntityInfo(alpha)
        local itemTable = self.getItemTable(self)

        if (itemTable) then
           local name = itemTable.getName and itemTable:getName() or L(itemTable.name)
            self.Interactable = {name, "Take"}
        end
  
        if true then return end -- NZPATCH APPLIED USE INTERACTABLE CLASS INSTEAD :))

        if (itemTable) then
            local oldData = itemTable.data
            itemTable.data = self.getNetVar(self, "data", {})
            itemTable.entity = self
            local position = toScreen(self.LocalToWorld(self, self.OBBCenter(self)))
            local x, y = position.x, position.y
            local description = itemTable.getDesc(itemTable)
            cam.Start2D()
            surface.SetFont("$MAIN_Font")
            local name = itemTable.getName and itemTable:getName() or L(itemTable.name)
            local txt_w, txt_h = surface.GetTextSize(name)
            local txt_w2, txt_h2 = surface.GetTextSize("E) Take")
            local XPos = ScrW() * 0.7
            NzGUI.DrawShadowText(name, XPos - (txt_w / 2), ScrH() / 2 - 32)
            NzGUI.DrawShadowText("E) Take", XPos - (txt_w2 / 2), ScrH() / 2 + 6)
            -- nut.util.drawText(, , colorAlpha(nut.config.get("color"), alpha), 1, 1, nil, alpha * 0.65)
            cam.End2D()
            y = y + 12
            itemTable.entity = nil
            itemTable.data = oldData
        end
    end
 
    scripted_ents.Register(ENT, "nut_item")