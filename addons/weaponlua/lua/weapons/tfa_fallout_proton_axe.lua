SWEP.Base         = "tfa_melee_base"
SWEP.Category     = "TFA Fallout"
SWEP.PrintName    = "Proton Axe"
SWEP.Author		  = "Yo Momma"       
SWEP.Spawnable    = true
SWEP.AdminOnly    = false

SWEP.UseHands     = true

SWEP.ViewModel    = "models/weapons/tfa_fallout/c_fallout_proton_axe.mdl"
SWEP.ViewModelFOV = 70
SWEP.VMPos        = Vector(0, 0, 0)
SWEP.VMAng        = Vector(0, 0, 0)          

SWEP.CameraOffset = Angle(0, -2, 0)

SWEP.InspectPos   = Vector(0, -13, -10) 
SWEP.InspectAng   = Vector(50, 0, 0)

SWEP.ProceduralHoslterEnabled = true
SWEP.ProceduralHolsterTime    = 0.35
SWEP.ProceduralHolsterPos     = Vector(0, 0, -10)
SWEP.ProceduralHolsterAng     = Vector(-40, -10, 10)

SWEP.Idle_Mode     = TFA.Enum.IDLE_BOTH         -- TFA.Enum.IDLE_DISABLED = no idle, TFA.Enum.IDLE_LUA = lua idle, TFA.Enum.IDLE_ANI = mdl idle, TFA.Enum.IDLE_BOTH = TFA.Enum.IDLE_ANI + TFA.Enum.IDLE_LUA
SWEP.Idle_Blend    = 0.25                       -- Start an idle this far early into the end of a transition
SWEP.Idle_Smooth   = 0.05                       -- Start an idle this far early into the end of another animation

SWEP.AllowSprintAttack = false

SWEP.Sprint_Mode   = TFA.Enum.LOCOMOTION_LUA    -- ANI = mdl, HYBRID = ani + lua, Lua = lua only
SWEP.SprintBobMult = 1.5

SWEP.RunSightsPos  = Vector(0, 0, 0.25)
SWEP.RunSightsAng  = Vector(-8.5, 0, 0)

SWEP.ViewModelBoneMods = {
	["ValveBiped.Bip01_R_Finger1"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 5, 0) },
	["ValveBiped.Bip01_R_Finger2"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 15, 0) },
	["ValveBiped.Bip01_R_Finger21"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 10, 0) },
	["ValveBiped.Bip01_R_Finger3"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(4.943, 13.078, -2.875) },
	["ValveBiped.Bip01_R_Finger31"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 10, 0) },
	["ValveBiped.Bip01_R_Finger4"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 25.33, 10.729) },
	["ValveBiped.Bip01_R_Finger41"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 6.151, 0) }
}

SWEP.WorldModel   = "models/weapons/tfa_fallout/w_fallout_proton_axe.mdl"
SWEP.HoldType     = "melee2"

SWEP.Offset = {
	Pos = {
		Up = 0,
		Right = 1,
		Forward = 3
	},
	Ang = {
		Up = 0,
		Right = 0,
		Forward = 180
	},
	Scale = 1
} 

SWEP.WorldModelBoneMods    = {}

SWEP.DisableIdleAnimations = false
SWEP.Primary.Directional   = true

SWEP.Primary.Attacks = {

	{
		['act'] = ACT_VM_HITRIGHT,                -- Animation; ACT_VM_THINGY, ideally something unique per-sequence
		['len'] = 16 * 4,                         -- Trace distance
		['dir'] = Vector(35, 0, 40),              -- Trace arc cast
		['dmg'] = 200,                            -- Damage
		['dmgtype'] = ( bit.bor( DMG_SLASH, DMG_SHOCK ) ), 
		['delay'] = 0.35,                         -- Delay
		['spr'] = true,                           -- Allow attack while sprinting?
		['snd'] = "TFA_Fallout.Proton_Axe.Swing", -- Sound ID
		['snd_delay'] = 0.2,                      -- Sound delay
		["viewpunch"] = Angle(-5, -5, 0),         -- viewpunch angle
		['end'] = 0.95,                           -- time before next attack
		['hull'] = 16,                            -- Hullsize
		['direction'] = "RB",                     -- Swing dir,
		['hitflesh'] = "TFA_Fallout.Proton_Axe.HitFlesh",
		['hitworld'] = "TFA_Fallout.Proton_Axe.HitWorld"
	},
	{
		['act'] = ACT_VM_SWINGHARD,               -- Animation; ACT_VM_THINGY, ideally something unique per-sequence
		['len'] = 16 * 4,                         -- Trace distance
		['dir'] = Vector(-35, 0, -35),            -- Trace arc cast
		['dmg'] = 200,                            -- Damage
		['dmgtype'] = ( bit.bor( DMG_SLASH, DMG_SHOCK ) ), 
		['delay'] = 0.375,                        -- Delay
		['spr'] = true,                           -- Allow attack while sprinting?
		['snd'] = "TFA_Fallout.Proton_Axe.Swing", -- Sound ID
		['snd_delay'] = 0.2,                      -- Sound delay
		["viewpunch"] = Angle(5, 5, 0),           -- viewpunch angle
		['end'] = 0.95,                           -- time before next attack
		['hull'] = 16,                            -- Hullsize
		['direction'] = "RB",                     -- Swing dir,
		['hitflesh'] = "TFA_Fallout.Proton_Axe.HitFlesh",
		['hitworld'] = "TFA_Fallout.Proton_Axe.HitWorld"
	},
}

SWEP.Secondary.Attacks    = {}

SWEP.Secondary.CanBash    = true
SWEP.Secondary.BashDamage = 30