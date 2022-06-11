SWEP.Base				 = "tfa_ins2_nade_base"
SWEP.Category			 = "TFA Fallout"           -- The category.  Please, just choose something generic or something I've already done if you plan on only doing like one swep..
SWEP.Author				 = "XxYanKy700xX"
SWEP.Contact			 = ""
SWEP.PrintName			 = "Molotov Cocktail"
SWEP.Purpose			 = ""
SWEP.Type				 = "Grenade"
SWEP.Slot				 = 4
SWEP.SlotPos			 = 99
SWEP.Weight				 = 2

SWEP.Spawnable			 = true
SWEP.AdminSpawnable		 = true
SWEP.DrawCrosshair		 = false
SWEP.DrawAmmo			 = true
SWEP.AutoSwitchTo		 = true
SWEP.AutoSwitchFrom		 = true

SWEP.Primary.RPM		 = 35
SWEP.Primary.ClipSize	 = 1
SWEP.Primary.DefaultClip = 1
SWEP.Primary.Automatic	 = false
SWEP.DisableChambering   = true

SWEP.Delay               = 0.25
SWEP.DelayCooked         = 0.22
SWEP.Delay_Underhand     = 0.25
SWEP.CookStartDelay      = 1
SWEP.CookingEnabled      = true
SWEP.CookTimer           = 5
SWEP.UnderhandEnabled    = true

SWEP.SelectiveFire       = false                        -- Allow selecting your firemode?
SWEP.DisableBurstFire    = false                        -- Only auto/single?
SWEP.OnlyBurstFire       = false                        -- No auto, only burst/single?
SWEP.DefaultFireMode     = "Thrown"                     -- Default to auto or whatev
SWEP.FireModeName        = "Thrown"                     -- Change to a text value to override it
 
SWEP.Primary.Ammo		 = "FireBomb"
SWEP.Primary.Round 	     = ("tfa_fallout_thrown_molotov_cocktail")
SWEP.Velocity            = 1000
SWEP.Velocity_Underhand  = 600

SWEP.ViewModel			 = "models/weapons/tfa_fallout/c_fallout_firebomb.mdl"
SWEP.ViewModelFOV		 = 70
SWEP.ViewModelFlip		 = false

SWEP.InspectPos 		 = Vector(5, -10, 3)
SWEP.InspectAng 		 = Vector(1, 35, -2.5)

SWEP.RunSightsPos        = Vector(0, 0, -3)
SWEP.RunSightsAng        = Vector(-50, 0, 0)

SWEP.ViewModelBoneMods = {
	["Index06"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, -0.6), angle = Angle(-16.5, 10, 0) },
	["Index05"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(10, 0, 0) },
	["Index04"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(10, 0, 0) },
	["Middle06"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, -0.3), angle = Angle(2.5, 5, 0) },
	["Ring06"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, -0.1), angle = Angle(2, 0, 0) },
	["Pinky06"] = { scale = Vector(1, 1, 1), pos = Vector(0.1, 0, 0), angle = Angle(15, -10, 0) },
	["Pinky05"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(2.5, 0, 0) },
	["Pinky04"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(2.5, 0, 0) },
}

SWEP.Sprint_Mode 		 = TFA.Enum.LOCOMOTION_ANI

SWEP.SprintAnimation = {
	["loop"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ,
		["value"] = "sprint",
		["is_idle"] = true
	}
}

SWEP.WorldModel			 = "models/weapons/tfa_fallout/w_fallout_firebomb.mdl"

SWEP.Offset = {
	Pos = {
		Up = 2,
		Right = 3,
		Forward = 4
	},
	Ang = {
		Up = 0,
		Right = 0,
		Forward = 200
	},
	Scale = 1
} -- Procedural world model animation, defaulted for CS:S purposes.

SWEP.HoldType 			 = "grenade"