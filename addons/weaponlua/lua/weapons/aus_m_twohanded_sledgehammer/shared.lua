SWEP.Base = "sword_swepbase"

SWEP.PrintName = "Sledge Hammer"
SWEP.Category = "Fallout | Melee Weapons"
SWEP.Author = ""
SWEP.Instructions = "LMB - Swing | RMB - Guard | R - Parry"
SWEP.Purpose = ""

SWEP.AdminSpawnable = true
SWEP.Spawnable = true
SWEP.AutoSwitchTo = false
SWEP.Slot = 0
SWEP.Weight = 2
SWEP.UseHands = true

-- For parrying
SWEP.StrikeAnimRate = 1
SWEP.StrikeTime = 0
SWEP.DmgType = 4
SWEP.MeleeRange = 0.1
SWEP.MeleeRange2 = 550
SWEP.CanParry = true

-- Blocking anim
SWEP.IronSights = true
SWEP.IronSightsPos = Vector(-15, 3, -8)
SWEP.IronSightsAng = Vector(0, 0, -60)

SWEP.GuardBlockAmount = 15

SWEP.HoldType = "melee2"
SWEP.GuardHoldType = "slam"

SWEP.ViewModel = "models/weapons/c_kaine_sword.mdl"
SWEP.WorldModel = "models/weapons/w_crowbar.mdl"
SWEP.ViewModelFOV = 80
SWEP.ViewModelFlip = false
SWEP.ShowWorldModel = false

-- Stamina counter
SWEP.SlotPos = 1
SWEP.DrawAmmo = true
SWEP.QuadAmmoCounter = false
SWEP.AmmoQuadColor = Color(255,0,0,255)

SWEP.BlockSound1 = Sound( "physics/metal/metal_canister_impact_hard1.wav" ) 
SWEP.BlockSound2 = Sound( "physics/metal/metal_canister_impact_hard3.wav" ) 
SWEP.ParrySound = Sound("weapons/warhammer/skyrim_warhammer_swing1.mp3")

SWEP.ReloadSound = Sound("common/null.wav")

SWEP.Primary.Automatic = true

SWEP.HitDistance		= 75
SWEP.HitRate			= 1.5

-- Primary attack sounds
local SwingSound = Sound( "weapons/warhammer/skyrim_warhammer_swing1.mp3" )
local HitSoundWorld = Sound( "weapons/warhammer/skyrim_warhammer_hitwall2.mp3" )
local HitSoundBody = Sound( "weapons/mace/skyrim_mace_flesh1.mp3" )


function SWEP:OnDeploy()

	self.Owner:ViewPunch(Angle(5,25,5))
		self:IdleAnimationDelay( 3, 3 )
		
            self.Weapon:EmitSound("weapons/greatsword/skyrim_greatsword_draw1.mp3")     
			
	local vm = self.Owner:GetViewModel()
	vm:SendViewModelMatchingSequence( vm:LookupSequence( "draw" ) )
			
end

function SWEP:IdleAnimationDelay( seconds, index )
	timer.Remove( "IdleAnimation" )
	self.Idling = index
	timer.Create( "IdleAnimation", seconds, 1, function()
		if not self:IsValid() or self.Idling == 0 then return end
		if self.Idling == index then
			self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
		end
	end )
end

function SWEP:Hitscan()

//This function calculate the trajectory

	local tr = util.TraceLine( {
		start = self.Owner:GetShootPos(),
		endpos = self.Owner:GetShootPos() + ( self.Owner:GetAimVector() * self.HitDistance * 1.5 ),
		filter = self.Owner,
		mask = MASK_SHOT_HULL
	} )

//This if shot the bullets

	if ( tr.Hit ) then
	

		bullet = {}
		bullet.Num    = 1
		bullet.Src    = self.Owner:GetShootPos()
		bullet.Dir    = self.Owner:GetAimVector()
		bullet.Spread = Vector(0, 0, 0)
		bullet.Tracer = 0
		bullet.Force  = 25
		bullet.Hullsize = 0
		bullet.Distance = self.HitDistance * 1.5
		bullet.Damage = math.random( 50, 85 )
		
		bullet.Callback = function(attacker, tr, dmginfo)
	dmginfo:SetDamageType(DMG_CLUB)
end
		
		self.Owner:FireBullets(bullet)

		self:EmitSound( SwingSound )

		//vm:SendViewModelMatchingSequence( vm:LookupSequence( "hitcenter1" ) )

		if tr.Entity:IsPlayer() or string.find(tr.Entity:GetClass(),"npc") or string.find(tr.Entity:GetClass(),"prop_ragdoll") then
			self:EmitSound( HitSoundBody )
				self.Owner:ViewPunch(Angle(-5,2,1))
		else
			self:EmitSound( HitSoundWorld )
				self.Owner:ViewPunch(Angle(-5,2,1))
		end

	
//if end
		//else vm:SendViewModelMatchingSequence( vm:LookupSequence( "misscenter1" ) )
		end

end
         
function SWEP:PrimaryAttack()

	-- Cannot swing if stamina is less than 5
	if self:Ammo1() < 5 then return end
	
						self.Weapon:EmitSound("weapons/axe/skyrim_axe_draw1.mp3")
						timer.Simple( 0.5, function() if self:IsValid() then
						self.Weapon:EmitSound("weapons/waraxe/skyrim_waraxe_swing1.mp3") end end)

	
			timer.Simple( 0.4, function() if self:IsValid() then
            self.Owner:SetAnimation( PLAYER_ATTACK1 ) end end);
    
    self.Weapon:SetNextPrimaryFire( CurTime() + 0.8 )
    			
				local ani = math.random( 1, 3 )
	if ani == 1 and self:IsValid() then
	self.Owner:ViewPunch(Angle(0,4,0))

		self.Weapon:SendWeaponAnim(ACT_VM_MISSLEFT)
		self.Owner:GetViewModel():SetPlaybackRate(0.7)
				self:IdleAnimationDelay( 1.3, 1.3 )

	elseif ani == 2 and self:IsValid() then
	self.Owner:ViewPunch(Angle(0,-4,0))

		self.Weapon:SendWeaponAnim(ACT_VM_MISSRIGHT)
		self.Owner:GetViewModel():SetPlaybackRate(0.7)
				self:IdleAnimationDelay( 1.3, 1.3 )

	else 
	self.Owner:ViewPunch(Angle(4,0,0))

		self.Weapon:SendWeaponAnim(ACT_VM_PULLBACK_HIGH)
		self.Owner:GetViewModel():SetPlaybackRate(0.7)
				self:IdleAnimationDelay( 1.3, 1.3 )

	end

	
	-- Stamina taken for each swing
			self:TakePrimaryAmmo(15)

	local vm = self.Owner:GetViewModel()
	
						self.Weapon:SetNextPrimaryFire( CurTime() + self.HitRate )

	timer.Create("hitdelay", 0.85, 1, function() self:Hitscan() end)

	timer.Start( "hitdelay" )

end

function SWEP:OnRemove()

	timer.Remove("hitdelay")
	return true
end


/*---------------------------------------------------------
	SecondaryAttack
---------------------------------------------------------*/
function SWEP:SecondaryAttack()


	if self.Owner:KeyDown(IN_ATTACK2) and self.Owner:GetNWBool( "Guardening") == true then

            self.Weapon:EmitSound("physics/metal/weapon_impact_soft2.wav")      
	self.Owner:ViewPunch(Angle(3,0,3))
			
end			

	if ( !self.IronSightsPos ) then return end
	if self.Owner:KeyDown(IN_ATTACK2) then return end
	if ( self.NextSecondaryAttack > CurTime() ) then return end
	if self.Owner:GetNWBool( "Guardening") == true then return end
	if self.Weapon:GetNWInt("Reloading") > CurTime() then return end
	if !self:CanSecondaryAttack() then return end

	
	--PARRY FUNCTION, PRETTY BUGGY
	if self:Ammo1() < 50 then return end
local wep = self.Weapon
local ply = self.Owner


self.NextSecondaryAttack = CurTime() + 2


			self:SendWeaponAnim(ACT_VM_DRAW); self.Owner:GetViewModel():SetPlaybackRate(0.7)
			
			self.Owner:ViewPunch(Angle(-30,0,0))

			self:IdleAnimationDelay( 1.5, 1.5 )

			
self:EmitSound( self.ParrySound )

	local rnda = self.Primary.Recoil * 1
	local rndb = self.Primary.Recoil * math.random(-1, 1)
		self.Owner:SetAnimation( PLAYER_ATTACK1 )	
		local fx 		= EffectData()
		
		fx:SetEntity(wep)
		fx:SetOrigin(ply:GetShootPos())
		fx:SetNormal(ply:GetAimVector())
		fx:SetAttachment("1")
		
		-- Stamina taken for each parry swing
		self:TakePrimaryAmmo(25)
		
		wep:SetNextPrimaryFire( CurTime() + 2 )
		self.Owner:SetNWBool( "Parry", true )
		
		-- Difficulty of parry success
timer.Simple( 0.1,function() if self:IsValid() and self.Owner:Alive() then

 self.Owner:SetNWBool( "Parry", false )
end end )
end

SWEP.ViewModelBoneMods = {
	["RW_Weapon"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["Root"] = { scale = Vector(1, 1, 1), pos = Vector(-5, 0.185, 1.296), angle = Angle(-5.557, -76.667, 0) }
}

SWEP.VElements = {
	["v_sledgehammer"] = { type = "Model", model = "models/mosi/fallout4/props/weapons/melee/sledgehammer.mdl", bone = "RightHand_1stP", rel = "", pos = Vector(-3.3, 8.831, -0.519), angle = Angle(-73.637, 38.57, -50.26), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["quad"] = { type = "Quad", bone = "ValveBiped.Bip01_Spine4", rel = "", pos = Vector(-24.198, -80, -27.16), angle = Angle(-85.556, -76.667, 1.11), size = 0.2, draw_func = nil}
}

SWEP.WElements = {
	["w_sledgehammer"] = { type = "Model", model = "models/mosi/fallout4/props/weapons/melee/sledgehammer.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3, 1.557, 2.596), angle = Angle(180, 64.286, 1.169), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
