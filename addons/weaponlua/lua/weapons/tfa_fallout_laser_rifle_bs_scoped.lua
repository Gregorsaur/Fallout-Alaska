SWEP.Category				= "TFA Fallout" --Category where you will find your weapons
SWEP.MuzzleAttachment			= "1" 	-- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.Author					= "XxYanKy700xX"
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions				= ""
SWEP.PrintName				= "Laser Rifle BS Scoped" -- Weapon name (Shown on HUD)	
SWEP.Slot				= 2				-- Slot in the weapon selection menu
SWEP.SlotPos				= 3			-- Position in the slot
SWEP.DrawAmmo				= true		-- Should draw the default HL2 ammo counter
SWEP.DrawWeaponInfoBox		= false		-- Should draw the weapon info box
SWEP.BounceWeaponIcon   	= false		-- Should the weapon icon bounce?
SWEP.DrawCrosshair			= true		-- set false if you want no crosshair
SWEP.Weight					= 300		-- rank relative ot other weapons. bigger is better
SWEP.AutoSwitchTo			= true		-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true		-- Auto switch from if you pick up a better weapon
SWEP.HoldType 				= "ar2"		-- how others view you carrying the weapon
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive 
-- you're mostly going to use ar2, smg, shotgun or pistol. rpg makes for good sniper rifles

SWEP.Type = "Energy Weapon"

SWEP.ViewModelFOV			= 70
SWEP.VMPos          = Vector(-2, -5, -1)
SWEP.VMAng          = Vector(2, -1, 0)
SWEP.ViewModel				= "models/weapons/laserrifle/c_laserrifle_beamsprittler_scoped.mdl"	-- Weapon view model
SWEP.WorldModel 			= "models/weapons/laserrifle/w_laserrifle_beamsplitter_scoped.mdl"	-- Weapon world model
SWEP.Base				    = "tfa_3dscoped_base" --the Base this weapon will work on. PLEASE RENAME THE BASE! 
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true
SWEP.FiresUnderwater = false
SWEP.UseHands = true

SWEP.WElements = {}

SWEP.Primary.Sound			= Sound("weapons/laserrifle/laserrifle_fire_3d01.wav")
SWEP.Primary.RPM			= 300			-- This is in Rounds Per Minute
SWEP.Primary.ClipSize			= 24		-- Size of a clip
SWEP.Primary.DefaultClip		= 0		-- Bullets you start with
SWEP.Primary.KickUp			= 0		-- Maximum up recoil (rise)
SWEP.Primary.KickDown			= 0		-- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal		= 0		-- Maximum up recoil (stock)
SWEP.Primary.Automatic			= false	-- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo			    = "MicrofusionCellsss" -- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
SWEP.DisableChambering          = true                      -- Disable round-in-the-chamber
SWEP.Primary.NumShots	= 2  	-- How many bullets to shoot per trigger pull
SWEP.MaxPenetrationCounter    = 1                 -- The maximum number of ricochets.  To prevent stack overflows.
SWEP.Primary.Velocity          = 1500          -- Bullet Velocity in m/s
SWEP.Primary.SpreadMultiplierMax = 3           -- How far the spread can expand when you shoot. Example val: 2.5
SWEP.Primary.SpreadIncrement     = 2           -- What percentage of the modifier is added on, per shot.  Example val: 1/3.5
SWEP.Primary.SpreadRecovery      = 3.5         -- How much the spread recovers, per second. Example val: 3

-- Pistol, buckshot, and slam always ricochet. 
-- Use AirboatGun for a light metal peircing shotgun pellets

SWEP.Secondary.IronFOV			= 70		-- How much you 'zoom' in. Less is more! 	

SWEP.data 				= {}				--The starting firemode

SWEP.Primary.Damage		= 19.2	-- Base damage per bullet
SWEP.Primary.DamageType        = ( bit.bor( DMG_BULLET, DMG_SHOCK ) ) -- See DMG enum.  This might be DMG_SHOCK, DMG_BURN, DMG_BULLET, etc.  Leave nil to autodetect.  DMG_AIRBOAT opens doors.
SWEP.Primary.Spread		= .015	-- Define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.IronAccuracy = .0015 -- Ironsight accuracy, should be the same for shotguns

-- Enter iron sight info and bone mod info below
SWEP.IronSightsPos = Vector(-2.56, 3, -0.345)
SWEP.IronSightsAng = Vector(0, 0, 0)
SWEP.ScopeReticule_Scale = {1.45, 1.45}
SWEP.RTScopeOffset = {187.5, -13}
SWEP.RTScopeFOV = 40

SWEP.Secondary.ScopeZoom = 5
SWEP.ScopeAngleTransforms = {
	{ "R", 180 },
	{ "P", 0.8 }, -- 0
	{ "Y", 3.3 }  -- 15
}

SWEP.ScopeOverlayTransforms = { -0.05, 0.05 }
SWEP.ScopeOverlayTransformMultiplier = 0

local scope = {}

SWEP.ScopeReticule = ("models/weapons/tfa_ins2/optics/4x_reticule")

local rt

if surface then
    rt = surface.GetTextureID("models/weapons/tfa_ins2/optics/4x_reticule")
end

--[[SCOPES]]--

SWEP.IronSightsSensitivity = 1          -- Useful for a RT scope.  Change this to 0.25 for 25% sensitivity.  This is if normal FOV compenstaion isn't your thing for whatever reason, so don't change it for normal scopes.
SWEP.BoltAction            = false      -- Unscope/sight after you shoot?
SWEP.Scoped                = false      -- Draw a scope overlay?
SWEP.ScopeOverlayThreshold = 0.875      -- Percentage you have to be sighted in to see the scope.
SWEP.BoltTimerOffset       = 0.25       -- How long you stay sighted in after shooting, with a bolt action.
SWEP.ScopeScale            = 0.5        -- Scale of the scope overlay
SWEP.ReticleScale          = 0.7        -- Scale of the reticle overlay

--[[RENDER TARGET]]--

SWEP.RTMaterialOverride = -1            -- Take the material you want out of print(LocalPlayer():GetViewModel():GetMaterials()), subtract 1 from its index, and set it to this.
SWEP.RTScopeAttachment  = 1
SWEP.RTOpaque           = true          -- Do you want your render target to be opaque?
SWEP.RTCode             = nil           -- function(self) return end --This is the function to draw onto your rendertarget

--[[ SPRINTING ]]--

SWEP.RunSightsPos = Vector(2, -1, -2.65)
SWEP.RunSightsAng = Vector(-20, 30, -30)

SWEP.InspectPos = Vector(6, -3, -1)
SWEP.InspectAng = Vector(12, 37.277, 3.2)

SWEP.VElements = {
	["rtcircle"] = { type = "Model", model = "models/weapons/laserrifle/c_laserrifle_scoped_reticle.mdl", bone = "Tribeam", rel = "", pos = Vector(2.7, 20, 8.18), angle = Angle(0, 90, 90), size = Vector(1.05, 1.05, 1.05), color = Color(255, 255, 255, 255), surpresslightning = false, material = "!tfa_rtmaterial", skin = 0, bodygroup = {}, bonemerge = false }
}

--[ ANIMATION ]--
SWEP.StatusLengthOverride = {        -- Changes the status delay of a given animation; only used on reloads.  Otherwise, use SequenceLengthOverride or one of the others
	[ACT_VM_RELOAD] = 45 / 30,
} 

SWEP.Sights_Mode = TFA.Enum.LOCOMOTION_HYBRID -- ANI = mdl, HYBRID = lua but continue idle, Lua = stop mdl animation
SWEP.Idle_Mode = TFA.Enum.IDLE_BOTH --TFA.Enum.IDLE_DISABLED = no idle, TFA.Enum.IDLE_LUA = lua idle, TFA.Enum.IDLE_ANI = mdl idle, TFA.Enum.IDLE_BOTH = TFA.Enum.IDLE_ANI + TFA.Enum.IDLE_LUA
SWEP.Sprint_Mode = TFA.Enum.LOCOMOTION_LUA -- ANI = mdl, HYBRID = ani + lua, Lua = lua only
SWEP.SprintBobMult = 1.35-- More is more bobbing, proportionally.  This is multiplication, not addition.  You want to make this > 1 probably for sprinting.

SWEP.TracerName 		= "tfa_fallout_tracer_fo3_laser" 	--Change to a string of your tracer name.  Can be custom.--There is a nice example at https://github.com/garrynewman/garrysmod/blob/master/garrysmod/gamemodes/base/entities/effects/tooltracer.lua
SWEP.TracerCount 		= 1 	--0 disables, otherwise, 1 in X chance

SWEP.BlowbackEnabled = true --Enable Blowback?
SWEP.BlowbackVector = Vector(0,-3.65,-0.3) --Vector to move bone <or root> relative to bone <or view> orientation.
SWEP.Blowback_Only_Iron = false --Only do blowback on ironsights
SWEP.Blowback_PistolMode = false --Do we recover from blowback when empty?
SWEP.Blowback_Shell_Enabled = false --Shoot shells through blowback animations
SWEP.Blowback_Shell_Effect = "ShellEject"--Which shell effect to use
SWEP.LuaShellEject = false --Enable shell ejection through lua?
SWEP.LuaShellEjectDelay = 0 --The delay to actually eject things
SWEP.LuaShellEffect = "PistolShellEject" --The effect used for shell ejection; Defaults to that used for blowback

SWEP.MuzzleFlashEffect          = "tfa_fallout_muzzleflash_laser" -- Change to a string of your muzzle flash effect.  Copy/paste one of the existing from the base.
SWEP.MuzzleFlashEnabled = true

SWEP.Offset = { -- Procedural world model animation, defaulted for CS:S purposes.
	Pos = {
		Up = 0.25,
		Right = 0.3,
		Forward = 11
	},
	Ang = {
		Up = 0,
		Right = -10,
		Forward = 180
	},
	Scale = 1.35
}

SWEP.Primary.Range               = 1.5 * (3280.84 * 16)     -- The distance the bullet can travel in source units.  Set to -1 to autodetect based on damage/rpm.
SWEP.Primary.RangeFalloff        = 1                        -- The percentage of the range the bullet damage starts to fall off at.  Set to 0.8, for example, to start falling off after 80% of the range.

SWEP.IronRecoilMultiplier     = 0.75              -- Multiply recoil by this factor when we're in ironsights.  This is proportional, not inversely.
SWEP.CrouchAccuracyMultiplier = 0.75              -- Less is more.  Accuracy * 0.5 = Twice as accurate, Accuracy * 0.1 = Ten times as accurate