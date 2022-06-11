SWEP.PrintName = "FM Sawnoff Shotgun"
SWEP.Author = "Fleshy Mammal"
SWEP.Contact = ""
SWEP.Purpose = "lol fuck off"
SWEP.Instructions = ""

SWEP.Category = "TFA Fallout"

SWEP.Spawnable= true
SWEP.AdminSpawnable= true
SWEP.AdminOnly = false
SWEP.CSMuzzleFlashes = true

SWEP.MuzzleAttachment = 1
SWEP.ShellAttachment = "2" 		-- Should be "2" for CSS models or "shell" for hl2 models

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
SWEP.ViewModel = "models/weapons/fml/fallout/c_sawnoff.mdl"
SWEP.WorldModel = "models/weapons/w_smg1.mdl"
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = false
SWEP.ViewModelBoneMods = {
	["Weapon_Muzzle"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0.25, -10), angle = Angle(-90, 0, 0) },	
	["A_Optic"] = { scale = Vector(1, 1, 1), pos = Vector(0, -0.25, -1), angle = Angle(0, 180, 0) },
}

SWEP.DisableChambering = true

SWEP.WElements = {
	["E"] = { type = "Model", model = "models/weapons/fml/fallout/c_sawnoff.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-2.01, 3.316, -4.258), angle = Angle(-10, 0, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.VElements = {}

SWEP.IronSightsPos = Vector(-2.34, -3, 0.479)
SWEP.IronSightsAng = Vector(0.98, 0, 0)

SWEP.Attachments = {
	[1] = { atts = { "sg_frag", "sg_slug" } },			
}

SWEP.RTOpaque	= true

SWEP.SequenceRateOverride = {
	[ACT_VM_RELOAD] = 1,	
}

SWEP.StatusLengthOverride = {
	[ACT_VM_RELOAD] = 75/60,
}

SWEP.LaserSightModAttachment = 1

SWEP.Type = "Pistol"

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
SWEP.Primary.KickUp = 6.25 -- This is the maximum upwards recoil (rise)
SWEP.Primary.KickHorizontal = 1.5
SWEP.Primary.StaticRecoilFactor = 0.5 --Amount of recoil to directly apply to EyeAngles.  Enter what fraction or percentage (in decimal form) you want.  This is also affected by a convar that defaults to 0.5.
--Firing Cone Related
SWEP.Primary.Spread = .085 --This is hip-fire acuracy.  Less is more (1 is horribly awful, .0001 is close to perfect)
SWEP.Primary.IronAccuracy = .085 -- Ironsight accuracy, should be the same for shotguns
--Unless you can do this manually, autodetect it.  If you decide to manually do these, uncomment this block and remove this line.
SWEP.Primary.SpreadMultiplierMax = 4.75 --How far the spread can expand when you shoot. Example val: 2.5
SWEP.Primary.SpreadIncrement = 0.75 --What percentage of the modifier is added on, per shot.  Example val: 1/3.5
SWEP.Primary.SpreadRecovery = 5 --How much the spread recovers, per second. Example val: 3
--Range Related
SWEP.Primary.Range = (980 * 16) -- The distance the bullet can travel in source units.  Set to -1 to autodetect based on damage/rpm.
SWEP.Primary.RangeFalloff = 0.8 -- The percentage of the range the bullet damage starts to fall off at.  Set to 0.8, for example, to start falling off after 80% of the range.
--Misc
SWEP.CrouchAccuracyMultiplier = 0.5 --Less is more.  Accuracy * 0.5 = Twice as accurate, Accuracy * 0.1 = Ten times as accurate
--Movespeed
SWEP.MoveSpeed = 0.875 --Multiply the player's movespeed by this.
SWEP.IronSightsMoveSpeed = 0.85 --Multiply the player's movespeed by this when sighting.

SWEP.IronSightTime = 0.35

SWEP.VMPos = Vector(0.5, 0, 0.5)
SWEP.VMAng = Vector(0,0,0)
SWEP.VMPos_Additive = false --Set to false for an easier time using VMPos. If true, VMPos will act as a constant delta ON TOP OF ironsights, run, whateverelse

SWEP.Primary.Sound = Sound("weapons/shotgunsawed/wpn_sawedoffshotgun.wav") -- This is the sound of the weapon, when you shoot.
SWEP.Primary.SilencedSound = Sound("TFA_INS2_M590.2") -- This is the sound of the weapon, when silenced.
SWEP.Primary.Damage = 10
SWEP.Primary.NumShots = 20
SWEP.Primary.TakeAmmo = 1
SWEP.Primary.ClipSize = 2
SWEP.Primary.Ammo = "12Gauge"
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

SWEP.Secondary.IronFOV = 80

--[[INSPECTION]]--
SWEP.InspectPos = Vector(7.769, -1.509, -0.394)
SWEP.InspectAng = Vector(13.678, 36.644, 15.503)

--[[SPRINTING]]--
SWEP.RunSightsPos = Vector(1.74, -5.207, -8)
SWEP.RunSightsAng = Vector(44.883, 7.519, -6.717)