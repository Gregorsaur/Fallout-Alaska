SWEP.Base				    = "tfa_gun_base"
SWEP.Category				= "TFA Fallout"           -- The category.  Please, just choose something generic or something I've already done if you plan on only doing like one swep..
SWEP.Manufacturer           = ""                      -- Gun Manufactrer (e.g. Hoeckler and Koch )
SWEP.Author				    = "XxYanKy700xX"          -- Author Tooltip
SWEP.Contact				= ""                      -- Contact Info Tooltip
SWEP.Purpose				= ""                      -- Purpose Tooltip
SWEP.Instructions			= ""                      -- Instructions Tooltip
SWEP.Spawnable				= true                    -- INSTALL SHARED PARTS
SWEP.AdminSpawnable			= true                    -- Can an adminstrator spawn this?  Does not tie into your admin mod necessarily, unless its coded to allow for GMod's default ranks somewhere in its code.  Evolve and ULX should work, but try to use weapon restriction rather than these.
SWEP.DrawCrosshair			= true		              -- Draw the crosshair?
SWEP.DrawCrosshairIS        = false                   -- Draw the crosshair in ironsights?
SWEP.PrintName				= "Police Pistol"	      -- Weapon name (Shown on HUD)
SWEP.Slot				    = 1				          -- Slot in the weapon selection menu.  Subtract 1, as this starts at 0.
SWEP.SlotPos				= 73			          -- Position in the slot
SWEP.AutoSwitchTo			= true		              -- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true		              -- Auto switch from if you pick up a better weapon
SWEP.Weight				    = 30			          -- This controls how "good" the weapon is for autopickup.
SWEP.Type                   = "Revolver"

--[[WEAPON HANDLING]]--

SWEP.Primary.Sound                 = Sound("TFA_Fallout.Police_Pistol.Fire") -- This is the sound of the weapon, when you shoot.
SWEP.Primary.SilencedSound         = nil     -- This is the sound of the weapon, when silenced.

SWEP.Primary.PenetrationMultiplier = 1       -- Change the amount of something this gun can penetrate through
SWEP.Primary.Damage                = 30      -- Damage, in standard damage points.
SWEP.Primary.DamageTypeHandled     = true    -- true will handle damagetype in base
SWEP.Primary.DamageType            = nil     -- See DMG enum.  This might be DMG_SHOCK, DMG_BURN, DMG_BULLET, etc.  Leave nil to autodetect.  DMG_AIRBOAT opens doors.
SWEP.Primary.Force                 = nil     -- Force value, leave nil to autocalc
SWEP.Primary.Knockback             = nil     -- Autodetected if nil; this is the velocity kickback
SWEP.Primary.HullSize              = 0       -- Big bullets, increase this value.  They increase the hull size of the hitscan bullet.
SWEP.Primary.NumShots              = 1       -- The number of shots the weapon fires.  SWEP.Shotgun is NOT required for this to be >1.
SWEP.Primary.Automatic             = false   -- Automatic/Semi Auto
SWEP.Primary.RPM                   = 300     -- This is in Rounds Per Minute / RPM
SWEP.Primary.RPM_Semi              = nil     -- RPM for semi-automatic or burst fire.  This is in Rounds Per Minute / RPM
SWEP.Primary.RPM_Burst             = nil     -- RPM for burst fire, overrides semi.  This is in Rounds Per Minute / RPM
SWEP.Primary.DryFireDelay          = 0.25    -- How long you have to wait after firing your last shot before a dryfire animation can play.  Leave nil for full empty attack length.  Can also use SWEP.StatusLength[ ACT_VM_BLABLA ]
SWEP.Primary.BurstDelay            = nil     -- Delay between bursts, leave nil to autocalculate
SWEP.FiresUnderwater               = false

-- Ammo Related
SWEP.Primary.ClipSize        = 6                         -- This is the size of a clip
SWEP.Primary.DefaultClip     = 0                         -- This is the number of bullets the gun gives you, counting a clip as defined directly above.
SWEP.Primary.Ammo            = "357Magnum"               -- What kind of ammo.  Options, besides custom, include pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, and AirboatGun.
SWEP.Primary.AmmoConsumption = 1                         -- Ammo consumed per shot
SWEP.DisableChambering       = true                      -- Disable round-in-the-chamber

-- Recoil Related
SWEP.Primary.KickUp          = 1.02       -- This is the maximum upwards recoil (rise)
SWEP.Primary.KickDown        = 0.85       -- This is the maximum downwards recoil (skeet)
SWEP.Primary.KickHorizontal  = 0.57       -- This is the maximum sideways recoil (no real term)
SWEP.Primary.StaticRecoilFactor = 0.72   -- Amount of recoil to directly apply to EyeAngles.  Enter what fraction or percentage (in decimal form) you want.  This is also affected by a convar that defaults to 0.5.

-- Firing Cone Related
SWEP.Primary.Spread       = .0135       -- This is hip-fire acuracy.  Less is more (1 is horribly awful, .0001 is close to perfect)
SWEP.Primary.IronAccuracy = .0025       -- Ironsight accuracy, should be the same for shotguns

-- Unless you can do this manually, autodetect it.  If you decide to manually do these, uncomment this block and remove this line.
SWEP.Primary.SpreadMultiplierMax = 8      -- How far the spread can expand when you shoot. Example val: 2.5
SWEP.Primary.SpreadIncrement     = 4.2    -- What percentage of the modifier is added on, per shot.  Example val: 1/3.5
SWEP.Primary.SpreadRecovery      = 15     -- How much the spread recovers, per second. Example val: 3

-- Range Related
SWEP.Primary.Range = 0.04 * (3280.84 * 16)  -- The distance the bullet can travel in source units.  Set to -1 to autodetect based on damage/rpm.
SWEP.Primary.RangeFalloff = 0.82            -- The percentage of the range the bullet damage starts to fall off at.  Set to 0.8, for example, to start falling off after 80% of the range.

-- Penetration Related
SWEP.MaxPenetrationCounter    = 4          -- The maximum number of ricochets.  To prevent stack overflows.

-- Misc
SWEP.IronRecoilMultiplier     = 0.435      -- Multiply recoil by this factor when we're in ironsights.  This is proportional, not inversely.
SWEP.CrouchAccuracyMultiplier = 0.42       -- Less is more.  Accuracy * 0.5 = Twice as accurate, Accuracy * 0.1 = Ten times as accurate

-- Movespeed
SWEP.MoveSpeed           = 1                      -- Multiply the player's movespeed by this.
SWEP.IronSightsMoveSpeed = SWEP.MoveSpeed  * 0.95 -- Multiply the player's movespeed by this when sighting.

-- Miscelaneous Sounds
SWEP.IronInSound         = Sound("TFA_INS2.IronIn")  -- Sound to play when ironsighting in?  nil for default
SWEP.IronOutSound        = Sound("TFA_INS2.IronOut") -- Sound to play when ironsighting out?  nil for default

--[[ Selective Fire Stuff ]]--

SWEP.SelectiveFire               = false                        -- Allow selecting your firemode?
SWEP.DisableBurstFire            = false                        -- Only auto/single?
SWEP.OnlyBurstFire               = false                        -- No auto, only burst/single?
SWEP.DefaultFireMode             = "Double-Action"              -- Default to auto or whatev
SWEP.FireModeName                = "Double-Action"              -- Change to a text value to override it

--[[EFFECTS]]--

--Attachments
SWEP.MuzzleAttachment			= "muzzle" -- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellAttachment			= "shell"  -- Should be "2" for CSS models or "shell" for hl2 models
SWEP.MuzzleFlashEnabled         = true     -- Enable muzzle flash
SWEP.MuzzleAttachmentRaw        = nil      -- This will override whatever string you gave.  This is the raw attachment number.  This is overridden or created when a gun makes a muzzle event.
SWEP.AutoDetectMuzzleAttachment = false    -- For multi-barrel weapons, detect the proper attachment?
SWEP.MuzzleFlashEffect          = "tfa_muzzleflash_revolver" -- Change to a string of your muzzle flash effect.  Copy/paste one of the existing from the base.
SWEP.SmokeParticle              = nil      -- Smoke particle (ID within the PCF), defaults to something else based on holdtype; "" to disable
SWEP.EjectionSmokeEnabled       = false    -- Disable automatic ejection smoke

--Shell eject override
SWEP.LuaShellEject      = false        -- Enable shell ejection through lua?
SWEP.LuaShellEjectDelay = 0            -- The delay to actually eject things
SWEP.LuaShellEffect     = "ShellEject" -- The effect used for shell ejection; Defaults to that used for blowback
SWEP.LuaShellModel      = "models/hdweapons/shell.mdl"

--Tracer Stuff
SWEP.TracerName 		= nil 	-- Change to a string of your tracer name.  Can be custom. There is a nice example at https://github.com/garrynewman/garrysmod/blob/master/garrysmod/gamemodes/base/entities/effects/tooltracer.lua
SWEP.TracerCount 		= 3 	-- 0 disables, otherwise, 1 in X chance

--Impact Effects
SWEP.ImpactEffect       = nil   -- Impact Effect
SWEP.ImpactDecal        = nil   -- Impact Decal

--[[VIEWMODEL]]--

SWEP.ViewModel		= "models/weapons/tfa_fallout/c_fallout_police_pistol.mdl" -- Viewmodel path
SWEP.VMPos          = Vector(0, 0, 0)          -- The viewmodel positional offset, constantly.  Subtract this from any other modifications to viewmodel position.
SWEP.VMAng          = Vector(0, 0, 0)          -- The viewmodel angular offset, constantly.   Subtract this from any other modifications to viewmodel angle.
SWEP.VMPos_Additive = false                    -- Set to false for an easier time using VMPos. If true, VMPos will act as a constant delta ON TOP OF ironsights, run, whateverelse

SWEP.ViewModelFOV	= 70		  -- This controls how big the viewmodel looks.  Less is more.
SWEP.ViewModelFlip	= false		  -- Set this to true for CSS models, or false for everything else (with a righthanded viewmodel.)
SWEP.UseHands       = true        -- Use gmod c_arms system.

SWEP.CenteredPos    = nil         -- The viewmodel positional offset, used for centering.  Leave nil to autodetect using ironsights.
SWEP.CenteredAng    = nil         -- The viewmodel angular offset, used for centering.  Leave nil to autodetect using ironsights.

SWEP.Bodygroups_V = {}

--[[VIEWMODEL ANIMATION HANDLING]]--

SWEP.AllowViewAttachment = true              -- Allow the view to sway based on weapon attachment while reloading or drawing, IF THE CLIENT HAS IT ENABLED IN THEIR CONVARS.

--[[ANIMATION]]--

SWEP.SequenceLengthOverride     = {} -- Changes both the status delay and the nextprimaryfire of a given animation
SWEP.SequenceRateOverride       = {} -- Like above but changes animation length to a target
SWEP.SequenceRateOverrideScaled = {} -- Like above but scales animation length rather than being absolute

SWEP.ProceduralHoslterEnabled   = nil
SWEP.ProceduralHolsterTime      = 0.3
SWEP.ProceduralHolsterPos       = Vector(3, 0, -5)
SWEP.ProceduralHolsterAng       = Vector(-40, -30, 10)

SWEP.Sights_Mode    = TFA.Enum.LOCOMOTION_HYBRID -- ANI = mdl, HYBRID = lua but continue idle, Lua = stop mdl animation
SWEP.Sprint_Mode    = TFA.Enum.LOCOMOTION_ANI    -- ANI = mdl, HYBRID = ani + lua, Lua = lua only
SWEP.Idle_Mode      = TFA.Enum.IDLE_BOTH         -- TFA.Enum.IDLE_DISABLED = no idle, TFA.Enum.IDLE_LUA = lua idle, TFA.Enum.IDLE_ANI = mdl idle, TFA.Enum.IDLE_BOTH = TFA.Enum.IDLE_ANI + TFA.Enum.IDLE_LUA
SWEP.Idle_Blend     = 0.25                       -- Start an idle this far early into the end of a transition
SWEP.Idle_Smooth    = 0.05                       -- Start an idle this far early into the end of another animation

SWEP.StatusLengthOverride = {
	[ACT_VM_RELOAD] = 100 / 32.2,
	[ACT_VM_RELOAD_DEPLOYED] = 82 / 30,
} -- Changes the status delay of a given animation; only used on reloads.  Otherwise, use SequenceLengthOverride or one of the others

--MDL Animations Below
SWEP.IronAnimation = {
	["shoot"] = {
		["type"] = TFA.Enum.ANIMATION_ACT,       -- Sequence or act
		["value"] = ACT_VM_PRIMARYATTACK_1,      -- Number for act, String/Number for sequence
		["value_empty"] = ACT_VM_PRIMARYATTACK_3
	}
}

SWEP.SprintAnimation = {
	["loop"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ,       -- Sequence or act
		["value"] = "base_sprint",               -- Number for act, String/Number for sequence
		["is_idle"] = true
	}
}

--[[EVENT TABLE]]--

SWEP.EventTable = {
	[ACT_VM_PRIMARYATTACK] = {
		{ ["time"] = 0, ["type"] = "lua", ["value"] = function(wep, vm)
			wep.Bodygroups_V[1] = math.Clamp(wep:Clip1(), 0, wep:GetMaxClip1())
		end, ["client"] = true, ["server"] = true},
	},
	[ACT_VM_PRIMARYATTACK_1] = {
		{ ["time"] = 0, ["type"] = "lua", ["value"] = function(wep, vm)
			wep.Bodygroups_V[1] = math.Clamp(wep:Clip1(), 0, wep:GetMaxClip1())
		end, ["client"] = true, ["server"] = true},
	},
	[ACT_SHOTGUN_RELOAD_START] = {
		{ ["time"] = 58 / 33.5, ["type"] = "lua", ["value"] = function(wep, vm)
			if wep.EventShell then
				for i = 1, wep.Bodygroups_V[2] do
					wep:EventShell()
				end
				wep.Bodygroups_V[2] = 0
			end
			wep:Unload()
		end, ["client"] = true, ["server"] = true},
	},
	[ACT_VM_RELOAD] = {
		{ ["time"] = 0, ["type"] = "lua", ["value"] = function(wep, vm)
			local clip = math.Clamp(wep:Clip1() + 1, 0, wep:GetMaxClip1())
			wep.Bodygroups_V[1] = clip
			wep.Bodygroups_V[2] = clip
		end, ["client"] = true, ["server"] = true},
	},
	[ACT_VM_RELOAD_DEPLOYED] = {
		{ ["time"] = 58 / 33.5, ["type"] = "lua", ["value"] = function(wep, vm)
			if wep.EventShell then
				for i = 1, wep.Bodygroups_V[2] do
					wep:EventShell()
				end
			end
			wep:Unload()
		end, ["client"] = true, ["server"] = true},
		{ ["time"] = 65 / 33.5, ["type"] = "lua", ["value"] = function(wep, vm)
			local ammo = math.Clamp(wep:Ammo1(), 0, wep:GetMaxClip1())
			wep.Bodygroups_V[1] = ammo
			wep.Bodygroups_V[2] = ammo
		end, ["client"] = true, ["server"] = true},
	},
} --Event Table, used for custom events when an action is played.  This can even do stuff like playing a pump animation after shooting.

--[[WORLDMODEL]]--

SWEP.WorldModel		= "models/weapons/tfa_fallout/w_fallout_police_pistol.mdl" -- Weapon world model path
SWEP.Bodygroups_W   = nil

SWEP.HoldType       = "revolver" 

-- This is how others view you carrying the weapon. Options include:
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive
-- You're mostly going to use ar2, smg, shotgun or pistol. rpg and crossbow make for good sniper rifles

SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
	Pos = {
		Up = -2.2,
		Right = 1,
		Forward = 4
	},
	Ang = {
		Up = -1,
		Right = -2,
		Forward = 178
	},
	Scale = 1.05
} 

SWEP.ThirdPersonReloadDisable = false --Disable third person reload?  True disables.


--[[IRONSIGHTS]]--

SWEP.data = {}
SWEP.data.ironsights   = 1  -- Enable Ironsights
SWEP.Secondary.IronFOV = 80 -- How much you 'zoom' in. Less is more!  Don't have this be <= 0.  A good value for ironsights is like 70.

SWEP.IronSightsPos = Vector(-2.025, 0, 0.75)
SWEP.IronSightsAng = Vector(-1, 0, 0)

--[[SPRINTING]]--

SWEP.RunSightsPos = Vector(1.25, -6, -6)
SWEP.RunSightsAng = Vector(50, 0, 0)

--[[INSPECTION]]--

SWEP.InspectPos = Vector(8, -6, -2.241) 
SWEP.InspectAng = Vector(27, 42, 15.477)

--[[ATTACHMENTS]]--

SWEP.Attachments = {
	[1] = { offset = { 0, 0 }, atts = { "am_match", "am_magnum", "am_gib" }, order = 1 },
}

SWEP.AttachmentDependencies = {}
SWEP.AttachmentExclusions = {}

SWEP.ViewModelBoneMods = {
    ["Casing_5"] = { scale = Vector(1, 1, 1), pos = Vector(0, -0.01, 0), angle = Angle(0, 0, 0) },
    ["Casing_4"] = { scale = Vector(1, 1, 1), pos = Vector(0, -0.005, 0), angle = Angle(0, 0, 0) },
	["A_Muzzle"] = { scale = Vector(1, 1, 1), pos = Vector(0, -0.8, 0), angle = Angle(90, 0, 0) },
	["L Finger41"] = { scale = Vector(0.95, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0)  },
}
SWEP.VElements = {
--	["laser"] = { type = "Model", model = "models/weapons/tfa_ins2/upgrades/a_flashlight_rail.mdl", bone = "Weapon", rel = "", pos = Vector(0, 2.8, 1.1), angle = Angle(0, -90, 0), size = Vector(0.6, 0.6, 0.6), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
--	["laser_beam"] = { type = "Model", model = "models/tfa/lbeam.mdl", bone = "LaserPistol", rel = "laser", pos = Vector(0, -0.15, -0.6), angle = Angle(0, 0, 0), size = Vector(2, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
}
SWEP.WElements = nil --Export from SWEP Creation Kit.  For each item that can/will be toggled, set active=false in its individual table

DEFINE_BASECLASS( SWEP.Base )