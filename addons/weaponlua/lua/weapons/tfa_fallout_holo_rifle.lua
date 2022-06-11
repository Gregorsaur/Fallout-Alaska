SWEP.Base			     	= "tfa_3dbash_base"
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
SWEP.PrintName				= "Holorifle"        -- Weapon name (Shown on HUD)
SWEP.Slot				    = 4   		         -- Slot in the weapon selection menu.  Subtract 1, as this starts at 0.
SWEP.SlotPos				= 73			     -- Position in the slot
SWEP.AutoSwitchTo			= true		         -- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true		         -- Auto switch from if you pick up a better weapon
SWEP.Weight				    = 30			     -- This controls how "good" the weapon is for autopickup.
SWEP.Type                   = "Pump Action Microfusion Cell Launcher"

--[[EFFECTS]]--

--Attachments--
SWEP.MuzzleAttachment	  = "muzzle" 	    -- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellAttachment	  = "shell" 		-- Should be "2" for CSS models or "shell" for hl2 models
SWEP.MuzzleFlashEnabled   = true            -- Enable muzzle flash
SWEP.MuzzleAttachmentRaw  = false           -- This will override whatever string you gave.  This is the raw attachment number.  This is overridden or created when a gun makes a muzzle event.
SWEP.AutoDetectMuzzleAttachment = false     -- For multi-barrel weapons, detect the proper attachment?
SWEP.MuzzleFlashEffect    = "tfa_muzzleflash_energy" 
SWEP.SmokeParticle        = nil             -- Smoke particle (ID within the PCF), defaults to something else based on holdtype; "" to disable
SWEP.EjectionSmokeEnabled = false           -- Disable automatic ejection smoke

--Shell eject override--
SWEP.LuaShellEject         = false          -- Enable shell ejection through lua?
SWEP.LuaShellEjectDelay    = nil            -- The delay to actually eject things
SWEP.LuaShellEffect        = nil

--Tracer Stuff--
SWEP.TracerName 		   = nil            -- Change to a string of your tracer name.  Can be custom. There is a nice example at https://github.com/garrynewman/garrysmod/blob/master/garrysmod/gamemodes/base/entities/effects/tooltracer.lua
SWEP.TracerCount 		   = 1              -- 0 disables, otherwise, 1 in X chance

--[[SHOTGUN CODE]]--

SWEP.Shotgun                = true      -- Enable shotgun style reloading.
SWEP.ShotgunEmptyAnim       = false     -- Enable emtpy reloads on shotguns?
SWEP.ShotgunEmptyAnim_Shell = false     -- Enable insertion of a shell directly into the chamber on empty reload?
SWEP.ShellTime              = .9        -- For shotguns, how long it takes to insert a shell.

--[[ WEAPON HANDLING ]]--

SWEP.Primary.Sound             = Sound("TFA_Fallout.HOLO_Rifle.Fire")-- This is the sound of the weapon, when you shoot.

--Miscelaneous Sounds--
SWEP.IronInSound  = Sound("TFA_INS2.IronIn")  -- Sound to play when ironsighting in?  nil for default
SWEP.IronOutSound = Sound("TFA_INS2.IronOut") -- Sound to play when ironsighting out?  nil for default

SWEP.Primary.PenetrationMultiplier = 0.5      -- Change the amount of something this gun can penetrate through
SWEP.Primary.Damage            = 100          -- Damage, in standard damage points.
SWEP.Primary.NumShots          = 1            -- The number of shots the weapon fires.  SWEP.Shotgun is NOT required for this to be >1.
SWEP.Primary.DamageTypeHandled = true         -- true will handle damagetype in base
SWEP.Primary.DamageType        = ( bit.bor( DMG_PARALYZE, DMG_SHOCK, DMG_DISSOLVE ) ) -- See DMG enum.  This might be DMG_SHOCK, DMG_BURN, DMG_BULLET, etc.  Leave nil to autodetect.  DMG_AIRBOAT opens doors.
SWEP.Primary.Force             = nil          -- Force value, leave nil to autocalc
SWEP.Primary.Knockback         = nil          -- Autodetected if nil; this is the velocity kickback
SWEP.Primary.HullSize          = 0            -- Big bullets, increase this value.  They increase the hull size of the hitscan bullet.
SWEP.Primary.Automatic         = false        -- Automatic/Semi Auto
SWEP.Primary.RPM               = 60           -- This is in Rounds Per Minute / RPM
SWEP.FireModes                 = {"Semi"}
SWEP.Primary.RPM_Burst         = 100
SWEP.Primary.DryFireDelay      = nil          -- How long you have to wait after firing your last shot before a dryfire animation can play.  Leave nil for full empty attack length.  Can also use SWEP.StatusLength[ ACT_VM_BLABLA ]
SWEP.Primary.BurstDelay        = nil          -- Delay between bursts, leave nil to autocalculate
SWEP.Primary.Velocity          = 1500         -- Bullet Velocity in m/s
SWEP.FiresUnderwater           = true

--Selective Fire Stuff--
SWEP.Primary.Automatic = false
SWEP.SelectiveFire     = true           -- Allow selecting your firemode?
SWEP.DisableBurstFire  = false          -- Only auto/single?
SWEP.OnlyBurstFire     = false          -- No auto, only burst/single?
SWEP.DefaultFireMode   = "Semi"         -- Default to auto or whatev
SWEP.FireModeName      = "Pump-Action"

--Ammo Related 
SWEP.Primary.ClipSize        = 4                       -- This is the size of a clip
SWEP.Primary.DefaultClip     = 0                       -- This is the number of bullets the gun gives you, counting a clip as defined directly above.
SWEP.Primary.Ammo            = "MicrofusionCellsss"    -- What kind of ammo.  Options, besides custom, include pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, and AirboatGun.
SWEP.Primary.AmmoConsumption = 1                       -- Ammo consumed per shot
SWEP.DisableChambering       = true                    -- Disable round-in-the-chamber

--Recoil Related
SWEP.Primary.KickUp              = 2.12 -- This is the maximum upwards recoil (rise)
SWEP.Primary.KickDown            = 2.5  -- This is the maximum downwards recoil (skeet)
SWEP.Primary.KickHorizontal      = 0.35 -- This is the maximum sideways recoil (no real term)
SWEP.Primary.StaticRecoilFactor  = 0.66 -- Amount of recoil to directly apply to EyeAngles.  Enter what fraction or percentage (in decimal form) you want.  This is also affected by a convar that defaults to 0.5.

--Firing Cone Related
SWEP.Primary.Spread              = .03   -- This is hip-fire acuracy.  Less is more (1 is horribly awful, .0001 is close to perfect)
SWEP.Primary.IronAccuracy        = .0025 -- Ironsight accuracy, should be the same for shotguns

--Unless you can do this manually, autodetect it.  If you decide to manually do these, uncomment this block and remove this line.

SWEP.Primary.SpreadMultiplierMax = 3    -- How far the spread can expand when you shoot. Example val: 2.5
SWEP.Primary.SpreadIncrement     = 3    -- What percentage of the modifier is added on, per shot.  Example val: 1/3.5
SWEP.Primary.SpreadRecovery      = 3.15 -- How much the spread recovers, per second. Example val: 3

--Range Related
SWEP.Primary.Range            = 2.5 * (3280.84 * 16) -- The distance the bullet can travel in source units.  Set to -1 to autodetect based on damage/rpm.
SWEP.Primary.RangeFalloff     = 1       -- The percentage of the range the bullet damage starts to fall off at.  Set to 0.8, for example, to start falling off after 80% of the range.

--Penetration Related
SWEP.MaxPenetrationCounter    = 1       -- The maximum number of ricochets.  To prevent stack overflows.

--Misc
SWEP.IronRecoilMultiplier     = 0.75    -- Multiply recoil by this factor when we're in ironsights.  This is proportional, not inversely.
SWEP.CrouchAccuracyMultiplier = 0.75    -- Less is more.  Accuracy * 0.5 = Twice as accurate, Accuracy * 0.1 = Ten times as accurate

--Movespeed
SWEP.MoveSpeed           = 0.8                      -- Multiply the player's movespeed by this.
SWEP.IronSightsMoveSpeed = SWEP.MoveSpeed  * 0.75   -- Multiply the player's movespeed by this when sighting.

--[[ VIEWMODEL ]]--

SWEP.ViewModel		= "models/weapons/tfa_fallout/c_fallout_holo_rifle.mdl" -- Viewmodel path
SWEP.ViewModelFOV	= 65		       -- This controls how big the viewmodel looks.  Less is more.
SWEP.ViewModelFlip	= false		       -- Set this to true for CSS models, or false for everything else (with a righthanded viewmodel.)
SWEP.UseHands       = true             -- Use gmod c_arms system.
SWEP.VMPos          = Vector(0, 0, 0) -- The viewmodel positional offset, constantly.  Subtract this from any other modifications to viewmodel position.
SWEP.VMAng          = Vector(0, 4, 0)  -- The viewmodel angular offset, constantly.   Subtract this from any other modifications to viewmodel angle.
SWEP.VMPos_Additive = false            -- Set to false for an easier time using VMPos. If true, VMPos will act as a constant delta ON TOP OF ironsights, run, whateverelse
SWEP.CenteredPos    = nil              -- The viewmodel positional offset, used for centering.  Leave nil to autodetect using ironsights.
SWEP.CenteredAng    = nil              -- The viewmodel angular offset, used for centering.  Leave nil to autodetect using ironsights.
SWEP.Bodygroups_V   = nil

--[[VIEWMODEL ANIMATION HANDLING]]--

SWEP.AllowViewAttachment       = true            -- Allow the view to sway based on weapon attachment while reloading or drawing, IF THE CLIENT HAS IT ENABLED IN THEIR CONVARS.

--[[ANIMATION]]--

SWEP.StatusLengthOverride = {
	[ACT_VM_RELOAD] = 0.35,
} -- Changes the status delay of a given animation; only used on reloads.  Otherwise, use SequenceLengthOverride or one of the others


SWEP.SequenceLengthOverride     = {} -- Changes both the status delay and the nextprimaryfire of a given animation
SWEP.SequenceRateOverride       = {} -- Like above but changes animation length to a target
SWEP.SequenceRateOverrideScaled = {} -- Like above but scales animation length rather than being absolute

SWEP.ProceduralHoslterEnabled   = true
SWEP.ProceduralHolsterTime      = 0.35
SWEP.ProceduralHolsterPos       = Vector(5, 0, -3)
SWEP.ProceduralHolsterAng       = Vector(-50, 0, 0)

SWEP.Sights_Mode   = TFA.Enum.LOCOMOTION_HYBRID -- ANI = mdl, HYBRID = lua but continue idle, Lua = stop mdl animation
SWEP.Sprint_Mode   = TFA.Enum.LOCOMOTION_LUA    -- ANI = mdl, HYBRID = ani + lua, Lua = lua only
SWEP.SprintBobMult = 1.65
SWEP.Idle_Mode     = TFA.Enum.IDLE_BOTH         -- TFA.Enum.IDLE_DISABLED = no idle, TFA.Enum.IDLE_LUA = lua idle, TFA.Enum.IDLE_ANI = mdl idle, TFA.Enum.IDLE_BOTH = TFA.Enum.IDLE_ANI + TFA.Enum.IDLE_LUA
SWEP.Idle_Blend    = 0.25                       -- Start an idle this far early into the end of a transition
SWEP.Idle_Smooth   = 0.05                       -- Start an idle this far early into the end of another animation

--MDL Animations Below--

SWEP.IronAnimation = {
	["loop"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ,  -- Sequence or act
		["value"] = "idle_raw",             -- Number for act, String/Number for sequence
	},
	["shoot"] = {
		["type"] = TFA.Enum.ANIMATION_ACT,  -- Sequence or act
		["value"] = ACT_VM_PRIMARYATTACK,   -- Number for act, String/Number for sequence
	}
}

--[[WORLDMODEL]]--

SWEP.WorldModel	  = "models/weapons/tfa_fallout/w_fallout_holo_rifle.mdl" -- Weapon world model path
SWEP.Bodygroups_W = nil

SWEP.HoldType     = "shotgun" 

-- This is how others view you carrying the weapon. Options include:
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive
-- You're mostly going to use ar2, smg, shotgun or pistol. rpg and crossbow make for good sniper rifles

SWEP.Offset = {
	Pos = {
		Up = -7,
		Right = 4.5,
		Forward = -5
	},
	Ang = {
		Up = -90,
		Right = -5.844,
		Forward = 180
	},
	Scale = 1
}

SWEP.ThirdPersonReloadDisable = false --Disable third person reload?  True disables.

-- [[ IRONSIGHTS ]] --

SWEP.data = {}
SWEP.data.ironsights   = 1  -- Enable Ironsights

SWEP.Secondary.IronFOV = 70 -- How much you 'zoom' in. Less is more!  Don't have this be <= 0.  A good value for ironsights is like 70.

SWEP.IronSightsPos     = Vector(-3.16, -3, -0.5)
SWEP.IronSightsAng     = Vector(0.9, -0.032, 0)

SWEP.Secondary.ScopeZoom = 15

SWEP.ScopeAngleTransforms = {
	{ "R", -90 },
	{ "P", -0.88 },
	{ "Y", 0 }
}

SWEP.ScopeOverlayTransforms = { -0.05, 0.05 }

SWEP.ScopeOverlayTransformMultiplier = 0

local scope = {}

SWEP.ScopeReticule = ("scope/gdcw_nvgilluminatedduplex")

local rt

if surface then
    rt = surface.GetTextureID("scope/gdcw_nvgilluminatedduplex")
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

--[[SPRINTING]]--

SWEP.RunSightsPos   = Vector(2.4, -2, -1.5)
SWEP.RunSightsAng   = Vector(-15, 30, -15)

--[[INSPECTION]]--

SWEP.InspectPos     = Vector(5, -6.5, -4)
SWEP.InspectAng     = Vector(22.386, 32.417, 5)

--[[ATTACHMENTS]]--

SWEP.ViewModelBoneMods = {
	["valveBiped.Bip01_L_Finger0"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0.5, 0.5), angle = Angle(0, 0, 180) },
	["valveBiped.Bip01_L_Finger01"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0.5, 0), angle = Angle(0, 0, 180) },
	["valveBiped.Bip01_L_Finger02"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0.5, 0), angle = Angle(0, 0, 180) },
	["valveBiped.Bip01_R_Finger0"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 180) },
	["valveBiped.Bip01_R_Finger01"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 180) },
	["valveBiped.Bip01_R_Finger02"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 180) },
}

SWEP.VElements = {
	["rtcircle"] = { type = "Model", model = "models/rtcircle.mdl", bone = "weapon", rel = "", pos = Vector(0.072, 6.7, 5.33), angle = Angle(0, 90, 0), size = Vector(0.25, 0.25, 0.25), color = Color(255, 255, 255, 255), surpresslightning = false, material = "!tfa_rtmaterial", skin = 0, bodygroup = {}, bonemerge = false }
}

SWEP.WElements          = {}
SWEP.WorldModelBoneMods = {}

SWEP.Attachments              = {}
SWEP.AttachmentDependencies   = {}
SWEP.AttachmentExclusions     = {}

SWEP.MuzzleAttachmentSilenced = 2

--[[Bash]]--

SWEP.Secondary.BashLength     = 50
SWEP.Secondary.BashDamage     = 25
SWEP.Secondary.BashDelay      = 0.2

DEFINE_BASECLASS( SWEP.Base )

function SWEP:DoImpactEffect( tr, dmgtype )

	if( tr.HitSky ) then return true; end
	
	util.Decal( "scorch", tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal );
	sound.Play( "Weapon_Theta.Shocking", tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal, 200 );
	

	
	-- is this even the correct way to handle this?
	if( game.SinglePlayer() or SERVER or not self:IsCarriedByLocalPlayer() or IsFirstTimePredicted() ) then

		local effect = EffectData();
		effect:SetOrigin( tr.HitPos );
		effect:SetNormal( tr.HitNormal );

		util.Effect( "tfa_fallout_blue_laser_impact", effect );
		

		local effect = EffectData();
		effect:SetOrigin( tr.HitPos );
		effect:SetStart( tr.StartPos );
		effect:SetDamageType( dmgtype );

		util.Effect( "RagdollImpact", effect );
		
	end

    return true;

end