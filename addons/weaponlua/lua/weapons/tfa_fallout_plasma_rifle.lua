SWEP.Category				= "TFA Fallout" --Category where you will find your weapons
SWEP.Author					= "XxYanKy700xX"
SWEP.PrintName				= "Plasma Rifle (MicroFusion Cells)" -- Weapon name (Shown on HUD)	
SWEP.Slot					= 3				-- Slot in the weapon selection menu
SWEP.SlotPos				= 1			-- Position in the slot
SWEP.DrawAmmo				= true		-- Should draw the default HL2 ammo counter
SWEP.DrawWeaponInfoBox		= false		-- Should draw the weapon info box
SWEP.BounceWeaponIcon   	= false		-- Should the weapon icon bounce?
SWEP.DrawCrosshair			= true		-- set false if you want no crosshair
SWEP.Weight					= 300		-- rank relative ot other weapons. bigger is better
SWEP.AutoSwitchTo			= true		-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= false		-- Auto switch from if you pick up a better weapon
SWEP.HoldType 				= "StriderMinigun"		-- how others view you carrying the weapon
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive 
-- you're mostly going to use ar2, smg, shotgun or pistol. rpg makes for good sniper rifles
SWEP.Type = "Energy Weapon"

--[[ Selective Fire Stuff ]]--

SWEP.SelectiveFire    = false     -- Allow selecting your firemode?
SWEP.DisableBurstFire = false     -- Only auto/single?
SWEP.OnlyBurstFire    = false     -- No auto, only burst/single?
SWEP.DefaultFireMode  = ""        -- Default to auto or whatev

SWEP.ViewModelFOV			= 70
SWEP.VMPos          = Vector(-2.25, -1.2, 0.65)
SWEP.VMAng          = Vector(1, 2, 0)
SWEP.UseHands				= true
SWEP.ViewModelFlip			= false
SWEP.ViewModel				= "models/Fallout/fonv/plasmarifle/c_fallout_plasma_rifle.mdl"	-- Weapon view model
SWEP.WorldModel 			= "models/Fallout/fonv/plasmarifle/w_fallout_plasmarifle.mdl"	-- Weapon world model
SWEP.Base					= "tfa_gun_base" --the Base this weapon will work on. PLEASE RENAME THE BASE! 
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true
SWEP.FiresUnderwater 		= false

SWEP.ViewModelBoneMods = {
--	["ValveBiped.Bip01_L_Finger0"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
--	["ValveBiped.Bip01_L_Clavicle"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
}	

SWEP.Primary.Sound		    = Sound("weapons/fallout_new_vegas/plasma_weapons/Wpn_plasmarifle_fire_2d_02.wav")
SWEP.Primary.RPM		    = 250 -- This is in Rounds Per Minute
SWEP.Primary.ClipSize       = 24  -- This is the size of a clip
SWEP.Primary.DefaultClip    = 0   -- This is the number of bullets the gun gives you, counting a clip as defined directly above.
SWEP.Primary.KickUp		    = 0.008		-- Maximum up recoil (rise)
SWEP.Primary.KickDown	    = 0.008		-- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal = 0.008		-- Maximum up recoil (stock)
SWEP.Primary.Automatic	    = false		-- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo			= "MicrofusionCellsss" -- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
SWEP.DisableChambering      = true -- Disable round-in-the-chamber
SWEP.MaxPenetrationCounter  = 1 -- The maximum number of ricochets.  To prevent stack overflows.
SWEP.Primary.Velocity       = 1000 -- Bullet Velocity in m/s

-- Pistol, buckshot, and slam always ricochet. 
-- Use AirboatGun for a light metal peircing shotgun pellets

SWEP.Secondary.IronFOV			= 70		-- How much you 'zoom' in. Less is more! 	

SWEP.data 				= {}				--The starting firemode
SWEP.data.ironsights	= 0

SWEP.Primary.Damage		= 47	-- Base damage per bullet
SWEP.Primary.DamageType = ( bit.bor ( DMG_SHOCK, DMG_PLASMA, DMG_RADIATION ) ) --See DMG enum.  This might be DMG_SHOCK, DMG_BURN, DMG_BULLET, etc.  Leave nil to autodetect.  DMG_AIRBOAT opens doors.
SWEP.Primary.Spread = .02 --This is hip-fire acuracy.  Less is more (1 is horribly awful, .0001 is close to perfect)
SWEP.Primary.IronAccuracy = .0025 -- Ironsight accuracy, should be the same for shotguns
SWEP.Primary.NumShots	= 1  	-- How many bullets to shoot per trigger pull

-- [[ IRONSIGHTS ]] --

SWEP.data = {}
SWEP.data.ironsights   = 1  -- Enable Ironsights

SWEP.Secondary.IronFOV = 70 -- How much you 'zoom' in. Less is more!  Don't have this be <= 0.  A good value for ironsights is like 70.

SWEP.IronSightsPos     = Vector(-4.1, -1, 1.5)
SWEP.IronSightsAng     = Vector(-4, -2.93, 0)

--[[ SPRINTING ]]--

SWEP.RunSightsPos = Vector(1, -3.5, -4)
SWEP.RunSightsAng = Vector(-10, 37, -30)

--[[ INSPECTION ]] --

SWEP.InspectPos     = Vector(6, -8, -1.5) 
SWEP.InspectAng     = Vector(24.622, 42.915, 15.477)

--[ ANIMATION ]--
SWEP.StatusLengthOverride = {        -- Changes the status delay of a given animation; only used on reloads.  Otherwise, use SequenceLengthOverride or one of the others
	[ACT_VM_RELOAD] = 109.8 / 30,
} 

SWEP.Offset = { -- Procedural world model animation, defaulted for CS:S purposes.
	Pos = {
		Up = 0.25,
		Right = 0.3,
		Forward = 8
	},
	Ang = {
		Up = -1,
		Right = -13,
		Forward = 184
	},
	Scale = 1.25
}

SWEP.IronSightsMoveSpeed = 0.9 --Multiply the player's movespeed by this when sighting.

SWEP.MuzzleFlashEffect          = "tfa_fallout_muzzleflash_plasma_green" -- Change to a string of your muzzle flash effect.  Copy/paste one of the existing from the base.
SWEP.MuzzleAttachment			= "1" 		-- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.MuzzleFlashEnabled = true

SWEP.ShootWhileDraw=false --Can you shoot while draw anim plays?
SWEP.AllowReloadWhileDraw=false --Can you reload while draw anim plays?
SWEP.SightWhileDraw=false --Can we sight in while the weapon is drawing / the draw anim plays?
SWEP.AllowReloadWhileHolster=true --Can we interrupt holstering for reloading?
SWEP.ShootWhileHolster=true --Cam we interrupt holstering for shooting?
SWEP.SightWhileHolster=false --Cancel out "iron"sights when we holster?
SWEP.UnSightOnReload=true --Cancel out ironsights for reloading.
SWEP.AllowReloadWhileSprinting=false --Can you reload when close to a wall and facing it?
SWEP.AllowReloadWhileNearWall=false --Can you reload when close to a wall and facing it?
SWEP.SprintBobMult=1.35-- More is more bobbing, proportionally.  This is multiplication, not addition.  You want to make this > 1 probably for sprinting.
SWEP.IronBobMult=1  -- More is more bobbing, proportionally.  This is multiplication, not addition.  You want to make this < 1 for sighting, 0 to outright disable.
SWEP.AllowViewAttachment = true --Allow the view to sway based on weapon attachment while reloading or drawing, only if they have convars enabled

SWEP.LuaShellEject = false
SWEP.LuaShellEjectDelay = 0

SWEP.TracerName 		= "tfa_fallout_tracer_plasma_green" 	--Change to a string of your tracer name.  Can be custom.--There is a nice example at https://github.com/garrynewman/garrysmod/blob/master/garrysmod/gamemodes/base/entities/effects/tooltracer.lua
SWEP.TracerCount 		= 1 	--0 disables, otherwise, 1 in X chance

SWEP.BlowbackEnabled = true --Enable Blowback?
SWEP.BlowbackVector = Vector(0, -2.5, 0.1) --Vector to move bone <or root> relative to bone <or view> orientation.
SWEP.BlowbackCurrentRoot = 0 --Amount of blowback currently, for root
SWEP.BlowbackCurrent = 0 --Amount of blowback currently, for bones
SWEP.BlowbackBoneMods =  nil
SWEP.Blowback_Only_Iron = false --Only do blowback on ironsights
SWEP.Blowback_PistolMode = false --Do we recover from blowback when empty?
SWEP.Blowback_Shell_Enabled = false  

SWEP.Offset = { -- Procedural world model animation, defaulted for CS:S purposes.
	Pos = {
		Up = -0.5,
		Right = 1,
		Forward = 3.5
	},
	Ang = {
		Up = 90,
		Right = 0,
		Forward = 190
	},
	Scale = 1
}

SWEP.Primary.Range               = 1.5 * (3280.84 * 16)     -- The distance the bullet can travel in source units.  Set to -1 to autodetect based on damage/rpm.
SWEP.Primary.RangeFalloff        = 1                        -- The percentage of the range the bullet damage starts to fall off at.  Set to 0.8, for example, to start falling off after 80% of the range.

SWEP.IronRecoilMultiplier     = 0.8              -- Multiply recoil by this factor when we're in ironsights.  This is proportional, not inversely.
SWEP.CrouchAccuracyMultiplier = 0.8              -- Less is more.  Accuracy * 0.5 = Twice as accurate, Accuracy * 0.1 = Ten times as accurate

function SWEP:DoImpactEffect( tr, dmgtype )

	if( tr.HitSky ) then return true; end
	
	util.Decal( "scorch", tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal );

	sound.Play( "Weapon_Theta.Shocking", tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal, 200 );

	if( game.SinglePlayer() or SERVER or not self:IsCarriedByLocalPlayer() or IsFirstTimePredicted() ) then

		local effect = EffectData();
		effect:SetOrigin( tr.HitPos );
		effect:SetNormal( tr.HitNormal );

		util.Effect( "Theta_Impact", effect );
		

		local effect = EffectData();
		effect:SetOrigin( tr.HitPos );
		effect:SetStart( tr.StartPos );
		effect:SetDamageType( dmgtype );

		util.Effect( "tfa_fallout_green_plasma_impact", effect );
	end

    return true;
end