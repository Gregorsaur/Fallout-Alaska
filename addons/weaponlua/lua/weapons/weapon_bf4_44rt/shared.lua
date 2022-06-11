SWEP.RTOpaque				= true
SWEP.Category				= "Fallout"
SWEP.Author				= ""
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions				= ""
SWEP.MuzzleAttachment			= "1" 	-- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment			= "2" 	-- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName				= ".44 Magnum"		-- Weapon name (Shown on HUD)	
SWEP.Slot				= 1				-- Slot in the weapon selection menu
SWEP.SlotPos				= 21			-- Position in the slot
SWEP.DrawAmmo				= true		-- Should draw the default HL2 ammo counter
SWEP.DrawWeaponInfoBox			= false		-- Should draw the weapon info box
SWEP.BounceWeaponIcon   		= 	false	-- Should the weapon icon bounce?
SWEP.DrawCrosshair			= true		-- set false if you want no crosshair
SWEP.Weight				= 30			-- rank relative ot other weapons. bigger is better
SWEP.AutoSwitchTo			= true		-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true		-- Auto switch from if you pick up a better weapon
SWEP.HoldType 				= "pistol"		-- how others view you carrying the weapon
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive 
-- you're mostly going to use ar2, smg, shotgun or pistol. rpg and crossbow make for good sniper rifles


SWEP.SelectiveFire		= false
SWEP.CanBeSilenced		= false
SWEP.ViewModelFOV			= 70
SWEP.ViewModelFlip			= false
SWEP.ViewModel				= "models/weapons/v_4ist_deagle.mdl"	-- Weapon view model
SWEP.WorldModel				= "models/weapons/w_4ist_deagle.mdl"	
SWEP.Base				= "tfa_gun_base"
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true
SWEP.FiresUnderwater = false
SWEP.DisableChambering = true
SWEP.FireModeName = "Revolver"
SWEP.Primary.Sound			= Sound("4eapon_DEagle.Single")		-- Script that calls the primary fire sound
SWEP.Primary.RPM			= 400			-- This is in Rounds Per Minute
SWEP.Primary.ClipSize			= 6		-- Size of a clip
SWEP.Primary.DefaultClip		= 36		-- Bullets you start with
SWEP.Primary.KickUp				= 0.3		-- Maximum up recoil (rise)
SWEP.Primary.KickDown			= 0.3		-- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal		= 0.3		-- Maximum up recoil (stock)
SWEP.Primary.Automatic			= false		-- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo			= "357"			-- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a light metal peircing shotgun pellets

SWEP.Secondary.IronFOV			= 70		-- How much you 'zoom' in. Less is more! 	

SWEP.data 				= {}				--The starting firemode
SWEP.data.ironsights			= 1
SWEP.Primary.NumShots	= 1		-- How many bullets to shoot per trigger pull
SWEP.Primary.Damage		= 79	-- Base damage per bullet
SWEP.Primary.Spread		= .025	-- Define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.IronAccuracy = .0001 -- Ironsight accuracy, should be the same for shotguns

-- Enter iron sight info and bone mod info below
SWEP.SightsPos = Vector(-3.141, 0, 0.899)
SWEP.SightsAng = Vector(-0.301, 0, 0)
SWEP.RunSightsPos = Vector (1.399, -11.801, -8.521)
SWEP.RunSightsAng = Vector (60.9, -1.101, 0)
SWEP.InspectPos = Vector(2.319, -5.6, -2.481)
SWEP.InspectAng = Vector(13.199, 23.399, 0)
SWEP.IronSightsPos_DEL = Vector(-3.161, -2.681, 0.119)
SWEP.IronSightsAng_DEL = Vector(1.6, -0.101, 0)
SWEP.IronSightsPos_PRIS = Vector(-3.1, -5.56, 0)
SWEP.IronSightsAng_PRIS = Vector(0.1, 0.5, 0)
SWEP.VElements = {
	["detla_sprite"] = { type = "Sprite", sprite = "sprites/redglow2", bone = "Gun", rel = "delta", pos = Vector(0.321, 0, 0.718), size = { x = 0.279, y = 0.279 }, color = Color(255, 255, 255, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false,active = false},
	["delta"] = { type = "Model", model = "models/robotnik_attachments/robotnik_delta.mdl", bone = "Gun", rel = "", pos = Vector(0, 0.33, 1.21), angle = Angle(0, 90, 0), size = Vector(0.435, 0.435, 0.435), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {},active = false },
	["prisma_rtcircle"] = { type = "Model", model = "models/rtcircle.mdl", bone = "Gun", rel = "prisma", pos = Vector(-0.01, -1.573, 0.899), angle = Angle(0, 90, 0), size = Vector(0.221, 0.221, 0.221), color = Color(255, 255, 255, 255), surpresslightning = false, material = "!tfa_rtmaterial", skin = 0, bodygroup = {},active = false },
	["prisma"] = { type = "Model", model = "models/robotnik_attachments/robotnik_prisma.mdl", bone = "Gun", rel = "", pos = Vector(-0.005, -0.242, 1.437), angle = Angle(0, 180, 0), size = Vector(0.351, 0.351, 0.351), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {},active = false }
}

SWEP.Attachments = {
	[2] = {
		header = "Sight",
		offset = {0, 0},
		atts = {"delta","prisma"}
	}
}
SWEP.Offset = {
        Pos = {
        Up = 1,
        Right = 0,
        Forward = -1,
        },
        Ang = {
        Up = 90,
        Right = 0,
        Forward = 180,
        },
		Scale = 1.0
}
