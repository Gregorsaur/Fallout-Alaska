AddCSLuaFile()

local cv_damagemul = GetConVar("sv_tfa_melee_damage_eft") or CreateConVar("sv_tfa_melee_damage_eft", "2", CLIENT and {FCVAR_REPLICATED} or {FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_NOTIFY}, "Damage multiplier for EFT melee weapons\n\t(Requires map restart to apply.)", 0.01, 0xFFFF)

if SWEP.Primary and SWEP.Primary.Damage then
	SWEP.Primary.Damage = SWEP.Primary.Damage * cv_damagemul:GetFloat()
end

if SWEP.Secondary and SWEP.Secondary.Damage then
	SWEP.Secondary.Damage = SWEP.Secondary.Damage * cv_damagemul:GetFloat()
end