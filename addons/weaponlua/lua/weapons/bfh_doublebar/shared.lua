SWEP.BlowbackEnabled = true --Enable Blowback?
SWEP.BlowbackVector = Vector(0,-4,0) --Vector to move bone <or root> relative to bone <or view> orientation.
SWEP.BlowbackCurrentRoot = 0 --Amount of blowback currently, for root
SWEP.BlowbackCurrent = 0 --Amount of blowback currently, for bones
SWEP.BlowbackBoneMods = nil --Viewmodel bone mods via SWEP Creation Kit
SWEP.Blowback_Only_Iron = false --Only do blowback on ironsights
SWEP.Blowback_PistolMode = false --Do we recover from blowback when empty?
SWEP.Blowback_Shell_Enabled = false
SWEP.Blowback_Shell_Effect = "RifleShellEject"-- ShotgunShellEject shotgun or ShellEject for a SMG    

SWEP.Category				= "Fallout"
SWEP.Author				= ""
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions				= ""
SWEP.MuzzleAttachment			= "1" 	-- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment			= "2" 	-- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName				= "Double Barrel Shotgun"		-- Weapon name (Shown on HUD)	
SWEP.Slot				= 3				-- Slot in the weapon selection menu
SWEP.SlotPos				= 25			-- Position in the slot
SWEP.DrawAmmo				= true		-- Should draw the default HL2 ammo counter
SWEP.DrawWeaponInfoBox			= false		-- Should draw the weapon info box
SWEP.BounceWeaponIcon   		= 	false	-- Should the weapon icon bounce?
SWEP.DrawCrosshair			= true		-- set false if you want no crosshair
SWEP.Weight				= 30			-- rank relative ot other weapons. bigger is better
SWEP.AutoSwitchTo			= true		-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true		-- Auto switch from if you pick up a better weapon
SWEP.HoldType 				= "shotgun"	-- how others view you carrying the weapon
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive 
-- you're mostly going to use ar2, smg, shotgun or pistol. rpg and crossbow make for good sniper rifles

SWEP.ViewModelFOV			= 70
SWEP.ViewModelFlip			= false
SWEP.ViewModel				= "models/weapons/v_bfh_dblbarrel.mdl"	-- Weapon view model
SWEP.WorldModel				= "models/weapons/w_shot_m3super90.mdl"	-- Weapon world model
SWEP.Base 				= "tfa_shotty_base"
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true

SWEP.Primary.Sound			= Sound("bfh_doublebarrel.Single")		-- script that calls the primary fire sound
SWEP.Primary.RPM				= 1000		-- This is in Rounds Per Minute
SWEP.Primary.ClipSize			= 2			-- Size of a clip
SWEP.Primary.DefaultClip		= 20	-- Default number of bullets in a clip
SWEP.Primary.KickUp				= 3				-- Maximum up recoil (rise)
SWEP.Primary.KickDown			= 1		-- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal		= 2	-- Maximum up recoil (stock)
SWEP.Primary.Automatic			= false		-- Automatic/Semi Auto
SWEP.Primary.Ammo			= "buckshot"	-- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a light metal peircing shotgun pellets

SWEP.Secondary.IronFOV			= 55		-- How much you 'zoom' in. Less is more! 
SWEP.ShellTime			= .0001

SWEP.data 				= {}				--The starting firemode
SWEP.data.ironsights			= 1

SWEP.Primary.NumShots	= 10		-- How many bullets to shoot per trigger pull, AKA pellets
SWEP.Primary.Damage		= 18	-- Base damage per bullet
SWEP.Primary.Spread		= .043	-- Define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.IronAccuracy = .043	-- Ironsight accuracy, should be the same for shotguns
-- Because irons don't magically give you less pellet spread!

-- Enter iron sight info and bone mod info below
SWEP.SightsPos = Vector(-1.231, 0, 1.409)
SWEP.SightsAng = Vector(-0.401, 0.2, 0)
SWEP.RunSightsPos = Vector(3.319, 0, 0.519)
SWEP.RunSightsAng = Vector(-22.101, 28.6, -12.9)
SWEP.InspectPos = Vector(9.319, 0, -0.48)
SWEP.InspectAng = Vector(7.8, 33.7, 8.3)
SWEP.ViewModelBoneMods = {
	["l_thumb_low"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-6.731, -8.296, -2.898) }
}


SWEP.Offset = {
        Pos = {
        Up = 0,
        Right = 0,
        Forward = -2,
        },
        Ang = {
        Up = 0,
        Right = -9,
        Forward = 180,
        },
		Scale = 1.0
}
if GetConVar("sv_tfa_default_clip") == nil then
	print("sv_tfa_default_clip is missing!  You might've hit the lua limit.  Contact the SWEP author(s).")
else
	if GetConVar("sv_tfa_default_clip"):GetInt() != -1 then
		SWEP.Primary.DefaultClip = SWEP.Primary.ClipSize * GetConVar("sv_tfa_default_clip"):GetInt()
	end
end

if GetConVar("sv_tfa_unique_slots") != nil then
	if not (GetConVar("sv_tfa_unique_slots"):GetBool()) then 
		SWEP.SlotPos = 2
	end
end