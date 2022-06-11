--FONTS START

surface.CreateFont( "ty_buff_font_durationLeft", {
    font = "Arial",
    extended = false,
    size = 18,
    weight = 0,
    blursize = 0,
    scanlines = 0,
    antialias = true,

} )


surface.CreateFont( "ty_crafting_header", {
    font = "Arial",
    extended = false,
    size = 20,
    weight = 100,
    blursize = 0,
    scanlines = 0,
    antialias = true,

} )

surface.CreateFont( "ty_buff_font_Header", {
    font = "Arial",
    extended = false,
    size = 16,
    weight = 500,
    blursize = 0,
    scanlines = 0,
    antialias = true,

} )
surface.CreateFont( "ty_buff_font_Description", {
    font = "Arial",
    extended = false,
    size = 14,
    weight = 400,
    blursize = 0,
    scanlines = 0,
    antialias = true,

} )
--FONTS ENDS

local string, surface, math, Color = string, surface, math, Color

-- ICONS
local icons = {}
hook.Add("PostEffectCreation", "IconImage", function(v)




    if v["icon"] then
    if file.Exists( "materials/"..v.icon, "game" ) then
        icons[v.networkID] = Material( v.icon, "noclamp smooth" )
    end
end
-- end
end)
--

local _player = FindMetaTable( "Player" )
function _player:purgeEffects(SaveAfter, ForceClear, PersistCertainDrugs)
if (self.states) then
    local states = {}
    for i, v in pairs (self.states) do
        if v - _getTimeSystem() < 0 then
            table.remove(states, i)
        end
    end 
end  

end

local l_Player = LocalPlayer()
net.Receive( "PushBuff", function( len, ply )

l_Player = LocalPlayer()
l_Player.stacks = l_Player.stacks or {}
local EndTime, ID, Stacks = net.ReadUInt( 32 ), net.ReadUInt( 13 ), net.ReadUInt( 8 )
if l_Player.states == nil then l_Player.states = {} end
l_Player.states[ID] = EndTime
l_Player.stacks[ID] = Stacks or 1
end )

net.Receive( "DeleteAllBuffs", function( len, ply )
l_Player.states = {}
l_Player.stacks = {}
end)
net.Receive( "PushBuffs", function( len, ply )
print("hey")
l_Player.states = l_Player.states or {}
l_Player.stacks = l_Player.stacks or {}
if len > 1 then
    for i = 53, len, 53 do
        local EndTime, ID, Stacks = net.ReadUInt( 32 ), net.ReadUInt( 13 ), net.ReadUInt( 8 )
        if l_Player.states == nil then l_Player.states = {} end
        l_Player.states[ID] = EndTime
        l_Player.stacks[ID] = Stacks or 1
    end
end

end )
net.Receive( "pushBuffToUpdatedClient", function( len, ply )
l_Player.states = {}
l_Player.stacks = {}
if len > 1 then
    for i = 53, len, 53 do
        local EndTime, ID, Stacks = net.ReadUInt( 32 ), net.ReadUInt( 13 ), net.ReadUInt( 8 )
        if l_Player.states == nil then l_Player.states = {} end
        l_Player.states[ID] = EndTime
        l_Player.stacks[ID] = Stacks or 1
    end
end

end )

local function OutlinedBox( x, y, w, h, thickness, clr )
if clr then surface.SetDrawColor( clr ) end
for i = 0, thickness - 1 do
    surface.DrawOutlinedRect( x + i, y + i, w - i * 2, h - i * 2 )
end
end

local buffSize = 42
local padding = 3
local thickness = 1

local BUFF_OUTLINE_COLOR = Color(135, 185, 255)
local DEBUFF_OUTLINE_COLOR = Color(170, 81, 91)
local BUFF_FILL_COLOR = Color(65, 65, 55, 90)
local context_menu_offset = 0
hook.Add("OnContextMenuOpen", "context_menu_offset_open", function() context_menu_offset = 30 end)
hook.Add("OnContextMenuClose", "context_menu_offset_close", function() context_menu_offset = 0 end)

local function getTextSize(a)
local c, d = surface.GetTextSize( a ) return c, d, a
end

local function a(b, c)
local d = 0 b = b:gsub(".", function(e)d = d + surface.GetTextSize(e)
    if d >= c then
        d = 0 return"\n"..e end
    return e end)return b, d
end
local function t_wrap(b, c)
    local d, h = 0, surface.GetTextSize(' ')
    b = b:gsub("(%s?[%S]+)", function(i)local e = string.sub(i, 1, 1)
        if e == "\n"or e == "\t"then d = 0 end
        local j = surface.GetTextSize(i)d = d + j
        if j >= c then local k, l = a(i, c - (d - j))d = l return k
        elseif d < c then return i end
        if e == ' 'then d = j - h return'\n'..string.sub(i, 2)end
    d = j return'\n'..i end)
    return b
end

function SecondsToClock(a)local a = tonumber(a)if a <= 0 then return"00:00:00"else hours = string.format("%02.f", math.floor(a / 3600))mins = string.format("%02.f", math.floor(a / 60 - hours * 60))secs = string.format("%02.f", math.floor(a - hours * 3600 - mins * 60))return hours..":"..mins..":"..secs end end
local buffbox_width = 220
function drawBuffBox(x, y, n, duration, BUFF_OUTLINE_COLOR)
    local cc = 0
    surface.SetFont( "ty_buff_font_Description" )
    local _type = type(n.description)
    local desc = _type == "function" and n.description(l_Player.stacks[selectedDrug.networkID]) or n.description
    if _type == "table" then
        desc = desc[l_Player.stacks[selectedDrug.networkID] or 1]

    end
    local ndesc = t_wrap(desc, buffbox_width - 8)
    local ndesc_height = select( 2, surface.GetTextSize( " " ) )
    local offset = 0
    for s in ndesc:gmatch("[^\n]+") do
        cc = cc + 1
    end
    if not duration then cc = cc - 0.8 end
    surface.SetDrawColor(BUFF_FILL_COLOR.r, BUFF_FILL_COLOR.g, BUFF_FILL_COLOR.b)
    local x, y = ScrW() > (x + buffbox_width) and x or (x - buffbox_width), y
    surface.DrawRect( x, y, buffbox_width, 36 + (ndesc_height * cc) )
    OutlinedBox( ScrW() > (x + buffbox_width) and x or (x - buffbox_width), y, buffbox_width, 36 + (ndesc_height * cc), 1, BUFF_OUTLINE_COLOR )

    surface.SetTextColor( BUFF_OUTLINE_COLOR )

    surface.SetFont( "ty_buff_font_Header" )
    surface.SetTextPos( x + 4, y + 4 )
    surface.DrawText( n.name )
    local headerHeight = select( 2, surface.GetTextSize( " " ) )
    --, , )
    if duration then
        local time_string = SecondsToClock(duration)
        local with, height, ext = getTextSize(time_string)
        surface.SetTextPos( x + buffbox_width - with - 4, y + 36 + (ndesc_height * cc) - height - 2 )
        surface.DrawText( time_string )
    end
    surface.SetFont( "ty_buff_font_Description" )

    lines = {}


  

    for s in ndesc:gmatch("[^\n]+") do
        surface.SetTextPos( x + 4, y + 4 + headerHeight + offset )
        surface.DrawText( s )
        offset = offset + ndesc_height
    end

end

function draw_drug_effects()
    cam.Start2D()
    if !l_Player.getActiveBuffs then return end
    local buffs = l_Player:getActiveBuffs() 

    for i = 1, #buffs do
        local buff = get_buff(buffs[i].id)
        if buff and buff.draw then
            (type(buff.draw) == "table" and (buff.draw[l_Player.stacks[buffs[i].id]] or function() end) or buff.draw )(l_Player.stacks[buffs[i].id])
        end
    end
    cam.End2D()
end

function draw_drug_effects2()
    if !l_Player.getActiveBuffs then return end
    local buffs = l_Player:getActiveBuffs() 
    for i = 1, #buffs do
        local buff = get_buff(buffs[i].id)
        if buff and buff.drawVFX then
            (type(buff.drawVFX) == "table" and (buff.drawVFX[l_Player.stacks[buffs[i].id]] or function() end) or buff.drawVFX )(l_Player.stacks[buffs[i].id])
        end
    end
end


local blur = Material( "pp/blurscreen" )
local blurwater = Material( "models/shadertest/shader3" )

PrintTable( blurwater :GetKeyValues() )

function prepDrawBlur(x)
    surface.SetDrawColor( 255, 255, 255, a )
    surface.SetMaterial( x and blurwater or blur )
end


function drawBlur(b, c, d, e, f, g)local i = render.UpdateScreenEffectTexture;local j = render.SetScissorRect;for k = 1, f do
    blur:SetFloat("$blur", k / f * g)

    blur:Recompute()i()j(b, c, b + d, c + e, true)surface.DrawTexturedRect(0, 0, ScrW(), ScrH())j(0, 0, 0, 0, false)
end
end
function drawWater(b, c, d, e, f, g)local i = render.UpdateScreenEffectTexture;local j = render.SetScissorRect;for k = 1, f do
blurwater:SetVector("$color2", Vector(1, 1, 1))
blurwater:SetFloat("$refractamount", 0.02)

blurwater:Recompute()i()j(b, c, b + d, c + e, true)surface.DrawTexturedRect(0, 0, ScrW(), ScrH())j(0, 0, 0, 0, false)
blurwater:SetFloat("$refractamount", 0.25)
blurwater:Recompute()
end
end

local cur = 0
local cachedtemp = 150
local lookedEntity
mse_debounce = nil
local mse = gui.EnableScreenClicker
mouseclick = false
debounceClick = false
local doMouse = {["drug_stove"] = true, ["drug_refine"] = true}

hook.Add("HUDPaint", "clickHandler", function()

local ply = LocalPlayer()
local et = ply:GetEyeTraceNoCursor()
if et and IsValid(et.Entity) and doMouse[et.Entity:GetClass()] and et.Entity:GetPos():DistToSqr( l_Player:GetPos() ) <= 5000 then
if mse_debounce ~= ply:KeyDown( IN_SPEED ) then
    mse_debounce = ply:KeyDown( IN_SPEED )
    mse( ply:KeyDown( IN_SPEED ) )
end
else
if mse_debounce then
    mse_debounce = false
    mse( false )
end
end


if mouseclick ~= input.IsMouseDown( MOUSE_LEFT )then
mouseclick = input.IsMouseDown( MOUSE_LEFT )
if not mouseclick then
    debounceClick = false
end
print(mouseclick)
end
end)
function drawbutton(x, y, xx, yy, text, func, disable)
local _x, _y = input.GetCursorPos()
if not disable then
if _x >= x and _x <= x + xx and _y >= y and _y <= y + yy then
    surface.SetDrawColor( 55, 55, 55, 150 )
    if mouseclick and not debounceClick then
        func()
        debounceClick = true
    end
else
    surface.SetDrawColor( 0, 0, 0, 150 )
end
else surface.SetDrawColor( 0, 0, 0, 100 )
end
surface.DrawRect(x, y, xx, yy)
OutlinedBox( x, y, xx, yy, 1, disable and Color( 128, 128, 128, 255 ) or Color( 255, 255, 255, 255 ) )
draw.SimpleText(text, "ty_buff_font_durationLeft", x + (xx / 2), y + (yy / 2), disable and Color(128, 128, 128) or Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

end





function draw_ui_drugs()
l_Player = LocalPlayer()
local _x, _y = input.GetCursorPos()
local drugindex = 0
local duration_selected = 0
local doesTopRowExist = false
local drug_index_end = 0

for _ = 0, 1 do
local states = l_Player.getActiveBuffs and l_Player:getActiveBuffs(true, _ == 1) or {}

for i = 1, #states do
    -- CALC
    if _ == 0 then
        doesTopRowExist = true
    end
    local colSelect = _ == 0 and BUFF_OUTLINE_COLOR or DEBUFF_OUTLINE_COLOR
    local BoxStart = {ScrW() - (buffSize * i) - ((padding) * i * thickness) - ty_effects.client.Interface.BuffOffset[1]
    , ty_effects.client.Interface.BuffOffset[2] + context_menu_offset + (doesTopRowExist and (_ * (buffSize + 22)) or 0) }
    -- OUTLINE
    OutlinedBox(BoxStart[1],
    BoxStart[2], buffSize, buffSize, thickness, colSelect )
    -- Fill
    if !icons[(states[i].id)] then
        surface.SetDrawColor( BUFF_FILL_COLOR )
        surface.DrawRect(BoxStart[1] + thickness, BoxStart[2] + thickness, buffSize - (thickness * 2), buffSize - (thickness * 2))
    else
        surface.SetDrawColor( 255, 255, 255, 255 )
        surface.SetMaterial( icons[(states[i].id)] ) -- If you use Material, cache it!
        surface.DrawTexturedRect(BoxStart[1] + thickness, BoxStart[2] + thickness, buffSize - (thickness * 2), buffSize - (thickness * 2))

    end
    -- Duration Text

    if states[i].time ~= 0 then
        print(states[i].time , _getTimeSystem()
            )        local dur = math.floor(states[i].time - _getTimeSystem())


        local f_string_cur = ""
        if dur > 60 then
            f_string_cur = math.ceil(dur / 60) .. " m"

        else f_string_cur = dur+1 .. " s"
        end
        draw.SimpleTextOutlined(f_string_cur, "ty_buff_font_durationLeft", BoxStart[1] + ((buffSize - (thickness * 2)) * 0.5), BoxStart[2] + buffSize + 8, Color(0, 0, 0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, colSelect) end
        if (l_Player.stacks[states[i].id] or 1) > 1 then
            draw.SimpleTextOutlined(l_Player.stacks[states[i].id], "ty_buff_font_durationLeft", BoxStart[1] + ((buffSize - (thickness * 2)) * 1), BoxStart[2] + buffSize, Color(0, 0, 0), TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 1, colSelect) -- FILL
        end

        if (BoxStart[1] < _x) and (BoxStart[1] > (_x - buffSize)) and
        (BoxStart[2] < _y) and (BoxStart[2] > (_y - buffSize)) then

            drugindex = i
            if states[drugindex] then
                selectedDrug = get_buff(states[drugindex].id)
                duration_selected = math.floor(states[i].time - _getTimeSystem())

            end
        end
    end



    if drugindex > 0 then
        if debounce then
            debounce = false
        end

        drawBuffBox(_x, _y, selectedDrug, duration_selected > 0 and duration_selected or false, selectedDrug.IsDebuff == false and BUFF_OUTLINE_COLOR or DEBUFF_OUTLINE_COLOR)

    else debounce = true

    end
end
end

hook.Add( "PreDrawHUD", "draw_drug_effects", draw_drug_effects)
hook.Add( "RenderScreenspaceEffects", "draw_drug_effects", draw_drug_effects2)
hook.Add( "HUDPaint", "drugView", draw_ui_drugs)
hook.Call("ty_update_drug_index")
