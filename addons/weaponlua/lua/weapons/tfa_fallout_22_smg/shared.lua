SWEP.PrintName = ".22LR SMG"
SWEP.Author = "Fleshy Mammal"
SWEP.Contact = ""
SWEP.Purpose = ""
SWEP.Instructions = ""

SWEP.Category = "TFA Fallout Weapons"

--[[VIEWMODEL BLOWBACK]]--
SWEP.BlowbackEnabled = true --Enable Blowback?
SWEP.BlowbackVector = Vector(0,-2.5,0) --Vector to move bone <or root> relative to bone <or view> orientation.
SWEP.BlowbackCurrentRoot = 0 --Amount of blowback currently, for root
SWEP.BlowbackCurrent = 0 --Amount of blowback currently, for bones
SWEP.BlowbackBoneMods = {
	["Weapon_Bolt"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, -2), angle = Angle(0, 0, 0) }
}
SWEP.Blowback_Only_Iron = true --Only do blowback on ironsights
SWEP.Blowback_PistolMode = true --Do we recover from blowback when empty?
SWEP.Blowback_Shell_Enabled = true --Shoot shells through blowback animations
SWEP.Blowback_Shell_Effect = "RifleShellEject"--Which shell effect to use

SWEP.Spawnable= true
SWEP.AdminSpawnable= true
SWEP.AdminOnly = false
SWEP.CSMuzzleFlashes = true

SWEP.MuzzleAttachment = 1
SWEP.ShellAttachment = 2 		-- Should be "2" for CSS models or "shell" for hl2 models

-- Shell eject override
SWEP.LuaShellEject = true --Enable shell ejection through lua?
SWEP.LuaShellEjectDelay = 0 --The delay to actually eject things
SWEP.LuaShellModel = nil --The model to use for ejected shells
SWEP.LuaShellScale = nil --The model scale to use for ejected shells
SWEP.LuaShellYaw = nil --The model yaw rotation ( relative ) to use for ejected shells

SWEP.HoldType = "ar2"
SWEP.ViewModelFOV = 70
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.ViewModel = "models/weapons/fml/fallout/c_dp28_smol.mdl"
SWEP.WorldModel = "models/weapons/w_smg1.mdl"
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = false
SWEP.ViewModelBoneMods = {
	["ValveBiped.Bip01_L_Clavicle"] = { scale = Vector(1, 1, 1), pos = Vector(0.115, 0, -0.2), angle = Angle(0, 0, 0) },

	["Weapon_Shell"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 135, 0) },	
	["Weapon_Muzzle"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0.5, 0), angle = Angle(-90, 0, 0) },	
	["A_Optic"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0.3, -0.5), angle = Angle(0, 180, 0) },
}

SWEP.WElements = {
	["E"] = { type = "Model", model = "models/weapons/fml/fallout/c_dp28_smol.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-5.678, 3.588, -6.074), angle = Angle(-10, 0, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {[1] = 1} }
}

SWEP.IronSightsPos = Vector(-2.616, 0, 1.179)
SWEP.IronSightsAng = Vector(0,0,0)

SWEP.IronSightsPos_EOTech = Vector(-2.61, -1.5, 0.148)
SWEP.IronSightsAng_EOTech = Vector(0, 0, 0)

SWEP.IronSightsPos_Kobra = Vector(-2.61, -1.5, 0.148)
SWEP.IronSightsAng_Kobra = Vector(0, 0, 0)

SWEP.IronSightsPos_RDS = Vector(-2.61, -1.5, 0.148)
SWEP.IronSightsAng_RDS = Vector(-0, 0, 0)

SWEP.IronSightsPos_2XRDS = Vector(-2.61, 1, 0.148)
SWEP.IronSightsAng_2XRDS = Vector(0, 0, 0)
SWEP.Secondary.IronFOV_2XRDS = 50

SWEP.IronSightsPos_C79 = Vector(-2.609, 1, -0.281)
SWEP.IronSightsAng_C79 = Vector(0, 0, 0)
SWEP.Secondary.IronFOV_C79 = 50

SWEP.IronSightsPos_PO4X = Vector(-2.965, -2, 0.162)
SWEP.IronSightsAng_PO4X = Vector(0, 0, 0)
SWEP.Secondary.IronFOV_PO4X = 50

SWEP.IronSightsPos_MX4 = Vector(-3.616, -2, -0.058)
SWEP.IronSightsAng_MX4 = Vector(0, 0, 0)
SWEP.Secondary.IronFOV_MX4 = 40

SWEP.RTOpaque	= true

SWEP.SequenceRateOverride = {
	[ACT_VM_RELOAD] = 1,	
}

SWEP.StatusLengthOverride = {
	[ACT_VM_RELOAD] = 90/60,
	[ACT_VM_RELOAD_EMPTY] = 90/60,	
}

SWEP.LaserSightModAttachment = 1

SWEP.Type = "Sub-Machine Gun"

SWEP.AutoSwitchTo = true
SWEP.AutoSwitchFrom = true

SWEP.Slot = 4
SWEP.SlotPos = 1
 
SWEP.UseHands = true

SWEP.FiresUnderwater = true

SWEP.DrawCrosshair = true

SWEP.DrawAmmo = true

SWEP.ReloadSound = ""

SWEP.Base = "tfa_gun_base"

SWEP.Primary.IronAccuracy_SG = .075

--Recoil Related
SWEP.Primary.KickUp = 0.25 -- This is the maximum upwards recoil (rise)
SWEP.Primary.KickHorizontal = 0.075
SWEP.Primary.StaticRecoilFactor = 0.5 --Amount of recoil to directly apply to EyeAngles.  Enter what fraction or percentage (in decimal form) you want.  This is also affected by a convar that defaults to 0.5.
--Firing Cone Related
SWEP.Primary.Spread = .0275 --This is hip-fire acuracy.  Less is more (1 is horribly awful, .0001 is close to perfect)
SWEP.Primary.IronAccuracy = .0075 -- Ironsight accuracy, should be the same for shotguns
--Unless you can do this manually, autodetect it.  If you decide to manually do these, uncomment this block and remove this line.
SWEP.Primary.SpreadMultiplierMax = 3 --How far the spread can expand when you shoot. Example val: 2.5
SWEP.Primary.SpreadIncrement = 1.5 --What percentage of the modifier is added on, per shot.  Example val: 1/3.5
SWEP.Primary.SpreadRecovery = 5 --How much the spread recovers, per second. Example val: 3
--Range Related
SWEP.Primary.Range = (980 * 16) -- The distance the bullet can travel in source units.  Set to -1 to autodetect based on damage/rpm.
SWEP.Primary.RangeFalloff = 0.8 -- The percentage of the range the bullet damage starts to fall off at.  Set to 0.8, for example, to start falling off after 80% of the range.
--Misc
SWEP.CrouchAccuracyMultiplier = 0.5 --Less is more.  Accuracy * 0.5 = Twice as accurate, Accuracy * 0.1 = Ten times as accurate
--Movespeed
SWEP.MoveSpeed = 0.75 --Multiply the player's movespeed by this.
SWEP.IronSightsMoveSpeed = 0.6 --Multiply the player's movespeed by this when sighting.

SWEP.IronSightTime = 0.35

SWEP.VMPos = Vector(0.5, -1, 0.5)
SWEP.VMAng = Vector(0,0,0)
SWEP.VMPos_Additive = false --Set to false for an easier time using VMPos. If true, VMPos will act as a constant delta ON TOP OF ironsights, run, whateverelse

SWEP.Primary.Sound = Sound("weapons/22smgsil/wpn_silenced22smg.wav") -- This is the sound of the weapon, when you shoot.
SWEP.Primary.SilencedSound = Sound("TFA_INS2_M4A1.2")
SWEP.Primary.Damage = 14
SWEP.Primary.TakeAmmo = 1
SWEP.Primary.ClipSize = 60
SWEP.Primary.Ammo = "AR2AltFire"
SWEP.Primary.DefaultClip = 61 + 60 * 3
SWEP.Primary.Automatic = true
SWEP.Primary.Recoil = 1
SWEP.Primary.RPM = 630
SWEP.Primary.Force = 1

SWEP.Primary.PenetrationMultiplier = 1 --Change the amount of something this gun can penetrate through

SWEP.Secondary.ClipSize = 0
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

SWEP.Secondary.IronFOV = 80

--[[INSPECTION]]--
SWEP.InspectPos = Vector(7.769, -1.509, -0.394)
SWEP.InspectAng = Vector(13.678, 36.644, 15.503)

--[[SPRINTING]]--
SWEP.RunSightsPos = Vector(1.559, 1, -1.13)
SWEP.RunSightsAng = Vector(-24.535, 23.375, -25.553)