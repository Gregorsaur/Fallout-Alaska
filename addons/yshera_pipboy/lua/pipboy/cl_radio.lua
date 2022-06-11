
local newfunc = math.sin

local songname = "NA"

local middleY = 230
local length = 300
local height = 200
local step = 2
local speed = 150
local slider = Material("pip_slid_O.png", "smooth noclamp")
local radio_vol = GetConVar("aftermath_cl_radio_volume")
local volIndicator = IsValid(radio_vol) and radio_vol:GetFloat() or 1

local startTime = CurTime() - 1   

local function video_killed_the_radio_star()
    if radio_vol == nil then 
    radio_vol = GetConVar("aftermath_cl_radio_volume")
    volIndicator = radio_vol and radio_vol:GetFloat() or 1
    end

    local volSlider = {
        [0] = 15,
        [75] = 15,
        [150] = 15,
        [225] = 15,
        [300] = 15,
    }
 
    if startTime < CurTime() then
        local theReturnedHTML = "" -- Blankness

        if EV_RAIDO_STATIONS_GET_SONG[EV_RADIO_GETINDEX()] then
            http.Post(EV_RAIDO_STATIONS_GET_SONG[EV_RADIO_GETINDEX()], {}, function(body, length, headers, code)
                -- onSuccess function
                -- The first argument is the HTML we asked for.
                songname = body
            end, function(message)
                -- onFailure function
                -- We failed. =(
                print(message)
            end, {
                -- header example
                ["accept-encoding"] = "gzip, deflate",
                ["accept-language"] = "fr"
            })
        else
            songname = "ERROR"
        end

        startTime = CurTime() + 3
    end

    local startX = 600
    local posOfBox = -6000
    for i, v in pairs(StationName) do
	
        surface.SetDrawColor(pip_color)
        local exists = i == EV_RADIO_GETINDEX()
        if exists then 
            surface.SetDrawColor(pip_color)
            surface.DrawRect(100, 105 + (48 * i), 420, 42, 42)
        end
        if NzGUI:DrawTextButton(string.upper(v), "Morton Medium" .. (exists and "!" or "@") .. "48", 100, 100 + (48 * i), 420, 42, 1, exists and pip_colorbb or (color_white), not exists and pip_color or color_white, exists and pip_color) then
            if i ~= EV_RADIO_GETINDEX() then
                EV_RADIO_PUBLIC_CON(i)
                songname = "Fetching..."
            else
                EV_RADIO_OFF()
            end
        
		end
    end

    local segmentWidth = radioFreq[EV_RADIO_GETINDEX()]
    if not segmentWidth then return end
    local time = CurTime()
    surface.SetDrawColor(pip_color)


    surface.DrawLine(startX + length, middleY - (height / 2), startX + length, middleY + (height / 2))
    surface.DrawLine(startX - 5, middleY + (height / 2), startX + length, middleY + (height / 2))
  -- draw.DrawText("Now Playing: ", "Morton Black@42", 100, 450)
  -- draw.DrawText(songname, "Morton Medium@42", 100, 480)
    draw.DrawText("Vol", "Morton Black@42", startX, 350)
    surface.DrawLine(startX, 400, startX + 300, 400)
    surface.SetMaterial(slider)
    surface.DrawTexturedRect(startX + (volIndicator * 300) - 8, 400 - 16, 18, 16)

    for i = 0, 300, 15 do
        surface.DrawLine(startX + i, 400, startX + i, 400 + (volSlider[i] or 8))
    end

    if CheckIfCursorInRange(startX + (volIndicator * 300) - 16, 385, 32, 30) and input.IsMouseDown(MOUSE_LEFT) then
        volIndicator = math.Clamp((cursor.x - startX) / 300, 0, 1)
        radio_vol:SetFloat(volIndicator)
    elseif CheckIfCursorInRange(startX, 397, 300, 6) and input.IsMouseDown(MOUSE_LEFT) then
        volIndicator = math.Clamp((cursor.x - startX) / 300, 0, 1)
        radio_vol:SetFloat(volIndicator)
    end
        local height = height * (radioHeight[EV_RADIO_GETINDEX()] or 1)
    for x = startX, startX + length, step do
        local y = newfunc((x + time * speed) / segmentWidth) * height / 2 + middleY
        local lastX = x - step
        local lastY = newfunc((lastX + time * speed) / segmentWidth) * height / 2 + middleY
        surface.DrawLine(lastX, lastY, x, y)
    end
end

--hook.Add("PlayerSpawn", "faww", function()

local tog = false

pipboy:AddRenderPage("RADIO", video_killed_the_radio_star)
-- end)

	HTMLWIN = vgui.Create("DHTML")
	HTMLWIN:Dock(FILL)
	 
	-- Wiki page URL
	local url = "http://ysora.studio/roll.html"
	
	-- Load the wiki page b
	HTMLWIN:OpenURL(url)
	
	-- Hide the HTMLWIN
	HTMLWIN:SetAlpha(0)
	HTMLWIN:SetMouseInputEnabled(false)
 
 

pipboy:AddRenderPage("Secret", function() 
if IsValid(HTMLWIN) then 
surface.SetMaterial(HTMLWIN:GetHTMLMaterial())
surface.DrawTexturedRect(-200, 0, 1800,1600) 
if IsUseDown then 
HTMLWIN:Call(tog and ' document.getElementById("video").play()' 
or ' document.getElementById("video").pause()' )
IsUseDown=false 
tog = not tog
end
end
end) 
if IsValid(HTMLWIN) then HTMLWIN:Remove() end



print"Loaded Screen"
--local PlyItems = player.GetAll()[1]:getChar():getInv():Add("potato", 1)    
local x, y = 100, 100
local width, height = 25, 25
local gridSize = 25
local framerate = 1 / 10
local direction = "RIGHT"

local canvasSize = {
    x = gridSize * 35,
    y = gridSize * 25
}

local directions = {
    [KEY_W] = "UP",
    [KEY_A] = "LEFT",
    [KEY_S] = "DOWN",
    [KEY_D] = "RIGHT",
}

local length = 3
local bodylocs = {}
local movementsqueued = {}

for i = 1, length do
    table.insert(bodylocs, {x, y})
end

local nextTime = CurTime() + 1 / 5
local firstTime = true
    local foodPos = {
        ["x"] = gridSize * 32,
        ["y"] = gridSize * 23
    } 
local function regenFoodLoc() 
            foodPos["x"] = math.random(0, 34) * gridSize
            foodPos["y"] = math.random(0, 24) * gridSize
            for i,v in pairs(bodylocs) do 
            if foodPos.x == v[1] and foodPos.y == v[2] then
            regenFoodLoc() 
            break
      end
   end
end
local function reset() 
    direction = "RIGHT"
            regenFoodLoc() 
            x, y = 100, 100
             length = 3
             bodylocs = {}
             movementsqueued = {}

            for i = 1, length do
                table.insert(bodylocs, {x, y})
            end
end
local function isCollideWithSelf()
    local isCollide = false
    if bodylocs[1][1] < 0 or bodylocs[1][1] > canvasSize.x-gridSize  or bodylocs[1][2] < 0 or bodylocs[1][2] > canvasSize.y-gridSize then 
    reset() 
    end
    for i, v in pairs(bodylocs) do
        if i ~= 1 and
             bodylocs[1][1] == v[1] and bodylocs[1][2] == v[2] then
        reset() 
            return true
            
        end

     
    end
       return false
end 
tablet.pages["snake"] = function(color_main)
    local oldW, oldH = ScrW(), ScrH()

    surface.SetDrawColor(pip_color)

    render.SetViewPort(128, 128, canvasSize.x, canvasSize.y)
    surface.DrawOutlinedRect(0, 0, canvasSize.x, canvasSize.y)

    if firstTime then
        firstTime = false
        regenFoodLoc()
    end

    for i, v in pairs(directions) do
        if input.WasKeyPressed(i) then
            if #movementsqueued <= 2 then
                table.insert(movementsqueued, v)
            end
        end
    end

    if nextTime < CurTime() then
        direction = movementsqueued[1] or direction

        if movementsqueued[1] then
            table.remove(movementsqueued, 1)
        end

        nextTime = CurTime() + framerate

        if direction == "UP" then
            y = y - gridSize
        elseif direction == "RIGHT" then
            x = x + gridSize
        elseif direction == "DOWN" then
            y = y + gridSize
        elseif direction == "LEFT" then
            x = x - gridSize
        end

        table.insert(bodylocs, 1, {x, y})

        table.remove(bodylocs, length + 1)

        if foodPos.x == x and foodPos.y == y then
            length = length + 1

            regenFoodLoc() 
        end
        isCollideWithSelf()
    end
    local transp = 600
    for i, v in pairs(bodylocs) do
        local n  = surface.GetDrawColor()
    local perc= 600/transp
    surface.SetDrawColor(n.r * perc,n.g* perc,n.b* perc,255)
        transp = transp - 1
        surface.DrawRect(v[1], v[2], width, height)
    end
    local n  = surface.GetDrawColor()
    local perc= 600/transp
    surface.SetDrawColor(pip_color)
    surface.DrawRect(foodPos.x + 6, foodPos.y + 6, 13, 13)
    render.SetViewPort(0, 0, oldW, oldH)
end

hook.Add("PlayerBindPress", "Minigames", function(ply, bind, pressed)
    if PIPBOY_ON_SCREEN and pipboy.SelectedHeader == "snake" then
        if bind == "+forward" then
            return true
        elseif bind == "+moveleft" then
            return true
        elseif bind == "+moveright" then
            return true
        elseif bind == "+back" then
            return true
        end
    end 
end)




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
    formattedText("NAME", character:getName():upper(), 64, 128)
    --formattedText("LEVEL", LocalPlayer():getChar():getLevel(), 64,200)
    --local krma = character:getNetVar("karma", karmaTbl)
    --formattedText("KARMA", krma.title.. " "..krma.level, 64,200)
    -- DRAW ATTRIBUTES  
    --[[AttributeDisplay(,0.154,2,500, 450)
AttributeDisplay(,500, 450)
AttributeDisplay(,500, 450)
AttributeDisplay(,500, 450)
]]
    --DRAW SEPERATORS
    surface.SetDrawColor(pip_color)
    surface.SetMaterial(error_mat)
    surface.DrawTexturedRect(630, 100, 200, 300)
    DrawHPBar(685, 80, 1)
    DrawHPBar(800, 200, 0.8)
    DrawHPBar(580, 200, 0.5)
    DrawHPBar(800, 350, 0.25)
    DrawHPBar(580, 350, 0)
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
            surface.SetMaterial(attriIMG[y])
            surface.SetDrawColor(pip_color)
            draw.DrawNonParsedText(attri_desc[y], "Morton Medium@24", 600, 400, pip_color, 0)

            if y == 1 then
                surface.DrawTexturedRect(626 + 42, 128, 150, 256)
                elseif          y == 5 then
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

hook.Add("HUDPaint", "SKILLS", function()
    local amt = (LocalPlayer():getChar():getSkillLevel("skillpoints") or 1) - 1

    if SELECTED_HEADER == "SKILLS" and PIPBOY_ON_SCREEN and amt > 0 then
        render.SetViewPort(ScrW() * 0.2, ScrH() * 0.775, wth, ht)
        local t = "[]"
        local n = "R [hold]) SPEND POINT ON SKILL (" .. amt .. ") "
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
        local n = "R) OPEN PERK MENU "
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

local deltSt = 0

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

SELECTED_HEADER = "SKILLS"

local draw_overview = function(pip_color2)
    for i, v in pairs(headers) do
        local vb, fn = NzGUI:DrawTextButton(v, "Morton Medium@48", 64 + offset[i], 64, offset2[i], 32, 1, v == SELECTED_HEADER and pip_color or pip_color_accent)

        if vb then
            if v == "PERKS" then 
            CREATE_PERK_MENU()
            else 
            SELECTED_HEADER = v
            end
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

pipboy:AddRenderPage("INFO", function() draw.DrawText("VTP://Connection Failed, Faulty Pipboy Connection", "Morton Medium@48", 200, 350, pip_color, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER) 
draw.DrawText("COMING SOON", "Morton Medium@48", 500, 400, pip_color, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
end)
-- // local ply = LocalPlayer()
-- // local JawScale = Vector(1, 1, 1)
-- // local PlyPos = Vector(0, 0, 0)
-- // ply:ManipulateBoneScale(ply:LookupBone("skin_bone_R_EyeUnder"), JawScale)
-- // ply:ManipulateBoneScale(ply:LookupBone("skin_bone_R_EyeUnder"), JawScale)
-- // ply:ManipulateBonePosition(ply:LookupBone("skin_bone_R_EyeUnder"), PlyPos)
-- // ply:ManipulateBonePosition(ply:LookupBone("skin_bone_R_EyeUnder"), PlyPos)


if IsValid(icon) then
    icon:Remove()
end

SELECTED_HEADER = "SKILLS" or "STATS"
