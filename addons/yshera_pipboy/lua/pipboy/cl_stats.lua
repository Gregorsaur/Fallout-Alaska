local function formattedText(text1, text2, x, y, font)
    font = font or "Morton Medium@48"
    surface.SetFont(font)
    draw.DrawText(text1, font, x, y, color_white)
    local width, _ = surface.GetTextSize(text1 .. " ")
    draw.DrawText(text2, font, x + width, y, pip_color)
end

local attribute_width = 400
local error_mat = Material("piboy5")

local function DrawHPBar(x, y, p, w)

    w = w or 52
    x = x - 35
    y = y + 100
    surface.SetDrawColor(pip_color)
    surface.DrawOutlinedRect(x, y, w + 8, 16)
    surface.DrawRect(x + 4, y + 4, w * p, 8)
    surface.SetDrawColor(pip_color_negative)
    surface.DrawRect(x + 4 + w * p, y + 4, (1 - p) * w, 8)
end 

local function AttributeDisplay(name, desc, progress, level, y, x)
    y = y + 7
    draw.DrawText(name, "Morton Medium@64", 80 + x, 0 + y, color_white)
    draw.DrawText(desc, "Morton Medium@19", 80 + x, 48 + y, color_white)
    draw.DrawText("LEVEL " .. level, "Morton Medium@48", 80 + x + attribute_width, 12 + y, pip_color, TEXT_ALIGN_RIGHT)
    draw.NoTexture()
    surface.SetDrawColor(color_white)
    -- Render stuff here bb 
    local offset24 = attribute_width * progress
    surface.DrawRect(81 + offset24 + x, 70 + y, attribute_width * (1 - progress), 11)
    surface.SetDrawColor(pip_color)
    surface.DrawRect(79 + x, 70 + y, attribute_width * progress, 11)
end

local DrawPly = {}

function DrawPly.STATS()
    local ply = LocalPlayer()
    local character = ply:getChar()
    --Draw Player Info
    formattedText("Name", character:getName():upper(), 64, 128)
    --formattedText("Faction", nut.faction.indices[character:getFaction()].name, 64, 128 + 32)
    formattedText("HP", LocalPlayer():Health() .. "/".. LocalPlayer():GetMaxHealth(), 64,128 + 64) 
	formattedText("HUNGER", ply:getLocalVar("hunger") .. "%", 64,128 + 128) 
	formattedText("THIRST", ply:getLocalVar("thirst").. "%", 64,256+64) 
	-- formattedText("AVO SYSTEM", "PAINKILLER", 64,128 + 96) 
    --local krma = character:getNetVar("karma", karmaTbl)
    --formattedText("KARMA", krma.title.. " "..krma.level, 64,200)
    -- DRAW ATTRIBUTES  


    --DRAW SEPERATORS
    surface.SetDrawColor(pip_color)
    surface.SetMaterial(error_mat)
    surface.DrawTexturedRect(600, 200, 200, 300)
    DrawHPBar(685, 80,  1-(character:getData("hp_head", 0)/300))
    DrawHPBar(800, 200, 1-(character:getData("hp_arm_left", 0)/300))
    DrawHPBar(580, 200, 1-(character:getData("hp_arm_right", 0)/300))
    DrawHPBar(800, 350,  1-(character:getData("hp_leg_right", 0)/300))
    DrawHPBar(580, 350, 1-(character:getData("hp_leg_left", 0)/300))
end 



local attri = {"Strength", "Perception", "Endurance", "Charisma", "Intelligence", "Agility", "Luck"}

local attri_a = {"str", "per", "end", "cha", "int", "agi", "luc"}

local attri_desc = {"Strength is a measure of your raw physical power. It affects how much you can carry, and determines the effectiveness of all melee attacks.", 'Perception is your environmental awareness and "sixth sense," and allows you to see things other people may not see.', "Endurance is the measure of overall physical fitness. It affects your total health and the action point drain from sprinting", "Charisma is your ability to charm and convince others. It affects your success to persuade others in dialogue and prices when you barter. It also allows you to inspire people in your party increase everyones max health.", "Intelligence is the measure of your overall mental acuity, and increases the amount of experience points earned.", "Agility is a measure of your overall finesse and reflexes. It affects the number of Action Points and your ability to sneak. Decreases reload time.", "Luck is a measure of your general good fortune, and affects the recharge rates of critical hits."}

for i, v in pairs(attri_desc) do
    attri_desc[i] = textWrap(v, "Morton Medium@24", 350)
end

local attriIMG = {Material("vault_boy/str"), Material("vault_boy/per"), Material("vault_boy/end"), Material("vault_boy/chr"), Material("vault_boy/int"), Material("vault_boy/agi"), Material("vault_boy/luck")}

local color_black = Color(0, 0, 0)
local f = Material("vault_boy/agi")
local deltSt = 0 
function DrawPly.SPECIAL()
    local ply = LocalPlayer()
    local character = ply:getChar()

    for y, v in pairs(attri) do
        local fn, click, draww = NzGUI:DrawTextButtonWithDelayedHover(v, "Morton Medium@48", 64, 116 + (y * 44), 400, 40, 1, color_white)
        local c = pip_color

        if fn then
            c = color_black
            surface.SetDrawColor(pip_color)
            surface.DrawRect(64, 118 + (y * 44), (500 - 64), 42)

            if IS_R_DOWN then
                deltSt = deltSt == 0 and CurTime() or deltSt

                --  
                --  
                if (LocalPlayer():getChar():getSkillLevel("specialpoints") or 1) - 1 > 0 then
                    local p = math.Clamp((CurTime() - deltSt) * 0.75, 0.01, 1)
                    surface.SetDrawColor(pip_color.r * 0.5, pip_color.g * 0.5, pip_color.b * 0.5)
                    surface.DrawRect(64, 118 + (y * 44), (500 - 64) * p, 42)

                    if p == 1 then
                        IsReloadUse = false
                        netstream.Start("perkIncrease", v[1])
                        deltSt = 0
                    end
                else
                    deltSt = 0
                end
         
                
                      else
                    deltSt = 0
            end

            surface.SetMaterial(attriIMG[y])
            surface.SetDrawColor(pip_color)
            draw.DrawNonParsedText(attri_desc[y], "Morton Medium@24", 600, 400, pip_color, 0)

            if y == 1 then
                surface.DrawTexturedRect(626 + 42, 128, 150, 256)
            elseif y == 5 then
                surface.DrawTexturedRect(626 + 62, 138, 150, 200)
            else
                surface.DrawTexturedRect(626, 128, 256, 256)
            end
        end

        local iness = character:getAttrib(attri_a[y], 0)
        draw.DrawText(iness, "Morton Medium@48", 500, 116 + (y * 44), c, TEXT_ALIGN_RIGHT)
        draww(c)
    end
end

local skill_def = {
    {"big_guns", "Big Guns"},
    {"small_arms", "Small Guns"},
    {"energy_weps", "Energy Weapons"},
    {"explosives", "Explosives"},
    {"melee", "Melee Weapons"},
    {"unarmed", "Unarmed"},
    {"science", "Science"},
    {"medicine", "Medicine"},
    {"survival", "Survival"},
    {"barter", "Barter"},
}

local SELECTED_HEADER
local wth, ht = ScrW(), ScrH()
hook.Add("pip_changepage", "SKILLS_", function(from, to)
    if to == "STATS" then
hook.Add("HUDPaint", "SKILLS", function()
    if LocalPlayer():getChar() then
    else
        return
    end

    local amt = (LocalPlayer():getChar():getSkillLevel("skillpoints") or 1) - 1
    local amts = (LocalPlayer():getChar():getSkillLevel("specialpoints") or 1) - 1
	local amtss = (LocalPlayer():getChar():getSkillLevel("perkpoints") or 1) - 1
    if SELECTED_HEADER == "SKILLS" and PIPBOY_ON_SCREEN and amt > 0 then
        render.SetViewPort(ScrW() * 0.2, ScrH() * 0.775, wth, ht)
        local t = "[]"
        local n = "R [HOLD]) SPEND POINT ON SKILL (" .. amt .. ") "
        surface.SetFont("Morton Medium@48")
        local tw, th = surface.GetTextSize(t)
        t = "["
        surface.SetFont("Morton Medium@42")
        local twn, thn = surface.GetTextSize(n)
        surface.SetDrawColor(pip_color.r, pip_color.g, pip_color.b, 20)
        surface.DrawRect(0, 13, tw + twn, th - 16)
        surface.SetFont("Morton Medium@48")
        NzGUI.DrawShadowText(t, 0, 0, c)
        NzGUI.DrawShadowText("]", tw + twn - (tw / 2), 0, c)
        surface.SetFont("Morton Medium@42")
        NzGUI.DrawShadowText(n, 12, 6, c)
        render.SetViewPort(0, 0, wth, ht)
    elseif SELECTED_HEADER == "SPECIAL" and PIPBOY_ON_SCREEN and amts > 0 then
        render.SetViewPort(ScrW() * 0.2, ScrH() * 0.775, wth, ht)
        local t = "[]"
        local n = "R [HOLD]) SPEND POINT ON SPECIAL (" .. amts .. ") "
        surface.SetFont("Morton Medium@48")
        local tw, th = surface.GetTextSize(t)
        t = "["
        surface.SetFont("Morton Medium@42")
        local twn, thn = surface.GetTextSize(n)
        surface.SetDrawColor(pip_color.r, pip_color.g, pip_color.b, 20)
        surface.DrawRect(0, 13, tw + twn, th - 16)
        surface.SetFont("Morton Medium@48")
        NzGUI.DrawShadowText(t, 0, 0, c)
        NzGUI.DrawShadowText("]", tw + twn - (tw / 2), 0, c)
        surface.SetFont("Morton Medium@42")
        NzGUI.DrawShadowText(n, 12, 6, c)
        render.SetViewPort(0, 0, wth, ht)
    elseif SELECTED_HEADER == "PERKS" and PIPBOY_ON_SCREEN then
        render.SetViewPort(ScrW() * 0.2, ScrH() * 0.775, wth, ht)
        local t = "[]"
        local n = "R) OPEN PERK MENU (" .. amtss .. ") "
        surface.SetFont("Morton Medium@48")
        local tw, th = surface.GetTextSize(t)
        t = "["
        surface.SetFont("Morton Medium@42")
        local twn, thn = surface.GetTextSize(n)
        surface.SetDrawColor(pip_color.r, pip_color.g, pip_color.b, 20)
        surface.DrawRect(0, 13, tw + twn, th - 16)
        surface.SetFont("Morton Medium@48")
        NzGUI.DrawShadowText(t, 0, 0, c)
        NzGUI.DrawShadowText("]", tw + twn - (tw / 2), 0, c)
        surface.SetFont("Morton Medium@42")
        NzGUI.DrawShadowText(n, 12, 6, c)
        render.SetViewPort(0, 0, wth, ht)

        if IsReloadUse then
            CREATE_PERK_MENU()
        end
    end
end)
    else
        hook.Remove("HUDPaint", "SKILLS")
    end
end)



local cached_desc = nil

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

function DrawPly.SKILLS()
    local height = 36
    local width = 400
    local ply = LocalPlayer()
    local character = ply:getChar()

    for y, v in pairs(skill_def) do
        local fn, click, draww = NzGUI:DrawTextButtonWithDelayedHover(v[2]:upper(), "Morton Medium@42", 64, 116 + (y * height), width, height, 1, color_white)
        local c = pip_color

        if fn then
            c = color_black
            surface.SetDrawColor(pip_color)
            surface.DrawRect(64, 118 + (y * (height)), ((width + 100) - 64), height)
            local amt = (LocalPlayer():getChar():getSkillLevel("skillpoints") or 1) - 1

            if IS_R_DOWN and amt > 0 then
                deltSt = deltSt == 0 and CurTime() or deltSt
                --  
                --  
                local p = math.Clamp((CurTime() - deltSt) * 0.75, 0.01, 1)
                surface.SetDrawColor(pip_color.r * 0.5, pip_color.g * 0.5, pip_color.b * 0.5)
                surface.DrawRect(64, 118 + (y * (height)), ((width + 100) - 64) * p, height)

                if p == 1 then
                    IsReloadUse = false
                    netstream.Start("statIncrease", v[1])
                    deltSt = 0
                end
            else
                deltSt = 0
            end
        end

        draw.DrawText(character:getSkillLevel(v[1]), "Morton Medium@48", width + 100, 116 + (y * height), c, TEXT_ALIGN_RIGHT)
        draww(c)
    end
end

local headers = {"STATS", "SPECIAL", "SKILLS", "PERKS"}

local offset = {0, 102, 225, 335}

local offset2 = {100, 120, 100, 100}

SELECTED_HEADER = "STATS"

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
    surface.SetDrawColor(128, 128, 128, 2)
    surface.DrawRect(0, 700, 200, 48)
    surface.DrawRect(210, 700, 400, 48)
    surface.DrawRect(620, 700, 230, 48)
    surface.DrawRect(860, 700, 230, 48)
    draw.DrawText("LEVEL " .. LocalPlayer():getChar():getSkillLevel("level"), "Morton Medium@48", 214, 700, pip_color, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    surface.SetDrawColor(pip_color)
    surface.DrawOutlinedRect(350, 715, 244, 22)
    surface.DrawOutlinedRect(351, 716, 242, 20)
    surface.DrawRect(350, 715, 244 * (lb / ub), 22)
    formattedText("XP", lb .. "/" .. ub, 630, 700, "Morton Medium@42")
end

pipboy:AddRenderPage("STATS", draw_overview)
-- // local ply = LocalPlayer()
-- // local JawScale = Vector(1, 1, 1)
-- // local PlyPos = Vector(0, 0, 0)
-- // ply:ManipulateBoneScale(ply:LookupBone("skin_bone_R_EyeUnder"), JawScale)
-- // ply:ManipulateBoneScale(ply:LookupBone("skin_bone_R_EyeUnder"), JawScale)
-- // ply:ManipulateBonePosition(ply:LookupBone("skin_bone_R_EyeUnder"), PlyPos)
-- // ply:ManipulateBonePosition(ply:LookupBone("skin_bone_R_EyeUnder"), PlyPos)
tablet.pages["MAP"] = function(pip_color) end

if IsValid(icon) then
    icon:Remove()
end

SELECTED_HEADER =  "STATS"

print("MAP")
local mpp_texture = Material("alaska_map01.png", "smooth")

MAP_ICON_SETTLEMENT = Material("map_icons/settlement.png", "smooth")

--14303 14303 

MAP_LOCATIONS = {

{"The Store", Vector(-244.423615, -3355.505615, 92.031250),MAP_ICON_SETTLEMENT}

}
MAP_ZONE_TYPE_WARZONE = { Color(255,0,0,25) }

MAP_ZONES = {
{"FREE4ALL",MAP_ZONE_TYPE_WARZONE, util.JSONToTable('[{"y":118.43226227534807,"x":562.4651077926608},{"y":118.03404185579342,"x":589.1908673825369},{"y":115.39816770686375,"x":603.6853898151413},{"y":112.80391262344355,"x":620.3225932822946},{"y":114.6097056523339,"x":643.2328405814881},{"y":120.39672050389498,"x":642.8041905630865},{"y":142.8898726461387,"x":641.1381460659081},{"y":163.2534320753849,"x":639.6298083558241},{"y":178.5575555495921,"x":641.9212290299331},{"y":190.9211015610624,"x":647.0196843564067},{"y":208.4650112325953,"x":649.1260834854015},{"y":226.890756302521,"x":647.7612920168067},{"y":240.40832688002213,"x":646.7600503933326},{"y":248.70051236735567,"x":646.1684582592161},{"y":254.8048336579157,"x":637.9454581787094},{"y":260.78230904588119,"x":606.0205260822395},{"y":253.91523511776973,"x":590.7617774527695},{"y":244.1922834370974,"x":579.1439482955591},{"y":236.4950325476906,"x":574.9705707442649},{"y":228.8116786404343,"x":572.2867460168374},{"y":214.57968337882606,"x":566.1634152121159},{"y":198.75864008924735,"x":565.1051510362356},{"y":182.83003894988657,"x":567.5592113270948},{"y":162.18880344108443,"x":567.3672892115332},{"y":118.32170938630924,"x":581.5302877537877},{"y":110.27042089646075,"x":579.8008083251549}]')	
 },
}
MAP_ZONES_DEBUG = MAP_ZONES_DEBUG or {}
print(util.TableToJSON( MAP_ZONES_DEBUG))

local map = {x = 100,y = 50, width = 800, height = 800}
function MAP_ZONE_OPTIMISE()  
	for i,a in pairs(MAP_ZONES) do 
		for c,v in pairs(a[2]) do 
			local playerPos = v
		local pX = ((playerPos.x+1000)/16303)/2+0.5
		local pY = 1-((playerPos.Y/16303)/2+0.5)
		print(pX,pY)
		a[2][c] =  {x= map.x + (map.width*pX),  y= map.y + (map.height*pY)}

	end
	end 
end 
print("==========")
concommand.Add("markpoint", function( ply, cmd, args )
		local playerPos = LocalPlayer():GetPos()
		local pX = ((playerPos.x+1000)/16303)/2+0.5
		local pY = 1-((playerPos.Y/16303)/2+0.5)

table.insert(MAP_ZONES_DEBUG, 
{x= map.x + (map.width*pX),  y= map.y + (map.height*pY)}
)
end)
concommand.Add("clearpoints", function( ply, cmd, args )
MAP_ZONES_DEBUG = {}
end)
-- MAP_ZONE_OPTIMISE() 
pipboy:AddRenderPage("MAP", function() 

	surface.SetMaterial(mpp_texture)
	surface.SetDrawColor(pip_color.r,pip_color.g,pip_color.b,75)
	
	
	surface.DrawTexturedRect(100,50,800,800)
		for i,v in pairs(MAP_ZONES) do 
 
	surface.SetDrawColor( v[2][1] )
	draw.NoTexture()
	surface.DrawPoly( v[3] )

	end
	surface.SetDrawColor(pip_color.r,pip_color.g,pip_color.b,255)
	local playerPos = LocalPlayer():GetPos()
	local pX = ((playerPos.x+1000)/16303)/2+0.5
	local pY = 1-((playerPos.Y/16303)/2+0.5)

	surface.DrawRect(map.x + (map.width*pX) - 4,map.y + (map.height*pY) -4,8,8)
	
	
	
	for i,v in pairs(MAP_LOCATIONS) do 
	local playerPos = v[2] 
	local pX = ((playerPos.x+1000)/16303)/2+0.5
	local pY = 1-((playerPos.Y/16303)/2+0.5)
	surface.SetMaterial(v[3])
	surface.DrawTexturedRect(map.x + (map.width*pX) - 16,map.y + (map.height*pY) -16,32,32)
	end
	
		surface.SetDrawColor(pip_color.r + 50,pip_color.g + 50,pip_color.b + 50,255)
		
		
		
	--surface.SetDrawColor( 0,255,0, 100 )
	--draw.NoTexture()
	--surface.DrawPoly( MAP_ZONES_DEBUG )

end)

--[[
skin_bone_C_MasterMouth
skin_bone_L_MouthCorner
skin_bone_L_MouthBot
skin_bone_L_MouthTop
skin_bone_C_MouthBot
skin_bone_C_MouthTop
skin_bone_R_MouthBot
skin_bone_R_MouthCorner
skin_bone_R_MouthTop
skin_bone_L_Cheek
skin_bone_C_MasterEyebrow
skin_bone_R_EyebrowIn
skin_bone_R_EyebrowOut
skin_bone_L_EyebrowIn
skin_bone_L_EyebrowOut
]]
--LocalPlayer():SetPlayerColor(Vector(1, 1.1, 1.3))

--[[  
LocalPlayer():SetSubMaterial(7, "models/kuma96/solesurvivor_vault111_female/vault111suit2.vmt")
LocalPlayer():SetPlayerColor(Vector(1, 1, 1))
local vm = LocalPlayer():GetViewModel(0)
vm:SetSubMaterial(9, "models/kuma96/solesurvivor_vault111_female/vault111suit2.vmt")

function vm:GetPlayerColor()
    return LocalPlayer():GetPlayerColor()
end

if IsValid(icon) thenx
    icon:Remove()
end]]
function CREATE_PERK_MENU()
    if IsValid(PerkPanel) then
        PerkPanel:Remove()
    end

    PerkPanel = vgui.Create("DPanel")
    PerkPanel:SetPos(10, 30) -- Set the position of the panel
    PerkPanel:SetSize(1000, 720) -- Set the size of the panel
    PerkPanel:Center()
    PerkPanel:MakePopup() -- Makes your mouse be able to move around.
    local close = PerkPanel:Add("DButton")
    close:SetSize(48, 48)
    close:SetText("X")
    close:SetFont("Morton Medium@48")
    close:SetPos(950, 0)
    close:SetZPos(100)

    close.DoClick = function()
        PerkPanel:Remove()
    end

    close:SetTextColor(pip_color)
    close.Paint = function() end

    function PerkPanel:Paint(w, h)
        Derma_DrawBackgroundBlur(self, 0)
        surface.SetDrawColor(pip_color.r * 0.5, pip_color.g * 0.5, pip_color.b * 0.5, 150)
        surface.DrawRect(0, 0, w, h)
        self:NoClipping(true)
        surface.DrawShadow(0, 0, 64, 4, pip_color)
        surface.DrawShadow(256, 0, w - 255, 4, pip_color)
        surface.SetFont("Morton Medium@48")
        NzGUI.DrawShadowText("PERKS", 120, -24, pip_color)
        surface.DrawShadow(0, 4, 4, h - 6, pip_color)
        surface.DrawShadow(0, h - 6, w, 4, pip_color)
        surface.DrawShadow(w - 4, 0, 4, h - 2, pip_color)
    end

    local formatString = {
        ["str"] = "Strength",
        ["agi"] = "Agility",
        ["per"] = "Perception",
        ["luc"] = "Luck",
        ["int"] = "Intelligence",
        ["cha"] = "Charisma",
        ["end"] = "Endurance",
        level = "Level"
    }

    local DScrollPanel = vgui.Create("DScrollPanel", PerkPanel)
    DScrollPanel:Dock(LEFT)
    DScrollPanel:SetWide(400)
    DScrollPanel:DockMargin(7, 24, 7, 7)
    local scrollbar = DScrollPanel.VBar

    function scrollbar:PerformLayout()
        local Wide = self:GetWide()
        local BtnHeight = 0

        if (self:GetHideButtons()) then
            BtnHeight = 0
        end

        local Scroll = self:GetScroll() / self.CanvasSize
        local BarSize = math.max(self:BarScale() * (self:GetTall() - (BtnHeight * 2)), 10)
        local Track = self:GetTall() - (BtnHeight * 2) - BarSize
        Track = Track + 1
        Scroll = Scroll * Track
        self.btnGrip:SetPos(0, BtnHeight + Scroll)
        self.btnGrip:SetSize(Wide, BarSize)

        if (BtnHeight > 0) then
            self.btnUp:SetPos(0, 0, Wide, Wide)
            self.btnUp:SetSize(0, 0)
            self.btnDown:SetPos(0, self:GetTall() - BtnHeight)
            self.btnDown:SetSize(Wide, 0)
            self.btnUp:SetVisible(true)
            self.btnDown:SetVisible(true)
        else
            self.btnUp:SetVisible(false)
            self.btnDown:SetVisible(false)
            self.btnDown:SetSize(Wide, BtnHeight)
            self.btnUp:SetSize(Wide, BtnHeight)
        end
    end

    local sbar = DScrollPanel:GetVBar()
    sbar.btnUp:SetVisible(false)

    function sbar:Paint(w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 100))
    end

    function sbar.btnGrip:Paint(w, h)
        draw.RoundedBox(0, 0, 0, w, h, pip_color)
    end

    local RightPanel = PerkPanel:Add("DPanel")
    RightPanel:Dock(FILL)
    RightPanel:DockMargin(0, 24, 0, 0)
    RightPanel.Header = ""
    local _VVV = nil

    local function computeDescMarkup(self, description, w)
        --  if (self.desc ~= description) then
        self.body = "<font=Morton Medium@32>" .. description .. "</font>"
        self.body = self.body .. "<font=Morton Medium@42>" .. "\nRequirements\n" .. "</font>"

        for i, v in pairs(self.requirements) do
            local isValid = CheckSkill({i, v})

            local display = formatString[i] or i

            if isValid then
                self.body = self.body .. "<font=Morton Medium@42><color=255,255,255>✓  " .. display .. " " .. v .. " </color>\n"
            else
                self.body = self.body .. "<font=Morton Medium@42><color=255,35,35>✗  " .. display .. " " .. v .. " </color>\n"
            end
        end

        -- self.body = self.body .. "<font=Morton Medium@42><color=255,255,255> ✓5 SCIENCE </color>\n"
        self.body = self.body .. "</font>"
        self.markup = nut.markup.parse(self.body, w - 20)
        -- end

        return self.markup
    end

    function RightPanel:Paint(w, h)
        if RightPanel.Ready then
            surface.SetFont("Morton Medium@48")
            NzGUI.DrawShadowText(self.Header, 0, 00, pip_color)

            if self.v.image then
                surface.SetDrawColor(pip_color)
                surface.SetMaterial(self.v.image)
                surface.DrawTexturedRect(w * 0.25, 50, w * 0.5, 240)
            end

            computeDescMarkup(self.v, self.v.desc, w)

            if (self.v.markup) then
                self.v.markup:draw(0, 280, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, alpha)
            else
                computeDescMarkup(self.v, self.v.desc, w)
                self.v.markup:draw(0, 280, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, alpha)
            end
        end
    end

    local Unlock = RightPanel:Add("DButton")
    Unlock:Dock(BOTTOM)
    Unlock:SetTall(32)
    Unlock:SetText("")

    Unlock.PaintOver = function(self, w, h)
        surface.SetFont("Morton Medium@32")
        NzGUI.DrawShadowText("UNLOCK", w / 2 - 32, 0, self.col)
    end

    local function ApplyFocus(v, i)
        v = (v or _VVV)
        if not IsValid(RightPanel) then return end
        RightPanel.Header = v.display
        RightPanel.v = v
        RightPanel.id = i
    end

    local PERK_SELECTED_ID = 0

    local function SetFocus(v, i)
        _VVV = v
        PERK_SELECTED_ID = i or 0
    end

    Unlock.DoClick = function()
        netstream.Start("unlockPerk", PERK_SELECTED_ID)
    end

    local doonce = true

    for i, v in pairs(PERKS) do
        local values = LocalPlayer():getChar():getData("p" .. v.bitmaskIndex) or 0
        local isOwned = bit.band(values, v.bitmaskCalc) == v.bitmaskCalc

        timer.Simple(isOwned and 0 or FrameTime() * 2, function()
            if doonce then
                doonce = false
                SetFocus(v, i)
                ApplyFocus(v, i)

                if IsValid(RightPanel) then
                    RightPanel.Ready = true
                end
            end

            local DButton = DScrollPanel:Add("DButton")
            DButton:Dock(TOP)
            DButton:SetTall(32)
            DButton:SetColor(pip_color)
            DButton:SetFont("Morton Medium@32")
            DButton:SetText("")

            DButton.PaintOver = function(self, w, h)
                local values = LocalPlayer():getChar():getData("p" .. v.bitmaskIndex) or 0
                local isOwned = bit.band(values, v.bitmaskCalc) == v.bitmaskCalc

                if DButton.Calced == nil then
                    local weCanDoThis = true

                    for _c, _v in pairs(v.requirements) do
                        local isValid = CheckSkill({_c, _v}, ply)

                        if not isValid then
                            weCanDoThis = false
                        end
                    end

                    DButton.Calced = weCanDoThis
                end

                local prefix = "" -- weCanDoThis and not isOwned and " + " or ""
                DButton.col = (isOwned and pip_color or Color(255, 255, 255))
                NzGUI.DrawShadowText(prefix .. v.display, 4, 0, self.col) --.. "   \\ " .. i
            end

            DButton.DoClick = function()
                SetFocus(v, i)
            end

            function DButton:OnCursorEntered()
                ApplyFocus(v, i)
            end

            function DButton:OnCursorExited()
                ApplyFocus(nil)
            end

            DButton:DockMargin(0, 0, 6, 2)
        end)
    end
end

function proc_luck()
    surface.PlaySound("luck.wav") 
    local luckmat1 = Material("vault_boy/luckproc")

    timer.Simple(2, function()
        hook.Remove("HUDPaint", "LUCK")
    end)

    hook.Add("HUDPaint", "LUCK", function()
        surface.SetMaterial(luckmat1)
        luckmat1:SetInt("$frame", 4)
        surface.SetDrawColor(0, 0, 0)
        surface.DrawTexturedRect(ScrW() / 2 - 62, ScrH() - 254, 128, 128)
        surface.SetDrawColor(pip_color)
        surface.DrawTexturedRect(ScrW() / 2 - 64, ScrH() - 256, 128, 128)
    end)
end
hook.Add("InitializedPlugins", "InitializedPlugins_SV_POLK", function() netstream.Hook("luck", proc_luck) end )
if nut or NUT or Nut then 
   netstream.Hook("luck", proc_luck)
end


