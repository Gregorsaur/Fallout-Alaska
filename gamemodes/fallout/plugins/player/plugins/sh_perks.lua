PLUGIN.name = "perk"
PLUGIN.author = "EVVIVE"
PLUGIN.desc = "we love a good pay"


function PLUGIN:ScalePlayerDamage(client, hitGroup, dmgInfo)
	hook.Run("ScalePlyDmg",   ply, hitgroup, dmginfo) 
end

if true then
    if (SERVER) then
        local SQLITE_ALTER_TABLES = [[

            ALTER TABLE nut_characters ADD COLUMN _trait INT(32)

        ]]
        local MYSQL_ALTER_TABLES = [[

            ALTER TABLE nut_characters ADD COLUMN _trait INT(32) AFTER _attribs;

        ]]

        nut.db.waitForTablesToLoad():next(function()
            print("QUERY - CLASS")
            nut.db.query(SQLITE_ALTER_TABLES):catch(function() end)
        end):catch(function() end)
        --if (nut.db.module) then
        --nut.db.query(MYSQL_ALTER_TABLES)
        --else
    end
end

TRAITS = {}
TRAIT_ID = {}
TRAIT_UID = {}

function DEFINE_TRAITS_ID(i, id, desc, init, verify)
    TRAITS[i] = {
        ["id"] = id,
        ["uid"] = i,
        ["desc"] = desc,
        ["verify"] = verify or function() return true end,
        ["init"] = init or function() return true end,
    }

    TRAIT_UID[id] = TRAITS[i]
end

DEFINE_TRAITS_ID(1, "Hard Metabolism", "Food and Water drain twice as slow")
DEFINE_TRAITS_ID(2, "Hoarder", "+20 Carry Weight")

DEFINE_TRAITS_ID(3, "Small Frame", "+2 Agility", nil, function()
    local skill = (nut.gui.charCreate.context and nut.gui.charCreate.context.attribs and nut.gui.charCreate.context.attribs.agi) or 0
    return skill <= 8
end)

DEFINE_TRAITS_ID(4, "Heavy Handed", "15% more damage with melee and unarmed.")
DEFINE_TRAITS_ID(5, "Suave Negotiator", "Start with 20 Barter")
DEFINE_TRAITS_ID(6, "The Good Doctor", "Start with 20 Medicine")
DEFINE_TRAITS_ID(7, "Cannibalism", "Cannibalism is the act of consuming another individual of the same species as food.") -- Perk System TODO
DEFINE_TRAITS_ID(8, "Experienced", "Start with an extra perk point")
DEFINE_TRAITS_ID(9, "Cateyed", "+3 Perception while wearing Power Armor", nil, function()
    local skill = (nut.gui.charCreate.context and nut.gui.charCreate.context.attribs and nut.gui.charCreate.context.attribs.per) or 0
    return skill <= 8
end)
DEFINE_TRAITS_ID(10, "Brainiac", "+2 Intelligence", nil, function()
    local skill = (nut.gui.charCreate.context and nut.gui.charCreate.context.attribs and nut.gui.charCreate.context.attribs.int) or 0
    return skill <= 8
end)
DEFINE_TRAITS_ID(11, "Healthy", "+20 HP")
DEFINE_TRAITS_ID(12, "Stoic", "+5% Damage Resistance")

hook.Add("ScalePlayerDamage", "Stoic", function(ply, hitgroup, dmginfo)
    if (ply:getChar():getTrait() == 12) then
        dmginfo:ScaleDamage(0.95)
    end
end)

hook.Add("OnCharCreated", "AddSkills", function(client, char, data)
    local switch = (data.trait and data.trait+1) or 0
    print(switch, "DATA SWITCH ON CHAR CREATE")

    -- Carry Weight 
    if switch == 2 then
        char:getInv():setData("maxWeight", 70)
    elseif switch == 3 then
    elseif switch == 5 then
        -- Small Frame
        -- Start with 20 barter
        char:setSkillLevel("barter", 20)
    elseif switch == 6 then
        char:setSkillLevel("medicine", 20)
    elseif switch == 7 then
        
    elseif switch == 8 then
	char:setSkillLevel("perkpoints", 1)
    elseif switch == 9 then

    local c = "int" timer.Simple(5,function() char:addBoost("char", c, 2) end)
    elseif switch == 11 then
    end
end)
hook.Add("PlayerLoadedChar", "AddSkills", function(client, char, data)
timer.Simple(0, function()
    local switch = (data.trait and data.trait+1) or 0
    print(switch, "DATA SWITCH")

    -- Carry Weight 
    if switch == 3 then
    local c = "agi" char:addBoost("char", c, 2) client:getChar():updateAttrib(c, 0.0)

    elseif switch == 9 then

    local c = "per" char:addBoost("char", c, 2) client:getChar():updateAttrib(c, 0.0)
    elseif switch == 10 then
    local c = "int" char:addBoost("char", c, 2)  client:getChar():updateAttrib(c, 0.0)
    end
    end)
end)
-- Carry Weight 
-- Carry Weight 
-- Carry Weight 
nut.char.registerVar("trait", {
    field = "_trait",
    default = 0,
    isLocal = true,
	noDisplay = true
})

if CLIENT then
    local PANEL = {}

    local function computeDescMarkup(self, description)
        --  if (self.desc ~= description) then
        self.desc = description
        self.markup = nut.markup.parse("<font=Morton Medium@24>" .. "|     " .. TRAITS[self.trait].desc .. "</font>", ScrW() * 0.5)
        -- end

        return self.markup
    end

    function PAINT_B(self, s, w, h)
        local selected_trait = self:getContext("trait", 0)
        nut.util.drawBlur(s)
        s.p = Lerp(FrameTime() * 20, s.p, s:IsHovered() and 1 or 0)
        surface.SetDrawColor(0, 0, 0, 100)
        local canTake = TRAITS[s.trait].verify()

        if selected_trait == s.trait then
            surface.SetDrawColor(65, 153, 255, 100)

            if not canTake then
                self:setContext("trait", 0)
            end
        else
            local y = s:IsHovered() and 1 or 0
            surface.SetDrawColor(y * 65, y * 65, y * 80, 100)
        end

        function s.DoClick(n)
            self:setContext("trait", s.trait)
            PrintTable(nut.gui.charCreate.context)
        end

        if s:IsHovered() and input.WasMousePressed(MOUSE_LEFT) then end
        surface.DrawRect(0, 0, w, h)
        surface.SetFont("Morton Medium@24")
        local textLenX = surface.GetTextSize(TRAITS[s.trait].id)
        draw.SimpleText(TRAITS[s.trait].id, "Morton Medium@24", ((w - 16) / 2 - (textLenX / 2)) * (1 - s.p) + 16, h / 2, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

        if s.p > 0.05 then
            computeDescMarkup(s, "ni")

            if (s.markup) then
                s.markup:draw((w - textLenX) * (1 - s.p) + textLenX + 32, h / 2, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, alpha)
            end
        end
    end

    function PANEL:Init()
        self.title = self:addLabel("Select a trait")

        for i, v in pairs(TRAITS) do
            self[v] = self:Add("DButton")
            self[v]:SetFont("Morton Medium@24")
            self[v]:Dock(TOP)
            self[v]:DockMargin(0, 4, 0, 0)
            self[v]:SetTall(32)
            self[v]:SetText("")
            self[v].trait = v.uid
            self[v].p = 0

            self[v].Paint = function(s, w, h)
                PAINT_B(self, s, w, h)
            end
        end
    end

    function PANEL:onDisplay()
    end

    function PANEL:onFactionSelected(faction)
    end

    function PANEL:shouldSkip()
        --return #self.faction.Choices == 1
    end

    function PANEL:onSkip()
    end

    vgui.Register("nutCharacterTRAIT", PANEL, "nutCharacterCreateStep")

    hook.Add("ConfigureCharacterCreationSteps", "ADDTRAIT_CHART", function(self)
        self:addStep(vgui.Create("nutCharacterTRAIT"))
    end)
end