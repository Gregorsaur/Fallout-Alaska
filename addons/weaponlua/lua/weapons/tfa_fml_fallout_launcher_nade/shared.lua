SWEP.PrintName = "FM Grenade Launcher"
SWEP.Author = "Fleshy Mammal"
SWEP.Contact = ""
SWEP.Purpose = "lol fuck off"
SWEP.Instructions = ""

SWEP.Category = "TFA Fallout"

--[[VIEWMODEL BLOWBACK]]--
SWEP.BlowbackEnabled = false --Enable Blowback?
SWEP.BlowbackVector = Vector(0,-3.5,0) --Vector to move bone <or root> relative to bone <or view> orientation.
SWEP.BlowbackCurrentRoot = 0 --Amount of blowback currently, for root
SWEP.BlowbackCurrent = 0 --Amount of blowback currently, for bones
SWEP.Blowback_Only_Iron = true --Only do blowback on ironsights
SWEP.Blowback_PistolMode = true --Do we recover from blowback when empty?
SWEP.Blowback_Shell_Enabled = true --Shoot shells through blowback animations
SWEP.Blowback_Shell_Effect = "RifleShellEject"--Which shell effect to use

SWEP.Spawnable= true
SWEP.AdminSpawnable= true
SWEP.AdminOnly = false
SWEP.CSMuzzleFlashes = true

SWEP.MuzzleAttachment = 1
SWEP.ShellAttachment            = 2 		-- Should be "2" for CSS models or "shell" for hl2 models

-- Shell eject override
SWEP.LuaShellEject = false --Enable shell ejection through lua?
SWEP.LuaShellEjectDelay = 0 --The delay to actually eject things
SWEP.LuaShellModel = nil --The model to use for ejected shells
SWEP.LuaShellScale = nil --The model scale to use for ejected shells
SWEP.LuaShellYaw = nil --The model yaw rotation ( relative ) to use for ejected shells

SWEP.PumpAction = {
    ["type"] = TFA.Enum.ANIMATION_SEQ,
    ["value"] = "pump",
	["value_is"] = "pump"
}
SWEP.HoldType = "shotgun"
SWEP.ViewModelFOV = 70
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.ViewModel = "models/weapons/fml/fallout/c_grenade_pump.mdl"
SWEP.WorldModel = "models/weapons/w_smg1.mdl"
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = false
SWEP.ViewModelBoneMods = {
	["ValveBiped.Bip01_L_Clavicle"] = { scale = Vector(1, 1, 1), pos = Vector(0.115, 0, -0.25), angle = Angle(0, 0, 0) },

	["Weapon_Shell"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 180, 0) },	
	["Weapon_Muzzle"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0.361, -1.134), angle = Angle(-90, 0, 0) },	
	["A_Optic"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-90, 180, 0) },
}

SWEP.WElements = {
	["E"] = { type = "Model", model = "models/weapons/fml/fallout/c_grenade_pump.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-1.443, 3.963, -6.074), angle = Angle(-10, 0, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {[1] = 1} }
}

SWEP.FlashlightAttachment = 0

SWEP.VElements = {}

SWEP.IronSightsPos = Vector(-2.921, -2.5, 1.36)
SWEP.IronSightsAng = Vector(0, 0, 0)

SWEP.RTOpaque	= true

SWEP.StatusLengthOverride = {
	[ACT_VM_RELOAD] = 25/60,	
	[ACT_VM_RELOAD_EMPTY] = 80/60,		
}

SWEP.EventTable = {
[ACT_VM_PULLBACK_LOW] = {
{time = 10 / 60, type = "lua", value = function(self) self:EventShell() end, client = true, server = true},
},
[ACT_VM_RELOAD_EMPTY] = {
{time = 20 / 60, type = "lua", value = function(self) self:EventShell() end, client = true, server = true},
},
}


SWEP.LaserSightModAttachment = 1

SWEP.Type = "Shotgun"

SWEP.AutoSwitchTo = true
SWEP.AutoSwitchFrom = true

SWEP.Slot = 4
SWEP.SlotPos = 1
 
SWEP.UseHands = true

SWEP.FiresUnderwater = true

SWEP.DrawCrosshair = true

SWEP.DrawAmmo = true

SWEP.ReloadSound = ""

SWEP.Shotgun = true --Enable shotgun style reloading.
SWEP.ShotgunEmptyAnim = true --Enable insertion of a shell directly into the chamber on empty reload?

SWEP.Base = "tfa_gun_base"

SWEP.Primary.IronAccuracy_SG = .075

--Recoil Related
SWEP.Primary.KickUp = 1.25 -- This is the maximum upwards recoil (rise)
SWEP.Primary.KickHorizontal = 0.75
SWEP.Primary.StaticRecoilFactor = 0.5 --Amount of recoil to directly apply to EyeAngles.  Enter what fraction or percentage (in decimal form) you want.  This is also affected by a convar that defaults to 0.5.
--Firing Cone Related
SWEP.Primary.Spread = .05 --This is hip-fire acuracy.  Less is more (1 is horribly awful, .0001 is close to perfect)
SWEP.Primary.IronAccuracy = .05 -- Ironsight accuracy, should be the same for shotguns
--Unless you can do this manually, autodetect it.  If you decide to manually do these, uncomment this block and remove this line.
SWEP.Primary.SpreadMultiplierMax = 6 --How far the spread can expand when you shoot. Example val: 2.5
SWEP.Primary.SpreadIncrement = 3 --What percentage of the modifier is added on, per shot.  Example val: 1/3.5
SWEP.Primary.SpreadRecovery = 5 --How much the spread recovers, per second. Example val: 3
--Range Related
SWEP.Primary.Range = 980 -- The distance the bullet can travel in source units.  Set to -1 to autodetect based on damage/rpm.
SWEP.Primary.RangeFalloff = 0.25 -- The percentage of the range the bullet damage starts to fall off at.  Set to 0.8, for example, to start falling off after 80% of the range.
--Misc
SWEP.CrouchAccuracyMultiplier = 0.5 --Less is more.  Accuracy * 0.5 = Twice as accurate, Accuracy * 0.1 = Ten times as accurate
--Movespeed
SWEP.MoveSpeed = 0.75 --Multiply the player's movespeed by this.
SWEP.IronSightsMoveSpeed = 0.6 --Multiply the player's movespeed by this when sighting.

SWEP.IronSightTime = 0.35

SWEP.VMPos_Additive = false --Set to false for an easier time using VMPos. If true, VMPos will act as a constant delta ON TOP OF ironsights, run, whateverelse

SWEP.Primary.Sound = Sound("weapons/M79/40mmthump.wav") -- This is the sound of the weapon, when you shoot.
SWEP.Primary.SilencedSound = Sound("TFA_INS2_M590.2") -- This is the sound of the weapon, when silenced.
SWEP.Primary.Damage = 150
SWEP.Primary.NumShots = 1
SWEP.Primary.TakeAmmo = 1
SWEP.Primary.ClipSize = 4
SWEP.Primary.Ammo = "40mmGrenade"
SWEP.Primary.DefaultClip = 0
SWEP.Primary.Automatic = false
SWEP.Primary.Recoil = 1
SWEP.Primary.RPM = 500
SWEP.Primary.Force = 1

SWEP.Primary.PenetrationMultiplier = 5 --Change the amount of something this gun can penetrate through

SWEP.Secondary.ClipSize = 0
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"
SWEP.DisableChambering       = true          -- Disable round-in-the-chamber

SWEP.Secondary.IronFOV = 80

--[[PROJECTILES]]--

SWEP.ProjectileEntity   = "tfa_exp_contact"  -- Entity to shoot
SWEP.ProjectileVelocity = 9000               -- Entity to shoot's velocity
SWEP.ProjectileModel    = "models/weapons/tfa_ins2/upgrades/a_projectile_m203.mdl" --Entity to shoot's model

--[[INSPECTION]]--
SWEP.InspectPos = Vector(7.769, -1.509, -0.394)
SWEP.InspectAng = Vector(13.678, 36.644, 15.503)

--[[SPRINTING]]--
SWEP.RunSightsPos = Vector(1.559, -1, -1.13)
SWEP.RunSightsAng = Vector(-24.535, 23.375, -25.553)