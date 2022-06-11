SWEP.Base = "yurie_eft_melee_base"
SWEP.Author = "YuRaNnNzZZ"
SWEP.Category = "TFA Escape From Tarkov"
SWEP.PrintName = "Cultist's knife"
SWEP.ViewModel = "models/yurie/eft/weapons/knife_ritual.mdl"
SWEP.ViewModelFOV = 65
SWEP.UseHands = true
SWEP.WorldModel = "models/yurie/eft/weapons/world/knife_ritual.mdl"
SWEP.HoldType = "melee"
SWEP.Purpose = "First two hits deal poison damage."

SWEP.Spawnable = TFA_BASE_VERSION and TFA_BASE_VERSION >= 4.5
SWEP.AdminOnly = false

SWEP.Primary.Damage = 18
SWEP.Secondary.Damage = 23
include("weapons/yurie_eft_melee_base/pre.lua")

SWEP.Primary.Attacks = {
	{
		["act"] = ACT_VM_PRIMARYATTACK, -- Animation; ACT_VM_THINGY, ideally something unique per-sequence
		["len"] = 36.75, -- Trace distance
		["dir"] = Vector(-15, 36.75, -5), -- Trace arc cast
		["dmg"] = SWEP.Primary.Damage, --Damage
		["dmgtype"] = DMG_SLASH, --DMG_SLASH,DMG_CRUSH, etc.
		["force"] = 12,
		["delay"] = 0.3073048, --Delay
		["spr"] = false, --Allow attack while sprinting?
		["snd"] = "YURIE_EFT.Knife_Bayonet.Swing", -- Sound ID
		["snd_delay"] = 0.2,
		["viewpunch"] = Angle(0, 0, 0), --viewpunch angle
		["end"] = 0.733333349, --time before next attack
		["hull"] = 10, --Hullsize
		["direction"] = "L", --Swing dir,
		["hitflesh"] = "YURIE_EFT.Knife_Bayonet.Hit",
		["hitworld"] = "YURIE_EFT.Knife_Bayonet.HitWall",
	}
}
SWEP.Secondary.Attacks = {
	{
		["act"] = ACT_VM_SECONDARYATTACK, -- Animation; ACT_VM_THINGY, ideally something unique per-sequence
		["len"] = 47.25, -- Trace distance
		["dir"] = Vector(-5, 47.25, 5), -- Trace arc cast
		["dmg"] = SWEP.Secondary.Damage, --Damage
		["dmgtype"] = DMG_SLASH, --DMG_SLASH,DMG_CRUSH, etc.
		["force"] = 16,
		["delay"] = 0.2720403, --Delay
		["spr"] = false, --Allow attack while sprinting?
		["snd"] = "YURIE_EFT.Knife_Bayonet.Swing", -- Sound ID
		["snd_delay"] = 0.2565,
		["viewpunch"] = Angle(0, 0, 0), --viewpunch angle
		["end"] = 1, --time before next attack
		["hull"] = 10, --Hullsize
		["direction"] = "F", --Swing dir,
		["hitflesh"] = "YURIE_EFT.Knife_Bayonet.Hit",
		["hitworld"] = "YURIE_EFT.Knife_Bayonet.HitWall",
	}
}

SWEP.InspectPos = Vector(10, -8, 12)
SWEP.InspectAng = Vector(35, 50, 50)

if surface and surface.GetTextureID then
	SWEP.WepSelectIcon = surface.GetTextureID("yurie/eft/icons/hud/weapon_cultist_damask")
end
if killicon and killicon.Add then
	killicon.Add("yurie_eft_cultist_damask", "yurie/eft/icons/death/weapon_cultist_damask", Color(255, 80, 0, 255))
end

DEFINE_BASECLASS(SWEP.Base)

function SWEP:CanBeJammed()
	return true -- hack to always show durability
end

function SWEP:ApplyDamage(traceres, damage, attack, ...)
	local tEnt = traceres.Entity

	if IsValid(tEnt) and (tEnt:IsPlayer() or tEnt:IsNPC() or tEnt:IsNextBot()) then
		local jamfac = self:GetJamFactor()

		if jamfac < 100 then
			self:SetJamFactor(math.min(jamfac + 50, 100))

			damage:SetDamageType(bit.bor(damage:GetDamageType(), DMG_POISON))
		end
	end

	return BaseClass.ApplyDamage(self, traceres, damage, attack, ...)
end

include("weapons/yurie_eft_melee_base/post.lua")