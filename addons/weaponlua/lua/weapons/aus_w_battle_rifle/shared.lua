SWEP.PrintName = "Battle Rifle"
SWEP.Author = ""
SWEP.Contact = ""
SWEP.Purpose = ""
SWEP.Instructions = ""

SWEP.Category = "Fallout | Weapons (.308 Rounds)"

--[[VIEWMODEL BLOWBACK]]--
SWEP.BlowbackEnabled = false --Enable Blowback?
SWEP.BlowbackVector = Vector(0,-3.5,0) --Vector to move bone <or root> relative to bone <or view> orientation.
SWEP.BlowbackCurrentRoot = 0 --Amount of blowback currently, for root
SWEP.BlowbackCurrent = 0 --Amount of blowback currently, for bones
SWEP.Blowback_Only_Iron = true --Only do blowback on ironsights
SWEP.Blowback_PistolMode = true --Do we recover from blowback when empty?
SWEP.Blowback_Shell_Enabled = false --Shoot shells through blowback animations
SWEP.Blowback_Shell_Effect = "RifleShellEject"--Which shell effect to use

SWEP.Spawnable= true
SWEP.AdminSpawnable= true
SWEP.AdminOnly = false
SWEP.CSMuzzleFlashes = true

SWEP.MuzzleAttachment = 1
SWEP.ShellAttachment = 2 

-- Shell eject override
SWEP.LuaShellEject = false --Enable shell ejection through lua?
SWEP.LuaShellEjectDelay = 0 --The delay to actually eject things
SWEP.LuaShellModel = nil --The model to use for ejected shells
SWEP.LuaShellScale = nil --The model scale to use for ejected shells
SWEP.LuaShellYaw = nil --The model yaw rotation ( relative ) to use for ejected shells

SWEP.HoldType = "ar2"
SWEP.ViewModelFOV = 70
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.ViewModel = "models/weapons/fml/fallout/c_m1_garand.mdl"
SWEP.WorldModel = "models/weapons/w_smg1.mdl"
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = false
SWEP.ViewModelBoneMods = {
	["ValveBiped.Bip01_L_Clavicle"] = { scale = Vector(1, 1, 1), pos = Vector(0.115, 0, -0.2), angle = Angle(0, 0, 0) },

	["Weapon_Shell"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 180, 0) },	
	["Weapon_Muzzle"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0.5, 1), angle = Angle(-90, 0, 0) },	
	["A_Optic"] = { scale = Vector(1, 1, 1), pos = Vector(0, -0.35, 2), angle = Angle(0, 180, 0) },
}

SWEP.WElements = {
	["E"] = { type = "Model", model = "models/weapons/fml/fallout/c_m1_garand.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-1.443, 3.963, -5), angle = Angle(-10, 0, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {[1] = 1} }
}

SWEP.IronSightsPos = Vector(-2.684, -3, 1.32)
SWEP.IronSightsAng = Vector(0, 0, 0)

SWEP.IronSightsPos_EOTech = Vector(-2.684, -4, -0.071)
SWEP.IronSightsAng_EOTech = Vector(0, 0, 0)

SWEP.IronSightsPos_Kobra = Vector(-2.684, -4, -0.071)
SWEP.IronSightsAng_Kobra = Vector(0, 0, 0)

SWEP.IronSightsPos_RDS = Vector(-2.684, -4, -0.071)
SWEP.IronSightsAng_RDS = Vector(0, 0, 0)

SWEP.IronSightsPos_2XRDS = Vector(-2.684, -4, -0.071)
SWEP.IronSightsAng_2XRDS = Vector(0, 0, 0)
SWEP.Secondary.IronFOV_2XRDS = 50

SWEP.IronSightsPos_C79 = Vector(-2.688, -4, -0.486)
SWEP.IronSightsAng_C79 = Vector(0, 0, 0)
SWEP.Secondary.IronFOV_C79 = 50

SWEP.IronSightsPos_PO4X = Vector(-2.638, -4, 0.059)
SWEP.IronSightsAng_PO4X = Vector(0, 0, 0)
SWEP.Secondary.IronFOV_PO4X = 50

SWEP.IronSightsPos_MX4 = Vector(-3.07, 3, 1.069)
SWEP.IronSightsAng_MX4 = Vector(0, 0, 0)
SWEP.Secondary.IronFOV_MX4 = 40

SWEP.RTOpaque	= true

SWEP.DisableChambering = true

SWEP.SequenceRateOverride = {
	[ACT_VM_PRIMARYATTACK_1] = 1.5,	
}

SWEP.StatusLengthOverride = {
	[ACT_VM_RELOAD] = 100/60,
}

SWEP.LaserSightModAttachment = 1

SWEP.Type = "Battle Rifle"

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
SWEP.Primary.KickUp = 0.35 -- This is the maximum upwards recoil (rise)
SWEP.Primary.KickHorizontal = 0.25
SWEP.Primary.StaticRecoilFactor = 0.5 --Amount of recoil to directly apply to EyeAngles.  Enter what fraction or percentage (in decimal form) you want.  This is also affected by a convar that defaults to 0.5.
--Firing Cone Related
SWEP.Primary.Spread = .09 --This is hip-fire acuracy.  Less is more (1 is horribly awful, .0001 is close to perfect)
SWEP.Primary.IronAccuracy = .00075 -- Ironsight accuracy, should be the same for shotguns
--Unless you can do this manually, autodetect it.  If you decide to manually do these, uncomment this block and remove this line.
SWEP.Primary.SpreadMultiplierMax = 2 --How far the spread can expand when you shoot. Example val: 2.5
SWEP.Primary.SpreadIncrement = 2.5 --What percentage of the modifier is added on, per shot.  Example val: 1/3.5
SWEP.Primary.SpreadRecovery = 10 --How much the spread recovers, per second. Example val: 3
--Range Related
SWEP.Primary.Range = (980 * 16) -- The distance the bullet can travel in source units.  Set to -1 to autodetect based on damage/rpm.
SWEP.Primary.RangeFalloff = 0.8 -- The percentage of the range the bullet damage starts to fall off at.  Set to 0.8, for example, to start falling off after 80% of the range.
--Misc
SWEP.CrouchAccuracyMultiplier = 0.3 --Less is more.  Accuracy * 0.5 = Twice as accurate, Accuracy * 0.1 = Ten times as accurate
--Movespeed
SWEP.MoveSpeed = 0.75 --Multiply the player's movespeed by this.
SWEP.IronSightsMoveSpeed = 0.65 --Multiply the player's movespeed by this when sighting.

SWEP.IronSightTime = 0.25

SWEP.VMPos = Vector(-0.5, 0, 0.5)
SWEP.VMAng = Vector(0,0, 0)
SWEP.VMPos_Additive = false --Set to false for an easier time using VMPos. If true, VMPos will act as a constant delta ON TOP OF ironsights, run, whateverelse

SWEP.Primary.Damage_SG = 12

SWEP.Primary.Ammo_Rifle = "ar2"
SWEP.Primary.Ammo_SG = "buckshot"
SWEP.Primary.Ammo_50cal = "ar2"

SWEP.Primary.Sound = Sound("weapons/riflebrushgun/wpn_brushgun.wav")
SWEP.Primary.SilencedSound = Sound("TFA_INS2_AKM.2") -- This is the sound of the weapon, when silenced.
SWEP.Primary.Damage = 68
SWEP.Primary.TakeAmmo = 1
SWEP.Primary.ClipSize = 8
SWEP.Primary.Ammo = "SniperRound"
SWEP.Primary.DefaultClip = 0
SWEP.Primary.Automatic = false
SWEP.Primary.Recoil = 1
SWEP.Primary.RPM = 60
SWEP.Primary.Force = 1

SWEP.Primary.PenetrationMultiplier = 10 --Change the amount of something this gun can penetrate through

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