SWEP.Base			    	= "tfa_3dscoped_base"
SWEP.Category				= "TFA Fallout"           -- The category.  Please, just choose something generic or something I've already done if you plan on only doing like one swep..
SWEP.Manufacturer           = ""                      -- Gun Manufactrer (e.g. Hoeckler and Koch )
SWEP.Author				    = "XxYanKy700xX"          -- Author Tooltip
SWEP.Contact				= ""                      -- Contact Info Tooltip
SWEP.Purpose				= ""                      -- Purpose Tooltip
SWEP.Instructions			= ""                      --Instructions Tooltip
SWEP.Spawnable				= true                    -- INSTALL SHARED PARTS
SWEP.AdminSpawnable			= true                    -- Can an adminstrator spawn this?  Does not tie into your admin mod necessarily, unless its coded to allow for GMod's default ranks somewhere in its code.  Evolve and ULX should work, but try to use weapon restriction rather than these.
SWEP.DrawCrosshair			= true                    -- Draw the crosshair?
SWEP.DrawCrosshairIS        = false                   -- Draw the crosshair in ironsights?
SWEP.PrintName				= "Bozar"                 -- Weapon name (Shown on HUD)
SWEP.Slot				    = 2		                  -- Slot in the weapon selection menu.  Subtract 1, as this starts at 0.
SWEP.SlotPos				= 73	                  -- Position in the slot
SWEP.AutoSwitchTo			= true                    -- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true                    -- Auto switch from if you pick up a better weapon
SWEP.Weight				= 30		                  -- This controls how "good" the weapon is for autopickup.

--[[EFFECTS]]--

--Attachments--
SWEP.MuzzleAttachment	  = "muzzle" 		-- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellAttachment	  = "shell" 		-- Should be "2" for CSS models or "shell" for hl2 models
SWEP.MuzzleFlashEnabled   = true            -- Enable muzzle flash
SWEP.MuzzleAttachmentRaw  = 1               -- This will override whatever string you gave.  This is the raw attachment number.  This is overridden or created when a gun makes a muzzle event.
SWEP.AutoDetectMuzzleAttachment = false     -- For multi-barrel weapons, detect the proper attachment?
SWEP.MuzzleFlashEffect    = "tfa_muzzleflash_rifle" -- Change to a string of your muzzle flash effect.  Copy/paste one of the existing from the base.
SWEP.SmokeParticle        = nil             -- Smoke particle (ID within the PCF), defaults to something else based on holdtype; "" to disable
SWEP.EjectionSmokeEnabled = false           -- Disable automatic ejection smoke

-- Shell eject override
SWEP.LuaShellEject      = true         -- Enable shell ejection through lua?
SWEP.LuaShellEjectDelay = 0            -- The delay to actually eject things
SWEP.LuaShellEffect     = "RifleShellEject" -- The effect used for shell ejection; Defaults to that used for blowback

-- Tracer Stuff
SWEP.TracerName 		= nil 	       -- Change to a string of your tracer name.  Can be custom. There is a nice example at https://github.com/garrynewman/garrysmod/blob/master/garrysmod/gamemodes/base/entities/effects/tooltracer.lua
SWEP.TracerCount 		= 3 	       -- 0 disables, otherwise, 1 in X chance

--[[ WEAPON HANDLING ]]--

SWEP.Primary.Sound          = Sound("weapons/fallout_new_vegas/bozar/wpn_bozar_fire_2d_01.wav") -- This is the sound of the weapon, when you shoot.

SWEP.Primary.PenetrationMultiplier = 1.2       -- Change the amount of something this gun can penetrate through
SWEP.Primary.Damage            = 24            -- Damage, in standard damage points.
SWEP.Primary.DamageTypeHandled = true          -- true will handle damagetype in base
SWEP.Primary.DamageType        = nil           -- See DMG enum.  This might be DMG_SHOCK, DMG_BURN, DMG_BULLET, etc.  Leave nil to autodetect.  DMG_AIRBOAT opens doors.
SWEP.Primary.Force             = nil           -- Force value, leave nil to autocalc
SWEP.Primary.Knockback         = nil           -- Autodetected if nil; this is the velocity kickback
SWEP.Primary.HullSize          = 0             -- Big bullets, increase this value.  They increase the hull size of the hitscan bullet.
SWEP.Primary.NumShots          = 1             -- The number of shots the weapon fires.  SWEP.Shotgun is NOT required for this to be >1.
SWEP.Primary.Automatic         = true          -- Automatic/Semi Auto
SWEP.Primary.RPM               = 600           -- This is in Rounds Per Minute / RPM
SWEP.Primary.BurstDelay        = nil           -- Delay between bursts, leave nil to autocalculate
SWEP.Primary.Velocity          = 800           -- Bullet Velocity in m/s
SWEP.FiresUnderwater           = false         -- Enable or Disable fire Under Water

--[[ Ammo Related ]]--

SWEP.Primary.ClipSize           = 30                        -- This is the size of a clip
SWEP.Primary.DefaultClip        = 0                         -- This is the number of bullets the gun gives you, counting a clip as defined directly above.
SWEP.Primary.Ammo               = "556mm"                   -- What kind of ammo.  Options, besides custom, include pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, and AirboatGun.
SWEP.Primary.AmmoConsumption    = 1                         -- Ammo consumed per shot
SWEP.DisableChambering          = true                      -- Disable round-in-the-chamber

--[[ Recoil Related ]]--

SWEP.Primary.KickUp             = 0.45                      -- This is the maximum upwards recoil (rise)
SWEP.Primary.KickDown           = 0.45                      -- This is the maximum downwards recoil (skeet)
SWEP.Primary.KickHorizontal     = 0.18                      -- This is the maximum sideways recoil (no real term)
SWEP.Primary.StaticRecoilFactor = 0.5                       -- Amount of recoil to directly apply to EyeAngles.  Enter what fraction or percentage (in decimal form) you want.  This is also affected by a convar that defaults to 0.5.

--[[ Firing Cone Related ]]--

SWEP.Primary.Spread              = .030         -- This is hip-fire acuracy.  Less is more (1 is horribly awful, .0001 is close to perfect)
SWEP.Primary.IronAccuracy        = .0025        -- Ironsight accuracy, should be the same for shotguns

-- Unless you can do this manually, autodetect it.  If you decide to manually do these, uncomment this block and remove this line.

SWEP.Primary.SpreadMultiplierMax = 4            -- How far the spread can expand when you shoot. Example val: 2.5
SWEP.Primary.SpreadIncrement     = 1.25         -- What percentage of the modifier is added on, per shot.  Example val: 1/3.5
SWEP.Primary.SpreadRecovery      = 5.92         -- How much the spread recovers, per second. Example val: 3

--[[ Movespeed ]]--

SWEP.MoveSpeed           = 1                      -- Multiply the player's movespeed by this.
SWEP.IronSightsMoveSpeed = 0.9                    -- Multiply the player's movespeed by this when sighting.


--[[ Range Related ]]--

SWEP.Primary.Range        = 0.06 * (3280.84 * 16) -- The distance the bullet can travel in source units.  Set to -1 to autodetect based on damage/rpm.
SWEP.Primary.RangeFalloff = 0.85                  -- The percentage of the range the bullet damage starts to fall off at.  Set to 0.8, for example, to start falling off after 80% of the range.

--[[ Penetration Related ]]--

SWEP.MaxPenetrationCounter    = 3                 -- The maximum number of ricochets.  To prevent stack overflows.

--[[ Misc ]]--

SWEP.IronRecoilMultiplier     = 0.75              -- Multiply recoil by this factor when we're in ironsights.  This is proportional, not inversely.
SWEP.CrouchAccuracyMultiplier = 0.75              -- Less is more.  Accuracy * 0.5 = Twice as accurate, Accuracy * 0.1 = Ten times as accurate

--[[ Selective Fire Stuff ]]--

SWEP.SelectiveFire    = true      -- Allow selecting your firemode?
SWEP.DisableBurstFire = true      -- Only auto/single?
SWEP.OnlyBurstFire    = false     -- No auto, only burst/single?
SWEP.DefaultFireMode  = ""        -- Default to auto or whatev
SWEP.FireModeName     = nil       -- Change to a text value to override it

-- [[ IRONSIGHTS ]] --

SWEP.data = {}
SWEP.data.ironsights   = 1  -- Enable Ironsights

SWEP.Secondary.IronFOV = 70 -- How much you 'zoom' in. Less is more!  Don't have this be <= 0.  A good value for ironsights is like 70.

SWEP.IronSightsPos     = Vector(-6.15, -4.2, 1.015)
SWEP.IronSightsAng     = Vector(0, 0.225, 0)

SWEP.Secondary.ScopeZoom = 15

SWEP.ScopeAngleTransforms = {
	{ "R", -88.9 },
	{ "P", -0.2 },
	{ "Y", 0.68 }
}

SWEP.ScopeOverlayTransforms = { -0.05, 0.05 }

SWEP.ScopeOverlayTransformMultiplier = 0

local scope = {}

SWEP.ScopeReticule = ("scope/gdcw_elcanreticle")

local rt

if surface then
    rt = surface.GetTextureID("scope/gdcw_elcanreticle")
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

SWEP.RunSightsPos   = Vector(1, -8.5, -5)
SWEP.RunSightsAng   = Vector(-0, 40, -15)

--[[INSPECTION]]--

SWEP.InspectPos   = Vector(5, -5, -1.5)
SWEP.InspectAng   = Vector(15, 32.417, 5)

--[[ VIEWMODEL ]]--

SWEP.ViewModel		= "models/weapons/tfa_fallout/c_fallout_bozar.mdl" -- Viewmodel path

SWEP.VMPos          = Vector(-2, -6, -0.25)
SWEP.VMAng          = Vector(0, 0, 0)
SWEP.VMPos_Additive = false                -- Set to false for an easier time using VMPos. If true, VMPos will act as a constant delta ON TOP OF ironsights, run, whateverelse

SWEP.ViewModelFOV   = 70		           -- This controls how big the viewmodel looks.  Less is more.
SWEP.ViewModelFlip  = false		           -- Set this to true for CSS models, or false for everything else (with a righthanded viewmodel.)
SWEP.UseHands       = true                 -- Use gmod c_arms system.
  
SWEP.CenteredPos    = nil                  -- The viewmodel positional offset, used for centering.  Leave nil to autodetect using ironsights.
SWEP.CenteredAng    = nil                  -- The viewmodel angular offset, used for centering.  Leave nil to autodetect using ironsights.
SWEP.Bodygroups_V   = {}

--[[ WORLDMODEL ]]--

SWEP.WorldModel	    = "models/weapons/tfa_fallout/w_fallout_bozar.mdl" -- Weapon world model path
SWEP.Bodygroups_W   = {}                                    -- Weapon World model BodyGroups
SWEP.HoldType       = "ar2"                              -- This is how others view you carrying the weapon. Options include:

-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive
-- You're mostly going to use ar2, smg, shotgun or pistol. rpg and crossbow make for good sniper rifles

SWEP.Offset = {
	Pos = {
        Up = 0,
        Right = 0,
        Forward = 0,
	},
	Ang = {
        Up = 0,
        Right = -9,
        Forward = 180,
	},
	Scale = 1
}

SWEP.ThirdPersonReloadDisable  = false    -- Disable third person reload?  True disables.

--[[ANIMATION]]--

SWEP.StatusLengthOverride = {        -- Changes the status delay of a given animation; only used on reloads.  Otherwise, use SequenceLengthOverride or one of the others
	[ACT_VM_RELOAD] = 37 / 30,
	[ACT_VM_RELOAD_EMPTY] = 80/ 30
} 

SWEP.ProceduralHoslterEnabled   = nil
SWEP.ProceduralHolsterTime      = 0.3
SWEP.ProceduralHolsterPos       = Vector(3, 0, -5)
SWEP.ProceduralHolsterAng       = Vector(-40, -30, 10)

SWEP.Sights_Mode   = TFA.Enum.LOCOMOTION_HYBRID -- ANI = mdl, HYBRID = lua but continue idle, Lua = stop mdl animation
SWEP.Sprint_Mode   = TFA.Enum.LOCOMOTION_LUA    -- ANI = mdl, HYBRID = ani + lua, Lua = lua only
SWEP.SprintBobMult = 1.42
SWEP.Idle_Mode     = TFA.Enum.IDLE_BOTH         -- TFA.Enum.IDLE_DISABLED = no idle, TFA.Enum.IDLE_LUA = lua idle, TFA.Enum.IDLE_ANI = mdl idle, TFA.Enum.IDLE_BOTH = TFA.Enum.IDLE_ANI + TFA.Enum.IDLE_LUA
SWEP.Idle_Blend    = 0.25                       -- Start an idle this far early into the end of a transition
SWEP.Idle_Smooth   = 0.05                       -- Start an idle this far early into the end of another animation

--[[VIEWMODEL ANIMATION HANDLING]]--

SWEP.AllowViewAttachment    = true 

--[[ VIEWMODEL BLOWBACK ]]--

SWEP.BlowbackEnabled        = false          -- Enable Blowback?
SWEP.BlowbackVector         = Vector(0,-2,0) -- Vector to move bone <or root> relative to bone <or view> orientation.
SWEP.BlowbackCurrentRoot    = 0              -- Amount of blowback currently, for root
SWEP.BlowbackCurrent        = 0              -- Amount of blowback currently, for bones
SWEP.BlowbackBoneMods       = nil            -- Viewmodel bone mods via SWEP Creation Kit
SWEP.Blowback_Only_Iron     = true           -- Only do blowback on ironsights
SWEP.Blowback_PistolMode    = false          -- Do we recover from blowback when empty?
SWEP.Blowback_Shell_Enabled = true           -- Shoot shells through blowback animations
SWEP.Blowback_Shell_Effect  = "RifleShellEject"   -- Which shell effect to use

--[[ ATTACHMENTS ]]--

SWEP.Attachments            = {}
SWEP.AttachmentDependencies = {}
SWEP.AttachmentExclusions   = {}

SWEP.ViewModelBoneMods = {
	["valveBiped.Bip01_L_Finger0"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, -180) },
	["valveBiped.Bip01_L_Finger01"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, -180) },
	["valveBiped.Bip01_L_Finger02"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, -180) },
	["valveBiped.Bip01_R_Finger0"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, -180) },
	["valveBiped.Bip01_R_Finger01"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, -180) },
	["valveBiped.Bip01_R_Finger02"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, -180) },
}

SWEP.WorldModelBoneMods = {}

SWEP.VElements = {
	["rtcircle"] = { type = "Model", model = "models/rtcircle.mdl", bone = "v_weapon.sg556_Parent", rel = "", pos = Vector(-0.142, -7.54, -2.1), angle = Angle(-90, 0, 0), size = Vector(0.33, 0.33, 0.33), color = Color(255, 255, 255, 255), surpresslightning = false, material = "!tfa_rtmaterial", skin = 0, bodygroup = {}, bonemerge = false }
}

SWEP.WElements = {}

local wmscale = Vector(1 / 1.3, 1 / 1.3, 1 / 1.3)

SWEP.MuzzleAttachmentSilenced     = 1

SWEP.LaserSightModAttachment      = 1
SWEP.LaserSightModAttachmentWorld = 0
SWEP.LaserDotISMovement           = true

SWEP.Secondary.BashLength   = 50
SWEP.Secondary.BashDamage   = 25
SWEP.Secondary.BashDelay    = 0.15

DEFINE_BASECLASS( SWEP.Base )           -- Allow the view to sway based on weapon attachment while reloading or drawing, IF THE CLIENT HAS IT ENABLED IN THEIR CONVARS.