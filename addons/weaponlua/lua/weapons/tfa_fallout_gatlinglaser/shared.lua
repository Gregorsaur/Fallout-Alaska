-- Variables that are used on both client and server
-- Blowback and Gun Naming (when spawned)
SWEP.Gun = ("tfa_fallout_gatlinglaser") -- Must be name of the folder this .lua file is in!
SWEP.BlowbackEnabled = true --Enable Blowback?
SWEP.BlowbackVector = Vector(0,-2.5,0) --Vector to move bone <or root> relative to bone <or view> orientation.
SWEP.BlowbackCurrentRoot = 0 --Amount of blowback currently, for root
SWEP.BlowbackCurrent = 0 --Amount of blowback currently, for bones
SWEP.BlowbackBoneMods =  nil
SWEP.Blowback_Only_Iron = true --Only do blowback on ironsights
SWEP.Blowback_PistolMode = false --Do we recover from blowback when empty?
SWEP.Blowback_Shell_Enabled = false  
SWEP.UseHands				= true
SWEP.Category               = "TFA Fallout Weapons" --Category where you will find your weapons
SWEP.Author					= "Nikkerio"
SWEP.PrintName				= "Gatling Laser"		-- Weapon name (Shown on HUD)	
SWEP.Slot					= 3				-- Slot in the weapon selection menu
SWEP.SlotPos				= 1			-- Position in the slot
SWEP.DrawAmmo				= true		-- Should draw the default HL2 ammo counter
SWEP.DrawWeaponInfoBox		= false		-- Should draw the weapon info box
SWEP.BounceWeaponIcon   	= false		-- Should the weapon icon bounce?
SWEP.DrawCrosshair			= true		-- set false if you want no crosshair
SWEP.Weight					= 300		-- rank relative ot other weapons. bigger is better
SWEP.AutoSwitchTo			= true		-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= false		-- Auto switch from if you pick up a better weapon
SWEP.HoldType 				= "crossbow"		-- how others view you carrying the weapon
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive 
-- you're mostly going to use ar2, smg, shotgun or pistol. rpg makes for good sniper rifles
SWEP.Type = "Rotary Machine Gun"

SWEP.ViewModelFOV			= 70
SWEP.ViewModelFlip			= false
SWEP.ViewModel				= "models/hub/weapons/gatlinglaser/c_gatlinglaser.mdl"	-- Weapon view model
SWEP.WorldModel 			= "models/hub/weapons/gatlinglaser/w_gatlinglaser.mdl"	-- Weapon world model
SWEP.Base					= "tfa_gun_base" --the Base this weapon will work on. PLEASE RENAME THE BASE! 
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true
SWEP.FiresUnderwater 		= false
SWEP.ShowWorldModel			= false

SWEP.WElements = {
	["element_name"] = { type = "Model", model = "models/hub/weapons/gatlinglaser/gatlinglaser.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(19.221, -6.753, 0.518), angle = Angle(-99.351, 3.506, 1.169), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.Primary.Sound			= Sound("weapons/gatlinglaser/wpn_gatlinglaser_fire_lpm.wav")
SWEP.Primary.RPM				= 1800			-- This is in Rounds Per Minute
SWEP.Primary.ClipSize			= 240		-- Size of a clip
SWEP.Primary.DefaultClip		= 240		-- Bullets you start with
SWEP.Primary.KickUp				= 0.005		-- Maximum up recoil (rise)
SWEP.Primary.KickDown			= 0.005		-- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal		= 0.005		-- Maximum up recoil (stock)
SWEP.Primary.Automatic			= true		-- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo			= "StriderMinigun"			-- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. 
--Use AirboatGun for a light metal peircing shotgun pellets

SWEP.Secondary.IronFOV			= 70		-- How much you 'zoom' in. Less is more! 	

SWEP.data 				= {}				--The starting firemode
SWEP.data.ironsights	= 0

SWEP.Primary.Damage		= 10	-- Base damage per bullet
SWEP.Primary.Spread		= .06	-- Define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.IronAccuracy = .0030 -- Ironsight accuracy, should be the same for shotguns
SWEP.Primary.NumShots	= 1  	-- How many bullets to shoot per trigger pull

-- Enter iron sight info and bone mod info below
SWEP.SightsPos = Vector()
SWEP.SightsAng = Vector()
SWEP.RunSightsPos = Vector ()
SWEP.RunSightsAng = Vector ()
SWEP.InspectPos = Vector()
SWEP.InspectAng = Vector()

SWEP.Offset = {
        Pos = {
        Up =2,
        Right = 0,
        Forward = 12,
        },
        Ang = {
        Up = 0,
        Right = -3,
        Forward = 180,
        },
		Scale = 1.0
}

SWEP.IronSightsMoveSpeed = 1.00 --Multiply the player's movespeed by this when sighting.

SWEP.MuzzleFlashEffect = nil --Change to a string of your muzzle flash effect.  Copy/paste one of the existing from the base.
SWEP.MuzzleFlashEnabled = true

SWEP.ShootWhileDraw=false --Can you shoot while draw anim plays?
SWEP.AllowReloadWhileDraw=false --Can you reload while draw anim plays?
SWEP.SightWhileDraw=false --Can we sight in while the weapon is drawing / the draw anim plays?
SWEP.AllowReloadWhileHolster=true --Can we interrupt holstering for reloading?
SWEP.ShootWhileHolster=true --Cam we interrupt holstering for shooting?
SWEP.SightWhileHolster=false --Cancel out "iron"sights when we holster?
SWEP.UnSightOnReload=true --Cancel out ironsights for reloading.
SWEP.AllowReloadWhileSprinting=false --Can you reload when close to a wall and facing it?
SWEP.AllowReloadWhileNearWall=false --Can you reload when close to a wall and facing it?
SWEP.SprintBobMult=0.8 -- More is more bobbing, proportionally.  This is multiplication, not addition.  You want to make this > 1 probably for sprinting.
SWEP.IronBobMult=1  -- More is more bobbing, proportionally.  This is multiplication, not addition.  You want to make this < 1 for sighting, 0 to outright disable.
SWEP.AllowViewAttachment = true --Allow the view to sway based on weapon attachment while reloading or drawing, only if they have convars enabled

SWEP.LuaShellEject = false
SWEP.LuaShellEjectDelay = 0

SWEP.TracerName 		= "effect_fo3_laser" 	--Change to a string of your tracer name.  Can be custom.--There is a nice example at https://github.com/garrynewman/garrysmod/blob/master/garrysmod/gamemodes/base/entities/effects/tooltracer.lua
SWEP.TracerCount 		= 1 	--0 disables, otherwise, 1 in X chance

--nZombies Stuff
SWEP.DisableChambering = true
SWEP.Primary.MaxAmmo = 240
-- Max Ammo function
function SWEP:NZMaxAmmo()

    local ammo_type = self:GetPrimaryAmmoType() or self.Primary.Ammo

    if SERVER then
        self.Owner:SetAmmo( self.Primary.MaxAmmo, ammo_type )
    end
end
-- PaP Function
SWEP.NZPaPName                = "Death Incinerator"
function SWEP:OnPaP()
self.Ispackapunched = 1
self.Primary.Damage = self.Primary.Damage*2
self.Primary.ClipSize = 510
self.Primary.MaxAmmo = 510
self:ClearStatCache()
return true
end