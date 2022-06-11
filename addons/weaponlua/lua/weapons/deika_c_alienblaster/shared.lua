SWEP.Spawnable            = true
SWEP.AdminSpawnable        = true
SWEP.UseHands			   = true

SWEP.BounceWeaponIcon  = false

SWEP.Author            = "Deika"
SWEP.Contact        = ""
SWEP.Purpose        = ""
SWEP.Instructions    = "Fuck her right in the pussy"

if CLIENT then

    SWEP.PrintName = "Alien Blaster"            
	
	SWEP.Category  = "Fallout 3"
	

	SWEP.HoldType = "ar2"
	SWEP.ViewModelFOV = 70
	SWEP.ViewModelFlip = false
	SWEP.ViewModel = "models/weapons/c_alienblaster.mdl"
	SWEP.WorldModel = "models/weapons/w_aliendisintegrator.mdl"
	SWEP.Slot = 2
    SWEP.SlotPos = 5
	SWEP.ShowViewModel = true
	SWEP.ShowWorldModel = true
	SWEP.ViewModelBoneMods = {}
	
    SWEP.DrawAmmo            = true
    SWEP.DrawCrosshair        = true
    SWEP.CSMuzzleFlashes    = true
	
	SWEP.IconLetter = "."
	
end
game.AddAmmoType( {
 name = "Alien Power Cell",
 dmgtype = DMG_DISSOLVE,
 tracer = TRACER_LINE,
 plydmg = 0,
 npcdmg = 0,
 force = 2000,
 minsplash = 10,
 maxsplash = 5
} )

function SWEP:Initialize()
	self:SetWeaponHoldType("pistol")
end
	SWEP.ViewModel = "models/weapons/c_alienblaster.mdl"
	SWEP.WorldModel = "models/weapons/w_alienblaster.mdl"

SWEP.Primary.Sound             = Sound("weapons/alienblaster/alienblaster_fire01.wav")
SWEP.Primary.Damage            = 1
SWEP.Primary.Force             = 1
SWEP.Primary.NumShots          = 1
SWEP.Primary.Delay             = .03
SWEP.Primary.Ammo              = "Alien Power Cell"
SWEP.Primary.Spread 		   = 0

SWEP.Primary.ClipSize        = 10
SWEP.Primary.DefaultClip    = 80
SWEP.Primary.Automatic        = false



SWEP.Secondary.Sound        = Sound("")
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.IronSightsPos = Vector(0, 0, 0)
SWEP.IronSightsAng = Vector(0, 0, 0)

SWEP.LastPrimaryAttack = 0


function SWEP:PrimaryAttack()
	if !self:CanPrimaryAttack() then return end	
    self.Weapon:SetNextPrimaryFire(CurTime() + .5)
	self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
    self.Weapon:EmitSound("weapons/alienblaster/alienblaster_fire01.wav")
	if SERVER then
		local pos = (self.Owner:GetShootPos() + self.Owner:EyeAngles():Right() * 10 + self.Owner:GetAimVector() * 20 - self.Owner:EyeAngles():Up() * 4)
		local ang = ( self.Owner:EyeAngles() )
		pos = pos +ang:Right() *5 +ang:Up() *-8
		local entLaser = ents.Create("alien_blaster_bolt")
		entLaser:SetAngles(ang)
		entLaser:SetPos(pos)
		entLaser:SetOwner(self.Owner)
		entLaser:Spawn()
		entLaser:Activate()
		local phys = entLaser:GetPhysicsObject()
		if IsValid(phys) then
			phys:SetVelocity(ang:Forward() *900000)
		end
	end	
	self:TakePrimaryAmmo(1)
end


function SWEP:SecondaryAttack()
end
function SWEP:Reload()
if ( self:Clip1() < self.Primary.ClipSize && self:Ammo1() > 0 ) then
self:EmitSound("weapons/alienblaster/alienblaster_reload.wav")
 self.Weapon:DefaultReload( ACT_VM_RELOAD )
end
end
function SWEP:Deploy()
	self:SendWeaponAnim(ACT_VM_DRAW)
      return true
end


