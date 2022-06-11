SWEP.Base = "tfa_melee_base"
SWEP.Category = "Tyler/Spice SupremeNetworks Rifles"
SWEP.PrintName = "Proton Axe"
SWEP.ViewModel = "models/weapons/v_stunbaton.mdl"
SWEP.ViewModelFOV = 80
SWEP.VMPos = Vector(8, -2, -2)
SWEP.VMAng = Vector(5,0,-15)
SWEP.UseHands = true
SWEP.CameraOffset = Angle(0, 0, 0)
--SWEP.InspectPos = Vector(17.184, -4.891, -11.902) - SWEP.VMPos
--SWEP.InspectAng = Vector(70, 46.431, 70)
SWEP.WorldModel = "models/f_anm.mdl"
SWEP.HoldType = "melee2"
SWEP.Primary.Directional = true
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.DisableIdleAnimations = false


if ( CLIENT ) then
SWEP.VElements = {
	["element_name"] = { type = "Model", model = "models/halokiller38/fallout/weapons/melee/protonaxe.mdl", bone = "Bip01 R Hand", rel = "", pos = Vector(0.536, 1.877, -11.804), angle = Angle(0, -77.276, -1), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
SWEP.WElements = {
	["element_name"] = { type = "Model", model = "models/halokiller38/fallout/weapons/melee/protonaxe.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.798, 1.957, 13.668), angle = Angle(180, -109.561, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
	SWEP.Slot			= 0					 
	SWEP.SlotPos		= 1
	SWEP.DrawAmmo		= false					 
	SWEP.IconLetter	= "w"
	killicon.AddFont( "weapon_crowbar", 	"HL2MPTypeDeath", 	"6", 	Color( 255, 80, 0, 255 ) )
end

SWEP.Primary.Attacks = {
	{
		["act"] = ACT_VM_HITCENTER, -- Animation; ACT_VM_THINGY, ideally something unique per-sequence
		["len"] = 16 * 4.5, -- Trace distance
		["dir"] = Vector(80, 0, 0), -- Trace arc cast
		["dmg"] = 50 * 0.8, --Damage
		["dmgtype"] = DMG_CLUB, --DMG_CLUB,DMG_CRUSH, etc.
		["delay"] = 35 / 60, --Delay
		["spr"] = true, --Allow attack while sprinting?
		["snd"] = "TFA_KF2_PULVERIZER.Swing", -- Sound ID
		["snd_delay"] = 20 / 60,
		["viewpunch"] = Angle(1, -5, 0), --viewpunch angle
		["end"] = 1.1, --time before next attack
		["hull"] = 16, --Hullsize
		["direction"] = "R", --Swing dir,
		["hitflesh"] = "TFA_KF2_PULVERIZER.HitFlesh",
		["hitworld"] = "TFA_KF2_PULVERIZER.HitWorld",
		["combotime"] = 0.1
	},
	{
		["act"] = ACT_VM_HITCENTER, -- Animation; ACT_VM_THINGY, ideally something unique per-sequence
		["len"] = 16 * 4.5, -- Trace distance
		["dir"] = Vector(-80, 0, 0), -- Trace arc cast
		["dmg"] = 50 * 0.8, --Damage
		["dmgtype"] = DMG_CLUB, --DMG_CLUB,DMG_CRUSH, etc.
		["delay"] = 35 / 60, --Delay
		["spr"] = true, --Allow attack while sprinting?
		["snd"] = "TFA_KF2_PULVERIZER.Swing", -- Sound ID
		["snd_delay"] = 20 / 60,
		["viewpunch"] = Angle(1, 5, 0), --viewpunch angle
		["end"] = 1.1, --time before next attack
		["hull"] = 16, --Hullsize
		["direction"] = "L", --Swing dir,
		["hitflesh"] = "TFA_KF2_PULVERIZER.HitFlesh",
		["hitworld"] = "TFA_KF2_PULVERIZER.HitWorld",
		["combotime"] = 0.1
	},
	{
		["act"] = ACT_VM_HITCENTER, -- Animation; ACT_VM_THINGY, ideally something unique per-sequence
		["len"] = 16 * 4.5, -- Trace distance
		["dir"] = Vector(0, 20, -70), -- Trace arc cast
		["dmg"] = 50, --Damage
		["dmgtype"] = DMG_CLUB, --DMG_CLUB,DMG_CRUSH, etc.
		["delay"] = 50 / 60, --Delay
		["spr"] = true, --Allow attack while sprinting?
		["snd"] = "TFA_KF2_PULVERIZER.Swing", -- Sound ID
		["snd_delay"] = 35 / 60,
		["viewpunch"] = Angle(5, 0, 0), --viewpunch angle
		["end"] = 1.1, --time before next attack
		["hull"] = 16, --Hullsize
		["direction"] = "F", --Swing dir,
		["hitflesh"] = "TFA_KF2_PULVERIZER.HitFlesh",
		["hitworld"] = "TFA_KF2_PULVERIZER.HitWorld",
		["combotime"] = 0.1
	},
	{
		["act"] = ACT_VM_HITCENTER, -- Animation; ACT_VM_THINGY, ideally something unique per-sequence
		["len"] = 16 * 4.5, -- Trace distance
		["dir"] = Vector(0, 20, 70), -- Trace arc cast
		["dmg"] = 50, --Damage
		["dmgtype"] = DMG_CLUB, --DMG_CLUB,DMG_CRUSH, etc.
		["delay"] = 45 / 60, --Delay
		["spr"] = true, --Allow attack while sprinting?
		["snd"] = "TFA_KF2_PULVERIZER.Swing", -- Sound ID
		["snd_delay"] = 25 / 60,
		["viewpunch"] = Angle(-5, 0, 0), --viewpunch angle
		["end"] = 1.1, --time before next attack
		["hull"] = 16, --Hullsize
		["direction"] = "B", --Swing dir,
		["hitflesh"] = "TFA_KF2_PULVERIZER.HitFlesh",
		["hitworld"] = "TFA_KF2_PULVERIZER.HitWorld",
		["combotime"] = 0.1
	}--[[,
	{
		["act"] = ACT_VM_HITCENTER, -- Animation; ACT_VM_THINGY, ideally something unique per-sequence
		["len"] = 16 * 4.5, -- Trace distance
		["dir"] = Vector(0, 30, 10), -- Trace arc cast
		["dmg"] = 120, --Damage
		["dmgtype"] = DMG_CLUB, --DMG_CLUB,DMG_CRUSH, etc.
		["delay"] = 0.2, --Delay
		["spr"] = true, --Allow attack while sprinting?
		["snd"] = "TFA_KF2_PULVERIZER.Swing", -- Sound ID
		["snd_delay"] = 0.1,
		["viewpunch"] = Angle(-5, 0, 2), --viewpunch angle
		["end"] = 1.1, --time before next attack
		["hull"] = 16, --Hullsize
		["direction"] = "FB", --Swing dir,
		["hitflesh"] = "TFA_KF2_PULVERIZER.HitFlesh",
		["hitworld"] = "TFA_KF2_PULVERIZER.HitWorld"
	}]]--
}

SWEP.Primary.Sound = "TFA_KF2_PULVERIZER.1"
SWEP.Primary.Automatic = true
SWEP.Primary.RPM = 60
SWEP.Primary.Damage = 50
SWEP.Primary.Radius = 16 * 5
SWEP.Primary.NumShots = 1
SWEP.Primary.Spread		= .015					--This is hip-fire acuracy.  Less is more (1 is horribly awful, .0001 is close to perfect)
SWEP.Primary.IronAccuracy = .005	-- Ironsight accuracy, should be the same for shotguns
SWEP.Primary.ClipSize = 5
SWEP.Primary.DefaultClip = 25
SWEP.Primary.Ammo = "buckshot"
SWEP.DisableChambering = true
SWEP.SelectiveFire = false
SWEP.Primary.Recovery = 1.4

SWEP.Secondary.ExpCallback = function(tbl,wep,tr)
	if not tbl.defaultkickback then
		tbl.defaultkickback = tbl.kickback
	end
	if not tbl.hitworlddefault then
		tbl.hitworlddefault = tbl.hitworld
	end
	if tr.Hit and tr.Fraction < 1 and IsValid(wep) and wep:Clip1() > 0 then
		tbl.kickback = tbl.defaultkickback
		wep:TakePrimaryAmmo(1)
		wep:SetNextPrimaryFire( CurTime() + wep.Primary.Recovery )
		wep:SetNextSecondaryFire( CurTime() + wep.Primary.Recovery )
		wep:EmitSound(wep.Primary.Sound)
		local spos = tr.HitPos or wep.Owner:GetShootPos()
		--[[
		local entbl = ents.FindInSphere( spos, wep.Primary.Radius )
		for k,v in pairs( entbl ) do
			if v ~= wep.Owner and v.TakeDamageInfo then
				local dist = spos:Distance( v:GetPos() )
				local falloff_fac = math.sqrt( 1 - math.Clamp( dist / wep.Primary.Radius, 0, 1 ) ) / 2 + 0.5
				local dmg = DamageInfo()
				dmg:SetDamage( wep.Primary.Damage * falloff_fac )
				dmg:SetDamageType( bit.bor( DMG_BLAST, DMG_ALWAYSGIB ) )
				dmg:SetDamagePosition( spos )
				dmg:SetDamageForce( ( v:GetPos() - spos ):GetNormalized() * dmg:GetDamage() / 4 )
				dmg:SetInflictor( wep )
				dmg:SetAttacker( wep.Owner or wep )
				if v.TakeDamageInfoSpecial then
					v:TakeDamageInfoSpecial( dmg )
				else
					v:TakeDamageInfo(dmg)
				end
			end
		end
		]]--
		local dmg = DamageInfo()
		dmg:SetDamage( wep.Primary.Damage )
		dmg:SetDamageType( bit.bor( DMG_BLAST, DMG_ALWAYSGIB ) )
		dmg:SetDamagePosition( spos )
		dmg:SetInflictor( wep )
		dmg:SetAttacker( wep.Owner or wep )
		util.BlastDamageInfo(dmg,spos,wep.Primary.Radius)
		tbl.hitworld = ""
	else
		tbl.kickback = nil
		tbl.hitworld = tbl.hitworlddefault or ""
	end
end



SWEP.Secondary.Attacks = {
	{
		["act"] = ACT_VM_MISSLEFT, -- Animation; ACT_VM_THINGY, ideally something unique per-sequence
		["len"] = 16 * 4.5, -- Trace distance
		["dir"] = Vector(80, 0, 0), -- Trace arc cast
		["dmg"] = 160 * 0.8, --Damage
		["dmgtype"] = bit.bor(DMG_CLUB, DMG_ALWAYSGIB), --DMG_CLUB,DMG_CRUSH, etc.
		["delay"] = 52 / 60, --Delay
		["spr"] = true, --Allow attack while sprinting?
		["snd"] = "TFA_KF2_PULVERIZER.SwingHard", -- Sound ID
		["snd_delay"] = 40 / 60,
		["viewpunch"] = Angle(1, -5, 0), --viewpunch angle
		["end"] = 1.3, --time before next attack
		["hull"] = 16, --Hullsize
		["direction"] = "R", --Swing dir,
		["hitflesh"] = "TFA_KF2_PULVERIZER.HitFleshHard",
		["hitworld"] = "TFA_KF2_PULVERIZER.HitWorld",
		["kickback"] = ACT_VM_MISSLEFT2,
		["callback"] = SWEP.Secondary.ExpCallback
	},
	{
		["act"] = ACT_VM_MISSRIGHT, -- Animation; ACT_VM_THINGY, ideally something unique per-sequence
		["len"] = 16 * 4.5, -- Trace distance
		["dir"] = Vector(-80, 0, 0), -- Trace arc cast
		["dmg"] = 160 * 0.8, --Damage
		["dmgtype"] = bit.bor(DMG_CLUB, DMG_ALWAYSGIB), --DMG_CLUB,DMG_CRUSH, etc.
		["delay"] = 53 / 60, --Delay
		["spr"] = true, --Allow attack while sprinting?
		["snd"] = "TFA_KF2_PULVERIZER.SwingHard", -- Sound ID
		["snd_delay"] = 40 / 60,
		["viewpunch"] = Angle(1, 5, 0), --viewpunch angle
		["end"] = 1.3, --time before next attack
		["hull"] = 16, --Hullsize
		["direction"] = "L", --Swing dir,
		["hitflesh"] = "TFA_KF2_PULVERIZER.HitFleshHard",
		["hitworld"] = "TFA_KF2_PULVERIZER.HitWorld",
		["kickback"] = ACT_VM_MISSRIGHT2,
		["callback"] = SWEP.Secondary.ExpCallback
	},
	{
		["act"] = ACT_VM_PULLBACK_HIGH, -- Animation; ACT_VM_THINGY, ideally something unique per-sequence
		["len"] = 16 * 4.5, -- Trace distance
		["dir"] = Vector(0, 20, 70), -- Trace arc cast
		["dmg"] = 160, --Damage
		["dmgtype"] = bit.bor(DMG_CLUB, DMG_ALWAYSGIB), --DMG_CLUB,DMG_CRUSH, etc.
		["delay"] = 55 / 60, --Delay
		["spr"] = true, --Allow attack while sprinting?
		["snd"] = "TFA_KF2_PULVERIZER.SwingHard", -- Sound ID
		["snd_delay"] = 40 / 60,
		["viewpunch"] = Angle(-10, 0, 0), --viewpunch angle
		["end"] = 1.3, --time before next attack
		["hull"] = 16, --Hullsize
		["direction"] = "B", --Swing dir,
		["hitflesh"] = "TFA_KF2_PULVERIZER.HitFleshHard",
		["hitworld"] = "TFA_KF2_PULVERIZER.HitWorld",
		["kickback"] = ACT_VM_MISSCENTER,
		["callback"] = SWEP.Secondary.ExpCallback
	},
	{
		["act"] = ACT_VM_SECONDARYATTACK, -- Animation; ACT_VM_THINGY, ideally something unique per-sequence
		["len"] = 16 * 4.5, -- Trace distance
		["dir"] = Vector(0, 20, -70), -- Trace arc cast
		["dmg"] = 160, --Damage
		["dmgtype"] = bit.bor(DMG_CLUB, DMG_ALWAYSGIB), --DMG_CLUB,DMG_CRUSH, etc.
		["delay"] = 62 / 60, --Delay
		["spr"] = true, --Allow attack while sprinting?
		["snd"] = "TFA_KF2_PULVERIZER.SwingHard", -- Sound ID
		["snd_delay"] = 50 / 60,
		["viewpunch"] = Angle(7.5, 0, 0), --viewpunch angle
		["end"] = 1.3, --time before next attack
		["hull"] = 16, --Hullsize
		["direction"] = "F", --Swing dir,
		["hitflesh"] = "TFA_KF2_PULVERIZER.HitFleshHard",
		["hitworld"] = "TFA_KF2_PULVERIZER.HitWorld",
		["kickback"] = ACT_VM_MISSCENTER2,
		["callback"] = SWEP.Secondary.ExpCallback
	}
}

SWEP.AllowSprintAttack = false

SWEP.Sprint_Mode = TFA.Enum.LOCOMOTION_HYBRID-- ANI = mdl, Hybrid = ani + lua, Lua = lua only
SWEP.SprintAnimation = {
	["loop"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "sprint_loop", --Number for act, String/Number for sequence
		["is_idle"] = true
	},--looping animation
	["out"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "sprint_out", --Number for act, String/Number for sequence
		["transition"] = true
	} --Outward transition
}

SWEP.RunSightsPos = Vector(6, -12, -12.785) - SWEP.VMPos
SWEP.RunSightsAng = Vector(36.04, -15, 12.243) - SWEP.VMAng

SWEP.CanBlock = true
SWEP.BlockAnimation = {
	["in"] = {
		["type"] = TFA.Enum.ANIMATION_ACT, --Sequence or act
		["value"] = ACT_VM_DEPLOY, --Number for act, String/Number for sequence
		["transition"] = true
	}, --Inward transition
	["loop"] = {
		["type"] = TFA.Enum.ANIMATION_ACT, --Sequence or act
		["value"] = ACT_VM_IDLE_DEPLOYED, --Number for act, String/Number for sequence
		["is_idle"] = true
	},--looping animation
	["hit"] = {
		["type"] = TFA.Enum.ANIMATION_ACT, --Sequence or act
		["value"] = ACT_VM_RELOAD_DEPLOYED, --Number for act, String/Number for sequence
		["is_idle"] = true
	},--when you get hit and block it
	["out"] = {
		["type"] = TFA.Enum.ANIMATION_ACT, --Sequence or act
		["value"] = ACT_VM_UNDEPLOY, --Number for act, String/Number for sequence
		["transition"] = true
	} --Outward transition
}
SWEP.BlockCone = 135 --Think of the player's view direction as being the middle of a sector, with the sector's angle being this
SWEP.BlockDamageMaximum = 0.0 --Multiply damage by this for a maximumly effective block
SWEP.BlockDamageMinimum = 0.4 --Multiply damage by this for a minimumly effective block
SWEP.BlockTimeWindow = 0.3 --Time to absorb maximum damage
SWEP.BlockTimeFade = 0.5 --Time for blocking to do minimum damage.  Does not include block window
SWEP.BlockSound = "TFA_KF2_PULVERIZER.Block"
SWEP.BlockDamageCap = 100
SWEP.BlockDamageTypes = {
	DMG_SLASH,DMG_CLUB
}

SWEP.Secondary.CanBash = true
SWEP.Secondary.BashDamage = 80
SWEP.Secondary.BashDelay = 0.1
SWEP.Secondary.BashLength = 16 * 3.5

SWEP.SequenceLengthOverride = {
	[ACT_VM_HITCENTER] = 0.8,
	[ACT_VM_DRAW] = 0.75,
	[ACT_VM_UNDEPLOY] = 0.5,
	[ACT_VM_RELOAD] = 236 / 60 - 0.1,
	[ACT_VM_RELOAD_EMPTY] = 236 / 60 - 0.1
}

SWEP.ViewModelBoneMods = {
}

SWEP.InspectionActions = {ACT_VM_RECOIL1, ACT_VM_RECOIL2, ACT_VM_RECOIL3}

SWEP.Offset = {
	Pos = {
		Up = -3,
		Right = 2,
		Forward = 4
	},
	Ang = {
		Up = 0,
		Right = 5,
		Forward = 165
	},
	Scale = 1
}

SWEP.EventTable = {
	[ACT_VM_RELOAD] = {
		{ ["time"] = 6 / 60, ["type"] = "sound", ["value"] = "TFA_KF2_PULVERIZER.Open" },
		{ ["time"] = 70 / 60, ["type"] = "sound", ["value"] = "TFA_KF2_PULVERIZER.MagOut" },
		{ ["time"] = 132 / 60 - 0.1, ["type"] = "sound", ["value"] = "TFA_KF2_PULVERIZER.MagIn" },
		{ ["time"] = 166 / 60, ["type"] = "sound", ["value"] = "TFA_KF2_PULVERIZER.Close" }
	},
	[ACT_VM_RELOAD_EMPTY] = {
		{ ["time"] = 6 / 60, ["type"] = "sound", ["value"] = "TFA_KF2_PULVERIZER.Open" },
		{ ["time"] = 70 / 60, ["type"] = "sound", ["value"] = "TFA_KF2_PULVERIZER.MagOut" },
		{ ["time"] = 132 / 60 - 0.1, ["type"] = "sound", ["value"] = "TFA_KF2_PULVERIZER.MagIn" },
		{ ["time"] = 166 / 60, ["type"] = "sound", ["value"] = "TFA_KF2_PULVERIZER.Close" }
	},
	[ACT_VM_MISSCENTER2] = {
		{ ["time"] = 24 / 60, ["type"] = "sound", ["value"] = "TFA_KF2_PULVERIZER.Open" },
		{ ["time"] = 60 / 60 - 0.04, ["type"] = "sound", ["value"] = "TFA_KF2_PULVERIZER.Close" }
	},
	[ACT_VM_MISSCENTER] = {
		{ ["time"] = 26 / 60, ["type"] = "sound", ["value"] = "TFA_KF2_PULVERIZER.Open" },
		{ ["time"] = 60 / 60 - 0.04, ["type"] = "sound", ["value"] = "TFA_KF2_PULVERIZER.Close" }
	},
	[ACT_VM_MISSRIGHT2] = {
		{ ["time"] = 24 / 60, ["type"] = "sound", ["value"] = "TFA_KF2_PULVERIZER.Open" },
		{ ["time"] = 53 / 60 - 0.04, ["type"] = "sound", ["value"] = "TFA_KF2_PULVERIZER.Close" }
	},
	[ACT_VM_MISSLEFT2] = {
		{ ["time"] = 24 / 60, ["type"] = "sound", ["value"] = "TFA_KF2_PULVERIZER.Open" },
		{ ["time"] = 61 / 60 - 0.04, ["type"] = "sound", ["value"] = "TFA_KF2_PULVERIZER.Close" }
	},
	[ACT_VM_RECOIL1] = {
		{ ["time"] = 0.01, ["type"] = "sound", ["value"] = "TFA_KF2_PULVERIZER.Open" },
		{ ["time"] = 15 / 24, ["type"] = "sound", ["value"] = "TFA_KF2_PULVERIZER.MagOut" },
		{ ["time"] = 40 / 24 - 0.1, ["type"] = "sound", ["value"] = "TFA_KF2_PULVERIZER.MagIn" },
		{ ["time"] = 57 / 24 - 0.04, ["type"] = "sound", ["value"] = "TFA_KF2_PULVERIZER.Close" }
	},
	[ACT_VM_RECOIL2] = {
		{ ["time"] = 0.01, ["type"] = "sound", ["value"] = "TFA_KF2_PULVERIZER.Open" },
		{ ["time"] = 25 / 24 - 0.04, ["type"] = "sound", ["value"] = "TFA_KF2_PULVERIZER.Close" }
	},
	[ACT_VM_RECOIL3] = {
		{ ["time"] = 0.01, ["type"] = "sound", ["value"] = "TFA_KF2_PULVERIZER.Twirl" }
	},
	[ACT_VM_HOLSTER] = {
		{ ["time"] = 25 / 60, ["type"] = "sound", ["value"] = "TFA_KF2_PULVERIZER.Holster" }
	}
}

DEFINE_BASECLASS( SWEP.Base )

function SWEP:Reload(released,...)
	BaseClass.Reload( self, released, true, ... )
end