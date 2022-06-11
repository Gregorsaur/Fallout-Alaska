SWEP.Gun = ("tfa_fallout_plasma_mine") -- must be the name of your swep but NO CAPITALS!

if (GetConVar(SWEP.Gun.."_allowed")) != nil then
	if not (GetConVar(SWEP.Gun.."_allowed"):GetBool()) then SWEP.Base = "bobs_blacklisted" SWEP.PrintName = SWEP.Gun return end
end

SWEP.Base				 = "tfa_ins2_nade_base"
SWEP.Category			 = "TFA Fallout"             -- The category.  Please, just choose something generic or something I've already done if you plan on only doing like one swep..
SWEP.Author				 = "XxYanKy700xX"
SWEP.Contact			 = ""
SWEP.PrintName			 = "Plasma Mine"
SWEP.Purpose			 = ""
SWEP.Type				 = "Mine"
SWEP.Slot				 = 4
SWEP.SlotPos			 = 99
SWEP.Weight				 = 2

SWEP.Spawnable			 = true
SWEP.AdminSpawnable		 = true
SWEP.DrawCrosshair		 = false
SWEP.DrawAmmo			 = true
SWEP.AutoSwitchTo		 = true
SWEP.AutoSwitchFrom		 = true

SWEP.MuzzleAttachment     = "1" 	-- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment = "2" 	-- Should be "2" for CSS models or "1" for hl2 models

SWEP.Primary.RPM		 = 60
SWEP.Primary.ClipSize	 = 1
SWEP.Primary.DefaultClip = 1
SWEP.Primary.Automatic	 = false
SWEP.DisableChambering   = true
SWEP.FiresUnderwater     = true

SWEP.SelectiveFire       = false                        -- Allow selecting your firemode?
SWEP.DisableBurstFire    = false                        -- Only auto/single?
SWEP.OnlyBurstFire       = false                        -- No auto, only burst/single?
SWEP.DefaultFireMode     = "Thrown"                     -- Default to auto or whatev
SWEP.FireModeName        = "Thrown"                     -- Change to a text value to override it
 
SWEP.Primary.Ammo		 = "PlasmaMine"
SWEP.Primary.Round 	     = ("tfa_fallout_plasma_mine")  
SWEP.Velocity            = 50
SWEP.Velocity_Underhand  = 50

SWEP.Primary.Damage             = 0                    -- Damage, in standard damage points.
SWEP.Primary.DamageType         = nil                  -- See DMG enum.  This might be DMG_SHOCK, DMG_BURN, DMG_BULLET, etc.  Leave nil to autodetect.  DMG_AIRBOAT opens doors.
SWEP.Primary.NumShots           = 0                    -- The number of shots the weapon fires.  SWEP.Shotgun is NOT required for this to be >1.

SWEP.Primary.KickUp             = 0                    -- This is the maximum upwards recoil (rise)
SWEP.Primary.KickDown           = 0                    -- This is the maximum downwards recoil (skeet)
SWEP.Primary.KickHorizontal     = 0                    -- This is the maximum sideways recoil (no real term)
SWEP.Primary.StaticRecoilFactor = 0                    -- Amount of recoil to directly apply to EyeAngles.  Enter what fraction or percentage (in decimal form) you want.  This is also affected by a convar that defaults to 0.5.

SWEP.ViewModel		     = "models/weapons/v_nothing.mdl"
SWEP.ViewModelFOV		 = 70
SWEP.ViewModelFlip		 = false
SWEP.UseHands            = true

SWEP.IronSightsPos       = Vector(0, 0, 0)
SWEP.IronSightsAng       = Vector(0, 0, 0)

SWEP.InspectPos 		 = Vector(4, -4 -0.75)
SWEP.InspectAng 		 = Vector(22, 35, 4.8)

SWEP.RunSightsPos        = Vector(0, 0, -3)
SWEP.RunSightsAng        = Vector(-50, 0, 0)

SWEP.Idle_Mode           = TFA.Enum.IDLE_BOTH         -- TFA.Enum.IDLE_DISABLED = no idle, TFA.Enum.IDLE_LUA = lua idle, TFA.Enum.IDLE_ANI = mdl idle, TFA.Enum.IDLE_BOTH = TFA.Enum.IDLE_ANI + TFA.Enum.IDLE_LUA
SWEP.Idle_Blend          = 0.25                       -- Start an idle this far early into the end of a transition
SWEP.Idle_Smooth         = 0.05                       -- Start an idle this far early into the end of another animation

SWEP.Sprint_Mode 		 = TFA.Enum.LOCOMOTION_LUA
SWEP.SprintBobMult       = 2.5

SWEP.ViewModelBoneMods   = {}
SWEP.VElements           = {}
SWEP.WElements           = {}

SWEP.WorldModel			 = "models/weapons/tfa_fallout/w_fallout_plasma_mine.mdl"

SWEP.Offset = {
	Pos = {
		Up = 2,
		Right = 5,
		Forward = 4.5
	},
	Ang = {
		Up = 0,
		Right = -90,
		Forward = 0
	},
	Scale = 1
} -- Procedural world model animation, defaulted for CS:S purposes.

SWEP.HoldType 			 = "slam"

function SWEP:PrimaryAttack()

	if self:CanPrimaryAttack() then	
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self.Weapon:SetNextPrimaryFire( CurTime() + 1 / ( self.Primary.RPM / 60 ) )
	plant = self.Owner:GetViewModel():SequenceDuration()
	
	timer.Simple( plant, function() if not IsValid( self ) then return end if IsValid( self.Owner ) and IsValid( self.Weapon ) then
		
		if self.Owner:Alive() and self.Owner:GetActiveWeapon():GetClass() == self.Gun then
			self.Weapon:SendWeaponAnim( ACT_VM_SECONDARYATTACK )
				
				local tr = {}
				
				tr.start = self.Owner:GetShootPos()
				tr.endpos = self.Owner:GetShootPos() + 100 * self.Owner:GetAimVector()
				tr.filter = { self.Owner }
				
				local trace = util.TraceLine( tr )
				
				self:TakePrimaryAmmo( 1 )
				
				if ( CLIENT ) then return end
				
				proxy = ents.Create("fallout_plasma_mine_explosive_ent")
				proxy:SetPos( trace.HitPos + trace.HitNormal )
				trace.HitNormal.z = -trace.HitNormal.z
				proxy:SetAngles( trace.HitNormal:Angle() - Angle(90, 180, 0) )
				proxy.Owner = self.Owner
				proxy:Spawn()
			
			local boxes
			
			parentme = {}
			parentme[1] = "m9k_ammo_40mm"
			parentme[2] = "m9k_ammo_c4"
			parentme[3] = "m9k_ammo_frags"
			parentme[4] = "m9k_ammo_ieds"
			parentme[5] = "m9k_ammo_nervegas"
			parentme[6] = "m9k_ammo_nuke"
			parentme[7] = "m9k_ammo_proxmines"
			parentme[8] = "m9k_ammo_rockets"
			parentme[9] = "m9k_ammo_stickynades"
			parentme[10] = "m9k_ammo_357"
			parentme[11] = "m9k_ammo_ar2"
			parentme[12] = "m9k_ammo_buckshot"
			parentme[13] = "m9k_ammo_pistol"
			parentme[14] = "m9k_ammo_smg"
			parentme[15] = "m9k_ammo_sniper_rounds"
			parentme[16] = "m9k_ammo_winchester"
			parentme[17] = "m9k_ammo_fragmines"
			parentme[18] = "m9k_ammo_pulsemines"
			parentme[19] = "m9k_ammo_plasmamines"
			
				if trace.Entity != nil and trace.Entity:IsValid() then
					for k, v in pairs ( parentme ) do
						if trace.Entity:GetClass() == v then
							boxes = trace.Entity
						end
					end
				end
			
				if trace.Entity and trace.Entity:IsValid() then
					if trace.Entity and trace.Entity:IsValid() then
						if boxes and trace.Entity:GetPhysicsObject():IsValid() then
						
							proxy:SetParent( trace.Entity )
							trace.Entity.Planted = true
							
						elseif not trace.Entity:IsNPC() and not trace.Entity:IsPlayer() and trace.Entity:GetPhysicsObject():IsValid() then
						
							constraint.Weld( proxy, trace.Entity )
							
						end
					end
					
				else
				
					proxy:SetMoveType( MOVETYPE_NONE )
					
				end	
				
				if not trace.Hit then
				
					proxy:SetMoveType( MOVETYPE_VPHYSICS )
					
				end
			end
			
		self:CheckWeaponsAndAmmo()
		
		end end)
	end
end

function SWEP:CheckWeaponsAndAmmo()

	timer.Simple( self.Owner:GetViewModel():SequenceDuration(), function()
	
		if SERVER and IsValid( self.Weapon ) then 
			if IsValid( self.Owner ) and self.Weapon:GetClass() == self.Gun then
				if self.Weapon:Clip1() == 0 && self.Owner:GetAmmoCount( self.Weapon:GetPrimaryAmmoType() ) == 0 then
				
					self.Owner:StripWeapon( self.Gun )
					
				else
				
				    self.Weapon:DefaultReload( ACT_VM_DRAW )
				
				end
			end
		end
	end)
end

function SWEP:SecondaryAttack()
end	

function SWEP:Think()
end