_G_SPECIAL = {}

function CL_MORPHUS()
    function GET_SPEICLA_FIX_PRIVATE()
        return _G_SPECIAL
    end

    for i, v in pairs({"Strength", "Perception", "Endurance", "Charisma", "Intelligence", "Agility", "Luck"}) do
        _G_SPECIAL[v] = 1
    end

    local first_names_male = {"David", "John", "James", "Robert", "Mark", "William", "Richard", "Thomas", "Jeffrey", "Steven", "Joseph", "Timothy", "Kevin", "Scott", "Brian", "Charles", "Paul", "Daniel", "Christop", "Kenneth", "Anthony", "Gregory", "Ronald", "Donald", "Gary", "Stephen", "Eric", "Edward", "Douglas", "Todd", "Patrick", "George", "Keith", "Larry", "Matthew", "Terry", "Andrew", "Dennis", "Randy", "Jerry", "Peter", "Frank", "Craig", "Raymond", "Jeffery", "Bruce", "Rodney", "Mike", "Roger", "Tony", "Ricky", "Steve", "Jeff", "Troy", "Alan", "Carl", "Danny", "Russell", "Chris", "Bryan", "Gerald", "Wayne", "Randall", "Lawrence", "Dale", "Phillip", "Johnny", "Vincent", "Martin", "Bradley", "Billy", "Glenn", "Shawn", "Jonathan", "Jimmy", "Sean", "Curtis", "Barry", "Bobby", "Walter", "Philip", "Samuel", "Jason", "Dean", "Jose", "Willie", "Arthur", "Darryl", "Henry", "Darrell", "Allen", "Victor", "Harold", "Greg"}

    local last_names_male = {"Smith", "Johnson", "Williams", "Brown", "Jones", "Garcia", "Miller", "Davis", "Rodriguez", "Martinez", "Hernandez", "Lopez", "Gonzales", "Wilson", "Anderson", "Thomas", "Taylor", "Moore", "Jackson", "Martin", "Lee", "Perez", "Thompson", "White", "Harris", "Sanchez", "Clark", "Ramirez", "Lewis", "Robinson", "Walker", "Young", "Allen", "King", "Wright", "Scott", "Torres", "Nguyen", "Hill", "Flores", "Green", "Adams", "Nelson", "Baker", "Hall", "Rivera", "Campbell", "Mitchell", "Carter", "Roberts", "Gomez", "Phillips", "Evans", "Turner", "Diaz", "Parker", "Cruz", "Edwards", "Collins", "Reyes", "Stewart", "Morris", "Morales", "Murphy", "Cook", "Rogers", "Gutierrez", "Ortiz", "Morgan", "Cooper", "Peterson", "BaileySmith", "Smith", "Johnson", "Williams", "Brown", "Jones", "Garcia", "Miller", "Davis", "Rodriguez", "Martinez", "Hernandez", "Lopez", "Gonzales", "Wilson", "Anderson", "Thomas", "Taylor", "Moore", "Jackson", "Martin", "Lee", "Perez", "Thompson", "White", "Harris", "Sanchez", "Clark", "Ramirez", "Lewis", "Robinson", "Walker", "Young", "Allen", "King", "Wright", "Scott", "Torres", "Nguyen", "Hill", "Flores", "Green", "Adams", "Nelson", "Baker", "Hall", "Rivera", "Campbell", "Mitchell", "Carter", "Roberts", "Gomez", "Phillips", "Evans", "Turner", "Diaz", "Parker", "Cruz", "Edwards", "Collins", "Reyes", "Stewart", "Morris", "Morales", "Murphy", "Cook", "Rogers", "Gutierrez", "Ortiz", "Morgan", "Cooper", "Peterson", "Bailey", "Reed", "Kelly", "Howard", "Ramos", "Kim", "Cox", "Ward", "Richardson", "Watson", "Brooks", "Chavez", "Wood", "James", "Bennet", "Gray", "Mendoza", "Ruiz", "Hughes", "Price", "Alvarez", "Castillo", "Sanders", "Patel", "Myers", "Long", "Ross", "Foster", "Jimenez"}

    local wang_ = Material("wang_slider.png")

    local stats = {"Strength", "Perception", "Endurance", "Charisma", "Intelligence", "Agility", "Luck"}

    local PANEL = {}
    print("NGIAEGNIANG")

    function PANEL:Init()
        --function CL_CreateCharacterCreationMenu(model)
        local model = male_character
 
        local Payload = {
            trait = "Healthy"
        }

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
            NzGUI.DrawShadowText(s.DESC, 0, -36, pip_color)
        end

        local CHARACTER_CREATION_PANEL = self
        CHARACTER_CREATION_PANEL.Model = model or female_character
        _G["§"] = self
        CHARACTER_CREATION_PANEL:DockPadding(0, 0, 0, 0)
        CHARACTER_CREATION_PANEL:SetSize(ScrW(), ScrH())
        CHARACTER_CREATION_PANEL:MakePopup() -- Make it a popup
        CHARACTER_CREATION_PANEL_LEFT = vgui.Create("DPanel", CHARACTER_CREATION_PANEL)
        CHARACTER_CREATION_PANEL_LEFT:Dock(LEFT)
        CHARACTER_CREATION_PANEL_LEFT:SetWide(ScrW() * 0.25)
        CHARACTER_CREATION_PANEL_LEFT:DockMargin(0, 0, 0, 0)
        CHARACTER_CREATION_PANEL_RIGHT = vgui.Create("DPanel", CHARACTER_CREATION_PANEL)
        CHARACTER_CREATION_PANEL_RIGHT:Dock(RIGHT)
        CHARACTER_CREATION_PANEL_RIGHT:SetWide(ScrW() * 0.25)
        CHARACTER_CREATION_PANEL_RIGHT:DockMargin(4, 4, 4, 4)

        CHARACTER_CREATION_PANEL.Paint = function(s, w, h)
            local old = DisableClipping(true) -- Avoid issues introduced by the natural clipping of Panel rendering

            render.RenderView({
                origin = Vector(-3869, 5386, 668),
                angles = Angle(0, 90, 0),
                x = x,
                y = y,
                w = w,
                h = h,
                fov = 90
            })

            DisableClipping(old)
        end

        local data = {
            bones = {},
            move_bones = {},
            facial_hair = 0,
            hair = {0, Vector(255 / 255, 220 / 255, 160 / 255)},
            eyecolor = 1,
        }

        function NewSlider(char, typ, func)
            local DermaNumSlider = SkinPanel:Add("DNumSlider")
            DermaNumSlider:Dock(TOP)
            DermaNumSlider:SetMin(1) -- Set the minimum number you can slide to
            DermaNumSlider:SetMax(10) -- Set the maximum number you can slide to
            DermaNumSlider:SetDecimals(0) -- Decimal places - zero for whole number
            DermaNumSlider:SetTall(32)
            DermaNumSlider:SetValue(1)
            DermaNumSlider:SetText("fa") -- Set the text above the slider
            DermaNumSlider.Scratch:SetVisible(false)
            DermaNumSlider.TextArea:SetVisible(true)
            DermaNumSlider.TextArea:SetWide(10)

            DermaNumSlider.Slider.Knob.Paint = function(panel, w, h)
                DermaNumSlider.Label:SetFont("$MAIN_Font16")
                DermaNumSlider.Label:SetFGColor(Color(0, 0, 0))
                surface.SetDrawColor(pip_color)
                surface.DrawRect(w * 0.1, 0, w * 0.8, h)
            end

            local _ = 15
            local _2 = _ / 2

            DermaNumSlider.Slider.Paint = function(panel, w, h)
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

            DermaNumSlider.DoOnce = true

            DermaNumSlider.OnValueChanged = function(self, value)
                self:SetValue(math.Round(self:GetValue()))
                func(DermaNumSlider, value)
            end

            DermaNumSlider.DoOnce = true

            return DermaNumSlider
        end

        SexPanel = vgui.Create("DPanel", CHARACTER_CREATION_PANEL_LEFT) -- Create a panel to parent it to
        SexPanel:SetPos(20, 100)
        SexPanel:DockMargin(4, 34, 4, 4)
        SexPanel:NoClipping(true)
        SexPanel.DESC = "GENDER"
        SexPanel.Paint = FOBIND
        SexPanel:Dock(TOP)
        SexPanel:SetTall(48)
        HairPanel = vgui.Create("DPanel", CHARACTER_CREATION_PANEL_LEFT) -- Create a panel to parent it to
        HairPanel:SetPos(20, 100)
        HairPanel:DockMargin(4, 34, 4, 4)
        HairPanel:NoClipping(true)
        HairPanel.DESC = "HAIR"
        HairPanel.Paint = FOBIND
        HairPanel:Dock(TOP)
        HairPanel:SetTall(205)
        DermaPanel = vgui.Create("DPanel", CHARACTER_CREATION_PANEL_LEFT) -- Create a panel to parent it to
        DermaPanel:SetTall(300)
        DermaPanel:SetPos(20, 100)
        DermaPanel:NoClipping(true)
        DermaPanel:DockMargin(4, 34, 4, 4)
        DermaPanel:Dock(TOP)
        DermaPanel.DESC = "BODY"
        RevampBodyPanel = DermaPanel
        DermaPanel.Paint = FOBIND
        DermaPanel:DockPadding(8, 8, 8, 8)
        SkinPanel = vgui.Create("DPanel", CHARACTER_CREATION_PANEL_RIGHT) -- Create a panel to parent it to
        SkinPanel:SetPos(20, 100)
        SkinPanel:DockMargin(4, 34, 4, 4)
        SkinPanel:NoClipping(true)
        SkinPanel.DESC = "CHARACTER"
        SkinPanel.Paint = FOBIND
        SkinPanel:Dock(FILL)
        SkinPanel:SetTall(800)
        local DermaNumSlider = DermaPanel:Add("DNumSlider")
        DermaNumSlider:Dock(TOP)
        DermaNumSlider:DockMargin(0, 0, 0, 0)
        DermaNumSlider:SetMin(0) -- Set the minimum number you can slide to
        DermaNumSlider:SetMax(1) -- Set the maximum number you can slide to
        DermaNumSlider:SetDecimals(2) -- Decimal places - zero for whole number
        DermaNumSlider:SetTall(32)
        DermaNumSlider:SetValue(0)
        DermaNumSlider:SetText("    Skin Color") -- Set the text above the slider
        DermaNumSlider.Scratch:SetVisible(false)
        DermaNumSlider.TextArea:SetVisible(true)
        DermaNumSlider.TextArea:SetWide(10)
        DermaNumSlider2 = HairPanel:Add("DNumSlider")
        DermaNumSlider2:Dock(BOTTOM)
        DermaNumSlider2:DockMargin(0, 16, 0, 0)
        DermaNumSlider2:SetMin(0) -- Set the minimum number you can slide to
        DermaNumSlider2:SetMax(11) -- Set the maximum number you can slide to
        DermaNumSlider2:SetDecimals(2) -- Decimal places - zero for whole number
        DermaNumSlider2:SetTall(32)
        DermaNumSlider2:SetValue(0)
        DermaNumSlider2:SetText("    Facial Hair") -- Set the text above the slider
        DermaNumSlider2.Scratch:SetVisible(false)
        DermaNumSlider2.TextArea:SetVisible(true)
        DermaNumSlider2.TextArea:SetWide(10)
        local dP = SkinPanel:Add("DPanel")
        dP:Dock(TOP)
        dP:SetTall(42)
        local icon = vgui.Create("DModelPanel", CHARACTER_CREATION_PANEL)

        dP.Paint = function()
            surface.SetFont("$Bold_font")
            NzGUI.DrawShadowText(" CHARACTER", 0, 0, pip_color)
        end

        local TextEntry = vgui.Create("DTextEntry", SkinPanel) -- create the form as a child of frame
        TextEntry:Dock(TOP)
        TextEntry:SetEditable(true)
        TextEntry:DockMargin(0, 0, 0, 0)
		
		
		 local CancerStick = DermaPanel:Add("DNumSlider")
        CancerStick:Dock(TOP)
        CancerStick:DockMargin(0, 0, 0, 0)
        CancerStick:SetMin(0) -- Set the minimum number you can slide to
        CancerStick:SetMax(5) -- Set the maximum number you can slide to
        CancerStick:SetDecimals(2) -- Decimal places - zero for whole number
        CancerStick:SetTall(32)
        CancerStick:SetValue(0)
        CancerStick:SetText("    Smooth Skin") -- Set the text above the slider
        CancerStick.Scratch:SetVisible(false)
        CancerStick.TextArea:SetVisible(true)
        CancerStick.TextArea:SetWide(10)
        local bnmnaeeaveahnbanmawedadadf = table.Random(first_names_male) .. " " .. table.Random(last_names_male)
        TextEntry:SetValue(bnmnaeeaveahnbanmawedadadf)
        Payload.CharacterName = TextEntry:GetValue()

        TextEntry.OnEnter = function(self)
			Payload.CharacterName = TextEntry:GetValue()
        end
		
		  TextEntry.OnChange = function(self)
			Payload.CharacterName = TextEntry:GetValue()
        end

        TextEntry:NoClipping(true)

        TextEntry.Paint = function(s, w, h)
            surface.SetFont("$Bold_fontcs")

            if s:HasFocus() then
                surface.SetDrawColor(0, 0, 0, 100)
                surface.DrawRect(0, 0, w, h)
                NzGUI.DrawShadowText("  NAME: ", 0, 0, pip_color)
                NzGUI.DrawShadowText(s:GetValue(), 80, 0, pip_color)
            else
                NzGUI.DrawShadowText("  NAME: ", 0, 0, pip_color)
                NzGUI.DrawShadowText(s:GetValue(), 80, 0, pip_color)
            end
        end

        local dP = SkinPanel:Add("DPanel")
        dP:Dock(TOP)
        dP:SetTall(42)

        dP.Paint = function()
            surface.SetFont("$Bold_font")
            NzGUI.DrawShadowText(" S.P.E.C.I.A.L", 0, 0, pip_color)
        end

        local localUpdate

        function CreateSlider(char, v, name, func, min, max, typeOfSlider)
            local DermaNumSlider
            DermaNumSlider = NewSlider(char, name, func)
            DermaNumSlider:SetText("    " .. name)
            DermaNumSlider:Dock(v or TOP)
			DermaNumSlider:DockMargin(0,0,0,-12)
            return DermaNumSlider
        end

        local budget_points = 21 + 7
        local max_points = 10
        Strength, Perception, Endurance, Charisma, Intelligence, Agility, Luck = 1, 1, 1, 1, 1, 1, 1
        Payload.Strength, Payload.Perception, Payload.Endurance, Payload.Charisma, Payload.Intelligence, Payload.Agility, Payload.Luck = Strength, Perception, Endurance, Charisma, Intelligence, Agility, Luck

        function CalcPoints()
            local a = 0

            for i, v in pairs(_G_SPECIAL) do
                a = a + v
            end

            Payload.Strength, Payload.Perception, Payload.Endurance, Payload.Charisma, Payload.Intelligence, Payload.Agility, Payload.Luck = Strength, Perception, Endurance, Charisma, Intelligence, Agility, Luck

            return a
        end

        local function resetSlider(self, c)
            local c = math.Round(c)

            if CalcPoints() > budget_points then
                self:SetValue(c - 1)
            end
        end

        for i, v in pairs(stats) do
            local nn = v
  
            local slider01 = CreateSlider(SkinPanel, TOP, v, function(self, c)
                _G_SPECIAL[v] = self:GetValue()
                resetSlider(self, c)
                localUpdate()
            end, 1, 20)
        end

        local Spider = vgui.Create("DPanel", SkinPanel)
        Spider:SetPos(80, 280)
        Spider:Dock(TOP)
        Spider:SetTall(350)
        Spider.Paint = BGDRAW

        function lrp(a, b, t)
            return a + (b - a) * t
        end

        local SPiderpoobutt = {}
        local xOf = 50

        function GenPent(n_sides, start_angle, x_centre, y_centre, r)
            local Pent = {}
            angle = start_angle or 0
            angle_increment = 2 * 3.14159 / n_sides

            for i = 1, n_sides do
                table.insert(Pent, {
                    x = x_centre + r * math.cos(angle),
                    y = y_centre + r * math.sin(angle)
                })

                angle = angle + angle_increment
            end

            return Pent
        end

        local rotation = 90 * -math.pi / 180
        SPiderpoobutt = GenPent(7, rotation, 150 + xOf, 150, 130)

        local offsets_ = {SPiderpoobutt, GenPent(7, rotation, 150 + xOf, 150, 80), GenPent(7, rotation, 150 + xOf, 150, 40), GenPent(7, rotation, 150 + xOf, 150, 10)}

        local function calc_average(n)
            return n / max_points
        end

        -- Create render target
        local exampleRT = GetRenderTarget("example_rdt_mat5", 400, 400)

        -- Draw to the render target
        function localUpdate()
            render.ClearRenderTarget(exampleRT, Color(0, 0, 0))
            render.PushRenderTarget(exampleRT)
            render.OverrideAlphaWriteEnable(true, true)
            render.ClearDepth()
            render.Clear(0, 0, 0, 0)
            -- Draw stuff here
            render.OverrideAlphaWriteEnable(false)
            cam.Start2D()
            draw.NoTexture()
            surface.SetDrawColor(0, 0, 0, 100)
            surface.DrawPoly(SPiderpoobutt)
            surface.SetDrawColor(pip_color)
            local Pent = 7

            for i = 1, Pent do
                for cv = 1, #offsets_ do
                    if cv < #offsets_ then
                        if i == Pent then
                            surface.DrawLine(offsets_[cv][i].x, offsets_[cv][i].y, offsets_[cv][1].x, offsets_[cv][1].y)
                        else
                            surface.DrawLine(offsets_[cv][i].x, offsets_[cv][i].y, offsets_[cv][i + 1].x, offsets_[cv][i + 1].y)
                        end
                    end
                end
            end

            local n = 1
            local progress = {}

            for i, v in pairs(stats) do
                progress[i] = calc_average(_G_SPECIAL[v])
                n = n + 1
            end

            --local progress = {5,2,3,5,6,2,4}
            local newSpider = {}

            for i = 1, Pent do
                newSpider[i] = {}
                newSpider[i].x = lrp(SPiderpoobutt[i].x, 150 + xOf, math.Clamp(1 - progress[i], 0, 1))
                newSpider[i].y = lrp(SPiderpoobutt[i].y, 150, math.Clamp(1 - progress[i], 0, 1))
            end

            surface.SetDrawColor(pip_color)
            draw.NoTexture()

            local ddd = {1, 2, 3, 4, 5}

            local spiderConcave = {}

            for i = 1, 8 - 2 do
                spiderConcave[i] = {newSpider[1], newSpider[i + 1], newSpider[i + 2]}
            end

            surface.SetDrawColor(pip_color.r, pip_color.g, pip_color.b, 200)

            for i, v in pairs(spiderConcave) do
                surface.DrawPoly(v)
            end

            draw.SimpleText("Available Attribute Points: " .. budget_points - CalcPoints(), "$MAIN_Font32", 200, 300, Color(0, 0, 0, 200), TEXT_ALIGN_CENTER)

            for i = 1, Pent do
                draw.SimpleTextOutlined(stats[i], "$MAIN_Font24", SPiderpoobutt[i].x + (i == 1 and -5 or 0), SPiderpoobutt[i].y - 8, pip_color, TEXT_ALIGN_CENTER, nil, 1, color_black)
            end

            cam.End2D()
            render.PopRenderTarget()
        end

        local customMaterial = CreateMaterial("example_rt_max", "UnlitGeneric", {
            ["$basetexture"] = exampleRT:GetName(), -- You can use "example_rt" as well
            ["$translucent"] = 1,
            ["$vertexcolor"] = 1
        })

        Spider.PaintOver = function(self, w, h)
            surface.SetDrawColor(255, 255, 255, 255)
            surface.SetMaterial(customMaterial)
            surface.DrawTexturedRect((w / 2) - (h / 2), 0, h, h)
        end
		Spider:DockMargin(0,0,0,-40)
        DermaNumSlider.Slider.Knob.Paint = function(panel, w, h)
            DermaNumSlider.Label:SetFont("$MAIN_Font16")
            DermaNumSlider.Label:SetFGColor(Color(0, 0, 0))
            surface.SetDrawColor(pip_color)
            surface.DrawRect(w * 0.1, 0, w * 0.8, h)
        end

        local _ = 15
        local _2 = _ / 2

        for i, DermaNumSliderx in pairs({DermaNumSlider, DermaNumSlider2,CancerStick}) do
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

        DermaNumSlider.OnValueChanged = function(self, value)
            local raw_vec = LerpVector(value, Vector(3, 3, 3), Vector(150 / 255, 120 / 255, 150 / 255))
            data.skin = raw_vec
            timer.Simple(FrameTime(),function() icon.Entity:ApplyMorph(data) end)
        end
	      CancerStick.OnValueChanged = function(self, value)

            data.ghoul = math.Round(value)
            timer.Simple(FrameTime(),function() icon.Entity:ApplyMorph(data) end)
        end
        DermaNumSlider2.OnValueChanged = function(self, value)
            local raw_vec = math.Round(value)
            data.facial_hair = raw_vec
             timer.Simple(FrameTime(),function() icon.Entity:ApplyMorph(data) end)
        end

        local dP = SkinPanel:Add("DPanel")
        dP:Dock(TOP)
        dP:SetTall(42)

        dP.Paint = function()
            surface.SetFont("$Bold_font")
            NzGUI.DrawShadowText(" TRAIT", 0, 0, pip_color)
        end

        function Test_Bind_Bone(label, boneid, xyz, Target, minmax)
            local character = CHARACTER_CREATION_PANEL.Model
            local Target = Target or Vector(1, 1, 1)

            minmax = minmax or {-1, 1}

            boneName = character.Bones_mesh[boneid]
            local DermaNumSlider = DermaPanel:Add("DNumSlider")
            DermaNumSlider:Dock(TOP)
            DermaNumSlider:SetMin(minmax[1]) -- Set the minimum number you can slide to
            DermaNumSlider:SetMax(minmax[2]) -- Set the maximum number you can slide to
            DermaNumSlider:SetDecimals(2) -- Decimal places - zero for whole number
            DermaNumSlider:SetTall(32)
            DermaNumSlider:SetValue(0)
            DermaNumSlider:SetText(label or boneName) -- Set the text above the slider
            DermaNumSlider.Scratch:SetVisible(false)
            DermaNumSlider.TextArea:SetVisible(true)
            DermaNumSlider.TextArea:SetWide(10)
            DermaNumSlider.TextArea.Paint = function() end

            DermaNumSlider.Slider.Knob.Paint = function(panel, w, h)
                DermaNumSlider.Label:SetFont("$MAIN_Font16")
                DermaNumSlider.Label:SetFGColor(Color(0, 0, 0))
                surface.SetDrawColor(pip_color)
                surface.DrawRect(w * 0.1, 0, w * 0.8, h)
            end

            local _ = 15
            local _2 = _ / 2

            DermaNumSlider.Slider.Paint = function(panel, w, h)
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

            DermaNumSlider.OnValueChanged = function(self, value)
                local raw_vec = (Vector(1, 1, 1) + (xyz * value))
                local maskedVector = Vector(raw_vec.x / Target.x, raw_vec.y / Target.y, raw_vec.z / Target.z)
                local bone = data.bones[boneid] or {}
                data.bones[boneid] = Vector(Target.x == 1 and maskedVector.x or (bone.x or 1), Target.y == 1 and maskedVector.y or (bone.y or 1), Target.z == 1 and maskedVector.z or (bone.z or 1))
                icon.Entity:ApplyMorph(data)
            end
        end

        -- Test_Bind_Bone("Chin", 1, Vector(0.2, 0.1, 0.1), Vector(1, 1, 0))
        -- //Test_Bind_Bone("Chin Tip", 1, Vector(0.7, 0.7, 0.7), Vector(0, 0, 1))
        -- Test_Bind_Bone("Jawline", 2, Vector(1, 1, 1))
        -- Test_Bind_Bone("Cheek", 4, Vector(1, 1, 1))
        -- Test_Bind_Bone("Lip Size", 5, Vector(0.6, 0.6, 0.6))
        -- Test_Bind_Bone("Dimples", 6, Vector(0.6, 0.6, 0.6))
        -- Test_Bind_Bone("Center Top Lip", 7, Vector(0.6, 0.6, 0.6))
        -- Test_Bind_Bone("Bottom Lip", 8, Vector(0.6, 0.6, 0.6))
        -- Test_Bind_Bone("Top Lip", 9, Vector(0.6, 0.6, 0.6))
        -- Test_Bind_Bone("Eye Brow Size", 10, Vector(1, 0.5, -2), nil, {-1, 0})
        -- Test_Bind_Bone("Eye Length", 12, Vector(0.2, 0, 0), Vector(1, 0, 0))
        -- Test_Bind_Bone("Eye Height", 12, Vector(0, 0.2, 0), Vector(0, 1, 0))
        -- Test_Bind_Bone("Nose Height", 16, Vector(0, 0.2, 0), Vector(0, 1, 0))
        -- Test_Bind_Bone("Nose Width", 16, Vector(0.1, 0, 0.1), Vector(1, 0, 1))
        -- Test_Bind_Bone("Nose Tip", 17, Vector(0, 0.2, 0), Vector(0, 1, 0))
        -- Test_Bind_Bone("Nose Bridge", 18, Vector(0.3, 0.3, 0.3), Vector(1, 1, 1))
        -- Test_Bind_Bone("Nostrils", 19, Vector(0, 0.2, 0), Vector(0, 1, 0))
        -- Test_Bind_Bone("Eye Height", 25, Vector(0, 0.5, 0), Vector(0, 1, 0))
        local hairColors = {}

        local function addHaircolor(x, y, z)
            table.insert(hairColors, Color(x, y, z))
        end

        addHaircolor(8, 8, 6)
        addHaircolor(44, 34, 43)
        addHaircolor(59, 49, 38)
        addHaircolor(78, 58, 63)
        addHaircolor(80, 69, 69)
        addHaircolor(106, 78, 66)
        addHaircolor(85, 72, 56)
        addHaircolor(167, 133, 106)
        addHaircolor(194, 151, 128)
        addHaircolor(220, 209, 186)
        addHaircolor(222, 188, 153)
        addHaircolor(151, 121, 96)
        addHaircolor(233, 206, 168)
        addHaircolor(229, 200, 168)
        addHaircolor(165, 137, 70)
        addHaircolor(145, 85, 61)
        addHaircolor(83, 61, 53)
        addHaircolor(133, 99, 93)
        addHaircolor(183, 186, 158)
        addHaircolor(214, 196, 194)
        addHaircolor(255, 245, 225)
        addHaircolor(202, 191, 177)
        addHaircolor(141, 74, 67)
        addHaircolor(181, 82, 57)
addHaircolor(56, 82, 255) 
        local function CreateFalloutCombo(parent, previewfunc, pos, offset)
            offset = offset or 4
            pos = pos or 0.25
            local DComboBox = vgui.Create("DComboBox", parent)

            previewfunc = previewfunc or function(dataCache, k)
                dataCache.hair[1] = k
            end

            DComboBox.DisplayName = {}
            DComboBox.l = 0.75

            DComboBox.OpenMenu = function(self, pControlOpener)
                if (pControlOpener and pControlOpener == self.TextEntry) then return end
                -- Don't do anything if there aren't any options..
                if (#self.Choices == 0) then return end

                -- If the menu still exists and hasn't been deleted
                -- then just close it and don't open a new one.
                if (IsValid(self.Menu)) then
                    self.Menu:Remove()
                    self.Menu = nil
                end

                self.Menu = DermaMenu(false, self)

                if (self:GetSortItems()) then
                    local sorted = {}

                    for k, v in pairs(self.Choices) do
                        local val = tonumber(v) or v

                        if (string.len(val) > 1 and not tonumber(val) and val:StartWith("#")) then
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
                            self:SetWide(self:GetWide() + 30)
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
                        
                                 timer.Simple(FrameTime(),function() icon.Entity:ApplyMorph(dataCache) end)
                            end

                            s.Null = s:IsHovered()
                        end

                        if (self.ChoiceIcons[v.id]) then
                            option:SetIcon(self.ChoiceIcons[v.id])
                        end

                        if (self.ChoiceColor[v.id]) then
                            option:SetTextColor(self.ChoiceColor[v.id])
                        end
                    end
                end

                local x, y = self:LocalToScreen(0, self:GetTall())
                self.Menu:SetMinimumWidth(self:GetWide() * 0.35)
                self.Menu.Paint = FOBIND
                self.Menu.DESC = ""
                self.Menu:Open(ScrW() * (pos) + offset, y - 30, false, self)

                self.Menu.OnRemove = function()
                    if IsValid(icon.Entity) then
                        icon.Entity:ApplyMorph(data)
                    end
                end
            end

            DComboBox.ChoiceColor = {}
            DComboBox:Dock(TOP)
            DComboBox:DockMargin(10, 10, 10, 10)
            DComboBox.D = DComboBox.D or ("Hairstyle: ")

            DComboBox.Paint = function(s, w, h)
                draw.DrawText(s.D .. CHARACTER_CREATION_PANEL.Model.Hairstyles["name_" .. s:GetValue()], "$MAIN_Font16", w / 2, 4, Color(0, 0, 0), TEXT_ALIGN_CENTER)
            end

            DComboBox:SetFGColor(0, 0, 0, 0)
            DComboBox:SetTextColor(Color(0, 0, 0, 0))
            DComboBox:SetValue(1)

            DComboBox.AddChoice = function(self, value, data, select, icon, textcolor)
                local i = table.insert(self.Choices, value)

                if (data) then
                    self.Data[i] = data
                    self.DisplayName[i] = data
                end

                if (icon) then
                    self.ChoiceIcons[i] = icon
                end

                if (select) then
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

                if (self.Menu) then
                    self.Menu:Remove()
                    self.Menu = nil
                end
            end

            return DComboBox
        end

        local HairBox = CreateFalloutCombo(HairPanel)

        HairBox.OnSelect = function(self, index, value)
            data.hair[1] = math.floor(value)
            icon.Entity:ApplyMorph(data)
        end

        for i = 1, (#CHARACTER_CREATION_PANEL.Model.Hairstyles) do
            HairBox:AddChoice(i, CHARACTER_CREATION_PANEL.Model.Hairstyles[i].name)
        end

        local modelindex

        local model = CreateFalloutCombo(SexPanel, function(dataCache, k)
            dataCache = dataCache
        end)

        model:Dock(TOP)
        model:AddChoice(0, "Male")
        model:AddChoice(1, "Female")

        timer.Simple(FrameTime(), function()
            model:SetValue(0)
            model:OnSelect(0, 0)
        end)

        model.Paint = function(s, w, h)
            local tbl = {
                [1] = "Male",
                [2] = "Female"
            }

            draw.DrawText("Gender: " .. tbl[1 + (s:GetValue() or 0)], "$MAIN_Font16", w / 2, 4, Color(0, 0, 0), TEXT_ALIGN_CENTER)
        end

        model.OnSelect = function(self, index, value)
            icon:SetModel(value == 1 and "models/yshera/humans/female.mdl" or "models/yshera/humans/male.mdl")
            DermaNumSlider2:SetVisible(true)

            if value == 1 then
                DermaNumSlider2:SetVisible(false)
                data.facial_hair = 0
            end

            icon.Entity:ApplyMorph(data)
        end

        local FaceMarkings = CreateFalloutCombo(DermaPanel, function(dataCache, k)
            dataCache.marking = k
        end)

        FaceMarkings:SetVisible(false)

        for i = 1, (#CHARACTER_CREATION_PANEL.Model.Markings) do
            FaceMarkings:AddChoice(i, CHARACTER_CREATION_PANEL.Model.Markings[i])
        end

        FaceMarkings:Dock(TOP)

        FaceMarkings.Paint = function(s, w, h)
            draw.DrawText("Marking: " .. CHARACTER_CREATION_PANEL.Model.Markings[s.ids or 1], "$MAIN_Font16", w / 2, 4, Color(0, 0, 0), TEXT_ALIGN_CENTER)
        end

        FaceMarkings.OnSelect = function(self, index, value)
            self.ids = value
            data.marking = math.floor(value)
            icon.Entity:ApplyMorph(data)
        end

        local EyeColor = CreateFalloutCombo(DermaPanel, function(dataCache, k)
            dataCache.eyecolor = k
        end)

        for i = 1, (#CHARACTER_CREATION_PANEL.Model.Eyecolor) do
            EyeColor:AddChoice(i, CHARACTER_CREATION_PANEL.Model.Eyecolor[i])
        end

        EyeColor:Dock(TOP)

        EyeColor.Paint = function(s, w, h)
            draw.DrawText("Eye Color: " .. CHARACTER_CREATION_PANEL.Model.Eyecolor[s.ids or 1], "$MAIN_Font16", w / 2, 4, Color(0, 0, 0), TEXT_ALIGN_CENTER)
        end

        EyeColor.OnSelect = function(self, index, value)
            self.ids = value
            data.eyecolor = math.floor(value)
            icon.Entity:ApplyMorph(data)
        end

        local PaintSwatch = Material("paint_swatch.png", "smooth")
        local DColorPalette = vgui.Create("DColorPalette", HairPanel)
        local DColors = {}

        for i, v in pairs(CHARACTER_CREATION_PANEL.Model.HairstylesColor) do
            DColors[i] = Color(v.x * 255, v.y * 255, v.z * 255)
        end

        DColorPalette:SetColorButtons(DColors)

        function DColorPalette:SetButtonSize(x, y)
            for k, v in pairs(self:GetChildren()) do
                v:SetSize(x, y)

                v.Paint = function(s, x, y)
                    surface.SetMaterial(PaintSwatch)
                    surface.SetDrawColor(s:GetColor())
                    surface.DrawTexturedRect(0, 0, x, y)
                end
            end

            self:InvalidateLayout()
        end

        DColorPalette:Dock(TOP)
        DColorPalette:DockMargin(16, 0, 0, 0)
        DColorPalette:SetButtonSize(ScrW() * 0.25 * 0.15, 30)
        DColorPalette.PaintOver = function() end

        function DColorPalette:OnRightClickButton(pnl)
            local c = pnl:GetColor()
            data.hair[3] = Vector(c.r / 255, c.g / 255, c.b / 255)
            icon.Entity:ApplyMorph(data)
        end

        function DColorPalette:OnValueChanged(c)
            data.hair[2] = Vector(c.r / 255, c.g / 255, c.b / 255)
            data.hair[3] = Vector(c.r / 255, c.g / 255, c.b / 255)
            icon.Entity:ApplyMorph(data)
        end

        icon:SetSize(ScrW() * 1, ScrH())
        icon:SetPos(0, 0)
        icon:SetModel("models/yshera/humans/female.mdl" or "models/yshera/humans/male.mdl") -- LocalPlayer():GetModel() -- you can only change colors on playermodels

        icon.Entity:ApplyMorph({
            bones = {},
            move_bones = {},
            hair = {1, Vector(75 / 255, 35 / 255, 35 / 255)},
            parts = {},
        })

        function icon.Entity:GetPlayerColor()
            return LocalPlayer():GetPlayerColor()
        end

        icon:SetZPos(-100)
        icon:SetFOV(90)

        function icon:PostDrawModel(m)
            for i, v in pairs(m.parts or {}) do
                if IsValid(v) then
                    local c = v.col or Vector(1, 1, 1)
                    render.SetColorModulation(c.r, c.g, c.b)
                    v:DrawModel()
                end
            end
        end

        local headpos = icon.Entity:GetBonePosition(icon.Entity:LookupBone("ValveBiped.Bip01_Head1"))
        icon:SetLookAt(headpos - Vector(0, 0, 1))
        icon:SetCamPos(headpos - Vector(-20, 0, 0)) -- Move cam in front of face
        icon.angx = 0.5
        icon.angy = 0.5
        icon:NoClipping(true)
        local mmX, mmY = ScrW() / 2, ScrH() / 2

        function icon:PreDrawModel(Entity)
            render.SetScissorRect(0, 0, 0, 0, false)

            return true
        end

        function icon:LayoutEntity(Entity)
            if input.IsMouseDown(MOUSE_LEFT) and self:IsHovered() then
                icon.angx = Lerp(FrameTime() * 30, icon.angx, (gui.MouseX() / ScrW() - 0.5) + 0.5)
                icon.angy = Lerp(FrameTime() * 30, icon.angy, (gui.MouseY() / ScrH() - 0.5) + 0.5)
            end

            if input.IsMouseDown(MOUSE_LEFT) and input.IsMouseDown(MOUSE_RIGHT) and self:IsHovered() then
                CHARACTER_CREATION_PANEL:Remove()
            end

            icon.Entity:ManipulateBoneAngles(icon.Entity:LookupBone("ValveBiped.Bip01_Head1"), Angle(0, Lerp(icon.angy, 22, -22), Lerp(icon.angx, -45, 45)))
 
            return
        end

        local HairBodx = CreateFalloutCombo(SkinPanel, function(a, b, s)
         
            local b = TRAITS[b].id
			   Payload.trait = b
            cam.Start2D()
            local x, y = ScrW() * 0.5 - 316, ScrH() - 116
            surface.DrawRect(x, y, 600, 100)
            x = x + 4
            draw.DrawText("Trait: " .. (b or ""), "$MAIN_Font32", x, y, Color(0, 0, 0), TEXT_ALIGN_LEFT)
            draw.DrawText((TRAIT_UID[b].desc), "$MAIN_Font32", x, y + 42, Color(25, 25, 35), TEXT_ALIGN_LEFT)
            cam.End2D()
        end, 0.75, -180)

        HairBodx.Paint = function(s, w, h)
            draw.DrawText("Trait: " .. (Payload.trait or ""), "$MAIN_Font16", w / 2, 4, Color(0, 0, 0), TEXT_ALIGN_CENTER)
        end

        HairBodx.OnSelect = function(self, index, value)
            self.ids = value
            Payload.trait = index
        end

        for i, v in pairs(TRAITS) do
            HairBodx:AddChoice(v.id, v.id)
        end

        localUpdate()
        CHARACTER_CREATION_PANEL:MakePopup()
        local CreateButton = vgui.Create("DButton", SkinPanel)
        CreateButton:SetText("Create")
        CreateButton:Dock(BOTTOM)
        CreateButton:SetTall(64)

        function CreateButton:DoClick()
            Payload.charData = data
            Payload.model = icon:GetModel()

            for i, v in pairs(_G_SPECIAL) do
                Payload[i] = v
            end

            net.Start("halo_server2Client, Create", true)
            net.WriteTable(Payload)
            net.SendToServer()
        end
    end

    surface.CreateFont("TOP_BAR_BUTTON", {
        font = "Raleway",
        extended = false,
        size = 24,
        weight = 400,
    })

    surface.CreateFont("TIME_FONT", {
        font = "Lato",
        extended = false,
        size = 24,
        weight = 400,
    })

    surface.CreateFont("TIME_FONT_BOLD", {
        font = "Lato",
        extended = false,
        size = 24,
        weight = 800,
    })

    if UI_INGAMEMENU and IsValid(UI_INGAMEMENU) then
        UI_INGAMEMENU:Remove()
        UI_INGAMEMENU = nil
    end

    MENU_ACCENT = Color(0x40, 0xdc, 0xff)
    MENU_ACCENT = pip_color
    MENU_ACCENT_BLACK = Color(24, 24, 24)

    surface.CreateFont("TheDefaultSettings", {
        font = "Arial", --  Use the font-name which is shown to you by your operating system Font Viewer, not the file name
        extended = false,
        size = 13,
        weight = 500,
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

    FALLOUT_ALASKA_LOGO_WHITE = Material("materials/alaska_white_64.png", "Smooth")
    local meta = FindMetaTable("Panel")
    local DEBUG_draw_outlnie = true

    function meta:AttachDebug()
        if DEBUG_draw_outlnie then
            function self:PaintOver(w, h)
                surface.SetDrawColor(MENU_ACCENT)
                surface.DrawOutlinedRect(0, 0, w, h)
                surface.DrawLine(0, 0, w, h)
                surface.DrawLine(w, 0, 0, h)
            end
        end
    end
        vgui.Register("nutCharacterCreation", PANEL, "EditablePanel")
    local PANEL = {}

    function PANEL:Init()
        if UI_INGAMEMENU and IsValid(UI_INGAMEMENU) then
            UI_INGAMEMENU:Remove()
            UI_INGAMEMENU = nil
        end

        net.Receive("nutCharList", function()
            local newCharList = {}
            local length = net.ReadUInt(32)

            for i = 1, length do
                newCharList[i] = net.ReadUInt(32)
            end

            local oldCharList = nut.characters
            nut.characters = newCharList

            if (oldCharList) then
                hook.Run("CharacterListUpdated", oldCharList, newCharList)
            else
                hook.Run("CharacterListLoaded", newCharList)
            end
        end)

        UI_INGAMEMENU = self
        UI_INGAMEMENU:SetPos(0, 0)
        UI_INGAMEMENU:SetSize(ScrW(), ScrH())
        UI_INGAMEMENU:MakePopup()
        nut.gui.character = UI_INGAMEMENU
        local MAIN_MENU = UI_INGAMEMENU
        MAIN_MENU.FADE_SPEED = 0.3

        function MAIN_MENU:setFadeToBlack(fade)
        end

        function MAIN_MENU:onCharacterSelected(character)
            if (self.choosing) then return end
            if (character == LocalPlayer():getChar()) then return end
            nutMultiChar:chooseCharacter(character)
            print("REMOVED CHARACTER SELECT")
            MAIN_MENU:Remove()
        end

        function UI_INGAMEMENU:OnKeyCodePressed(key)
            if (key == KEY_F1) then
                self:Remove()
            end
        end

        function UI_INGAMEMENU:Paint(w, h)
            surface.SetDrawColor(24, 24, 24, 255)
            surface.DrawRect(0, 0, w, h)
        end

        function UI_INGAMEMENU:hoverSound()
            LocalPlayer():EmitSound(unpack(SOUND_CHAR_HOVER))
        end

        function UI_INGAMEMENU:clickSound()
            LocalPlayer():EmitSound(unpack(SOUND_CHAR_CLICK))
        end

        function UI_INGAMEMENU:warningSound()
            LocalPlayer():EmitSound(unpack(SOUND_CHAR_WARNING))
        end

        UI_INGAMEMENU.Topbar = vgui.Create("DPanel", UI_INGAMEMENU)
        UI_INGAMEMENU.Topbar:Dock(TOP)
        UI_INGAMEMENU.Topbar:SetTall(64)
        UI_INGAMEMENU.ANIM_SPEED = 0.1
        UI_INGAMEMENU.FADE_SPEED = 0.5

        function UI_INGAMEMENU.Topbar:Paint(w, h)
            surface.SetDrawColor(24, 24, 24, 255)
            surface.DrawRect(0, 0, w, h)
        end

        local topbar_buttons = {
            {
                "CREATE", function()
                    vgui.Create("nutCharacterCreation")
                end
            },
            {"CHARACTERS", function() end},
         
           
        }
		if LocalPlayer():getChar() ~=  nil then 
			table.insert(topbar_buttons,{
                "CLOSE", function()
                    UI_INGAMEMENU:Remove()
                end
            })
			end
        local FalloutButton = UI_INGAMEMENU.Topbar:Add("DButton")
        FalloutButton:Dock(LEFT)
        FalloutButton:SetText("")
        FalloutButton:SetWide(64 * 2)
        FalloutButton:SetFont("TOP_BAR_BUTTON")
        FalloutButton:SetTextColor(color_white)

        function FalloutButton:Paint(w, h)
            surface.SetDrawColor(MENU_ACCENT)
            surface.SetMaterial(FALLOUT_ALASKA_LOGO_WHITE)
            surface.DrawTexturedRect(2, 2, w - 4, h - 4)
        end

        for i, v in pairs(topbar_buttons) do
            local button = UI_INGAMEMENU.Topbar:Add("DButton")
            button:Dock(LEFT)
            button:SetText(v[1])
            button:SetWide(64 * 2.5)
            button:SetFont("TOP_BAR_BUTTON")
            button:SetTextColor(color_white)
            button.progress = 0
            button.DoClick = v[2]

            function button:Paint(w, h)
                button.progress = Lerp(FrameTime() * 60, button.progress, self:IsHovered() and 1 or 0)
                surface.SetFont(button:GetFont())
                local widthOftext, heightofText = surface.GetTextSize(button:GetText())
                widthOftext = widthOftext + 6
                widthOftext = widthOftext * button.progress
                surface.SetDrawColor(MENU_ACCENT)
                surface.DrawRect(w / 2 - (widthOftext / 2), 42, widthOftext, 4)
            end
        end

        UI_INGAMEMENU.body = UI_INGAMEMENU:Add("DPanel")
        UI_INGAMEMENU.body:Dock(FILL)

        function UI_INGAMEMENU.body:Paint(w, h)
        end

        local INFO = UI_INGAMEMENU.body:Add("DPanel")
        INFO:Dock(FILL)
        local Time = UI_INGAMEMENU.body:Add("DPanel")
        Time:Dock(TOP)

        function Time:Paint(w, h)
            surface.SetDrawColor(MENU_ACCENT)
            surface.DrawRect(0, 0, w, h)
            draw.SimpleText("14:29 | Sunday, 15 December 1985", "TIME_FONT", w / 2, h / 2, Color(24, 24, 24), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end

        Time:SetTall(32)

        for i, v in pairs(nut.characters) do
            local char = nut.char.loaded[v]
            local Player = INFO:Add("DPanel")
            Player:Dock(LEFT)
            Player:SetWide(350)
            Player:DockMargin(0, 3, 3, 2)

            function Player:Paint(w, h)
                surface.SetDrawColor(24, 24, 24, 255)
                surface.DrawRect(0, 0, w, h)
                surface.SetDrawColor(MENU_ACCENT)
                surface.DrawRect(0, 0, w, 32)
                draw.SimpleText(char:getName(), "TIME_FONT", w / 2, 16, Color(24, 24, 24), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            end

            local PlayerMdl = Player:Add("DModelPanel")
            PlayerMdl:Dock(TOP)
            PlayerMdl:DockMargin(0, 32, 0, 0)

            timer.Simple(1, function()
                if IsValid(PlayerMdl) then
                    PlayerMdl:SetTall(Player:GetTall() / 2)
                end
            end)

            timer.Simple(0.5, function()
                if IsValid(PlayerMdl) then
                    PlayerMdl:SetTall(Player:GetTall() / 2)
                end
            end)

            timer.Simple(1 / 30, function()
                if IsValid(PlayerMdl) then
                    PlayerMdl:SetTall(Player:GetTall() / 2)
                end
            end)

            timer.Simple(FrameTime(), function()
                if IsValid(PlayerMdl) then
                    PlayerMdl:SetTall(Player:GetTall() / 2)
                end
            end)

            -- disables default rotation
            function PlayerMdl:LayoutEntity(Entity)
                Entity:SetAngles(Angle(0, -45, 0))

                return Angle(0, 25, 0)
            end

            PlayerMdl:SetModel(char:getModel()) -- you can only change colors on playermodels
            PlayerMdl:SetFOV(49)
            TRANSFORM_LOCALLY_BG(PlayerMdl.Entity, char:getApperance())
            PlayerMdl.Entity:ApplyMorph(char:getApperance())
            local ent = PlayerMdl.Entity

            function PlayerMdl:PostDrawModel(m)
				local inc = m:LookupBone("ValveBiped.Bip01_Head1")
				if inc == nil then return end 
                local headpos = m:GetBonePosition(inc)
                self:SetLookAt(headpos - Vector(0, 0, 0))
                self:SetCamPos(headpos - Vector(-30, 0, 0)) -- Move cam in front of face
                self:SetFOV(45)

                for i, v in pairs(m.parts or {}) do
                    if IsValid(v) then
                        local c = v.col or Vector(1, 1, 1)
                        render.SetColorModulation(c.r, c.g, c.b)
                        v:DrawModel()
                    end
                end
            end

            local PlayerInfo = Player:Add("DPanel")
            PlayerInfo:Dock(FILL)

            local function DrawPlayerInfoBox(texta, textb, x, y)
                surface.SetFont("TIME_FONT_BOLD")
                local WIDTHOFBOX = select(1, surface.GetTextSize(texta))
                surface.DrawRect(x, y - 10, WIDTHOFBOX + 2, 24)
                draw.SimpleText(texta, "TIME_FONT_BOLD", x, y, MENU_ACCENT_BLACK, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
                draw.SimpleText(textb, "TIME_FONT", x + WIDTHOFBOX + 8, y, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
            end

            function PlayerInfo:Paint(w, h)
                surface.DrawRect(8, 4, w - 16, 4)
                DrawPlayerInfoBox("CAPS", "" .. char:getMoney(), 8, 54)
                DrawPlayerInfoBox("LEVEL", char:getSkillLevel("level"), 8, 24)
                DrawPlayerInfoBox("RADIATION", (char:getData("rads", 0) or 0) * 0.25, 8, 84)
            end

            local button = Player:Add("DButton")
            button:Dock(BOTTOM)
            button:DockMargin(4, 4, 4, 4)
            button:SetTall(22)
            button:SetText("")

            function button:Paint()
                surface.SetDrawColor(MENU_ACCENT)
                surface.DrawRect(0, 0, self:GetWide(), self:GetTall())
                draw.SimpleText("DELETE", "TIME_FONT_BOLD", self:GetWide() / 2, self:GetTall() / 2, Color(24, 24, 24), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            end

            button.DoClick = function(s)
                local id = char:getID()

                vgui.Create("nutCharacterConfirm"):setMessage(L("Deleting a character cannot be undone.")):onConfirm(function()
                    Player:Remove()

                    timer.Simple(1, function()
                        vgui.Create("nutCharacter")
                    end)

                    nutMultiChar:deleteCharacter(id)
                end)
            end

            button = Player:Add("DButton")
            button:Dock(BOTTOM)
            button:DockMargin(4, 4, 4, 4)
            button:SetTall(42)
            button:SetText("")

            function button:Paint()
                surface.SetDrawColor(MENU_ACCENT)
                surface.DrawRect(0, 0, self:GetWide(), self:GetTall())
                draw.SimpleText("PLAY", "TIME_FONT_BOLD", self:GetWide() / 2, self:GetTall() / 2, Color(24, 24, 24), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            end

            button.DoClick = function(s)
                s.id = char:getID()
                if (MAIN_MENU.choosing) then return end

                if (LocalPlayer():getChar() ~= nil and s.id == LocalPlayer():getChar():getID()) then
                    return MAIN_MENU:Remove()
                else
                    MAIN_MENU:onCharacterSelected(s.id)
                end
            end
            --[[
    hook.Remove("PlayerBindPress", nut.plugin.list.f1menu)

hook.Add("PlayerBindPress", nut.plugin.list.f1menu, function(a, client, bind, pressed)
    if (bind:lower():find("gm_showhelp") and pressed) then
        if (LocalPlayer():getChar()) then
            CreateF1Menu()
        end

        return true
    end
end)
]]
        end
    end

    -----------------------------------------------
    vgui.Register("nutCharacter", PANEL, "EditablePanel") --CreateF1Menu()

    timer.Create("check_menu", 5, 0, function()
        if not (IsValid(UI_INGAMEMENU)) and LocalPlayer().getChar and LocalPlayer():getChar() == nil then
            vgui.Create("nutCharacter")
        end
    end)


end

hook.Add("InitializedPlugins", "MORPHUS_OVERWRITE", CL_MORPHUS)
CL_MORPHUS()
--CL_CreateCharacterCreationMenu(male_character)

