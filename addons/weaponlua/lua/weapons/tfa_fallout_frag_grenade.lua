SWEP.Base				 = "tfa_ins2_nade_base"
SWEP.Category			 = "TFA Fallout"           -- The category.  Please, just choose something generic or something I've already done if you plan on only doing like one swep..
SWEP.Author				 = "XxYanKy700xX"
SWEP.Contact			 = ""
SWEP.PrintName			 = "Frag Grenade"
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
 
SWEP.Primary.Ammo		 = "FragGrenade"
SWEP.Primary.Round 	     = ("tfa_fallout_thrown_frag_greande")
SWEP.Velocity            = 1200
SWEP.Velocity_Underhand  = 600

SWEP.ViewModel			 = "models/weapons/tfa_fallout/c_fallout_fraggrenade.mdl"
SWEP.ViewModelFOV		 = 70
SWEP.ViewModelFlip		 = false

SWEP.InspectPos 		 = Vector(4, -4 -0.75)
SWEP.InspectAng 		 = Vector(22, 35, 4.8)

SWEP.RunSightsPos        = Vector(0, 0, -3)
SWEP.RunSightsAng        = Vector(-50, 0, 0)

SWEP.Idle_Mode           = TFA.Enum.IDLE_BOTH         -- TFA.Enum.IDLE_DISABLED = no idle, TFA.Enum.IDLE_LUA = lua idle, TFA.Enum.IDLE_ANI = mdl idle, TFA.Enum.IDLE_BOTH = TFA.Enum.IDLE_ANI + TFA.Enum.IDLE_LUA
SWEP.Idle_Blend          = 0.25                       -- Start an idle this far early into the end of a transition
SWEP.Idle_Smooth         = 0.05                       -- Start an idle this far early into the end of another animation

SWEP.Sprint_Mode 		 = TFA.Enum.LOCOMOTION_ANI

SWEP.SprintAnimation = {
	["loop"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ,
		["value"] = "sprint",
		["is_idle"] = true
	}
}

SWEP.WorldModel			 = "models/weapons/tfa_fallout/w_fallout_fraggrenade.mdl"

SWEP.Offset = {
	Pos = {
		Up = 0,
		Right = 1.5,
		Forward = 3.3
	},
	Ang = {
		Up = 0,
		Right = 0,
		Forward = 180
	},
	Scale = 1
} -- Procedural world model animation, defaulted for CS:S purposes.

SWEP.HoldType 			 = "grenade"