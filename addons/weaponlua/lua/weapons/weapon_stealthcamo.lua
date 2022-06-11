AddCSLuaFile()

SWEP.PrintName = "Stealth Boy"
SWEP.Instructions = "Primary attack: toggle camo"

SWEP.WorldModel = ""
SWEP.ViewModel = "models/weapons/c_slam.mdl"
SWEP.UseHands = true

SWEP.Category = "Other"
SWEP.Spawnable = true
SWEP.AdminOnly = true

SWEP.Primary.Ammo = "none"
SWEP.Primary.ClipSize = 30
SWEP.Primary.DefaultClip = 30
SWEP.Primary.Automatic = false

SWEP.Secondary.Ammo = "none"
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false

SWEP.RenderGroup = RENDERGROUP_BOTH

SWEP.Slot = 0
SWEP.SlotPos = 1

function SWEP:IsCloaked()
	return self.Owner:GetNWBool( "StealthCamo", false )
end

function SWEP:Cloak( pl )
	self:EmitSound( "player/spy_cloak.wav" )
	self.Owner:SetNWBool( "StealthCamo", true )
	self.Owner:DrawShadow( false )
end

function SWEP:Uncloak( pl )
	self:EmitSound( "player/spy_uncloak.wav" )
	self.Owner:SetNWBool( "StealthCamo", false )
	self.Owner:DrawShadow( true )
end

hook.Add( "OnPlayerChangedTeam", "PURGE::UNCLOAK", function( _p )
	if( _p:GetNWBool( "StealthCamo", true ) ) then
		_p:SetNWBool( "StealthCamo", false )
		_p:DrawShadow( false )
	end
end );

hook.Add( "PlayerDeath", "PURGE::UNCLOAK", function( _p )
	if( _p:GetNWBool( "StealthCamo", true ) ) then
		_p:SetNWBool( "StealthCamo", false )
		_p:DrawShadow( false )
	end
end );

function SWEP:Deploy()
	self:SendWeaponAnim( ACT_SLAM_DETONATOR_DRAW )
end

function SWEP:PrimaryAttack()
	self:SendWeaponAnim( ACT_SLAM_DETONATOR_DETONATE )

	if self:IsCloaked() and self:Clip1() > 0 then self:Uncloak() else self:Cloak() end
	self:SetNextPrimaryFire( CurTime() + 1 )
end

function SWEP:SecondaryAttack()
end

function SWEP:Think()
	if self.NextTick and self.NextTick > CurTime() then return end

	if SERVER then
		if self:IsCloaked() then
			self:SetClip1( math.Clamp( self:Clip1() - 1, 0, self:GetMaxClip1() ) )
		else
			self:SetClip1( math.Clamp( self:Clip1() + 1, 0, self:GetMaxClip1() ) )
		end
	end
	
	if self:IsCloaked() and self:Clip1() <= 0 then
		self:Uncloak()
	end

	self.NextTick = CurTime() + 1
end

if SERVER then
	function SWEP:Initialize()
		self:SetWeaponHoldType( "normal" )
		self:SetClip1( 30 )
	end

	function SWEP:Holster()
		return not self:IsCloaked()
	end
else
	function SWEP:Initialize()
		self:SetWeaponHoldType( "normal" )

		hook.Add( "PrePlayerDraw", self, self.PrePlayerDraw )
		hook.Add( "PostPlayerDraw", self, self.PostPlayerDraw )
		hook.Add( "PreDrawPlayerHands", self, self.PreDrawPlayerHands )
		hook.Add( "PostDrawPlayerHands", self, self.PostDrawPlayerHands )
	end

	local Materials = {}

	function SWEP:PrepareMaterial( mat )
		--~local shader = Material( mat ):GetShader()
		local shader = "VertexLitGeneric"
		local params = util.KeyValuesToTable( file.Read( "materials/" .. mat .. ".vmt", "GAME" ) ) or {}
		params.Proxies = params.proxies or {}

		params[ "$cloakpassenabled" ] = 1
		params[ "$cloakfactor" ] = 0

		params.Proxies[ "PlayerCloak" ] = {}

		Materials[ mat ] = CreateMaterial( mat .. "_c", shader, params )
	end

	function SWEP:CloakThink()
		if not self.Owner.CloakFactor then self.Owner.CloakFactor = 0 end

		self.Owner.CloakFactor = math.Approach(
			self.Owner.CloakFactor, self:IsCloaked( self.Owner ) and 1 or 0, FrameTime() )
	end

	function SWEP:PrePlayerDraw( pl )
		if pl ~= self.Owner then return end

		self:CloakThink()

		if self.Owner.CloakFactor <= 0 then return end

		render.UpdateRefractTexture() 

		for k, v in ipairs( self.Owner:GetMaterials() ) do
			if not Materials[ v ] then self:PrepareMaterial( v ) end
			render.MaterialOverrideByIndex( k - 1, Materials[ v ] )
		end
	end

	function SWEP:PostPlayerDraw( pl )
		if pl ~= self.Owner or self.Owner.CloakFactor <= 0 then return end

		render.MaterialOverrideByIndex()
	end

	function SWEP:PreDrawPlayerHands( hands, vm, pl )
		if pl ~= self.Owner then return end

		self:CloakThink()

		if self.Owner.CloakFactor <= 0 then return end

		render.SetBlend( 1 - self.Owner.CloakFactor )
	end

	function SWEP:PostDrawPlayerHands( hands, vm, pl )
		if pl ~= self.Owner or self.Owner.CloakFactor <= 0 then return end

		render.SetBlend( 1 )
	end

	function SWEP:CustomAmmoDisplay()
		self.AmmoDisplay = self.AmmoDisplay or {} 
		self.AmmoDisplay.Draw = true
		self.AmmoDisplay.PrimaryClip = self:Clip1()

		return self.AmmoDisplay
	end

	matproxy.Add{
		name = "PlayerCloak",
		init = function() end,
		bind = function( self, mat, ent )
			if not IsValid( ent ) or not ent.CloakFactor then return end
			mat:SetFloat( "$cloakfactor", ent.CloakFactor )
		end
	}
end
