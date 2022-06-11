-- If you are reading this and decided to copy-paste and rename this EFT-specific code (why?), at least credit me (YuRaNnNzZZ) for it, don't be *that* guy.

AddCSLuaFile()

if TFA and TFA.AddSound then
	local p1,p2 = "yurie/eft/weapons/knife_bayonet/","YURIE_EFT.Knife_Bayonet."

	TFA.AddSound(p2.."Eqiup", CHAN_STATIC, 1, 140, 100, p1.."knife_bayonet_equip.wav", ")")
	TFA.AddSound(p2.."Hit_Wall", CHAN_STATIC, 1, 140, 100, p1.."knife_bayonet_hit_wall.wav", ")")
	TFA.AddSound(p2.."Hit", CHAN_STATIC, 1, 140, 100, {p1.."knife_bayonet_hit1.wav",p1.."knife_bayonet_hit2.wav"}, ")")
	TFA.AddSound(p2.."Holster", CHAN_STATIC, 1, 140, 100, p1.."knife_bayonet_holster.wav", ")")
	TFA.AddSound(p2.."Stab", CHAN_STATIC, 1, 140, 100, p1.."knife_bayonet_stab.wav", ")")
	TFA.AddSound(p2.."Swing", CHAN_STATIC, 1, 140, 100, {p1.."knife_bayonet_swing1.wav",p1.."knife_bayonet_swing2.wav"}, ")")
end

SWEP.Base = "tfa_melee_base"

SWEP.DrawCrosshair = true

SWEP.Idle_Blend = 0
SWEP.Idle_Smooth = 0

SWEP.Sprint_Mode = TFA.Enum.LOCOMOTION_HYBRID
SWEP.RunSightsPos = Vector(0, 0, 0)
SWEP.RunSightsAng = Vector(-15, 15, 0)
SWEP.SprintBobMult = 4

SWEP.SprintAnimation = {
	["in"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ,
		["value"] = "Hands.PATROL IN",
		["transition"] = true,
	},
	["loop"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ,
		["value"] = "Hands.PATROL",
		["is_idle"] = true,
	},
	["out"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ,
		["value"] = "Hands.PATROL OUT",
		["transition"] = true,
	}
}

SWEP.Customize_Mode = TFA.Enum.LOCOMOTION_HYBRID
SWEP.InspectPos = Vector(10, -8, -2)
SWEP.InspectAng = Vector(22, 56, 16)

SWEP.CustomizeAnimation = {
	["in"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ,
		["value"] = "Hands.OPEN INVENTORY",
		["transition"] = true,
	},
	["loop"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ,
		["value"] = "Hands.IN IVENTORY",
		["is_idle"] = true,
	},
	["out"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ,
		["value"] = "Hands.CLOSE INVENTORY",
		["transition"] = true,
	}
}

SWEP.Primary.RPM_Displayed = 80

SWEP.Primary.Directional = false
SWEP.Primary.MaxCombo = -1
SWEP.Secondary.Directional = false
SWEP.Secondary.MaxCombo = -1

SWEP.AllowSprintAttack = false
SWEP.AltAttack = false

SWEP.EventTable = {
	[ACT_VM_DRAW] = {
		{["time"] = 0, ["type"] = "sound", ["value"] = "YURIE_EFT.Knife_Bayonet.Eqiup"},
	},
	[ACT_VM_HOLSTER] = {
		{["time"] = 0, ["type"] = "sound", ["value"] = "YURIE_EFT.Knife_Bayonet.Holster"},
	}
}

SWEP.MeleeSound_Hit = "YURIE_EFT.Knife_Bayonet.Stab"

DEFINE_BASECLASS(SWEP.Base)

function SWEP:SetHitPP()
	if self:VMIV() then
		self.OwnerViewModel:SetPoseParameter("collider", 1)
	end
end

function SWEP:UnsetHitPP()
	if self:VMIV() then
		self.OwnerViewModel:SetPoseParameter("collider", 0)
	end
end

function SWEP:SmackEffect(...)
	self:SetHitPP()

	self:EmitSoundNet(self:GetStat("MeleeSound_Hit"))

	return BaseClass.SmackEffect(self, ...)
end

function SWEP:PlaySwing(...)
	self:UnsetHitPP()

	return BaseClass.PlaySwing(self, ...)
end