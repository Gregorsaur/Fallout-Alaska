







surface.CreateFont("$MAIN_Font", {
    font = "Roboto Condensed",
    extended = false,
    size = 42,
    weight = 500,
    blursize = 0,
    scanlines = 0,
})

surface.CreateFont("$MAIN_Font32", {
    font = "Roboto Condensed",
    extended = false,
    size = 32,
    weight = 500,
    blursize = 0,
    scanlines = 0,
    antialias = true,
})

surface.CreateFont("$MAIN_Font24", {
    font = "Roboto",
    extended = false,
    size = 24,
    weight = 0,
    blursize = 0,
    scanlines = 0,
    antialias = true,
})

surface.CreateFont("$MAIN_Font16", {
    font = "Roboto Bold",
    extended = false,
    size = 16,
    weight = 800,
    blursize = 0,
    scanlines = 0,
    antialias = true,
})

local grad_r = Material("vgui/gradient-d")

surface.CreateFont("$Bold_font", {
    font = "Roboto Bold",
    extended = false,
    size = 42,
    weight = 800,
    blursize = 0,
    scanlines = 0,
    antialias = true,
})

surface.CreateFont("$Bold_fontcs", {
    font = "Roboto Bold",
    extended = false,
    size = 22,
    weight = 800,
    blursize = 0,
    scanlines = 0,
    antialias = true,
})

surface.CreateFont("$Notify_Font", {
    font = "Roboto Condensed",
    extended = false,
    size = 24,
    weight = 400,
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



hook.Add( "CreateMove", "keypress_use_hi", function( cmd)
        local player = LocalPlayer()
        	local stamima = player:getLocalVar("stm", 0)
		if (player:GetMoveType() ~= MOVETYPE_NOCLIP and cmd:KeyDown(IN_JUMP)) and (stamima < 25) then
		
		
            	cmd:RemoveKey(IN_JUMP)
		
	
		
	end
    if  (stamima <= 0) and  cmd:KeyDown(IN_SPEED) then cmd:RemoveKey(IN_SPEED) -- run -speed to prevent rubber banding stamina 
        LocalPlayer():ConCommand( "-speed" )
     end
end)



local start, oldhp, newhp = 0, -1, -1
local barW = 200
Pip_Color_hostile = Color(255, 100, 100)
Pip_Color_friendly = Color(125, 255, 125)
local animationTime = 0.1 -- seconds
local compass = Material("compassf.png", " noclamp")
compass:SetFloat("")
local radIcon = Material("icons/hud/gieger.png", " noclamp")
local shadow = Color(0, 0, 0)
local ply = LocalPlayer()
local W, H = ScrW(), ScrH()
local cachedHealth = 0.1
local surface = surface
local TargetEnt = nil
local TargetEntTimeSinceLastLook = 0




local function XdrawBaX(x, y, w, h, pos, neg, max, right, label, font, color)


    if (pos > max) then
        pos = max
    end

    max = max - 1


    pos = math.max(((w - 2) / max) * pos, 0)
    neg = math.max(((w - 2) / max) * neg, 0)
    surface.SetDrawColor(255, 255, 255, 255)
    surface.DrawRect(x, y, w + 6, h)
    surface.SetDrawColor(255, 255, 255, 200)
    surface.DrawOutlinedRect(x, y, w + 6, h)
    surface.SetDrawColor(1)
    surface.DrawRect(x + 3, y + 3, pos, h - 6)
    surface.SetDrawColor(255, 100, 100)
    surface.DrawRect(x + 4 + (w - neg), y + 3, neg, h - 6)
end



    local hungerIcon = Material("hunger.png")
    local thirstIcon = Material("thirst.png")

print("VoiceNotify")

local CompassLetters = {"N", "E", "S", "W"}

local crshairtype = 0
DRAW_INTERACTABLE = true

local function DrawCrosshair()
		
    if DRAW_INTERACTABLE == true and not PIPBOY_ON_SCREEN then
        local Center = ScrW() / 2
        local Centery = ScrH() / 2
        local size = 8
        local centerOffset = 16
        local eyetrace = LocalPlayer():GetEyeTrace()
		
        local rdy = (eyetrace.Entity.Interactable and eyetrace.Entity:GetPos():DistToSqr(LocalPlayer():GetPos()) < 10000) or FAKE_ENTITY_INTERACTABLE
        crshairtype = Lerp(FrameTime() * 5, crshairtype, rdy and 0 or 1)
        -- local et = eyetrace.HitPos:ToScreen()
        --Center, Centery = et.x, et.y

        surface.SetAlphaMultiplier(1 - crshairtype)
        surface.DrawShadow(Center - centerOffset, Centery - centerOffset, size, 2, pip_color)
        surface.DrawShadow(Center - centerOffset, Centery - centerOffset + 2, 2, size - 2, pip_color)
        surface.DrawShadow(Center + centerOffset - 2 - size, Centery - centerOffset, size, 2, pip_color)
        surface.DrawShadow(Center + centerOffset - 4, Centery - centerOffset + 2, 2, size - 2, pip_color)
        surface.DrawShadow(Center - centerOffset, Centery + centerOffset - size - 2, 2, size - 2, pip_color)
        surface.DrawShadow(Center - centerOffset, Centery + centerOffset - 4, size, 2, pip_color)
        surface.DrawShadow(Center + centerOffset - 4, Centery + centerOffset - 2 - size, 2, size - 2, pip_color)
        surface.DrawShadow(Center + centerOffset - 2 - size, Centery + centerOffset - 4, size, 2, pip_color)
        surface.SetAlphaMultiplier(1)

        if rdy then
			
            local InteractablePresent = FAKE_ENTITY_INTERACTABLE or eyetrace.Entity.Interactable
            InteractablePresent = type(InteractablePresent) == "function" and InteractablePresent() or InteractablePresent
            surface.SetFont("$MAIN_Font")
            local name =   InteractablePresent[1]
            local txt_w, txt_h = surface.GetTextSize(name)
            local str = "E) " .. InteractablePresent[2]
            local txt_w2, txt_h2 = surface.GetTextSize(str)
            local XPos = ScrW() * 0.7
            NzGUI.DrawShadowText(name, XPos - (txt_w / 2), ScrH() / 2 - 32)
            NzGUI.DrawShadowText(str, XPos - (txt_w2 / 2), ScrH() / 2 + 6)
            -- nut.util.drawText(, , colorAlpha(nut.config.get("color"), alpha), 1, 1, nil, alpha * 0.65)
        end
    end

    FAKE_ENTITY_INTERACTABLE = nil -- RESET TO NULL
end

local tab = {
    ["$pp_colour_addr"] = 0.1,
    ["$pp_colour_addg"] = 0,
    ["$pp_colour_addb"] = 0,
    ["$pp_colour_brightness"] = 0,
    ["$pp_colour_contrast"] = 1,
    ["$pp_colour_mulr"] = 2,
    ["$pp_colour_mulg"] = 0,
    ["$pp_colour_mulb"] = 0,
    ["$pp_colour_colour"] = 0,
}

-- Give the RT a size
-- Create the RT
local iTexFlags = bit.bor(1, 262144, 32768, 8388608, 2048, 4, 8)
local tex = GetRenderTargetEx("ccsgsafcaaffba", ScrW(), ScrH(), RT_SIZE_OFFSCREEN, MATERIAL_RT_DEPTH_NONE, 0, 0, IMAGE_FORMAT_RGB888) --[[IMPORTANT]]

local myMat = CreateMaterial("accasabafaassafb", "UnlitGeneric", {
    ["$basetexture"] = tex:GetName(),
    ["$translucent"] = "0"
})

local Mask_Tex = GetRenderTargetEx("_ccsgsacaaffba", ScrW(), ScrH(), RT_SIZE_OFFSCREEN, MATERIAL_RT_DEPTH_NONE, 0, 0, IMAGE_FORMAT_BGRA8888) --[[IMPORTANT]]

local Mask_Mat = CreateMaterial("_accasabafasasb", "UnlitGeneric", {
    ["$basetexture"] = Mask_Tex:GetName(),
    ["$translucent"] = "1"
})

local txBackground = Material("models/weapons/v_toolgun/screen_bg")
local mask = Material("sleep_dreams_sweet_prince2.png", "smooth")
local mat_color = Material("pp/colour")
mat_color:SetFloat("$translucent", "1")

local function RenderColorBlendSpace()
    for k, v in pairs(tab) do
        mat_color:SetFloat(k, v)
    end

    surface.SetDrawColor(color_white)
    surface.SetMaterial(mat_color)
    surface.DrawTexturedRect(0, 0, ScrW(), ScrH())
end

function RenderMaskedRT()
    -- Draw the "background" image
    render.SetWriteDepthToDestAlpha(false)
    surface.SetDrawColor(color_white)
    surface.SetMaterial(myMat)
    surface.DrawTexturedRect(0, 0, ScrW(), ScrH())
    -- Draw the actual mask
    render.SetWriteDepthToDestAlpha(false)
    render.OverrideBlend(true, BLEND_SRC_COLOR, BLEND_SRC_ALPHA, BLENDFUNC_MIN)
    surface.SetMaterial(mask)
    surface.DrawTexturedRect(0, 0, ScrW(), ScrH())
    render.OverrideBlend(false)
    render.SetWriteDepthToDestAlpha(true)
end

local function DrawBleed()
    -- Render animated stuff to the render target
    render.PushRenderTarget(tex)
    cam.Start2D()
    render.ClearDepth()
    render.Clear(0, 0, 0, 0)
    RenderColorBlendSpace()
    cam.End2D()
    render.PopRenderTarget()
    --Draw EFFECT
    render.PushRenderTarget(Mask_Tex)
    cam.Start2D()
    render.Clear(0, 0, 0, 0)
    RenderMaskedRT()
    cam.End2D()
    render.PopRenderTarget()
    -- Actually draw the Render Target to see the final result.
    surface.SetDrawColor(color_white)
    surface.SetMaterial(Mask_Mat)
    surface.DrawTexturedRect(0, 0, ScrW(), ScrH())
    -- This is just for debugging, to see what it looks like without the mask
    -- RenderMaskedRT()
    -- surface.SetDrawColor(color_white)
    -- surface.SetMaterial(myMat)
    --  surface.DrawTexturedRect(0, 0, ScrW(), ScrH())
    --    render.DrawTextureToScreen( tex )
end

hook.Add("RenderScreenspaceEffects", "PostProcessingExample", function()
    render.UpdateScreenEffectTexture()
    mat_color:SetTexture("$fbtexture", render.GetScreenEffectTexture())
    render.UpdateScreenEffectTexture()
end)

--DrawBleed()
hook.Remove("PostDrawHUD", "PostProcessingExample")

local PartyFrames = {
    w = 256,
    h = 64,
    avatar = 48,
    hpbar = 16,
    lp = 68,
    padding = 4,
    hoffset = 128
}

local TEX_SIZE = 64
local p = FindMetaTable("Player")
for i,v in pairs(player.GetAll()) do 
v.avatar = nil
end
function p:CreateThumbnail(n)
    local avatar = GetRenderTarget(self:Nick() .. "avataar" .. TEX_SIZE, TEX_SIZE, TEX_SIZE)
	self.avatarMat = CreateMaterial("avatarr" .. self:Nick(), "UnlitGeneric", {
    ['$basetexture'] = self:Nick() .. "avataar" .. TEX_SIZE,
    --["$translucent"] = "1", -- This is necessary to render the RT with alpha channel,
    ["$alphatest"] = "1",
    ["$alphatestreference"] = "0.2",
	})
    self.avatar = avatar


    if mdl and IsValid(mdl) then
        mdl:Remove()
    end
  
    mdl = vgui.Create("DModelPanel", BGPanel)
    mdl:SetSize(TEX_SIZE, TEX_SIZE) 
    mdl:SetModel(n:GetModel())
    mdl:SetPaintedManually(true)

    -- Disable cam rotation
    function mdl:LayoutEntity(Entity)
        return
    end
	
    function mdl:PostDrawModel(s)
	if s.parts then 
        for i, v in pairs(s.parts   ) do
            if IsValid(v) then 
                local c = v.col or Vector(1, 1, 1)
                render.SetColorModulation(c.r, c.g, c.b)
		
                v:DrawModel() 
            end
        end 
		end
    end

    mdl:SetAnimated(false)
    local headpos = mdl.Entity:GetBonePosition(mdl.Entity:LookupBone("ValveBiped.Bip01_Head1"))
    mdl:SetLookAt(headpos)
    mdl:SetCamPos(headpos - Vector(-15, 0, 0))
    mdl.Entity:SetAngles(Angle(0, 45, 0))
end
local tab = {
	[ "$pp_colour_addr" ] = 12/255,
	[ "$pp_colour_addg" ] = 12/255,
	[ "$pp_colour_addb" ] = 25/255,
	[ "$pp_colour_brightness" ] = -0.05,
	[ "$pp_colour_contrast" ] = 1,
	[ "$pp_colour_colour" ] = 1,
	[ "$pp_colour_mulr" ] = 0/255,
	[ "$pp_colour_mulg" ] = 0/255,
	[ "$pp_colour_mulb" ] = 0/255
}

hook.Add( "RenderScreenspaceEffects", "color_modify_example", function()
	
	DrawColorModify( tab )

end )
local AvatarMat = CreateMaterial("reeeeeeeAvatar2", "UnlitGeneric", {
    ['$basetexture'] = "",
    --["$translucent"] = "1", -- This is necessary to render the RT with alpha channel,
    ["$alphatest"] = "1",
    ["$alphatestreference"] = "0.2",
})

-- RESET CACHE  
for i, v in pairs(player.GetAll()) do
    v.avatarReady = nil
    v.avatar = nil
end

local function DrawPartyFrame(ply)
	if true then return end
    local sW, wH = ScrW(), ScrH()
    surface.SetDrawColor(pip_color)
    local hoffset = PartyFrames.hoffset + (PartyFrames.h * PartyFrames.i)
    surface.SetMaterial(AvatarMat)

    if ply.avatar then
        if ply.avatarReady == nil then 
            ply.avatarReady = 1
			 TRANSFORM_LOCALLY_BG(mdl.Entity, ply:getChar():getApperance())
			mdl.Entity:ApplyMorph(ply.data or ply:getChar():getApperance(),true)
            render.PushRenderTarget(ply.avatar)
			
            cam.Start2D()
            render.ClearDepth()
            render.Clear(0, 0, 0, 0, true, true)
            render.SetWriteDepthToDestAlpha(false)
            render.PushFilterMag(TEXFILTER.ANISOTROPIC)
            render.PushFilterMin(TEXFILTER.ANISOTROPIC)
            
            mdl:PaintManual()
	
            render.SetWriteDepthToDestAlpha(true)
            render.PopFilterMag()
            render.PopFilterMin()
            cam.End2D()
            render.PopRenderTarget()
            ply.avatarReady = true
        end
    else
        ply:CreateThumbnail(ply)
    end

    if ply.avatar then
        AvatarMat:SetTexture("$basetexture", ply.avatar:GetName())
    end

    surface.DrawRect(PartyFrames.lp - PartyFrames.avatar - PartyFrames.padding, wH - hoffset - PartyFrames.avatar + PartyFrames.hpbar, PartyFrames.avatar, PartyFrames.avatar)
    surface.DrawTexturedRect(PartyFrames.lp - PartyFrames.avatar - PartyFrames.padding, wH - hoffset - PartyFrames.avatar + PartyFrames.hpbar, PartyFrames.avatar, PartyFrames.avatar)
    surface.DrawRect(PartyFrames.lp, wH - hoffset, PartyFrames.w, PartyFrames.hpbar)
    surface.DrawRect(PartyFrames.lp, wH - hoffset - PartyFrames.avatar + PartyFrames.hpbar, PartyFrames.avatar, PartyFrames.avatar - PartyFrames.hpbar - PartyFrames.padding)
    NzGUI.DrawShadowText(ply:Nick(), PartyFrames.lp + PartyFrames.avatar + PartyFrames.padding, wH - hoffset - PartyFrames.hpbar - 18, pip_color)
    PartyFrames.i = PartyFrames.i + 1
end
 
function DrawPartyFrames()
 
    local sW, wH = ScrW(), ScrH()
    PartyFrames.i = 0

    for i, v in pairs(player.GetAll()) do
        if v ~= LocalPlayer() then
            DrawPartyFrame(v)
        end
    end
end

local radsPerSecond = 0

--surface.DrawTexturedRect(x, H - y, 64, 64)
local DRAW_RADS = true
local function DrawFalloutBar(doFlip,x,y,text,p,negativeboundary)


	local ply = LocalPlayer()
	
	   local rads = ply:getChar():getData("rad", 0)/100

   --surface.DrawRect(math.ceil(64 + (400 * p)), H - 64, math.ceil(400 * -(p - 1)), 16)



   local baroffset = 42
   local barwidth = 300
		if DRAW_RADS then 
        surface.SetDrawColor(pip_color_negative)

      surface.DrawRect(math.ceil(x+baroffset + (barwidth * (1 - rads))), H - 64, math.floor(barwidth * rads), 16)
		DRAW_RADS = false 
		end 
   --surface.DrawRect(x-2,H-70,barwidth+baroffset+8,28)
   surface.SetDrawColor(pip_color)
   surface.DrawRect(x+baroffset, H - 48, barwidth+1, 2)
   surface.DrawRect(x+baroffset+barwidth, H - 64, 2, 18)
   surface.DrawRect(x+baroffset, H - 64, math.ceil(barwidth * p), 16)
   NzGUI.DrawShadowText(text, x+3 + ((doFlip and barwidth+baroffset+8) or 0), H - 71)

end
local HudPaint = GetRenderTarget( "PWR_ARMRw", ScrW() , ScrH() )
local customMaterial = CreateMaterial( "example_rt_maxxtx" .. math.random(1,10000000 ), "UnlitGeneric", {
	["$basetexture"] = HudPaint:GetName(), -- You can use "example_rt" as well
	["$translucent"] = 0,
	["$vertexcolor"] = 0,
    ["$additive"] = 1,
} )

hook.Add("HUDPaint", "flUI", function()

DrawCrosshair()

    if (not IsValid(LocalPlayer())) then return end
    local ply = LocalPlayer()
    local char = ply:getChar()
    if char == nil then return end
	render.PushRenderTarget( HudPaint )
	    render.Clear( 0, 0, 0, 255, true, true )

	cam.Start2D() 
	
    local hp = LocalPlayer():Health()
    local maxhp = LocalPlayer():GetMaxHealth()
    surface.SetFont("$MAIN_Font32")
    DrawPartyFrames()

    -- The values are not initialized yet, do so right now
    if (oldhp == -1 and newhp == -1) then
        oldhp = hp
        newhp = hp
    end

    if not vgui.CursorVisible() then
        
    end

    -- You can use a different smoothing function here
    local smoothHP = Lerp((SysTime() - start) / animationTime, oldhp, newhp)

    -- Health was changed, initialize the animation
    if newhp ~= hp then
        -- Old animation is still in progress, adjust
        if (smoothHP ~= hp) then
            -- Pretend our current "smooth" position was the target so the animation will
            -- not jump to the old target and start to the new target from there
            newhp = smoothHP
        end

        oldhp = newhp
        start = SysTime()
        newhp = hp
    end

    cachedHealth = smoothHP / maxhp
    local p = cachedHealth
    surface.SetFont("$MAIN_Font32")
    local rads = (char:getData("rads", 0) * 0.25) / maxhp
	DRAW_RADS = true
	DrawFalloutBar(false,20,100,"HP",p,negativeboundary)
	local stm = ply:getNetVar("stm") or 0
	local maxstm = ply:getNetVar("maxStm") or 0
	DrawFalloutBar(true,ScrW()-420,100,"AP",stm/maxstm,negativeboundary)
	
	local ply = LocalPlayer()
    local char = ply:getChar()
    local hunger = char:getData("hunger", 100)
    local thirst = char:getData("thirst", 100)
	do
	local x = ScrW() - 380
    local y = ScrH() - 90
    local w = 127
    local h = 12
   	    surface.SetDrawColor(pip_color.r,pip_color.g,pip_color.b,35)
    surface.DrawRect(x + 3, y + 3, w , h - 6)
    surface.SetDrawColor(pip_color)
    surface.DrawRect(x + 3, y + 3, w * (hunger / 200), h - 6)

    --Hunger Icon
    surface.SetMaterial(hungerIcon)
    surface.DrawTexturedRect(x + w + 15, y - 32 + h, 20, 32)
    --Thirst bar
    x = x + w + 46
	    surface.SetDrawColor(pip_color.r,pip_color.g,pip_color.b,35)
    surface.DrawRect(x + 3, y + 3, w , h - 6)
    surface.SetDrawColor(pip_color)
    surface.DrawRect(x + 3, y + 3, w * (thirst / 200), h - 6)
    --Thirst Icon
    surface.SetMaterial(thirstIcon)
    surface.DrawTexturedRect(x + w + 15, y - 30 + h, 22, 30)
	end
	
	--radsPerSecond = 42069
    if radsPerSecond > 0 then
        surface.SetDrawColor(shadow)
        surface.DrawRect(64, H - 46, 403, 1)
        surface.DrawRect(466, H - 64, 1, 18)
        surface.SetDrawColor(pip_color_negative)
        surface.SetMaterial(radIcon)
		surface.DrawTexturedRect(370, H - 102,64,64)
        -- if char:getData("radsPSec", 0) > 0 then
        local radtxt = "+" .. radsPerSecond .. " RADS"
        local rad_w, rad, h = surface.GetTextSize(radtxt)
        NzGUI.DrawShadowText(radtxt, 370 - rad_w, H - 102, pip_color_negative)
    end
   
    
   local scale = 1
   local RawAngles = EyeAngles().y
   local Angles = RawAngles
   local playerAngle = (Angles / 90) + 0.5
   local cOrign = W / 2 - 200
   local yOri = H - 64
   local compasslen = 400
   surface.SetMaterial(grad_r)
   surface.SetDrawColor(pip_color.r, pip_color.g, pip_color.b, 80)
   surface.DrawTexturedRect(cOrign + 4, yOri - 14, compasslen-4, 28)
   surface.SetDrawColor(shadow)
  --surface.DrawRect(cOrign, yOri - 14, 7, 29)
  --surface.DrawRect(cOrign + 396, yOri - 14, 7, 30)
  --surface.DrawRect(cOrign, yOri + 14, 402, 2)
   surface.SetDrawColor(pip_color)
   surface.DrawRect(cOrign, yOri - 14, 4, 24)
   surface.DrawRect(cOrign + 396, yOri - 14, 4, 24)
    --surface.DrawTexturedRect(cOrign , yOri, compasslen, 28,playerAngle,0,playerAngle+1,1)
    --surface.DrawTexturedRect(cOrign, yOri, 407, 28,playerAngle, 0, 1)
    render.SetScissorRect(cOrign, yOri - 32, cOrign + compasslen, H, true)
    local angle
    surface.SetMaterial(compass)
    angle = Angle(0, EyeAngles().y * 4, 0)
    --DEBUG
    angle = angle.y
    angle = (angle) % 360 / 360
    angle = angle + 0.5
    surface.SetDrawColor(shadow)
    surface.DrawTexturedRectUV(cOrign + 3, yOri + 3, compasslen, 28, angle + 1, 0, angle, 1)
    surface.SetDrawColor(pip_color)
    surface.DrawTexturedRectUV(cOrign, yOri, compasslen, 28, angle + 1, 0, angle, 1)
    local widthSpacCompass = cOrign + (playerAngle * compasslen) - 11
    local XCROD = 0

    --for i, v in pairs(ents.GetAll()) do
    --    if v:GetClass() == "npc_monk" then
    --        local pv, vp = v:GetPos(), LocalPlayer():GetPos()
    --        local y, x = vp.y - pv.y, vp.x - pv.x
    --        local ang = (Angle(0, math.floor(math.deg(math.atan2(y, x))), 0) + Angle(0, LocalPlayer():EyeAngles().y + 270, 0)).y
    --        ang = (ang) % 360 / 360
    --        ang = ang * 2
    --        surface.SetDrawColor(shadow)
    --        surface.DrawRect(cOrign + (ang * compasslen) - 11, yOri - 15, 16, 16)
    --        surface.SetDrawColor(255, 100, 100)
    --        surface.DrawRect(cOrign + (ang * compasslen) - 11, yOri - 15, 15, 15)
    --    end
    --end

    -- NzGUI.DrawShadowText("N", cOrign+(xPpp*400)-12, H - 38)
    for i, v in pairs(CompassLetters) do
        local xPpp = (((((i - 1) * 90) + (EyeAngles().y) + 45) * 4) / 360) % 4
        local x2 = 400 * xPpp
        NzGUI.DrawShadowText(v, cOrign + x2 - 12, H - 38)
    end

    --NzGUI.DrawShadowText("W", widthSpacCompass + (-compasslen), H - 38) -- hack to make W not dissapear
    render.SetScissorRect(0, 0, 0, 0, false)
    local ply = LocalPlayer()
    local eye = ply:EyeAngles()
    local playerx = eye.y
    local wep = LocalPlayer():GetActiveWeapon()

   if wep and wep["Clip1"] and wep.DrawAmmo then
       surface.SetTextColor(shadow)
       surface.SetTextPos(W - 126, H - 158)
       local frontclip = string.format("%03d", wep:Clip1() or 0)
       local backclip = string.format("%03d", LocalPlayer():GetAmmo()[wep:GetPrimaryAmmoType()] or 0)
       surface.DrawText(frontclip)
       surface.SetTextPos(W - 126, H - 118)
       surface.DrawText(backclip)
       surface.SetTextColor(pip_color)
       surface.SetTextPos(W - 128, H - 160)
       surface.DrawText(frontclip)
       surface.SetTextPos(W - 128, H - 120)
       surface.DrawText(backclip)
 
       surface.SetDrawColor(pip_color)
       surface.DrawRect(W - 135, H - 125, 55, 2)
   end

    local lookAt = LocalPlayer():GetEyeTrace().Entity

    if lookAt:IsNPC() or lookAt:IsPlayer() or lookAt.DisplayName  then
        TargetEnt = lookAt
        TargetEntTimeSinceLastLook = CurTime() + 0.1
    end

    if IsValid(TargetEnt) and TargetEntTimeSinceLastLook > CurTime() and TargetEnt:GetPos():Distance(LocalPlayer():GetPos()) < 500 then
		if TargetEnt.CloakFactor then return end
        local IsPlayer = TargetEnt:IsPlayer()
        local IsFriendly = TargetEnt.ForcedFriendly or IsPlayer -- Only for now
        local colorToUSe = IsFriendly and Pip_Color_friendly or Pip_Color_hostile
        local eneP = TargetEnt:Health() / TargetEnt:GetMaxHealth()
        surface.SetDrawColor(shadow.r, shadow.g, shadow.b, 100)
        local w2 = W / 2
        local xBox = w2 - 258
        surface.DrawRect(w2 - 205, 44, (400) + 9, 24)
        surface.SetDrawColor(shadow)
        surface.DrawRect(xBox, 32, 50, 50)
        surface.DrawRect(w2 - 201, 48, (400 * eneP) + 2, 18)
        surface.SetDrawColor(colorToUSe)
        surface.DrawRect(w2 - 201, 48, 400 * eneP, 16)
        local enemy_name = IsPlayer and (hook.Run("GetDisplayedName", TargetEnt) or TargetEnt:Nick()) or TargetEnt.PrintName
        surface.SetFont("$MAIN_Font")
        local getTextWidth, txtheight = surface.GetTextSize(enemy_name)
        getTextWidth = getTextWidth / 2
        surface.SetTextColor(shadow)
        surface.SetTextPos(w2 - getTextWidth + 2, 6 + 2)
        surface.DrawText(enemy_name)
        surface.SetTextColor(colorToUSe)
        surface.SetTextPos(w2 - getTextWidth, 6)
        surface.DrawText(enemy_name)
        surface.DrawRect(xBox, 32, 48, 48)
        local level = (TargetEnt:IsPlayer() and TargetEnt:getChar():getSkillLevel("level")) or TargetEnt.Level or TargetEnt:GetNWInt("lvl", 0)
        surface.SetFont("$Bold_font")
        getTextWidth, txtheight = surface.GetTextSize(level)
        getTextWidth = getTextWidth / 2
        surface.SetTextPos(xBox + 24 - getTextWidth, 36)
        surface.SetTextColor(0, 0, 0)
        surface.DrawText(level)
    end
	
	hook.Run("FusionPaint")
	cam.End2D()
render.PopRenderTarget()
surface.SetMaterial(customMaterial)
surface.SetDrawColor(color_white)
surface.DrawTexturedRect(0,0,ScrW(),ScrH())
end)

--[[
if (not RenderTargetCamera or not RenderTargetCamera:IsValid()) then
    RenderTargetCamera = ents.CreateClientside("point_camera")
    RenderTargetCamera:SetKeyValue("GlobalOverride", 1)
    RenderTargetCamera:Spawn()
    RenderTargetCamera:Activate()
    RenderTargetCamera:Fire("SetOn", "", 0.0)
end

Pos = ent:LocalToWorld(Vector(12, 0, 0))
RenderTargetCamera:SetPos(Pos)
RenderTargetCamera:SetAngles(ent:GetAngles())
RenderTargetCamera:SetParent(ent)
RenderTargetCameraProp = ent
hook.Add("HUDPaint", "watermarkpaint", function()
    surface.SetTextColor(pip_color)
    surface.SetFont("Default")
    surface.SetTextPos(25, 25)
    surface.DrawText("FALLOUT ALASKA-FUSION / Yshera " .. LocalPlayer():getNetVar("stm") .. "/" .. LocalPlayer():getNetVar("maxStm") .. " - " .. LocalPlayer():getNetVar("stm") / LocalPlayer():getNetVar("maxStm"))

    local build = {"FALLOUT AFLASK / Yshera", "FPS: " .. math.floor(1 / FrameTime()) .. "      PING: " .. LocalPlayer():Ping(), "INST: " .. (LocalPlayer().Phase or 0) .. "!City",}

    local tx = "FALLOUT FUSION / Yshera"
    local tx_w, tx_h = surface.GetTextSize(tx)
    surface.SetDrawColor(0, 0, 0, 200)
    surface.DrawRect(ScrW() - 16 - (tx_w), ScrH() - 100, 400, #build * 17)

    for i, v in pairs(build) do
        local tx_w, tx_h = surface.GetTextSize(v)
        surface.SetTextPos(ScrW() - 8 - (tx_w), ScrH() - 100 + (10 * i))
        surface.DrawText(v)
    end
end)
]]
hook.Add("ShouldHideBars", "hideBars", function() return true end)

hook.Add("InitializedPlugins", "HUDRADMGNETOWRK", function()
    netstream.Hook("RADDMG", function(i, n)
        radsPerSecond = i
    end)
end)

local custom_vector = Vector( 1, 1, 1 )
hook.Add("HUDPaint", "2d rotation test", function()

end)




local PANEL = {}
local PlayerVoicePanels = {}

function PANEL:Init()

	self.LabelName = vgui.Create( "DLabel", self )
	self.LabelName:SetFont( "GModNotify" )
	self.LabelName:Dock( FILL )
	self.LabelName:DockMargin( 40, 0, 0, 0 )
	self.LabelName:SetTextColor( color_white )

	--self.Avatar = vgui.Create( "AvatarImage", self )
	--self.Avatar:Dock( LEFT )
	--self.Avatar:SetSize( 32, 32 )

	self.Color = color_transparent

	self:SetSize( 250, 32 + 8 )
	self:DockPadding( 4, 4, 4, 4 )
	self:DockMargin( 2, 2, 2, 2 )
	self:Dock( BOTTOM )

end

function PANEL:Setup( ply )

	self.ply = ply
	self.LabelName:SetText( "ply:Nick()" )
	--self.Avatar:SetPlayer( ply )
	
	
	
	
	
	self.Color = team.GetColor( ply:Team() )
	
	self:InvalidateLayout()

end

function PANEL:Paint( w, h )

	if ( !IsValid( self.ply ) ) then return end
	function self:Paint(w,h)
	surface.SetDrawColor(pip_color.r,pip_color.g,pip_color.b,50)
	surface.DrawRect(0,0,w,h)

	
		surface.SetMaterial(AvatarMat)

	if self.ply.avatar then
        AvatarMat:SetTexture("$basetexture", self.ply.avatar:GetName())
  end

	surface.DrawTexturedRect(0,0,44,42)
	end

end
 
function PANEL:Think()
		
	if ( IsValid( self.ply ) ) then
	   
	local ply = self.ply
    if ply.avatar then
        if ply.avatarReady == nil then 
            ply.avatarReady = 1
			 TRANSFORM_LOCALLY_BG(mdl.Entity, ply:getChar():getApperance())
			mdl.Entity:ApplyMorph(ply.data or ply:getChar():getApperance(),true)
            render.PushRenderTarget(ply.avatar)
			
            cam.Start2D()
            render.ClearDepth()
            render.Clear(0, 0, 0, 0, true, true)
            render.SetWriteDepthToDestAlpha(false)
            render.PushFilterMag(TEXFILTER.ANISOTROPIC)
            render.PushFilterMin(TEXFILTER.ANISOTROPIC)
            
            mdl:PaintManual()
			PrintTable(mdl.Entity.parts or {"ghea"})
            render.SetWriteDepthToDestAlpha(true)
            render.PopFilterMag()
            render.PopFilterMin()
            cam.End2D()
            render.PopRenderTarget()
            ply.avatarReady = true
        end
    else 
        ply:CreateThumbnail(ply)
    end
		
		self.LabelName:SetText( (hook.Run("GetDisplayedName", self.ply) or self.ply:Nick()) )
	end

	if ( self.fadeAnim ) then
		self.fadeAnim:Run()
	end

end

function PANEL:FadeOut( anim, delta, data )
	
	if ( anim.Finished ) then
	
		if ( IsValid( PlayerVoicePanels[ self.ply ] ) ) then
			PlayerVoicePanels[ self.ply ]:Remove()
			PlayerVoicePanels[ self.ply ] = nil
			return
		end
		
	return end
	
	self:SetAlpha( 255 - ( 255 * delta ) )

end

derma.DefineControl( "VoiceNotify", "", PANEL, "DPanel" )


local GM = GAMEMODE or GM or gm or gamemode
function GM:PlayerStartVoice( ply )

	if ( !IsValid( g_VoicePanelList ) ) then return end
	
	-- There'd be an exta one if voice_loopback is on, so remove it.
	GAMEMODE:PlayerEndVoice( ply )


	if ( IsValid( PlayerVoicePanels[ ply ] ) ) then

		if ( PlayerVoicePanels[ ply ].fadeAnim ) then
			PlayerVoicePanels[ ply ].fadeAnim:Stop()
			PlayerVoicePanels[ ply ].fadeAnim = nil
		end

		PlayerVoicePanels[ ply ]:SetAlpha( 255 )

		return

	end

	if ( !IsValid( ply ) ) then return end

	local pnl = g_VoicePanelList:Add( "VoiceNotify" )
	pnl:Setup( ply )
	
	PlayerVoicePanels[ ply ] = pnl

end
if IsValid(g_VoicePanelList) then g_VoicePanelList:Remove() end
local function VoiceClean()

	for k, v in pairs( PlayerVoicePanels ) do
	
		if ( !IsValid( k ) ) then
			GAMEMODE:PlayerEndVoice( k )
		end
	
	end

end
timer.Create( "VoiceClean", 10, 0, VoiceClean )

function GM:PlayerEndVoice( ply )

	if ( IsValid( PlayerVoicePanels[ ply ] ) ) then

		if ( PlayerVoicePanels[ ply ].fadeAnim ) then return end

		PlayerVoicePanels[ ply ].fadeAnim = Derma_Anim( "FadeOut", PlayerVoicePanels[ ply ], PlayerVoicePanels[ ply ].FadeOut )
		PlayerVoicePanels[ ply ].fadeAnim:Start( 1 )
		timer.Simple(2, function() if IsValid(PlayerVoicePanels[ ply ]) then PlayerVoicePanels[ ply ]:Remove() end end)

	end

end
 
local function CreateVoiceVGUI()

	g_VoicePanelList = vgui.Create( "DPanel" )

	g_VoicePanelList:ParentToHUD()
	g_VoicePanelList:SetPos( ScrW() - 300, 100 )
	g_VoicePanelList:SetSize( 250, ScrH() - 200 )
	g_VoicePanelList:SetPaintBackground( false )

end 
if nut then CreateVoiceVGUI() end
hook.Add( "InitPostEntity", "CreateVoiceVGUI", CreateVoiceVGUI )


local sky_cvar = GetConVar("sv_skyname")
local sky_name = ""
local sky_materials = {}

-- sort the portals by distance since draw functions do not obey the z buffer
timer.Create("seamless_portal_distance_fix", 5, 0, function()

	-- update sky material (I guess it can change?)
	if sky_name != sky_cvar:GetString() then
		sky_name = sky_cvar:GetString()

		local prefix = "skybox/" .. sky_name
		sky_materials[1] = Material(prefix .. "bk")
		sky_materials[2] = Material(prefix .. "dn")
		sky_materials[3] = Material(prefix .. "ft")
		sky_materials[4] = Material(prefix .. "lf")
		sky_materials[5] = Material(prefix .. "rt")
		sky_materials[6] = Material(prefix .. "up")
	end
end)
	-- update sky material (I guess it can change?)
	if sky_name != sky_cvar:GetString() then
		sky_name = sky_cvar:GetString()

		local prefix = "skybox/" .. sky_name
		sky_materials[1] = Material(prefix .. "bk")
		sky_materials[2] = Material(prefix .. "dn")
		sky_materials[3] = Material(prefix .. "ft")
		sky_materials[4] = Material(prefix .. "lf")
		sky_materials[5] = Material(prefix .. "rt")
		sky_materials[6] = Material(prefix .. "up")
	end


local floor = CreateMaterial( "colortexshpd", "UnlitGeneric", {
  ["$basetexture"] = "gm_construct/grass1",
  ["$model"] = 1,
  ["$translucent"] = 1,
  ["$vertexalpha"] = 1,
  ["$vertexcolor"] = 1
} )


-- draw the skybox
local drawsky = function(pos, ang, size, size_2, color, materials)
	-- BACK

	render.SetMaterial(materials[1])
	render.DrawQuad(Vector(	1495.1739501953	,	11686.43359375-4	,	-466.03125	),
Vector(	1894.0745849609	,	11686.96875-4	,	-466.7294921875	),
Vector(	1896.96875	,	11686.814453125-4	,	-589.73565673828	),
Vector(	1495.8376464844	,	11686.96875-4	,	-589.8125	),color, 0)

	---- FRONT
	--render.SetMaterial(materials[3])
	--render.DrawQuadEasy(pos - Vector(0, size, 0), -ang:Right(), size_2, size_2, color, 0)
	-- LEFT
	render.SetMaterial(materials[4])
		render.DrawQuad(Vector(	1894.2730712891-4	,	11686.96875+4	,	-468.87588500977	),
Vector(	1896.96875-4	,	11179.469726563+4	,	-466.45294189453	),
Vector(	1896.96875-4	,	11179.922851563+4	,	-590.89331054688	),
Vector(	1896.96875-4	,	11682.837890625+4	,	-590.82946777344	),
color)
	--render.DrawQuadEasy(pos - Vector(size, 0, 0), ang:Forward(), size_2, size_2, color, 0)
	---- RIGHT
	render.SetMaterial(materials[5])
		render.SetMaterial(materials[4])
		render.DrawQuad(Vector(	1500.9055175781	,	11179.739257813	,	-466.03125	),
Vector(	1500.1756591797	,	11683.275390625	,	-466.03125	),
Vector(	1500.03125	,	11683.998046875	,	-590.50341796875	),
Vector(	1500.03125	,	11179.989257813	,	-590.70355224609	),

color)
	---- UP
	render.SetMaterial(materials[6])
	render.DrawQuad(Vector(	1894.4053955078	,	11683.987304688	,	-500.03125	),Vector(	1496.515625	,	11682.736328125	,	-500.03125	),Vector(	1495.3937988281	,	11179.82421875	,	-500.03125	),Vector(	1896.96875	,	11179.361328125	,	-500.06137084961	),



 color, 180)
 	-- DOWN

	render.SetMaterial(floor)
	render.DrawQuad(Vector(	1896.2801513672	,	11179.03125	,	-590.05169677734	),
Vector(	1495.03125	,	11179.083984375	,	-590.36767578125	),
Vector(	1497.0660400391	,	11683.01171875	,	-590.88244628906	),
Vector(	1893.4781494141	,	11682.41015625	,	-590.41650390625	),
 color, 180)


end
local skysize = 100
hook.Add("PostDrawTranslucentRenderables", "seamless_portal_skybox", function()

	render.OverrideDepthEnable(true, false) -- Fixes drawing over map
	drawsky(LocalPlayer():GetPos(), angle_zero, skysize, -skysize * 2, color_white, sky_materials)
	render.OverrideDepthEnable(false , false)
	
end)



hook.Add("HUDPaint", "Worldboss", function() 
--local width,height = ScrW(),ScrH() 
--local xOF= 300
--surface.SetFont("$MAIN_Font32")
--NzGUI.DrawShadowText("DAILY: Butcher Pete, Pt.1" ,width-xOF, 64,nil,false)
--surface.SetFont("$MAIN_Font24")
--
--NzGUI.DrawShadowText("0/10 Feral Ghouls Killed" ,width-xOF, 90,nil,false)
--surface.SetDrawColor(100,100,100) 
--NzGUI.DrawShadowText("10/10 Glowing Ones Killed" ,width-xOF, 110,Color(100,100,100),false)


--NzGUI.DrawShadowText("You currently have FISSION, move away from people with DECAY" ,width/2, 64,nil,true)
--NzGUI.DrawShadowText("Unum has selected you to harvest your radiation. " ,width/2, 64,nil,true)
--NzGUI.DrawShadowText("Unum has opened a radioactive fissure on the ground " ,width/2, 64,nil,true)

end)
hook.Add("InitializedPlugins","inviteInitializedPlugins",function() 
nut.playerInteract.addFunc("invite", {
	name = "Invite To Faction",
	callback = function(target)
	net.Start("invite_fac")
		net.WriteEntity(target)
	net.SendToServer()
	end,
	canSee = function(target)
		return LocalPlayer():getChar():hasFlags("L") and LocalPlayer():getChar():getFaction() ~= target:getChar():getFaction()
	end
})
end)
 




discord_start = discord_start or os.time()

 

-- This requires a special module to be installed before it works correctly
-- Sorry to disappoint you
if file.Find("lua/bin/gmcl_gdiscord_*.dll", "GAME")[1] == nil then return end
require("gdiscord")
--chat.AddText("DISCORD DLL FOUND")
-- Configuration
local map_restrict = true -- Should a display default image be displayed if the map is not in a given list?
local map_list = {
    gm_flatgrass = true,
    gm_construct = true
}
local image_fallback = "freezingcold"
local discord_id = "925571638429368341"
local refresh_time = 60


  
function DiscordUpdate()
    -- Determine what type of game is being played
    local rpc_data = {}
	rpc_data["state"] = "Level " .. LocalPlayer():getChar():getSkillLevel("level") 
	
    

    -- Determine the max number of players
    rpc_data["partySize"] = player.GetCount()
    rpc_data["partyMax"] = game.MaxPlayers()
    if game.SinglePlayer() then rpc_data["partyMax"] = 0 end

    -- Handle map stuff
    -- See the config
    rpc_data["largeImageKey"] = "freezingcold"
    rpc_data["largeImageText"] = game.GetMap()
    if map_restrict and not map_list[map] then
        rpc_data["largeImageKey"] = image_fallback
    end 
	
	   rpc_data["partyId"] = "ae488379-351d-4a4f-ad32-2b9b01c91657";
    rpc_data["details"] = "Wandering the alaskan wasteland"
	--rpc_data["details"] = "Currently in an active war"
	-- rpc_data["details"] = "Vibing to REBORN FM"
    rpc_data["startTimestamp"] = discord_start
	rpc_data["joinSecret"] = "steam://connect/34.85.148.248:27015"
    DiscordUpdateRPC(rpc_data)
end

hook.Add("Initialize", "UpdateDiscordStatus", function()
    discord_start = os.time()
    DiscordRPCInitialize(discord_id)
   

    timer.Create("DiscordRPCTimer", refresh_time, 0, DiscordUpdate) 
end) 
if nut then  
    DiscordRPCInitialize(discord_id)
    DiscordUpdate()
 
    timer.Create("DiscordRPCTimer", refresh_time, 0, DiscordUpdate) end

