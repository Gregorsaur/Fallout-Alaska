local function REFRESH_PIPBOY() 
PIPBOY_ON_SCREEN = false
NzGUI = NzGUI or {}

concommand.Add("a", function()
    --[[
timer.Simple(1, function () vgui.GetHoveredPanel():Remove() end) 
timer.Simple(2, function () vgui.GetHoveredPanel():Remove() end) 
timer.Simple(3, function () vgui.GetHoveredPanel():Remove() end) ]]
    local character = nut.char.loaded[nut.characters[2]]
    local alsaka = Material("alaska.png")
    local alsakalogo = Material("alaska_f1.png", "smooth")

    if MAIN_MENU and IsValid(MAIN_MENU) then
        MAIN_MENU:Remove()
    end

    MAIN_MENU = vgui.Create("DPanel") 
    MAIN_MENU:SetSize(ScrW(), ScrH())
    MAIN_MENU:MakePopup()
    MAIN_MENU:Center() 

    MAIN_MENU.Paint = function(s, w, h) 
        surface.SetDrawColor(color_white)
        surface.SetMaterial(alsaka) 
        local x, y = input.GetCursorPos()
        local paralax_x = math.Clamp(1 - (x / ScrW()), 0, 1) 
        local paralax_y = math.Clamp(1 - (y / ScrH()), 0, 1)
        local size = 50
        surface.DrawTexturedRect(-size + (paralax_x * size), -size + (paralax_y * size), w + (size * 2), h + (size * 2))
        surface.SetMaterial(alsakalogo)
        surface.DrawTexturedRect(16, 16, 512, 200)
    end

    local icon = MAIN_MENU:Add("DModelPanel")
    icon:Dock(FILL)

    function icon:LayoutEntity(ent)
        ent:SetAngles(Angle(0, 25, 0))
        icon:RunAnimation()

        return
    end

    icon:SetFOV(45)
    icon:SetCamPos(Vector(50, 50, 35))

    function icon:PostDrawModel(m)
        for i, v in pairs(m.parts or {}) do
            if IsValid(v) then
                local c = v.col or Vector(1, 1, 1)
                render.SetColorModulation(c.r, c.g, c.b)
                v:DrawModel()
            end
        end
    end

    icon.angx = 0.5
    icon.angy = 0.5

    -- disables default rotation
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

    MAIN_MENU.FADE_SPEED = 0.3

    function MAIN_MENU:setFadeToBlack(fade)
    end

    function MAIN_MENU:onCharacterSelected(character)
        if (self.choosing) then return end
        if (character == LocalPlayer():getChar()) then return end
        nutMultiChar:chooseCharacter(character)
        MAIN_MENU:Remove()
    end

    local sidebar = MAIN_MENU:Add("DPanel")
    sidebar:Dock(LEFT)
    sidebar.Paint = function() end
    sidebar:SetWide(ScrW() * 0.2)
    local sidebar = MAIN_MENU:Add("DPanel")
    sidebar:Dock(RIGHT)
    sidebar:SetWide(ScrW() * 0.2)
    local Label = sidebar:Add("DPanel")
    Label:Dock(TOP)
    Label:SetTall(128)
    local Confirm = icon:Add("DButton")
    Confirm:Dock(BOTTOM)
    Confirm:DockMargin(386, 0, 386, 42)
    Confirm:SetTall(42)
    Confirm:SetText("")

    Confirm.Paint = function(self, w, h)
        surface.SetDrawColor(124, 167, 255, self:IsHovered() and 255 or 200)
        surface.DrawRect(0, 0, w, h)
        draw.SimpleText("PLAY", "Morton Medium@32", w / 2, 6, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
    end

    function MAIN_MENU:fadeOut()
        self:AlphaTo(0, 0.25, 0, function()
            self:Remove()
        end)
    end

    Confirm.DoClick = function(s)
        if (MAIN_MENU.choosing) then return end

        if (s.id == LocalPlayer():getChar():getID()) then
            return MAIN_MENU:fadeOut()
        else
            MAIN_MENU:onCharacterSelected(s.id)
        end
    end

    local Create = sidebar:Add("DButton")
    Create:Dock(BOTTOM)
    Create:SetTall(42)
    Create:SetText("")

    Create.Paint = function(self, w, h)
        surface.SetDrawColor(124, 167, 255, self:IsHovered() and 255 or 200)
        surface.DrawRect(0, 0, w, h)
        draw.SimpleText("CREATE", "Morton Medium@32", w / 2, 6, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
    end

    Create.DoClick = function(s)
        CL_CreateCharacterCreationMenu()
    end

    for i, v in pairs(nut.characters) do
        local Char = sidebar:Add("DButton")
        Char:Dock(TOP)
        Char:SetTall(64)
        Char:SetText("")
        Char.char = nut.char.loaded[v]
        Char.id = v

        function Char:Paint(w, h)
            surface.SetDrawColor(255, 100, 100, self:IsHovered() and 100 or 255)
            surface.DrawRect(0, 0, w, h)
            draw.SimpleText(self.char:getName(), "Morton Medium@32", 8, 8, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
            draw.SimpleText("LEVEL " .. self.char:getSkillLevel("level"), "Morton Medium@24", 8, 34, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
        end
 
        function Char:DoClick()
            Confirm.id = self.id
            icon:SetModel(self.char:getModel())
            icon.Entity:SetAngles(Angle(0, 0, 0))
            icon.Entity:ApplyMorph(self.char.vars.apperance, true)
         
            icon:SetLookAt(headpos - Vector(0, 0, 0))
            icon:SetCamPos(headpos - Vector(-35, 0, 0)) -- Move cam in front of face
            icon:SetFOV(45)
        end

        if i == 2 then
            Char:DoClick()
        end
    end
end)

hook.Add("InitializedPlugins", "RemoveFogFromFOMP", function()
    local GAMEMODE = GAMEMODE or GM

    function GAMEMODE:SetupWorldFog()
        render.FogMode(MATERIAL_FOG_NONE)

        return true
    end
end)

local function charWrap(text, remainingWidth, maxWidth)
    local totalWidth = 0

    text = text:gsub(".", function(char)
        totalWidth = totalWidth + surface.GetTextSize(char)

        -- Wrap around when the max width is reached
        if totalWidth >= remainingWidth then
            -- totalWidth needs to include the character width because it's inserted in a new line
            totalWidth = surface.GetTextSize(char)
            remainingWidth = maxWidth

            return "\n" .. char
        end

        return char
    end)

    return text, totalWidth
end

function textWrap(text, font, maxWidth)
    local totalWidth = 0
    surface.SetFont(font)
    local spaceWidth = surface.GetTextSize(' ')

    text = text:gsub("(%s?[%S]+)", function(word)
        local char = string.sub(word, 1, 1)

        if char == "\n" or char == "\t" then
            totalWidth = 0
        end

        local wordlen = surface.GetTextSize(word)
        totalWidth = totalWidth + wordlen

        -- Wrap around when the max width is reached
        -- Split the word if the word is too big
        if wordlen >= maxWidth then
            local splitWord, splitPoint = charWrap(word, maxWidth - (totalWidth - wordlen), maxWidth)
            totalWidth = splitPoint

            return splitWord
        elseif totalWidth < maxWidth then
            return word
        end

        -- Split before the word
        if char == ' ' then
            totalWidth = wordlen - spaceWidth

            return '\n' .. string.sub(word, 2)
        end

        totalWidth = wordlen

        return '\n' .. word
    end)

    return text
end

-- concatenate a space to avoid the text being parsed as valve string
local function safeText(text)
    return string.match(text, "^#([a-zA-Z_]+)$") and text .. " " or text
end

function draw.DrawNonParsedText(text, font, x, y, color, xAlign)
    return draw.DrawText(safeText(text), font, x, y, color, xAlign)
end

function draw.DrawNonParsedSimpleText(text, font, x, y, color, xAlign, yAlign)
    return draw.SimpleText(safeText(text), font, x, y, color, xAlign, yAlign)
end

function draw.DrawNonParsedSimpleTextOutlined(text, font, x, y, color, xAlign, yAlign, outlineWidth, outlineColor)
    return draw.SimpleTextOutlined(safeText(text), font, x, y, color, xAlign, yAlign, outlineWidth, outlineColor)
end

function surface.DrawNonParsedText(text)
    return surface.DrawText(safeText(text))
end

function chat.AddNonParsedText(...)
    local tbl = {...}

    for i = 2, #tbl, 2 do
        tbl[i] = safeText(tbl[i])
    end

    return chat.AddText(unpack(tbl))
end

local convarName = "flaska"
local falloutColor = CreateConVar("fallout_" .. convarName .. "_pipboy_color", "64 220 255", FCVAR_ARCHIVE)
local falloutnegativeColor = CreateConVar("fallout_" .. convarName .. "_pipboy_negt_color", "255 100 100", FCVAR_ARCHIVE)

local function StringToColor(id)
    r = {}
    local s = (id or falloutColor):GetString()
    local delimiter = " "

    for match in (s .. delimiter):gmatch("(.-)" .. delimiter) do
        table.insert(r, match)
    end

    return Color(r[1], r[2], r[3])
end

pip_color = pip_color or StringToColor()
pip_color_negative = StringToColor(falloutnegativeColor)

cvars.AddChangeCallback("fallout_" .. convarName .. "_pipboy_color", function(convar_name, value_old, value_new)
    pip_color = StringToColor()
    pip_color_20 = Color(pip_color.r, pip_color.g, pip_color.b,50)
    pip_color_accent = Color(pip_color.r * 0.8, pip_color.g * 0.8, pip_color.b * 0.8)
    pip_color_negative = StringToColor(falloutnegativeColor)
end)

cvars.AddChangeCallback("fallout_" .. convarName .. "_pipboy_negt_color", function(convar_name, value_old, value_new)
    pip_color = StringToColor()
    pip_color_20 = Color(pip_color.r, pip_color.g, pip_color.b,50)
    pip_color_accent = Color(pip_color.r * 0.8, pip_color.g * 0.8, pip_color.b * 0.8)
    pip_color_negative = StringToColor(falloutnegativeColor)
end)

local RGBMODE = false

if RGBMODE then
    hook.Add("HUDPaint", "RGB", function()
        pip_color = HSVToColor(CurTime() * 36, 1, 1)
        pip_color_accent = Color(pip_color.r * 0.8, pip_color.g * 0.8, pip_color.b * 0.8)
    end)
else
    hook.Remove("HUDPaint", "RGB")
end

local list = file.Find("tablet/*.lua", "LUA")
tablet = {}
tablet.pages = {}

for _, f in pairs(list) do
    include("tablet/" .. f)
end

local left, right = -450, 437
local top, bottom = -296, 335
local scx, scy = 0, 0
local cursors = Material("tabletcursor.png", "smooth")
local color_white = Color(255, 255, 255)
local color_black = Color(0, 0, 0)
NzGUI.ColorShadow = Color(0, 0, 0)

function NzGUI.DrawText(txt, x, y, c)
    surface.SetTextColor(c or pip_color)
    surface.SetTextPos(x, y)
    surface.DrawText(txt)
end

function NzGUI.DrawShadowText(txt, x, y, c, centered)
    surface.SetTextColor(NzGUI.ColorShadow)
	local width,height = surface.GetTextSize(txt) 
	x = x - (centered and (width/2) or 0)
    surface.SetTextPos(x + 2, y + 2)
	
	
    surface.DrawText(txt)
    NzGUI.DrawText(txt, x , y, c)
end
function NzGUI.DrawTextRight(txt, x, y,wth,col)
	local width,height = surface.GetTextSize(txt) 
	x = x + wth - width
     surface.SetTextColor(NzGUI.ColorShadow)
    surface.SetTextPos(x + 2, y + 2)
    surface.DrawText(txt)
    
    NzGUI.DrawText(txt, x , y, c)
end
function CreateFont(name, size, we)
    surface.CreateFont(name .. "@" .. size, {
        font = name,
        extended = false,
        size = size,
        weight = we or 600,
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

    surface.CreateFont(name .. "!" .. size, {
        font = name,
        extended = false,
        size = size,
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
end

CreateFont("Morton Medium", 82)
CreateFont("Morton Medium", 72)
CreateFont("Morton Medium", 24)
CreateFont("Morton Medium", 32)
CreateFont("Morton Medium", 19)
CreateFont("Morton Medium", 64)
CreateFont("Morton Medium", 48)
CreateFont("Morton Medium", 42)
CreateFont("Morton Medium", 92)
CreateFont("Morton Black", 42)

local headerUnderscorePos = {-360, -220, -75, 70, 204, 340}

local tri_size = 6
tablet.TransitionPos = 0
tablet.TargetPos = 0

tablet.PosHandler = function()
    tablet.TransitionPos = Lerp(FrameTime() * 12, tablet.TransitionPos, tablet.TargetPos)

    return tablet.TransitionPos
end

tablet.Transparency = 0

tablet.GetTransparency = function()
    tablet.Transparency = Lerp(FrameTime() * 12, tablet.Transparency, 1)

    return tablet.Transparency
end

tablet.Selected = "INV"

function ChangeTabletToPage(n)
end

tablet.Inventory = nil
local drawHeader
local dirt_overlay = Material("tablet_scartch.png", "noclamp smooth")
--[[If you get a divorce in Alabama,
	are you still brother and sister]]
local suffix____ = "nm2gg4"
local tex_name = "RenderTargetTexture_Textur3" .. suffix____
local mat_name = mat_name or "RenderTargetTexture_Material2" .. suffix____
local WIDTH, HEIGHT = 1024, 774
tex = GetRenderTargetEx(tex_name, WIDTH, HEIGHT, RT_SIZE_NO_CHANGE, MATERIAL_RT_DEPTH_SHARED, 0, 0, IMAGE_FORMAT_RGBA8888)

local myMat = CreateMaterial(mat_name, "UnlitGeneric", {
    ["$basetexture"] = tex:GetName(),
    ["$translucent"] = "0",
    ["$model"] = "1",
    ["$selfillum"] = 1,
})
doDrawBackground = false
local holographic = CreateMaterial(mat_name.."e", "UnlitGeneric", {
    ["$basetexture"] = tex:GetName(),

	["$translucent"] = 1,
	["$vertexcolor"] = 1,
    ["$additive"] = 0,
})


local vm
local wave = Material("decals/lambdaspray_2a")
wave:SetTexture("$basetexture", "null")
local drawDirty = false
local screenMat = Material("fnvh.png", "noclamp smooth")
pip_color = Color(100, 255, 100)
pip_color = Color(255, 182, 66)
pip_color = StringToColor()
pip_color_accent = Color(pip_color.r * 0.8, pip_color.g * 0.8, pip_color.b * 0.8)
pip_color_20 = Color(pip_color.r, pip_color.g, pip_color.b,50)
local cur_icon = Material("pip_cursor.png", "smooth")

cursor = {
    x = 0,
    y = 0
}

local cursor_sens = 0.3
cursor.Pressed = false
cursor.WaitingForRelease = false

function cursor:IsReady()
    return cursor.WaitingForRelease == false
end

function cursor:CheckStatePost()
end

local shadow = Color(0, 0, 0, 255)

function surface.DrawShadow(x, y, w, h, c)
    surface.SetDrawColor(shadow)
    surface.DrawRect(x, y, w + 2, h + 2)
    surface.SetDrawColor(c)
    surface.DrawRect(x, y, w, h)
end

hook.Add("InputMouseApply", "LockToPitchOnly", function(ccmd, x, y, angle)
    local lply = LocalPlayer()
    local awep = lply:GetActiveWeapon()
    local left, right, bottom, top = 0, WIDTH, HEIGHT, 0

    if lply and PIPBOY_ON_SCREEN then
        cursor.x, cursor.y = math.Clamp(cursor.x + (x * cursor_sens), left, right), math.Clamp(cursor.y + (y * cursor_sens), top, bottom)
        ccmd:SetViewAngles(angle)

        return true
    end
end)

function DrawCursor()
    surface.SetDrawColor(pip_color)
    surface.SetMaterial(cur_icon)
    surface.DrawTexturedRect(cursor.x, cursor.y, 16, 22)
end

function AddUIButton_implementation(x, y, width, height, PardonMouseUP)
end

local uiButtonCheck = Color(255, 100, 100)
local IsLeftMouseDown = false

function CheckIfCursorInRange(x, y, width, height)
    --surface.DrawOutlinedRect(x, y, width, height)
    return cursor.x > x and cursor.x < width + x and cursor.y > y and cursor.y < height + y
end

function AddUIButton(x, y, width, height, PardonMouseUP)
    PardonMouseUP = PardonMouseUP or false
    local isCursorIn = CheckIfCursorInRange(x, y, width, height)
    --  surface.SetDrawColor(isCursorIn and uiButtonCheck or pip_color)
    local weIN = false

    if isCursorIn and IsLeftMouseDown and cursor:IsReady() then
        weIN = true

        --	surface.SetDrawColor(0,0,255)
        if PardonMouseUP == false then
            cursor.WaitingForRelease = true
        end
    end
    -- surface.DrawOutlinedRect(x, y, width, height)
    -- surface.SetDrawColor(pip_color)

    return isCursorIn, weIN
end

function NzGUI:DrawTextButton(txt, font, x, y, width, height, align, col)
    local n, yy = AddUIButton(x, y, width, height)
    draw.DrawText(txt, font, x + (align == 0 and (width / 2) or 0), y, col, align == 0 and TEXT_ALIGN_CENTER or TEXT_ALIGN_LEFT)

    return yy, n
end

function NzGUI:DrawTextButtonWithDelayedHover(txt, font, x, y, width, height, align, col)
    local n, yy = AddUIButton(x, y, width, height)

    return n, yy, function(ow)
        draw.DrawText(txt, font, x + (align == 0 and (width / 2) or 0), y, ow or col, (align == 0 and TEXT_ALIGN_CENTER) or TEXT_ALIGN_LEFT)
    end
end

function NzGUI:DrawTextButtonWithHover(txt, font, x, y, width, height, align, col)
    local n, yy = AddUIButton(x, y, width, height)
    draw.DrawText(txt, font, x + (align == 0 and (width / 2) or 0), y, col, (align == 0 and TEXT_ALIGN_CENTER) or TEXT_ALIGN_LEFT)

    return n, yy
end

pipboy = pipboy or {}
local headers = {}

function pipboy:AddHeader(header)
    table.insert(headers, header)
end

function pipboy:AddRenderPage(header, data)
    tablet.pages[header] = data
end

pipboy:AddHeader("STATS")
pipboy:AddHeader("INV")
pipboy:AddHeader("RADIO")
pipboy:AddHeader("INFO")
pipboy:AddHeader("MAP")
pipboy:AddHeader("CHARACTERS")

hook.Run("pipboy_headers")
pipboy.SelectedHeader = "STATS"

hook.Add("HUDPaint", "mute", function()
    local player = LocalPlayer()
    player:StopSound("items/flashlight1.wav")
    player:StopSound("player/geiger1.wav")
    player:StopSound("player/geiger2.wav")
    player:StopSound("player/geiger3.wav")
end)
local xPos = 25
---local framerate = 1 / 5
---local nexttime = CurTime()
hook.Add("Move", "uihud_halo", function()
    if not PIPBOY_ON_SCREEN then return end
	if pipboy.SelectedHeader == "CHARACTERS" then 
	pipboy.SelectedHeader = "STATS"
	      hook.Run("pip_changepage", not PIPBOY_ON_SCREEN and pipboy.SelectedHeader, PIPBOY_ON_SCREEN and pipboy.SelectedHeader)
	TogglePipboyView()
	drawHeader("STATS")
	vgui.Create("nutCharacter")
	end
    --if nexttime > CurTime() then return end
    --nexttime = CurTime() + framerate
    render.PushRenderTarget(tex)
    render.OverrideAlphaWriteEnable(true, true)
    render.Clear(0, 0, 0, 0, true)
    cam.Start2D()


	    surface.SetDrawColor(100, 100, 100)
    surface.SetMaterial(screenMat)
    surface.DrawTexturedRect(0, 0, WIDTH, HEIGHT)
	
    surface.SetDrawColor(255, 255, 255)

    -- End the 3D2D context
    --drawFooter() 
    if tablet.pages[pipboy.SelectedHeader] then
        tablet.pages[pipboy.SelectedHeader](pip_color)
    end

    drawHeader() -- Draws Header
    DrawCursor()

    -- LEAVE HERE PLS
    if not IsLeftMouseDown then
        cursor.WaitingForRelease = false
    end

    cam.End2D()
    surface.SetDrawColor(255, 255, 255, 1)
    surface.SetMaterial(dirt_overlay)
    surface.DrawTexturedRect(0, 0, 2000, 1200)
    render.PopRenderTarget()
    --frame:PaintManual()
    render.OverrideAlphaWriteEnable(true, true)
end)


local XWidth = 105
local padding_header_x = 90
local desiredX = padding_header_x

function CHANGE_PIP_BOY_PAGE(page)
    local padding = (WIDTH - 120) / #headers
    local prevTextWidthOffset = padding_header_x
    surface.SetFont("Morton Medium@42")

    for i, v in pairs(headers) do
        local xP = prevTextWidthOffset
        local width, height = surface.GetTextSize(v)
        prevTextWidthOffset = width + xP + 30

        if page == v then
            desiredX = xP
            XWidth = width + 35
        end
    end

    hook.Run("pip_changepage", pipboy.SelectedHeader, page)
    pipboy.SelectedHeader = page
end

function drawHeader(select_index)
	if select_index == nil then select_index = -1 end
    surface.SetDrawColor(pip_color)
    local padding = (WIDTH - 120) / #headers
    local prevTextWidthOffset = padding_header_x

    for i, v in pairs(headers) do
        local xP = prevTextWidthOffset
        draw.DrawText(v, "Morton Medium@42", xP + 64, 8, pip_color, TEXT_ALIGN_)
        local width, height = surface.GetTextSize(v)
        prevTextWidthOffset = width + xP + 30
        local isIn, doOut = AddUIButton(xP + 64, 8, width, height)

        if doOut or v == select_index then
            desiredX = xP
            XWidth = width + 35
            CHANGE_PIP_BOY_PAGE(v)
            sound.PlayFile("sound/pipboy/ui_pipboyxsel.wav", "mono", function(channel)
                if (IsValid(channel)) then
                    channel:SetVolume(1 / 50)
                    channel:Play()
                end
            end)
        end

        if v == pipboy.SelectedHeader then
            --draw.DrawText( cursor.x,  "Morton Medium@42",WIDTH/2,HEIGHT/2,pip_color,TEXT_ALIGN_CENTER) 
            xPos = Lerp(FrameTime() * 20, xPos, desiredX)
        end
    end

    local cachedxp = xPos - 18
    surface.DrawRect(64, 42, cachedxp, 2)
    surface.DrawRect(cachedxp + 64, 28, 2, 16)
    surface.DrawRect(cachedxp + 64, 28, 12, 2)
    surface.DrawRect(cachedxp + XWidth + 64, 42, 960 - (cachedxp + XWidth + 64), 2)
    surface.DrawRect(cachedxp + XWidth + 64, 28, 2, 16)
    surface.DrawRect(cachedxp + XWidth + 52, 28, 12, 2)
end

local iconCaps = Material("icons/hud/caps.png", "smooth")

function PIP_DRAW_FOOTER()
    surface.SetDrawColor(pip_color)
    local inventory = LocalPlayer():getChar():getInv()
    surface.DrawLine(0, 700, 1300, 700)
    surface.DrawLine(0, 701, 1300, 701)
    local money = LocalPlayer():getChar():getMoney()
    surface.SetFont("Morton Medium@64")
    local moneyWidth = select(1, surface.GetTextSize(money))
    draw.DrawText(LocalPlayer():getChar():getMoney(), "Morton Medium@64", 125, 695, pip_color)
    surface.SetMaterial(iconCaps)
    surface.DrawTexturedRect(125 + moneyWidth + 24, 705, 48, 48)
    draw.NoTexture()
    -- draw.DrawText("12:00", "Morton Medium@72", 432, 274, pip_color, TEXT_ALIGN_RIGHT)
    draw.DrawText("WEIGHT :", "Morton Medium@64", 630, 695, pip_color, TEXT_ALIGN_RIGHT)
    draw.DrawText(inventory:getWeight() .. "/" .. inventory:getMaxWeight(), "Morton Medium@64", 900, 695, pip_color, TEXT_ALIGN_RIGHT)
    draw.NoTexture()
end

--hook.Add("PostRender", "drawinterface", function() end)
local offsetView = 0
local offsetDT = 0

function pip_init()






    cs_vm = IsValid(cs_vm) and cs_vm or ents.CreateClientside("cl_fakeVM")
  	print("CS_VM", cs_vm) 
    cs_vm:SetModel("models/weapons/c_arms.mdl")
    cs_arms = IsValid(cs_arms) and cs_arms or ents.CreateClientside("cl_fakeVM")
    cs_pip = IsValid(cs_pip) and cs_pip or ents.CreateClientside("cl_fakeVM")

    function cs_arms:GetPlayerColor()
        return LocalPlayer():GetPlayerColor()
    end

    net.Start("pipboy")
    net.SendToServer()

    net.Receive("pipboy", function()
        cs_pip:SetModel(net.ReadString())
        cs_pip:SetSubMaterial(1, net.ReadString() .. mat_name)
        local a, b = net.ReadString(), net.ReadString()
        local vm = cs_vm
        vm[a](vm, vm:LookupBone(net.ReadString()), Vector(53, 25, 0))
        vm[b](vm, vm:LookupBone(net.ReadString()), Angle(0, 150, 45))
        vm[b](vm, vm:LookupBone(net.ReadString()), Angle(0, -50, 45))
        vm[b](vm, vm:LookupBone(net.ReadString()), Angle(0, 5, 35))
        vm[b](vm, vm:LookupBone(net.ReadString()), Angle(-25, 0, 0))
      	print("FIXED BONE POS")
    end)
   

    local function applycs(self, vm)
        self:AddEffects(EF_BONEMERGE)

        if vm then
            self:SetParent(vm)
        end

        self:SetMoveType(MOVETYPE_NONE)
        self:SetNotSolid(true)
        self:DrawShadow(false)
    end

    cs_arms:SetNoDraw(true)
    cs_vm:SetNoDraw(true)
    cs_pip:SetNoDraw(false)
    applycs(cs_vm)
    applycs(cs_arms, cs_vm)
    cs_vm:SetSequence(6)
    local trace = LocalPlayer():GetEyeTrace()
    cs_vm:SetPos(vector_origin)
    cs_vm:SetAngles(angle_zero)
    local error_mat = Material("models/shadertest/shader3")
    local cxm = nil
    PrintTable(cs_vm:GetSequenceList())
    local _VEC_OFFSET = Vector()
    local LOWERED_ANGLES = Angle(-9, 35, 15)

    hook.Add("PreDrawViewModel", "aheXXAFGAGA", function(viewmodel, weapon)
      
        local miles = (1 - offsetDT) * 18
        local client = LocalPlayer()
        cs_vm:SetPos(client:GetViewModel():GetPos() - _VEC_OFFSET + (cs_vm:GetUp() * 4.5) + (cs_vm:GetForward() * 5) + (cs_vm:GetUp() * -miles))
        local cs_vm_ang = EyeAngles()
        cs_vm:SetAngles(cs_vm_ang)
        cs_pip:SetPos(cs_vm:GetPos() + (cs_vm:GetForward() * 10) + (cs_vm:GetUp() * -5))
        local ang = cs_vm:GetAngles()
        ang:RotateAroundAxis(cs_vm:GetForward(), 270)
        ang:RotateAroundAxis(cs_vm:GetRight(), 180)
        cs_pip:SetAngles(ang)
      
              if offsetDT > 0.00001 then
            cs_vm:SetupBones()
            cs_vm:DrawModel()
            cs_arms:DrawModel()
            cs_pip:DrawModel()
       
            render.SetLightingMode(0)
          end
       
    end)

    hook.Add("PostDrawViewModel", "aheXXAFGAGA", function(viewmodel, weapon)
        --

       -- end
    end)

    hook.Add("CalcViewModelView", "calcoffset", function(wep, vm, oldPos, oldAng, pos, ang)
        offsetDT = (Lerp(FrameTime() * 5, offsetDT, offsetView))
        local p = (offsetDT * -24)
        _VEC_OFFSET = (vm:GetUp() * p)
        if offsetDT > 0.001 then return oldPos + (vm:GetUp() * p), ang end
    end)

    hook.Add("KeyPress", ">unsureaboutthisone", function(ply, key)
        if (PIPBOY_ON_SCREEN) then return true end
    end)

    hook.Add("Think", "Pipboy_overwrite_input_listen", function()
        IS_R_DOWN = input.IsKeyDown(KEY_R)
    end)

    hook.Add("PlayerBindPress", "Pipboy_overwrite_input", function(ply, bind, pressed)
        if not pressed then return end

        if PIPBOY_ON_SCREEN then
            if bind == "+attack" then
                IsLeftMouseDown = true

                timer.Simple(0, function()
                    IsLeftMouseDown = false
                end)

                return true
            elseif bind == "+reload" then
                IsReloadUse = true
                IsReloadHold = true

                timer.Simple(0, function()
                    IsReloadUse = false
                end)

                return true
            elseif bind == "+use" then
                IsUseDown = true

                timer.Simple(0, function()
                    IsUseDown = false
                end)

                return true
            end
        end
    end)

    function TogglePipboyView(ChangePageTo)
        if IsValid(cs_arms) then
            cs_arms:SetModel(LocalPlayer():GetViewModel():GetModel())
        end 
 
        offsetView = tog and 1 or 0
        tog = not tog
        PIPBOY_ON_SCREEN = offsetView == 1
		if doDrawBackground == true then 
		offsetView = 0
		end
		net.Start("pipboy_toggle")
		net.WriteBool(PIPBOY_ON_SCREEN)
		
		net.SendToServer()
        clearinv()
        hook.Run("pip_changepage", not PIPBOY_ON_SCREEN and pipboy.SelectedHeader, PIPBOY_ON_SCREEN and pipboy.SelectedHeader)
        ui_hum[PIPBOY_ON_SCREEN and "Play" or "Pause"](ui_hum)

    end
	
	

	hook.Add("PlayerBindPress",nut.plugin.list["f1menu"],function(client, bind, pressed)

end)

	
end

hook.Add("Move", "keyLiwasten", function()
    if vgui.GetKeyboardFocus() == nil then
        if input.WasKeyPressed(KEY_I) then
            CHANGE_PIP_BOY_PAGE("INV")
            TogglePipboyView()
        end
    end
end)

concommand.Add("test", function()
    TogglePipboyView()
end)

ui_hum = ui_hum or nil

if ui_hum then
    ui_hum:Stop()
end
CreateClientConVar("fallout_simple_pipboy", "1", true, false)
hook.Add("HUDPaint", "pipboy", function()
doDrawBackground = GetConVar("fallout_simple_pipboy"):GetBool()
    if PIPBOY_ON_SCREEN and (GetConVar("simple_thirdperson_enabled"):GetBool() or doDrawBackground) then
		local wth,height = 1000,ScrH()
		height = height-100
		wth = height/4*5
		
		local x,y = (wth/4)+50, 50
		surface.SetDrawColor(0,0,0,50)  
		surface.DrawRect( x,y,wth,height)
        surface.SetDrawColor(color_white)
        surface.SetMaterial(holographic)
        surface.DrawTexturedRect(x,y,wth,height)
    end
end)

sound.PlayFile("sound/pipboy/ui_hum.wav", "noblock noplay", function(channel)
    if (IsValid(channel)) then
        channel:EnableLooping(true)
        channel:SetVolume(.05)
        ui_hum = channel
    end
end)


offsetView = 0 -- make 0 to disable pipboy force lo ading
offsetDT = offsetView
PIPBOY_ON_SCREEN = offsetView == 1 -- set to 1 or 0 to disable pipboy, this is used for having the pipboy stay on lua refresh
if nut or NUT or Nut then pip_init() end
hook.Run("ReloadPipboy")
end
net.Receive( "pipboy_fix", function( len, ply )
REFRESH_PIPBOY()  
end )
REFRESH_PIPBOY()  

	hook.Add("PlayerBindPress", "1_pip_tab", function(ply, bind, pressed, num)

    if (bind:lower():find("gm_showhelp") ) and pressed then
       TogglePipboyView()
	   return true
    end
end)
