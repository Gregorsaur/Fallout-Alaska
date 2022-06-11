-- Variables that are used on both client and server
SWEP.Gun = ("nik_m1897trench") -- must be the name of your swep but NO CAPITALS!
if (GetConVar(SWEP.Gun.."_allowed")) != nil then
	if not (GetConVar(SWEP.Gun.."_allowed"):GetBool()) then SWEP.Base = "tfa_blacklisted" SWEP.PrintName = SWEP.Gun return end
end
SWEP.Category				= "TFA Fallout"
SWEP.Author				= ""
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions				= ""
SWEP.MuzzleAttachment			= "1" 	-- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment			= "2" 	-- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName				= "Dinner Bell"		-- Weapon name (Shown on HUD)	
SWEP.Slot				= 3				-- Slot in the weapon selection menu
SWEP.SlotPos				= 31			-- Position in the slot
SWEP.DrawAmmo				= true		-- Should draw the default HL2 ammo counter
SWEP.DrawWeaponInfoBox			= false		-- Should draw the weapon info box
SWEP.BounceWeaponIcon   		= 	false	-- Should the weapon icon bounce?
SWEP.DrawCrosshair			= true	-- set false if you want no crosshair
SWEP.Weight				= 8			-- rank relative ot other weapons. bigger is better
SWEP.AutoSwitchTo			= true		-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true		-- Auto switch from if you pick up a better weapon
SWEP.HoldType 				= "shotgun"	-- how others view you carrying the weapon
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive 
-- you're mostly going to use ar2, smg, shotgun or pistol. rpg and crossbow make for good sniper rifles

SWEP.ViewModelFOV			= 70
SWEP.ViewModelFlip			= false
SWEP.ViewModel				= "models/weapons/v_nik_trenchy.mdl"	-- Weapon view model
SWEP.WorldModel				= "models/weapons/w_nik_trenchy.mdl"	-- Weapon world model
SWEP.Offset = {Pos = {Up = 0.75,Right = 1,Forward = 2.75,},Ang = {Up = 2,Right = -6,Forward = 180},Scale = 1}

SWEP.Base 				= "tfa_shotty_base"
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true

SWEP.Primary.Sound			= Sound("NikM1897.Trig")		-- script that calls the primary fire sound
SWEP.Primary.RPM				= 70		-- This is in Rounds Per Minute
SWEP.Primary.ClipSize			= 6			-- Size of a clip
SWEP.Primary.DefaultClip		= 66	-- Default number of bullets in a clip
SWEP.Primary.KickUp				= 3.9				-- Maximum up recoil (rise)
SWEP.Primary.KickDown			= 2.6		-- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal		= 0.4	-- Maximum up recoil (stock)
SWEP.Primary.Automatic			= false		-- Automatic/Semi Auto
SWEP.Primary.Ammo			= "slam"	-- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a light metal peircing shotgun pellets

SWEP.Secondary.IronFOV			= 60		-- How much you 'zoom' in. Less is more! 

SWEP.data 				= {}				--The starting firemode
SWEP.data.ironsights			= 1

SWEP.ShellTime			= .6

SWEP.Primary.NumShots	= 8		//how many bullets to shoot, use with shotguns
SWEP.Primary.Damage		= 20	//base damage, scaled by game
SWEP.Primary.Spread		= .04	//define from-the-hip accuracy (1 is terrible, .0001 is exact)
SWEP.Primary.IronAccuracy = .04 // has to be the same as primary.spread
-- Because irons don't magically give you less pellet spread!

SWEP.VMPos = Vector(0.5,0,-1) --The viewmodel positional offset, constantly. 
SWEP.VMAng = Vector(3,0,0) --The viewmodel angular offset, constantly. 

SWEP.IronSightsPos = Vector(2.809, 0, 1.48)
SWEP.IronSightsAng = Vector(0, 0, 0)
SWEP.SightsPos = Vector(-2.625, 2, 1)
SWEP.SightsAng = Vector(1, -0.25, -1.75)
SWEP.RunSightsPos = Vector(5, -1, -1)
SWEP.RunSightsAng = Vector(-7, 20, 0)

if ((gmod.GetGamemode().Name) == "Murderthon 9000") or ((gmod.GetGamemode().Name) == "Murderthon 9000 beta") then
	SWEP.Primary.Ammo			= "slam"
else
	SWEP.Primary.Ammo			= "buckshot"
end

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