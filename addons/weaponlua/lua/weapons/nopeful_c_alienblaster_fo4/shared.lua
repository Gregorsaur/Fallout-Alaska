SWEP.Spawnable            = true
SWEP.AdminSpawnable        = true
SWEP.UseHands			   = true

SWEP.BounceWeaponIcon  = false

SWEP.Author            = "Deika"
SWEP.Contact        = ""
SWEP.Purpose        = ""
SWEP.Instructions    = "Fuck her right in the pussy"

if CLIENT then

    SWEP.PrintName = "Alien Blaster Pistol"            
	
	SWEP.Category  = "Fallout 4"
	

	SWEP.HoldType = "ar2"
	SWEP.ViewModelFOV = 70
	SWEP.ViewModelFlip = false
	SWEP.ViewModel = "models/weapons/c_alienblasterd_fo4.mdl"
	SWEP.WorldModel = "models/weapons/w_alienblaster_fo4.mdl"
	SWEP.Slot = 1
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
	SWEP.ViewModel = "models/weapons/c_alienblasterd_fo4.mdl"
	SWEP.WorldModel = "models/weapons/w_alienblaster_fo4.mdl"

SWEP.Primary.Sound             = Sound("weapons/alienblaster/alienblaster_fire01.wav")
SWEP.Primary.Damage            = 1
SWEP.Primary.Force             = 1
SWEP.Primary.NumShots          = 1
SWEP.Primary.Delay             = .02
SWEP.Primary.Ammo              = "Alien Power Cell"
SWEP.Primary.Spread 		   = 0

SWEP.Primary.ClipSize        = 42
SWEP.Primary.DefaultClip    = 252
SWEP.Primary.Automatic        = false
SWEP.Base 				= "deika_base"


SWEP.Secondary.Sound        = Sound("")
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.IronSightsPos = Vector(-6.301, -3.372, 1.529)
SWEP.IronSightsAng = Vector(-0.245, -0.436, 0)

SWEP.LastPrimaryAttack = 0
SWEP.FirstDraw = true


function SWEP:Initialize()
	self:SetWeaponHoldType("revolver")
end


function SWEP:PrimaryAttack()
	if !self:CanPrimaryAttack() then return end	
    self.Weapon:SetNextPrimaryFire(CurTime() + .5)
	self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
    self.Weapon:EmitSound("weapons/alienblaster/alienblasterfo4_fire.wav")
	if SERVER then
		local pos = (self.Owner:GetShootPos() + self.Owner:EyeAngles():Right() * 10 + self.Owner:GetAimVector() * 20 - self.Owner:EyeAngles():Up() * 4)
		local ang = ( self.Owner:EyeAngles() )
		pos = pos +ang:Right() *5 +ang:Up() *-8
		local entLaser = ents.Create("alienblaster_fo4_bolt")
		entLaser:SetAngles(ang)
		entLaser:SetPos(pos)
		entLaser:SetOwner(self.Owner)
		entLaser:Spawn()
		entLaser:Activate()
		local phys = entLaser:GetPhysicsObject()
		if IsValid(phys) then
			phys:SetVelocity(ang:Forward() *1500)
		end
	end	
	self:TakePrimaryAmmo(1)
end


function SWEP:Reload()
if ( self:Clip1() < self.Primary.ClipSize && self:Ammo1() > 0 ) then
 self.Weapon:DefaultReload( ACT_VM_RELOAD )
 self:SetIronsights(false, self.Owner)
end
end
function SWEP:Deploy()
	if self.FirstDraw == true then
		self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
		self.FirstDraw = false
	else
		self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK_DEPLOYED)
	end
return true
end

local soundData = {
    name                = "alienfo4.magout" ,
    channel     = CHAN_WEAPON,
    volume              = 0.5,
    soundlevel  = 80,
    pitchstart  = 100,
    pitchend    = 100,
    sound               = "weapons/alienblaster/boltopen.wav"
}
sound.Add(soundData)
local soundData = {
    name                = "alienfo4.magin" ,
    channel     = CHAN_WEAPON,
    volume              = 0.5,
    soundlevel  = 80,
    pitchstart  = 100,
    pitchend    = 100,
    sound               = "weapons/alienblaster/clipinsert.wav"
}
sound.Add(soundData)
local soundData = {
    name                = "alienfo4.ready" ,
    channel     = CHAN_WEAPON,
    volume              = 0.5,
    soundlevel  = 80,
    pitchstart  = 100,
    pitchend    = 100,
    sound               = "weapons/alienblaster/boltclose.wav"
}
sound.Add(soundData)