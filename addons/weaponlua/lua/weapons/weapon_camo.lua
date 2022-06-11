if CLIENT then
	SWEP.PrintName = "Active Camouflage"
	SWEP.Author = "Master Pro11™"
	SWEP.Slot = 2
	SWEP.SlotPos = 1
	SWEP.WepSelectIcon = surface.GetTextureID("camo/camo_wepselecticon.vmt")
end

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Ammo = "none"
SWEP.DrawAmmo = false

SWEP.HoldType = "normal"
SWEP.Category = "Master's Weapons"
SWEP.UseHands = false

SWEP.Spawnable = true
SWEP.AdminSpawnable = true

SWEP.Primary.Automatic= false

SWEP.ViewModel = "models/weapons/c_pistol.mdl"
SWEP.WorldModel = "models/weapons/w_pistol.mdl"

local CamoActivate = Sound("camo/camo_on.wav")
local CamoDeactivate = Sound("camo/camo_off.wav")

local CamoMat = Material("camo/camo_shade.vmt")
local CamoOverlayMat = "camo/camo_overlay.vmt"
local CamoIconMat = "camo/camo_icon.vmt"

SWEP.Weight = 5
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

function SWEP:PrimaryAttack()
	self:SetNextPrimaryFire(CurTime() + 3)
	local CamoIsOn = self.Owner:GetNWBool("CamoEnabled")
	
	if SERVER then
		self.Owner:SetNWBool("CamoEnabled",!CamoIsOn)
		if CamoIsOn then
			NPC_SwitchRelationship(self.Owner,false)
		else
			NPC_SwitchRelationship(self.Owner,true)
		end
	elseif CLIENT then
		if CamoIsOn then
			surface.PlaySound(CamoDeactivate)
		elseif !CamoIsOn then
			surface.PlaySound(CamoActivate)
		end
	end
end 

function NPC_SwitchRelationship(ply,yn)
	if SERVER then
		for k,v in ipairs(ents.FindByClass("npc_*")) do
			if !yn then
				v:AddEntityRelationship(ply,D_HT,99)
			else
				v:AddEntityRelationship(ply,D_NU,99)
			end
		end
	end
end

if CLIENT then
	local colorMofify = {
		["$pp_colour_addr"] = 0,
		["$pp_colour_addg"] = 0,
		["$pp_colour_addb"] = 0,
		["$pp_colour_brightness"] = 0,
		["$pp_colour_contrast"] = 1,
		["$pp_colour_colour"] = 0,
		["$pp_colour_mulr"] = 0,
		["$pp_colour_mulg"] = 0,
		["$pp_colour_mulb"] = 0,
	}

	local function DrawCamoEffects()
		if LocalPlayer():GetNWBool("CamoEnabled") then
			DrawColorModify(colorMofify)
			DrawMotionBlur(0.1, 0.5, 0.01)
			DrawToyTown(2,ScrH()/2)
		end
	end
	hook.Add("RenderScreenspaceEffects","ShowCamoEffects",DrawCamoEffects)
	
	local CamoOverlayID = surface.GetTextureID(CamoOverlayMat)
	local CamoIconID = surface.GetTextureID(CamoIconMat)
	local CamoIconSize = ScrH()/5
	local CamoIconY = (ScrH()/2)+(ScrH()/5)
	local CamoIconX = (ScrW()/2)-(CamoIconSize/2)
	
	local function DrawCamoItems()
		if LocalPlayer():GetNWBool("CamoEnabled") then
			surface.SetDrawColor(255,255,255,255)
			surface.SetTexture(CamoOverlayID)
			surface.DrawTexturedRect(0,0,ScrW(),ScrH())
			
			surface.SetDrawColor(0,0,0,255)
			surface.SetTexture(CamoIconID)
			surface.DrawTexturedRect(CamoIconX,CamoIconY,CamoIconSize,CamoIconSize)
		end
	end
	hook.Add("HUDPaint","DrawActiveCamoItems",DrawCamoItems)
	
	local function DrawPlayerMaterial(ply)
		if ply:GetNWBool("CamoEnabled") then
			render.ModelMaterialOverride(CamoMat)
		end
	end
	hook.Add("PrePlayerDraw","DrawPlayerCamo",DrawPlayerMaterial)
	
	local function UndoPlayerMaterial(ply)
		render.ModelMaterialOverride()
	end
	hook.Add("PostPlayerDraw","UndoPlayerCamo",UndoPlayerMaterial)
end

if SERVER then
	local function CheckPlayerStill()
		for k,v in ipairs(player.GetAll()) do
			if v:GetNWBool("CamoEnabled") then
				if v:GetVelocity():Length() <= 1 then
					v:SetNoDraw(true)
				else
					v:SetNoDraw(false)
				end
			else
				v:SetNoDraw(false)
			end
		end
	end
	hook.Add("Think","SetPlayerCamoAlpha",CheckPlayerStill)
	
	local function CheckPlayerDead(ply)
		local CamoIsOn = ply:GetNWBool("CamoEnabled")
		
		if CamoIsOn then
			ply:SetNWBool("CamoEnabled",false)
			NPC_SwitchRelationship(ply,false)
		end
	end
	hook.Add("PlayerDeath","RemoveDeadPlayerCamo",CheckPlayerDead)
end

function SWEP:SecondaryAttack()
	return
end

function SWEP:Initialize()
	self:SetWeaponHoldType(self.HoldType)
end

function SWEP:Deploy()
	self:SetNextPrimaryFire(CurTime() + .2)
	self.Owner:DrawViewModel(false)
end

function SWEP:DrawWorldModel()
	return false
end

function SWEP:Reload()
	return
end