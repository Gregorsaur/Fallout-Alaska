SWEP.Base				    = "tfa_gun_base"
SWEP.Category				= "TFA Fallout"      -- The category.  Please, just choose something generic or something I've already done if you plan on only doing like one swep..
SWEP.Manufacturer           = ""                 -- Gun Manufactrer (e.g. Hoeckler and Koch )
SWEP.Author				    = "XxYanKy700xX"     -- Author Tooltip
SWEP.Contact				= ""                 -- Contact Info Tooltip
SWEP.Purpose				= ""                 -- Purpose Tooltip
SWEP.Instructions		    = ""                 -- Instructions Tooltip
SWEP.Spawnable				= true               -- Can you, as a normal user, spawn this?
SWEP.AdminSpawnable			= true               -- Can an adminstrator spawn this?  Does not tie into your admin mod necessarily, unless its coded to allow for GMod's default ranks somewhere in its code.  Evolve and ULX should work, but try to use weapon restriction rather than these.
SWEP.DrawCrosshair			= true		         -- Draw the crosshair?
SWEP.DrawCrosshairIS        = false              -- Draw the crosshair in ironsights?
SWEP.PrintName				= "Brush Gun"        -- Weapon name (Shown on HUD)
SWEP.Slot				    = 1			         -- Slot in the weapon selection menu.  Subtract 1, as this starts at 0.
SWEP.SlotPos				= 73			     -- Position in the slot
SWEP.AutoSwitchTo			= true		         -- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true		         -- Auto switch from if you pick up a better weapon
SWEP.Weight				    = 30			     -- This controls how "good" the weapon is for autopickup.
SWEP.Type                   = "Lever Action Rifle"

--[[EFFECTS]]--

--Attachments--
SWEP.MuzzleAttachment	  = "1" 		    -- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellAttachment	  = "2" 	    	-- Should be "2" for CSS models or "shell" for hl2 models
SWEP.MuzzleFlashEnabled   = true            -- Enable muzzle flash
SWEP.MuzzleAttachmentRaw  = nil             -- This will override whatever string you gave.  This is the raw attachment number.  This is overridden or created when a gun makes a muzzle event.
SWEP.AutoDetectMuzzleAttachment = false     -- For multi-barrel weapons, detect the proper attachment?
SWEP.MuzzleFlashEffect    = nil             -- Change to a string of your muzzle flash effect.  Copy/paste one of the existing from the base.
SWEP.SmokeParticle        = nil             -- Smoke particle (ID within the PCF), defaults to something else based on holdtype; "" to disable
SWEP.EjectionSmokeEnabled = false           -- Disable automatic ejection smoke

--Shell eject override--
SWEP.LuaShellEject      = true              -- Enable shell ejection through lua?
SWEP.LuaShellEjectDelay = 0.65
SWEP.LuaShellEffect     = "RifleShellEject"

--Tracer Stuff--
SWEP.TracerName 		= nil -- Change to a string of your tracer name.  Can be custom. There is a nice example at https://github.com/garrynewman/garrysmod/blob/master/garrysmod/gamemodes/base/entities/effects/tooltracer.lua
SWEP.TracerCount 		= 3   -- 0 disables, otherwise, 1 in X chance

--[[SHOTGUN CODE]]--

SWEP.Shotgun                = true      -- Enable shotgun style reloading.
SWEP.ShotgunEmptyAnim       = false     -- Enable emtpy reloads on shotguns?
SWEP.ShotgunEmptyAnim_Shell = false     -- Enable insertion of a shell directly into the chamber on empty reload?
SWEP.ShellTime              = 0.8         -- For shotguns, how long it takes to insert a shell.

--[[ WEAPON HANDLING ]]--

SWEP.Primary.Sound          = Sound("weapons/fallout_new_vegas/brush_gun/wpn_brushgun.wav") -- This is the sound of the weapon, when you shoot.

--Miscelaneous Sounds--
SWEP.IronInSound  = Sound("TFA_INS2.IronIn")  -- Sound to play when ironsighting in?  nil for default
SWEP.IronOutSound = Sound("TFA_INS2.IronOut") -- Sound to play when ironsighting out?  nil for default

SWEP.Primary.PenetrationMultiplier = 1.35     -- Change the amount of something this gun can penetrate through
SWEP.Primary.Damage            = 75           -- Damage, in standard damage points.
SWEP.Primary.NumShots          = 1            -- The number of shots the weapon fires.  SWEP.Shotgun is NOT required for this to be >1.
SWEP.Primary.DamageTypeHandled = true         -- true will handle damagetype in base
SWEP.Primary.DamageType        = nil          -- See DMG enum.  This might be DMG_SHOCK, DMG_BURN, DMG_BULLET, etc.  Leave nil to autodetect.  DMG_AIRBOAT opens doors.
SWEP.Primary.Force             = nil          -- Force value, leave nil to autocalc
SWEP.Primary.Knockback         = nil          -- Autodetected if nil; this is the velocity kickback
SWEP.Primary.HullSize          = 0            -- Big bullets, increase this value.  They increase the hull size of the hitscan bullet.
SWEP.Primary.RPM               = 65           -- This is in Rounds Per Minute / RPM
SWEP.Primary.DryFireDelay      = nil          -- How long you have to wait after firing your last shot before a dryfire animation can play.  Leave nil for full empty attack length.  Can also use SWEP.StatusLength[ ACT_VM_BLABLA ]
SWEP.Primary.BurstDelay        = nil          -- Delay between bursts, leave nil to autocalculate
SWEP.Primary.Velocity          = 940          -- Bullet Velocity in m/s
SWEP.FiresUnderwater           = false

--Selective Fire Stuff--
SWEP.Primary.Automatic = false
SWEP.SelectiveFire     = false          -- Allow selecting your firemode?
SWEP.DisableBurstFire  = false          -- Only auto/single?
SWEP.OnlyBurstFire     = false          -- No auto, only burst/single?
SWEP.DefaultFireMode   = "Lever Action" -- Default to auto or whatev
SWEP.FireModeName      = "Lever Action"

--Ammo Related
SWEP.Primary.ClipSize        = 6         -- This is the size of a clip
SWEP.Primary.DefaultClip     = 0         -- This is the number of bullets the gun gives you, counting a clip as defined directly above.
SWEP.Primary.Ammo = "45-70Govt"
SWEP.Primary.AmmoConsumption = 1         -- Ammo consumed per shot
SWEP.DisableChambering       = true      -- Disable round-in-the-chamber

--Recoil Related
SWEP.Primary.KickUp              = 3     -- This is the maximum upwards recoil (rise)
SWEP.Primary.KickDown            = 1.72  -- This is the maximum downwards recoil (skeet)
SWEP.Primary.KickHorizontal      = 0.15  -- This is the maximum sideways recoil (no real term)
SWEP.Primary.StaticRecoilFactor  = 0.72  -- Amount of recoil to directly apply to EyeAngles.  Enter what fraction or percentage (in decimal form) you want.  This is also affected by a convar that defaults to 0.5.

--Firing Cone Related
SWEP.Primary.Spread              = .017   -- This is hip-fire acuracy.  Less is more (1 is horribly awful, .0001 is close to perfect)
SWEP.Primary.IronAccuracy        = .001  -- Ironsight accuracy, should be the same for shotguns

--Unless you can do this manually, autodetect it.  If you decide to manually do these, uncomment this block and remove this line.

SWEP.Primary.SpreadMultiplierMax = 2.5  -- How far the spread can expand when you shoot. Example val: 2.5
SWEP.Primary.SpreadIncrement     = 2.5  -- What percentage of the modifier is added on, per shot.  Example val: 1/3.5
SWEP.Primary.SpreadRecovery      = 3.05 -- How much the spread recovers, per second. Example val: 3

--Range Related
SWEP.Primary.Range            = 0.06 * (3280.84 * 16) -- The distance the bullet can travel in source units.  Set to -1 to autodetect based on damage/rpm.
SWEP.Primary.RangeFalloff     = 0.42    -- The percentage of the range the bullet damage starts to fall off at.  Set to 0.8, for example, to start falling off after 80% of the range.

--Penetration Related
SWEP.MaxPenetrationCounter    = 5       -- The maximum number of ricochets.  To prevent stack overflows.

--Misc
SWEP.IronRecoilMultiplier     = 0.65    -- Multiply recoil by this factor when we're in ironsights.  This is proportional, not inversely.
SWEP.CrouchAccuracyMultiplier = 0.8     -- Less is more.  Accuracy * 0.5 = Twice as accurate, Accuracy * 0.1 = Ten times as accurate

--Movespeed
SWEP.MoveSpeed           = 0.95                      -- Multiply the player's movespeed by this.
SWEP.IronSightsMoveSpeed = SWEP.MoveSpeed  * 0.9 -- Multiply the player's movespeed by this when sighting.

--[[ VIEWMODEL ]]--

SWEP.ViewModel		= "models/weapons/tfa_fallout/c_fallout_brush_gun.mdl" -- Viewmodel path
SWEP.ViewModelFOV	= 60		       -- This controls how big the viewmodel looks.  Less is more.
SWEP.ViewModelFlip	= false		       -- Set this to true for CSS models, or false for everything else (with a righthanded viewmodel.)
SWEP.UseHands       = true             -- Use gmod c_arms system.
SWEP.VMPos          = Vector(0, 0, 0)  -- The viewmodel positional offset, constantly.  Subtract this from any other modifications to viewmodel position.
SWEP.VMAng          = Vector(0, 0, 0)  -- The viewmodel angular offset, constantly.   Subtract this from any other modifications to viewmodel angle.
SWEP.VMPos_Additive = false            -- Set to false for an easier time using VMPos. If true, VMPos will act as a constant delta ON TOP OF ironsights, run, whateverelse
SWEP.CenteredPos    = nil              -- The viewmodel positional offset, used for centering.  Leave nil to autodetect using ironsights.
SWEP.CenteredAng    = nil              -- The viewmodel angular offset, used for centering.  Leave nil to autodetect using ironsights.
SWEP.Bodygroups_V   = nil

--[[VIEWMODEL ANIMATION HANDLING]]--

SWEP.AllowViewAttachment       = true            -- Allow the view to sway based on weapon attachment while reloading or drawing, IF THE CLIENT HAS IT ENABLED IN THEIR CONVARS.

--[[ANIMATION]]--

SWEP.StatusLengthOverride   = {} -- Changes the status delay of a given animation; only used on reloads.  Otherwise, use SequenceLengthOverride or one of the others
SWEP.SequenceLengthOverride = {}

SWEP.SequenceLengthOverride     = {} -- Changes both the status delay and the nextprimaryfire of a given animation
SWEP.SequenceRateOverride       = {} -- Like above but changes animation length to a target
SWEP.SequenceRateOverrideScaled = {} -- Like above but scales animation length rather than being absolute

SWEP.ProceduralHoslterEnabled   = nil
SWEP.ProceduralHolsterTime      = 0.3
SWEP.ProceduralHolsterPos       = Vector(3, 0, -5)
SWEP.ProceduralHolsterAng       = Vector(-40, -30, 10)

SWEP.Sights_Mode   = TFA.Enum.LOCOMOTION_HYBRID -- ANI = mdl, HYBRID = lua but continue idle, Lua = stop mdl animation
SWEP.Sprint_Mode   = TFA.Enum.LOCOMOTION_ANI    -- ANI = mdl, HYBRID = ani + lua, Lua = lua only
SWEP.SprintBobMult = 0
SWEP.Idle_Mode     = TFA.Enum.IDLE_BOTH         -- TFA.Enum.IDLE_DISABLED = no idle, TFA.Enum.IDLE_LUA = lua idle, TFA.Enum.IDLE_ANI = mdl idle, TFA.Enum.IDLE_BOTH = TFA.Enum.IDLE_ANI + TFA.Enum.IDLE_LUA
SWEP.Idle_Blend    = 0.25                       -- Start an idle this far early into the end of a transition
SWEP.Idle_Smooth   = 0.05                       -- Start an idle this far early into the end of another animation

--MDL Animations Below--
SWEP.StatusLengthOverride = {
	[ACT_VM_RELOAD] = 0.33,
} -- Changes the status delay of a given animation; only used on reloads.  Otherwise, use SequenceLengthOverride or one of the others

SWEP.SequenceRateOverride  = {
	[ACT_SHOTGUN_RELOAD_START] = 1.2,
	[ACT_SHOTGUN_RELOAD_FINISH] = 1.2,
	[ACT_VM_PRIMARYATTACK] = 1.2,
	[ACT_VM_PRIMARYATTACK_1] = 1.2,	
}

SWEP.PumpAction = {
	["type"] = TFA.Enum.ANIMATION_ACT, --Sequence or act
	["value"] = ACT_VM_PULLBACK_LOW, --Number for act, String/Number for sequence
	["value_is"] = ACT_VM_PULLBACK
}

SWEP.SprintAnimation = {
        ["in"] = {
                ["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
                ["value"] = "Idle_to_Sprint", --Number for act, String/Number for sequence
                ["transition"] = true
        }, -- Inward transition
        ["loop"] = {
                ["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
                ["value"] = "Sprint", --Number for act, String/Number for sequence
                ["is_idle"] = true
        },-- looping animation
        ["out"] = {
                ["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
                ["value"] = "Sprint_to_Idle", --Number for act, String/Number for sequence
                ["transition"] = true
        } -- Outward transition
}

--[[WORLDMODEL]]--

SWEP.WorldModel	  = "models/weapons/tfa_fallout/w_fallout_brush_gun.mdl" -- Weapon world model path
SWEP.Bodygroups_W = nil

SWEP.HoldType     = "shotgun" 

-- This is how others view you carrying the weapon. Options include:
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive
-- You're mostly going to use ar2, smg, shotgun or pistol. rpg and crossbow make for good sniper rifles

SWEP.Offset = {
	Pos = {
        Up = -1,
        Right = 1,
        Forward = 25,
	},
	Ang = {
        Up = 0,
        Right = 0,
        Forward = 180,
	},
	Scale = 1
}

SWEP.ThirdPersonReloadDisable = false --Disable third person reload?  True disables.

--[[IRONSIGHTS]]--

SWEP.data              = {}
SWEP.data.ironsights   = 1             -- Enable Ironsights

SWEP.Secondary.IronFOV = 80            -- How much you 'zoom' in. Less is more!  Don't have this be <= 0.  A good value for ironsights is like 70.

SWEP.IronSightsPos     = Vector(-3, -1, 1.59)
SWEP.IronSightsAng     = Vector(0, 0.04, 0)

--[[SPRINTING]]--

SWEP.RunSightsPos   = Vector(2.4, 2, -0.8)
SWEP.RunSightsAng   = Vector(-15, 30, -15)
--[[INSPECTION]]--

SWEP.InspectPos   = Vector(6, -7, -2.787)
SWEP.InspectAng   = Vector(15, 32.417, 5)

--[[ATTACHMENTS]]--

SWEP.ViewModelBoneMods = {
	["v_fa_1887"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0.2, 0), angle = Angle(0, 0, 0) },
	["Hammer"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0.2, 0), angle = Angle(0, 0, 0) },
	["SphereGizmo01"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0.3, -0.2), angle = Angle(0, 0, 0) },
	["Thumb04"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 3, 0) },
	["Thumb1"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(5, 0, 0) },
	["Thumb2"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(5, 0, 0) },
	["Ring1"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(5, -5, 0) },
	["Index1"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-3.5, -20, 0) },
	["Middle1"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-2, -15, 0) },
	["Pinky1"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(10, 0, 0) },
	["ValveBiped.Bip01_L_UpperArm"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, -124.2) },
	["ValveBiped.Bip01_L_Forearm"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-0.803, 0, -112) },
	["ValveBiped.Bip01_L_Hand"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-16.5, 0, -1.1) },
}

SWEP.VElements          = {}
SWEP.WElements          = {}
SWEP.WorldModelBoneMods = {}

SWEP.MuzzleAttachmentSilenced = 2

SWEP.Attachments = {}

SWEP.AttachmentDependencies = {}
SWEP.AttachmentExclusions   = {}

DEFINE_BASECLASS( SWEP.Base )