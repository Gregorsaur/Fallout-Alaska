
SWEP.Base = "weapon_base"

SWEP.AdminSpawnable = false

SWEP.AutoSwitchTo = false
SWEP.Slot = 0
SWEP.Category = "Fallout | Melee Weapons"
SWEP.Author = ""
SWEP.Spawnable = false
SWEP.AutoSwitchFrom = false
SWEP.Weight = 5
SWEP.DrawCrosshair = false

SWEP.StrikeAnimRate = 0.8
SWEP.StrikeTime = 0
SWEP.GuardBlockAmount = 30
-- DmgType: 4 == SLASH, 128 == CLUB (like hammer or crowbar)
SWEP.DmgType = 4
--MeleeRange = anything above 0.5 is too high
SWEP.MeleeRange = 0.1
SWEP.MeleeRange2 = 10

SWEP.Secondary.IronFOV = 60

SWEP.IronSights = true
SWEP.CanParry = true
SWEP.ParryAnim = ACT_VM_HITCENTER

function SWEP:AttackAnimination()
self.Weapon:SendWeaponAnim( ACT_VM_MISSCENTER )
end

SWEP.IronSightsPos = Vector(-16.08, -4.624, 5.828)
SWEP.IronSightsAng = Vector(0, 0, -70)

SWEP.DodgingEnabled = true
SWEP.DodgeStaminaTake = 25

SWEP.CustomCrosshair = false

SWEP.Category = "Melee Arts"
SWEP.SlotPos = 1
SWEP.DrawAmmo = false
SWEP.QuadAmmoCounter = false
SWEP.AmmoQuadColor = Color(84,196,247,255)
SWEP.Instructions = "LMB - Swing | RMB - Guard | R - Parry"
SWEP.Purpose = "A slow, powerful melee weapon made from a road sign and a pipe."
SWEP.HoldType = "melee2"
SWEP.GuardHoldType = "slam"
SWEP.ViewModelFOV = 50
SWEP.ViewModelFlip = false
SWEP.ViewModel = "models/weapons/c_crowbar.mdl"
SWEP.WorldModel = "models/weapons/w_crowbar.mdl"
SWEP.EntAccuracy = 0

SWEP.UseHands = true
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = true
SWEP.LaserSight = 0
SWEP.Dissolve = 0
SWEP.Hitmarker = false
SWEP.HitmarkerSound = false
SWEP.IronsightTime = 0.17

SWEP.DisableMuzzle = 1
SWEP.LuaShells = false
SWEP.ShellName = "hg_rifle_shell"

SWEP.HealingBullets = false
SWEP.HealAmount = 5
SWEP.DamageType = nil

SWEP.DefSwayScale 	= 1.3
SWEP.DefBobScale 	= 1.3

SWEP.MaxAnim = 3
SWEP.InspectDuration = 3
SWEP.ViewModelBoneMods = {
}




SWEP.MaxDist = 35

SWEP.Dual = false


SWEP.BlockSound1 = Sound( "physics/metal/metal_solid_impact_bullet4.wav" ) 
SWEP.BlockSound2 = Sound( "physics/metal/metal_solid_impact_bullet3.wav" ) 
SWEP.HitSound1 = Sound( "ambient/machines/slicer4.wav" ) 
SWEP.HitSound2 = Sound( "ambient/machines/slicer3.wav" ) 
SWEP.PrimarySound = Sound("WeaponFrag.Throw")
SWEP.ParrySound = Sound("WeaponFrag.Throw")

SWEP.ReloadSound = Sound("common/null.wav")

SWEP.Primary.Damage = 40
SWEP.Primary.TakeAmmo = 20
SWEP.Primary.ClipSize = -1
SWEP.Primary.Ammo = "Battery"
SWEP.Primary.DefaultClip = 0
SWEP.Primary.Spread = 1
SWEP.Primary.Cone = 1
SWEP.IronCone = 1
SWEP.DefaultCone = 1
SWEP.Primary.NumberofShots = 1
SWEP.Primary.Automatic = true
SWEP.Primary.Recoil = 1
SWEP.Primary.IronRecoil = 1
SWEP.DefaultRecoil = 1
SWEP.Primary.Delay = 0.6
SWEP.Primary.Force = 2

SWEP.Secondary.Ammo = "none"

SWEP.CrossColor = Color( 0, 255, 0, 255 )
SWEP.CSGOstyle = false
SWEP.CSGOMultiplier = 1

//1 - AR2, 2 - Air Boat Gun, 3 - Tool tracer, 4 - Gauss tracer, 5 - Gunship tracer, 6 - Default, 7 - Tool tracer 2.
//След пули. Какой он может быть смотри выше --cyka blyat
SWEP.Tracer = 6
SWEP.CustomTracerName = "Tracer"


SWEP.Sprint = false
SWEP.BlackMesaSprint = false
SWEP.SniperScope = false

SWEP.SprintMul = 3

SWEP.RunPos = Vector(0,0,0)
SWEP.RunAng = Vector(-9.146, 0, 0)


SWEP.SightBreath = false
SWEP.SightBreathMul = 1

SWEP.InfinityBreathHolding = true
SWEP.BreathHoldingTime = 10

SWEP.RTScope = false
SWEP.RTScopeType = "def"
SWEP.RTScopeReticle = "reticles/reticle2"
SWEP.RTScopeReticleSize = 80

SWEP.RTScopeCustomFunc = function()

end

SWEP.NearWallType = 1

SWEP.WallPos = Vector(0,0,0)
SWEP.WallAng = Vector(-9.146, 0, 0)



SWEP.Skins = false

SWEP.SkinsFrame = 1

SWEP.SkinsTable = {
}

SWEP.SomeData = {}

SWEP.SomeData.SubMat0 = nil
SWEP.SomeData.SubMat1 = nil
SWEP.SomeData.SubMat2 = nil
SWEP.SomeData.SubMat3 = nil

local HitSound = {
"sweps/Hitmarker Sound.wav"
  	}


SWEP.MarkerOpacity = 0

local rndr = render
local mth = math
local srface = surface
local inpat = input

function SWEP:TimedPunch( time, ang )
local ply = self.Owner
local wep = self.Weapon
	timer.Simple(time, function()
		if wep == nil then return end
		ply:ViewPunch( ang )
	end)
end

function SWEP:Deploy()
self:OnDeploy()
	self:SendWeaponAnim( ACT_VM_DRAW )
	self:SetNextPrimaryFire( CurTime() + self:SequenceDuration() )
	self:SetHoldType( self.HoldType )	
	self.Primary.Cone = self.DefaultCone
	self.Weapon:SetNWInt("Reloading", CurTime() + self:SequenceDuration() )
	self.Weapon:SetNWString( "AniamtionName", "none" )
	--self.Owner:SetNWInt( "breathholdtime_hg", self.BreathHoldingTime )
	
	return true
end

function SWEP:OnDeploy()

end

function SWEP:ServThink()
end

local nxtbreathdown = 0

function SWEP:Think()
self:SecondThink()
self:InspectThink()

	if SERVER then
		self:ServThink()
	end

local ply = self.Owner
local wep = self.Weapon

wep:SetNWInt("skenscount", table.Count(wep.SkinsTable) )

	local sprintshit = wep:GetNWBool( "SprintShit" )
	
	if SERVER and self.InfinityBreathHolding == false then
	
		if ply:KeyDown(IN_SPEED) and self.Weapon:GetNWInt("breathholdtime_hg") > 0 and self.Weapon:GetNWInt("nxtbreathdown") < CurTime() then
			self.Weapon:SetNWInt("breathholdtime_hg", self.Weapon:GetNWInt("breathholdtime_hg")-1)
			self.Weapon:SetNWInt("nxtbreathdown", CurTime() + .5)
		end
		
		if !ply:KeyDown(IN_SPEED) and self.Weapon:GetNWInt("breathholdtime_hg") < self.BreathHoldingTime and self.Weapon:GetNWInt("nxtbreathdown") < CurTime() then
			self.Weapon:SetNWInt("breathholdtime_hg", self.Weapon:GetNWInt("breathholdtime_hg")+1)
			self.Weapon:SetNWInt("nxtbreathdown", CurTime() + .5)
		end
		
		if self.Weapon:GetNWInt("breathholdtime_hg") > self.BreathHoldingTime/6 and self.Weapon:GetNWBool("over_breathhold") == true then
			self.Weapon:SetNWBool("over_breathhold", false )
		end
		
		if self.Weapon:GetNWInt("breathholdtime_hg") <= 0 then
			self.Weapon:SetNWBool("over_breathhold", true )
		end
	
	end
if SERVER then
	if self:Ammo1() < 100 and wep:GetNextPrimaryFire() + 1.5 < CurTime() and ply:GetNWBool( "Guardening" ) == false then 
	ply:GiveAmmo( 1, "Battery", true )
	end

	if self:Ammo1() < 0 then 
	ply:SetAmmo(0,"Battery")
	end
	
		if self:Ammo1() > 100 then 
	ply:SetAmmo(100,"Battery")
	end
	
end	 
	

	
	
		if self.IronSights == false then
			ply:SetNWBool( "Guardening", false )
		end
	
		if self.IronSights == true and ply:GetNWBool( "MelAttacking") == false and ply:KeyDown(IN_ATTACK2) and ply:WaterLevel() != 3 and sprintshit == false and wep:GetNWInt("Reloading") < CurTime() and self:Ammo1() > 0 then
				ply:SetNWBool( "Guardening", true )
				self.Weapon:SetNextPrimaryFire( CurTime() + 0.3 )

				
							self.Primary.Cone = self.IronCone
				self.Primary.Recoil = self.Primary.IronRecoil
			else
				ply:SetNWBool( "Guardening", false )	

				self.Primary.Cone = self.DefaultCone		
				self.Primary.Recoil = self.DefaultRecoil
		end
		
		if ply:KeyReleased(IN_ATTACK2) and self.SniperScope == true then
			if CLIENT then
				self.Owner:DrawViewModel(true)
			end
		end
		
		
		--parry
		if ply:KeyDown(IN_RELOAD) then
		if self.CanParry == false then return true end
			self:SecondaryAttack()
		end
		--parry ernd
		
		
		--dodging
				--===================================
		--backstep dodge
		if SERVER then
		if ply:KeyDown(IN_WALK) and ply:KeyDown(IN_BACK) and self:Ammo1() >= self.DodgeStaminaTake - 1 and self.DodgingEnabled == true and ply:GetNWBool("CanDodge") == true and ply:GetNWBool("Guardening") == false then
		
		ply:SetNWBool("BackstepDodge", true)
		self:MeleeDodgeMechanic()
		end
		--sidestep towards the left
		if ply:KeyDown(IN_WALK) and ply:KeyDown(IN_MOVELEFT) and self:Ammo1() >= self.DodgeStaminaTake - 1 and self.DodgingEnabled == true and ply:GetNWBool("CanDodge") == true and ply:GetNWBool("Guardening") == false then

		
		ply:SetNWBool("SidestepLeftDodge", true)
		self:MeleeDodgeMechanic()
		end
		--sidestep towards the right
		if ply:KeyDown(IN_WALK) and ply:KeyDown(IN_MOVERIGHT) and self:Ammo1() >= self.DodgeStaminaTake - 1 and self.DodgingEnabled == true and ply:GetNWBool("CanDodge") == true and ply:GetNWBool("Guardening") == false  then
		if self:Ammo1() <= self.DodgeStaminaTake - 1 then return end
		if ply:GetNWBool("CanDodge") == false then return true end
		if ply:GetNWBool("Guardening") == true then return true end
		
		ply:SetNWBool("SidestepRightDodge", true)
		self:MeleeDodgeMechanic()
		end
		end
		        --===================================
		--dodge ernd
		
		
		--buggy animations
		
		if ply:GetNWBool("Guardening") == true or ply:GetNWBool("Parry") == true then
			self:SetHoldType( self.GuardHoldType )	
		else
			self:SetHoldType( self.HoldType )			
		end
		
		--parry aniamtion test

		--ya
		
		--end of buggy animations
		if self.SniperScope == true then
			if CLIENT then
				if self.Weapon:GetNWBool( "FuckDaModel" ) == true then
					if ply:KeyPressed(IN_ATTACK2) then
						self.Owner:DrawViewModel(false)
					end
				elseif self.Weapon:GetNWBool( "FuckDaModel" ) == false then 
					--self.Owner:DrawViewModel(true)
				end
			end
		end

		if ply:KeyDown(IN_SPEED) and ply:GetVelocity():Length() > 350 and wep:GetNWInt("Reloading") < CurTime() and self.Sprint == true and self.BlackMesaSprint == false then
			wep:SetNextPrimaryFire( CurTime() + 0.3 )
			wep:SetNextSecondaryFire( CurTime() + 0.3 )
		end
		

		
		if ply:WaterLevel() == 3 then
			wep:SetNextPrimaryFire( CurTime() + 0.5 )
			wep:SetNextSecondaryFire( CurTime() + 0.5 )
			
			
function self.Owner:OnTakeDamage(dmginfo)
self:HandleDamage(dmginfo) -- As an example, your function goes here
dmginfo:SetDamage(0)
end
			
		end
		
if self.CSGOstyle == true then
	self.Primary.Cone = (self.DefaultCone + self.Owner:GetVelocity():Length()/100) * self.CSGOMultiplier
end

if self.Hitmarker == true then
	if self.MarkerOpacity >= 0 then
		self.MarkerOpacity = self.MarkerOpacity - 5
		wep:SetNWInt( "Hitmarker", self.MarkerOpacity )
	end
end

end




--DODGING, VERY BUGGY
function SWEP:MeleeDodgeMechanic()
local wep = self.Weapon
local ply = self.Owner

--if self.DodgingEnabled == false then return end
if !ply:IsOnGround() then return end
--if self:Ammo1() <= self.DodgeStaminaTake - 1 then return end

ply:SetNWBool("CanDodge", false)

--seperate dodge functions, this is going to look messey
if SERVER then
if ply:GetNWBool("BackstepDodge") == true then
   local boom = -800
   local shiftstraight = ply:GetAngles():Forward()*boom
   shiftstraight.z = 0

      
         ply:SetGroundEntity(NULL)
            ply:SetLocalVelocity(shiftstraight)
     

 end

if ply:GetNWBool("SidestepLeftDodge") == true then
   local boom = -800
   local shiftstraight = ply:GetAngles():Right()*boom
   shiftstraight.z = 0

     
         ply:SetGroundEntity(NULL)
            ply:SetLocalVelocity(shiftstraight)
     

 end
 
 if ply:GetNWBool("SidestepRightDodge") == true then
   local boom = 800
   local shiftstraight = ply:GetAngles():Right()*boom
   shiftstraight.z = 0

     
         ply:SetGroundEntity(NULL)
            ply:SetLocalVelocity(shiftstraight)
      

 end
 end
--end of seperate dodge functions



wep:SetNextPrimaryFire( CurTime() + 1 )
self:TakePrimaryAmmo(self.DodgeStaminaTake)
	timer.Simple( 0.5,function()
ply:SetNWBool("CanDodge", true)


ply:SetNWBool("BackstepDodge", false)
ply:SetNWBool("SidestepLeftDodge", false)
ply:SetNWBool("SidestepRightDodge", false)
end)

end
--END OF DODGING




function SWEP:CustomAmmoDisplay()
	self.AmmoDisplay = self.AmmoDisplay or {} 
 
	self.AmmoDisplay.Draw = self.DrawAmmo 
 
	if self.Primary.ClipSize > 0 then
		self.AmmoDisplay.PrimaryClip = self:Clip1() 
		self.AmmoDisplay.PrimaryAmmo = self:Ammo1() 
	end
	if self.Secondary.ClipSize > 0 then
		self.AmmoDisplay.SecondaryClip = self:Clip2()
		self.AmmoDisplay.SecondaryAmmo = self:Ammo2()
	end
 
	return self.AmmoDisplay
end

function SWEP:SecondThink()

end

function SWEP:PrimaryCall()//Если надо что-то приписать к выстрелу, но не нужен весь код
end

function SWEP:ServPrimaryCall()//Если надо что-то приписать к выстрелу, но не нужен весь код
end

function SWEP:CanPrimaryAttack()
      return self:Ammo1() >= self.Primary.TakeAmmo
end

function SWEP:PrimaryAttack()
if ( !self:CanPrimaryAttack() ) then return end
local wep = self.Weapon
local ply = self.Owner

if self.Owner:GetNWBool("Guardening") == true then return true end

wep:SetNextPrimaryFire( CurTime() + self.Primary.Delay )


self:AttackAnimination()
self.Owner:GetViewModel():SetPlaybackRate(self.StrikeAnimRate)
	timer.Simple( self.StrikeTime,function()
self:EmitSound( self.PrimarySound )
end)
	local rnda = self.Primary.Recoil * 1
	local rndb = self.Primary.Recoil * math.random(-1, 1)
if SERVER then  --main flamethrower functions, this was hell
ply:SetNWBool( "MelAttacking", true )
	timer.Simple( self.StrikeTime,function()
	local pos = self.Owner:GetShootPos()
	local ang = self.Owner:GetAimVector():Angle()
	pos = pos +ang:Forward() *0 +ang:Right() *(5 + math.random(- self.EntAccuracy, self.EntAccuracy)) +ang:Up() *-(5 + (math.random(- self.EntAccuracy, self.EntAccuracy))/2)
	
	--some weird technique
	local ent = ents.Create("parry_swing")
		ent:SetAngles(self.Owner:GetAimVector():Angle())
	ent:SetOwner(self.Weapon:GetOwner())
	ent:SetPos(pos)
	ent:Spawn()
	ent:Activate()
	ent:GetPhysicsObject():ApplyForceCenter(self.Owner:GetAimVector() * 5)
ply:SetNWBool( "MelAttacking", false )
end)
end
		self.Owner:SetAnimation( PLAYER_ATTACK1 )	
		local fx 		= EffectData()
		
		fx:SetEntity(wep)
		fx:SetOrigin(ply:GetShootPos())
		fx:SetNormal(ply:GetAimVector())
		fx:SetAttachment("1")
		
		self:TakePrimaryAmmo(self.Primary.TakeAmmo)
end


function SWEP:CriticalAttack()
--if ( !self:CanPrimaryAttack() ) then return end
local wep = self.Weapon
local ply = self.Owner

if self.Owner:GetNWBool("Guardening") == true then return true end

wep:SetNextPrimaryFire( CurTime() + self.Primary.Delay )


self:AttackAnimination()
self.Owner:GetViewModel():SetPlaybackRate(self.StrikeAnimRate)
	timer.Simple( self.StrikeTime,function()
self:EmitSound( self.PrimarySound )
end)
	local rnda = self.Primary.Recoil * 1
	local rndb = self.Primary.Recoil * math.random(-1, 1)
if SERVER then  --main flamethrower functions, this was hell
	timer.Simple( self.StrikeTime,function()
	local pos = self.Owner:GetShootPos()
	local ang = self.Owner:GetAimVector():Angle()
	pos = pos +ang:Forward() *0 +ang:Right() *(5 + math.random(- self.EntAccuracy, self.EntAccuracy)) +ang:Up() *-(5 + (math.random(- self.EntAccuracy, self.EntAccuracy))/2)
	
	local ent = ents.Create("parry_swing")
		ent:SetAngles(self.Owner:GetAimVector():Angle())
	ent:SetOwner(self.Weapon:GetOwner())
	ent:SetPos(pos)
	ent:Spawn()
	ent:Activate()
	ent:GetPhysicsObject():ApplyForceCenter(self.Owner:GetAimVector() * 5)
end)
end
		self.Owner:SetAnimation( PLAYER_ATTACK1 )	
		local fx 		= EffectData()
		
		fx:SetEntity(wep)
		fx:SetOrigin(ply:GetShootPos())
		fx:SetNormal(ply:GetAimVector())
		fx:SetAttachment("1")
		
		--self:TakePrimaryAmmo(self.Primary.TakeAmmo)
end



function SWEP:ShootEffects()

	self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK) 	
	self.Owner:MuzzleFlash()						

end

function SWEP:NPCShoot_Primary( ShootPos, ShootDir )
	if ( !self:CanPrimaryAttack() ) then return end
	--if self.Weapon:Clip1() <= 0 then self:Reload() end
	
	if self.Weapon:GetNextPrimaryFire() < CurTime() then
		self:PrimaryAttack()
	end
end


SWEP.VElements = {
	["quad"] = { type = "Quad", bone = "ValveBiped.Bip01_Spine4", rel = "", pos = Vector(6.752, -16.105, -11.948), angle = Angle(-57.273, -99.351, -8.183), size = 0, draw_func = nil}
}

SWEP.WElements = {
	}

local nxt = 0
local ftmul = 0
local fmul
local nxtsken = 0

function SWEP:PlayAnim( firstframe, lastframe, speed1, dur, name )

local maxanim = self.MaxAnim
local FT = FrameTime()
local ply = self.Owner
local wep = self.Weapon
local animtime = wep:GetNWInt( "AnimTime" )

	--wep:SetNWInt( "AnimTime", firstframe )
	wep:SetNWString( "AnimationName", name )
	wep:SetNWInt( "AnimTime", firstframe )
	wep:SetNWInt( "NextAnim", CurTime() + dur )
	wep:SetNWInt( "NextFrame", 0 )
	wep:SetNWInt( "FirstFrame", firstframe )
	wep:SetNWInt( "LastFrame", lastframe )
	wep:SetNWInt( "TFrameDelay", speed1 )
	wep:SetNWInt( "FrameDelay", wep:GetNWInt( "TFrameDelay" ) )
	
end

function SWEP:GetFrames()
local ply = self.Owner
local wep = self.Weapon
local ff, lf = wep:GetNWInt( "FirstFrame" ), wep:GetNWInt( "LastFrame" )
	return ff, lf
end

function SWEP:GetFramesDelay()
local ply = self.Owner
local wep = self.Weapon
local fd = wep:GetNWInt( "TFrameDelay" ) 
	return fd
end

function SWEP:SetFrame( frame )
	local ply = self.Owner
	local wep = self.Weapon
	wep:SetNWInt( "AnimTime", frame )
	
end

function SWEP:InspectThink()
local maxanim = self.MaxAnim
local FT = FrameTime()
local ply = self.Owner
local wep = self.Weapon
local animtime = wep:GetNWInt( "AnimTime" )
local animka = wep:GetNWString( "AnimationName" )

if CLIENT then

	if wep:GetNWInt( "NextAnim" ) > CurTime() then--and animtime != 0 and animtime < lf then
		if wep:GetNWInt( "NextFrame" ) < CurTime() then
				if self.ViewModelBoneMods[animtime] and self.ViewModelBoneMods[animtime]["NextFrame"] and self.ViewModelBoneMods[animtime]["NextFrame"].speed != "lerp" then
					wep:SetNWInt( "FrameDelay", self.ViewModelBoneMods[animtime]["NextFrame"].speed )
				else
					wep:SetNWInt( "FrameDelay", self:GetFramesDelay() )
				end
				--print(wep:GetNWInt( "FrameDelay" ), animtime)
			wep:SetNWInt( "NextFrame", CurTime() + wep:GetNWInt( "FrameDelay" ) )
			wep:SetNWInt( "AnimTime", animtime + 1 )			
		end
	else
		wep:SetNWInt( "AnimTime", 0 )
		wep:SetNWString( "AnimationName", "none" )
		--nxt = CurTime() + ftmul
	end
	
		if ply:KeyDown(IN_USE) and inpat.IsKeyDown(KEY_G) and nxtsken < CurTime() then
				/*net.Start( "SkinsMenuHGNetworking" )								
					net.WriteEntity( self.Owner )
					net.WriteEntity( self.Weapon )
				net.SendToServer()*/
				RunConsoleCommand("ohgskens")
			nxtsken = CurTime() + 0.3
		end
	
		if animka == "none" and (inpat.IsKeyDown(KEY_G) ) and !ply:KeyDown(IN_USE) and !ply:KeyDown(IN_ATTACK) and !ply:KeyDown(IN_ATTACK2) and wep:GetNWBool( "SprintShit" ) == false then
			//bultst2 = Lerp(FT*2, bultst2, -35)
			--if nxt < CurTime() then
			--	wep:SetNWInt( "AnimTime", animtime + 1 )					
			--	nxt = CurTime() + fmul
			--end
			self:PlayAnim( 0, self.MaxAnim, 2, self.InspectDuration, "inspect" )
		end
		if animka == "inspect" and ply:KeyDown(IN_ATTACK) or self.Owner:KeyDown(IN_ATTACK2) or wep:GetNWBool( "SprintShit" ) != false or wep:GetNWInt("Reloading") > CurTime() then
			self:SetFrame( 0 )
			wep:SetNWString( "AnimationName", "none" )
		end
		if wep:GetNWBool("AnimExpect") == true then
			self:SetFrame( self.SkinsFrame )
		end	

self:DoBones()
end

end

function SWEP:DoBones()
local FT = FrameTime()
local ply = self.Owner
local wep = self.Weapon
local vm = ply:GetViewModel()
local animtime = wep:GetNWInt( "AnimTime" )

if self.ViewModelBoneMods[animtime] and self.ViewModelBoneMods[animtime]["FrameSpeed"] then
ftmul = self.ViewModelBoneMods[animtime]["FrameSpeed"].speed
else
ftmul = 2
end

	for i=0, vm:GetBoneCount() do
		local bonename = vm:GetBoneName(i)
		
		if (self.ViewModelBoneMods[animtime]) and (self.ViewModelBoneMods[bonename]) then
			
			if animtime > 0 and (self.ViewModelBoneMods[animtime][bonename]) then 
					self.ViewModelBoneMods[bonename].pos = LerpVector( FT*ftmul, self.ViewModelBoneMods[bonename].pos, self.ViewModelBoneMods[animtime][bonename].pos )
					self.ViewModelBoneMods[bonename].scale = LerpVector( FT*ftmul, self.ViewModelBoneMods[bonename].scale, self.ViewModelBoneMods[animtime][bonename].scale )
					self.ViewModelBoneMods[bonename].angle = LerpAngle( FT*ftmul, self.ViewModelBoneMods[bonename].angle, self.ViewModelBoneMods[animtime][bonename].angle )				
				elseif !(self.ViewModelBoneMods[bonename]) then
					local newbone = { [bonename] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) } }
					table.Add( self.ViewModelBoneMods[0], newbone ) 				
				elseif !(self.ViewModelBoneMods[animtime][bonename]) then
					self.ViewModelBoneMods[bonename].pos = LerpVector( FT*ftmul, self.ViewModelBoneMods[bonename].pos, self.ViewModelBoneMods[0][bonename].pos )
					self.ViewModelBoneMods[bonename].scale = LerpVector( FT*ftmul, self.ViewModelBoneMods[bonename].scale, self.ViewModelBoneMods[0][bonename].scale )
					self.ViewModelBoneMods[bonename].angle = LerpAngle( FT*ftmul, self.ViewModelBoneMods[bonename].angle, self.ViewModelBoneMods[0][bonename].angle )
				else
					self.ViewModelBoneMods[bonename].pos = LerpVector( FT*ftmul, self.ViewModelBoneMods[bonename].pos, self.ViewModelBoneMods[0][bonename].pos )
					self.ViewModelBoneMods[bonename].scale = LerpVector( FT*ftmul, self.ViewModelBoneMods[bonename].scale, self.ViewModelBoneMods[0][bonename].scale )
					self.ViewModelBoneMods[bonename].angle = LerpAngle( FT*ftmul, self.ViewModelBoneMods[bonename].angle, self.ViewModelBoneMods[0][bonename].angle )
			end
		end
	end
end


SWEP.AngFrames = {
["FOV"] = 0,
["PosAdd"] = Vector(0, 0, 0),
[0] = Angle(0,0,0),
[1] = Angle(5,5,5),
[2] = Angle(0,-15,-5),
[3] = Angle(0,15,-25)
}

SWEP.IdkTestView = false

local ViewMul1 = 0
local nxtfraem = 0
local maxframe = 3
local tstang = Angle(0,0,0)
local lerpfov = 0
local ironfov = 0
local lerpsprint = Angle(0,0,0)
local posadd = Vector(0, 0, 0)
local skensangle = Angle(0, 0, 0)

local lerpshitmudafaka = Angle(0,0,0)

function SWEP:ViewCalc()
end

function SWEP:CalcView( ply, origin, angles, fov )
if !IsFirstTimePredicted() then
	local FT = FrameTime()
	
	local ply = self.Owner
	local wep = self.Weapon
	local angtime = wep:GetNWInt( "AngFrame" )

	local sprintshit = Angle(0, 0, mth.sin(CurTime()/0.1) * self.SprintMul)

	self:ViewCalc()

		--[[if self.Weapon:GetNWBool("Reloading") == true then
			if nxtfraem < CurTime() then
			nxtfraem = CurTime() + 1
				if angtime < maxframe then 
					self.Weapon:SetNetworkedInt( "AngFrame", angtime + 1 )			
				end
			else
			//self.Weapon:SetNetworkedInt( "AngFrame", 0 )
			end
			ViewMul1 = Lerp(FT*5, ViewMul1, 1)		
		else
			self.Weapon:SetNetworkedInt( "AngFrame", 0 )
			ViewMul1 = Lerp(FT*5, ViewMul1, 0)
		end]]
		
		tstang = LerpAngle( FT*2, tstang, self.AngFrames[angtime])
		lerpfov = Lerp( FT*2, lerpfov, self.AngFrames["FOV"])

	if self.SniperScope == false then
	--ironpos = Lerp( FT*25, ironpos, 0)
		if self.IronSights == true and ply:GetNWBool( "Guardening" ) == true and ply:WaterLevel() != 3  then
			ironfov = Lerp( FT*6, ironfov, 0)
		else
			ironfov = Lerp( FT*8, ironfov, 0)
		end
		
		elseif self.SniperScope == true then 
		
			//if self.Weapon:GetNetworkedBool( "FuckDaModel" ) == false then
			if ply:GetNWBool( "Guardening" ) == true and ply:WaterLevel() != 3  then
				ironfov = Lerp( FT*6, ironfov, 45)
			else
				ironfov = Lerp( FT*10, ironfov, 0)
			end
			//end
		
			if wep:GetNWBool( "FuckDaModel" ) == true and ply:WaterLevel() != 3  then
				//ironpos = Lerp( FT*25, ironpos, 145)
				//ironfov = Lerp( FT*6, ironfov, 50)
			else
				//ironpos = Lerp( FT*25, ironpos, 0)
			end
		
	end

		posadd = LerpVector( FT*2, posadd, self.AngFrames["PosAdd"])
			
		if ply:KeyDown(IN_SPEED) and ply:GetVelocity():Length() > 350 and ply:WaterLevel() != 3 and ( ConVarExists( "hg_viewbob" ) and GetConVarNumber( "hg_viewbob" ) == 1 ) then
			lerpsprint = Lerp( FT*2, lerpsprint, sprintshit)
		else
			lerpsprint = Lerp( FT*2, lerpsprint, Angle(0,0,0))
		end
		
		if wep:GetNWBool("AnimExpect") == true then
			skensangle = LerpAngle( FT*2, skensangle, Angle(mth.sin(CurTime()/2) * 2, mth.sin(CurTime()/2) * 5, mth.sin(CurTime()/2) * 5) )
		else
			skensangle = LerpAngle( FT*2, skensangle, Angle(0, 0, 0) )
		end
		
		lerpshitmudafaka = LerpAngle( FT*7, lerpshitmudafaka, ply:EyeAngles())
		
		origin = origin + posadd --+ ( ply:EyeAngles():Forward() ) --* ironpos
		
		if self.IdkTestView == false then
			angles = angles + tstang + lerpsprint + skensangle //angles + self.AngFrames[angtime]//LerpAngle( FT*2, angles, angles + self.AngFrames[angtime])
		else
			angles = lerpshitmudafaka + lerpsprint
		end
		
		fov = fov + lerpfov - ironfov
		
		return origin, angles, fov
end

end

/*---------------------------------------------------------
   Name: GetViewModelPosition
   Desc: Allows you to re-position the view model
---------------------------------------------------------*/
	local Mul = 0
	local MulB = 0
	local MulI = 0
	local MulBI = 0
	local breath = 0
	
	local ModX = 0
	local ModY = 0
	local ModZ = 0
	
	local ModAngX = 0
	local ModAngY = 0
	local ModAngZ = 0
	
	local SprintMul = 0
	
	local nearwallang = 0
	
	local veloshit = 0

function SWEP:GetViewModelPosition( pos, ang )
local ply = self.Owner
local wep = self.Weapon
	if !ply:IsValid() then return end

--if !IsFirstTimePredicted() then
	local bIron = ply:GetNWBool( "Guardening" )
	local sprintshit = wep:GetNWBool( "SprintShit" )
	
		if ( bIron ) then 
			self.SwayScale 	= 1
			self.BobScale 	= 1
		else 
			self.SwayScale 	= self.DefSwayScale
			self.BobScale 	= self.DefBobScale
		end

	local FT = 0
	if game.SinglePlayer() then
		FT = FrameTime()
	else
		FT = FrameTime()/2
	end
	local FT2 = FT / 25
	
			local Offset	= self.IronSightsPos
	
	--local lagspeed = 20 - self.Primary.Cone
	--gunlagang = LerpAngle( FT*lagspeed, gunlagang, self.Owner:EyeAngles())
			
	if self.BlackMesaSprint == false then
		if ply:KeyDown(IN_SPEED) and ply:GetVelocity():Length() > 350 and ply:WaterLevel() < 1 and self.Sprint == true and wep:GetNWInt("Reloading") < CurTime() then
			SprintMul = Lerp(FT*4, SprintMul, 1)	
			wep:SetNWBool( "SprintShit", true )			
		else
			SprintMul = Lerp(FT*4, SprintMul, 0)
			wep:SetNWBool( "SprintShit", false )				
		end
	else
		if ply:KeyDown(IN_SPEED) and !ply:KeyDown(IN_ATTACK) and wep:GetNextPrimaryFire() + 1 < CurTime() and ply:GetVelocity():Length() > 150 and ply:WaterLevel() < 1 and self.Sprint == true then
			SprintMul = Lerp(FT*4, SprintMul, 1)	
			wep:SetNWBool( "SprintShit", true )		
		elseif self.Owner:KeyDown(IN_ATTACK) then
			SprintMul = Lerp(FT*14, SprintMul, 0)
			wep:SetNWBool( "SprintShit", false )		
		else
			SprintMul = Lerp(FT*4, SprintMul, 0)
			wep:SetNWBool( "SprintShit", false )				
		end
	end
	
	if ( self.IronSightsAng ) then	
		ModAngX = self.IronSightsAng.x
		ModAngY = self.IronSightsAng.y 
		ModAngZ = self.IronSightsAng.z
	end
	

	
	wep:SetNWInt("NearWallMul", nearwallang)
	if ply:KeyDown(IN_MOVERIGHT) then
		veloshit = Lerp(FT*6, veloshit, -ply:GetVelocity():Length()/100 )//-5 )	
	elseif ply:KeyDown(IN_MOVELEFT) then
		veloshit = Lerp(FT*6, veloshit, ply:GetVelocity():Length()/100 )//5 )
	else
		veloshit = Lerp(FT*6, veloshit, 0 )
	end
	
		ang = ang * 1

		ang:RotateAroundAxis( ang:Right(), 		( ModAngX * Mul ) + (self.RunAng.x * SprintMul) + (self.WallAng.x * nearwallang) )
		ang:RotateAroundAxis( ang:Up(), 		( ModAngY * Mul ) + (self.RunAng.y * SprintMul) + (self.WallAng.y * nearwallang) )
		ang:RotateAroundAxis( ang:Forward(), 	( ModAngZ * Mul ) + (veloshit) + (self.RunAng.z * SprintMul) + (self.WallAng.z * nearwallang)  )
	
	local Right 	= ang:Right()
	local Up 		= ang:Up()
	local Forward 	= ang:Forward()

		--if !wep:GetNWBool( "FuckDaModel" ) then 
			ModX = Offset.x * Right * Mul + ( ang:Right() * (self.RunPos.x * SprintMul) ) + ( ang:Right() * (self.WallPos.x * nearwallang) ) 
			ModY = Offset.y * Forward * Mul + ( ang:Forward() * (self.RunPos.y * SprintMul) )  + ( ang:Forward()  * (self.WallPos.y * nearwallang) )
			ModZ = Offset.z * Up * Mul + ( ang:Up() * (self.RunPos.z * SprintMul) )  + ( ang:Up()  * (self.WallPos.z * nearwallang))
		--else
		/*	ModX = Offset.x * Right 
			ModY = Offset.y * Forward + ( ang:Forward() * -5) 
			ModZ = Offset.z * Up + ( ang:Up() * -3)*/
		--end
		
	if bIron then
		Mul = Lerp(FT*15, Mul, 1)
		MulB = Lerp(FT*15, MulB, 0)	
	else
		Mul = Lerp(FT*7, Mul, 0)
		MulB = Lerp(FT*15, MulB, 1)
	end
	
	if ply:KeyDown(IN_DUCK) then 
		MulI = Lerp(FT*2, MulI, 0)
	elseif bIron then
		MulI = Lerp(FT*15, MulI, 0)
	else
		MulI = Lerp(FT*15, MulI, 1)
	end
	
	breath = (mth.sin(CurTime())/(2)) * MulB 
	if Mul >= 0.98 and self.SniperScope == true then
		wep:SetNWBool( "FuckDaModel", true )
	else //Че дальше
		wep:SetNWBool( "FuckDaModel", false )
	end
			pos = pos + ModX
			pos = pos + ModY + (EyeAngles():Up() * (breath) )
			pos = pos + ModZ
			
			ang = ang 
			
		ang:RotateAroundAxis( ang:Right(), (mth.sin(CurTime()/2)) * MulI )
		ang:RotateAroundAxis( ang:Up(), (mth.sin(CurTime()/2)) * MulI )
		ang:RotateAroundAxis( ang:Forward(), (mth.sin(CurTime()/2)) * MulI )

	if self.SightBreath == true then
		if bIron and (!ply:KeyDown(IN_SPEED) or wep:GetNWBool("over_breathhold") == true ) then 
				
			if ply:KeyDown(IN_DUCK) then
				MulBI = Lerp(FT*6, MulBI, 0.1)
			elseif ply:GetVelocity():Length() > 50 then
				MulBI = Lerp(FT*6, MulBI, 2)		
			else
				MulBI = Lerp(FT*6, MulBI, 0.3)
			end
		elseif bIron and ply:KeyDown(IN_SPEED) and wep:GetNWBool("over_breathhold") == false then
			MulBI = Lerp(FT*6, MulBI, 0.01)
		else	
			MulBI = Lerp(FT*6, MulBI, 0)	
		end			
		
		if !game.SinglePlayer() then
			MulBI = MulBI*0.6
		end
			
		local angles = Angle(0,0,0)
		
		--angles:RotateAroundAxis( angles:Right(), (mth.sin(CurTime()/2)) )
		angles:RotateAroundAxis( angles:Right(), (mth.sin(CurTime()*2)/19) * (MulBI) )
		angles:RotateAroundAxis( angles:Up(), (mth.sin(CurTime()/2)/19) * (MulBI) )
		--angles:RotateAroundAxis( angles:Forward(), 0)--mth.sin(CurTime()/6)) * 1 )
		
		ply:SetEyeAngles( ply:EyeAngles()+( (angles*Mul) * self.SightBreathMul ) )	
	end
			
return pos, ang

--end

end

function SWEP:AdjustMouseSensitivity()
     
	if self.Weapon:GetNWBool( "FuckDaModel", true ) then
      	  return (1)
    	else 
    		return 1
     	end
end




SWEP.NextSecondaryAttack = 0

/*---------------------------------------------------------
	SecondaryAttack
---------------------------------------------------------*/
function SWEP:SecondaryAttack()
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

--if self.Owner:GetNWBool("Guardening") == true then return true end

self.NextSecondaryAttack = CurTime() + 1


self.Weapon:SendWeaponAnim( self.ParryAnim )
self:EmitSound( self.ParrySound )
	local rnda = self.Primary.Recoil * 1
	local rndb = self.Primary.Recoil * math.random(-1, 1)
		self.Owner:SetAnimation( PLAYER_ATTACK1 )	
		local fx 		= EffectData()
		
		fx:SetEntity(wep)
		fx:SetOrigin(ply:GetShootPos())
		fx:SetNormal(ply:GetAimVector())
		fx:SetAttachment("1")
		
		self:TakePrimaryAmmo(50)
		wep:SetNextPrimaryFire( CurTime() + 1.5 )
		self.Owner:SetNWBool( "Parry", true )
timer.Simple( 0.08,function()
self.Owner:SetNWBool( "Parry", false )
end)
--end
end

	
function SWEP:Equip()
	self:SetHoldType(self.HoldType)
end	
	
function SWEP:OnRestore()

	self.NextSecondaryAttack = 0
	
end

function SWEP:ReloadFunc()

end

function SWEP:ReloadFinished()

end

--[[function SWEP:Reload()
if not IsValid(self) then return end 
if not IsValid(self.Owner) then return end

if self:Clip1() >= self.Primary.ClipSize or self:GetNextPrimaryFire() > CurTime() then return end

if self.Owner:IsPlayer() and not (self.Weapon:Clip1() < self.Primary.ClipSize and self.Owner:GetAmmoCount(self.Primary.Ammo) > 0) then
	return
end

	self.Weapon:DefaultReload(ACT_VM_RELOAD)
	//self.Weapon:SetNWBool("Reloading", true)
if self.Owner:IsPlayer() then
local waitdammit = (self.Owner:GetViewModel():SequenceDuration())
self.Weapon:SetNWInt("Reloading", CurTime() + (waitdammit + .1) )
	timer.Simple(waitdammit + .1, 
	function() 
		if self.Weapon == nil then return end
		self:ReloadFinished()
	end)
	self:ReloadFunc()
	
	self.Owner:EmitSound(self.ReloadSound)
		
		if CLIENT then

			self.Owner:DrawViewModel(true)

		end
else
self.Owner:SetSchedule(SCHED_RELOAD)
end

end]]--
function SWEP:ShootBullet(CurrentDamage, CurrentRecoil, NumberofShots, CurrentCone, NearWallShit, trace)

	if self.Tracer == 1 then--Still modified shit from m9k lelele
		TracerName = "Ar2Tracer"
	elseif self.Tracer == 2 then
		TracerName = "AirboatGunHeavyTracer"
	elseif self.Tracer == 3 then
		TracerName = "ToolTracer"
	elseif self.Tracer == 4 then
		TracerName = "GaussTracer"
	elseif self.Tracer == 5 then
	    TracerName = "GunshipTracer"
	elseif self.Tracer == 7 then
	    TracerName = "ToolTracer"
	elseif self.Tracer == 10 then
	    TracerName = trace
	else
		TracerName = "Tracer"
	end
	local vectorshit
	if self.Owner:IsPlayer() then
			vectorshit = self.Owner:GetAimVector():Angle()+self.Owner:GetViewPunchAngles()--self.Owner:GetViewModel():GetAngles()--
	else
		vectorshit = self.Owner:GetAimVector():Angle()
		CurrentDamage = CurrentDamage*0.5
	end
	
	local posshit = self.Owner:GetShootPos()
	
	--if self:NearWall() and self.NearWallType == 1 then
		vectorshit:RotateAroundAxis( vectorshit:Right(), 	(self.WallAng.x * NearWallShit)*2 )
		vectorshit:RotateAroundAxis( vectorshit:Up(), 		(self.WallAng.y * NearWallShit)  )
		vectorshit:RotateAroundAxis( vectorshit:Forward(), 	(self.WallAng.z * NearWallShit) )
		
		posshit = posshit + (self.WallPos * NearWallShit) 
	--end

	local bullet = {}
		bullet.Num 		= NumberofShots
		bullet.Src 		= (posshit)	
		bullet.Dir 		= self.Owner:GetAimVector() + (vectorshit:Forward()) --* NearWallShit
		if self.Owner:IsPlayer() then
			bullet.Spread 	= Vector( CurrentCone * 0.1)
		else
			bullet.Spread 	= Vector(0.03,0.03,0.03)
		end
		bullet.Tracer = mth.random(1,2)						
		bullet.TracerName = TracerName
		bullet.Force	= self.Primary.Force
		bullet.Damage	= CurrentDamage
		bullet.Callback	= function(attacker, tracedata, dmginfo) 
			if self.Dissolve == 1 then 
				dmginfo:SetDamageType( bit.bor( DMG_ENERGYBEAM, DMG_DISSOLVE ) )
			end
			if self.DamageType != nil then
				dmginfo:SetDamageType( bit.bor( self.DamageType, self.DamageType ) )
			end
				return self:HitCallback(attacker, tracedata, dmginfo) 
		end

	self.Owner:FireBullets(bullet)

end

function SWEP:ShootBulletInfo(trace)

	local CurrentDamage
	local CurrentRecoil
	local CurrentCone
	local basedamage

	local damagedice = mth.Rand(.85,1.3)
	
	local NearWallShit = 0

	if self:NearWall() and self.NearWallType == 1 then
		NearWallShit = ( mth.Clamp( (self.MaxDist - self.Owner:GetShootPos():Distance(self.Owner:GetEyeTrace().HitPos) )/(self.MaxDist/1.5), 0, 1) ) 
		else
		NearWallShit = Lerp(FrameTime()*4, NearWallShit, 0)		
	end
	
	if !trace then
		trace = self.CustomTracerName
	end

	basedamage = self.Primary.Damage
	CurrentDamage = basedamage * damagedice
	CurrentRecoil = self.Primary.Recoil
	CurrentCone = self.Primary.Cone
	self:ShootBullet(CurrentDamage, CurrentRecoil, self.Primary.NumberofShots, CurrentCone, NearWallShit, trace)
	
end

function SWEP:ShootBulletInfoSec(trace)

	local CurrentDamage
	local CurrentRecoil
	local CurrentCone
	local basedamage

	local damagedice = mth.Rand(.85,1.3)
	
	local NearWallShit = 0

	if self:NearWall() and self.NearWallType == 1 then
		NearWallShit = ( mth.Clamp( (self.MaxDist - self.Owner:GetShootPos():Distance(self.Owner:GetEyeTrace().HitPos) )/(self.MaxDist/1.5), 0, 1) ) 
		else
		NearWallShit = Lerp(FrameTime()*4, NearWallShit, 0)		
	end
	
	if !trace then
		trace = self.CustomTracerName
	end
	
	basedamage = self.Secondary.Damage
	CurrentDamage = basedamage * damagedice
	CurrentRecoil = self.Secondary.Recoil
	CurrentCone = self.Secondary.Cone
	self:ShootBullet(CurrentDamage, CurrentRecoil, self.Secondary.NumberofShots, CurrentCone, NearWallShit, trace)
	
end

function SWEP:HitCallback(attacker, tr, dmginfo)
	
	if not IsFirstTimePredicted() then
	return {damage = false, effects = false}
	end
		
	local DoDefaultEffect = true
	if (tr.HitSky) then return end
	self:CustomHitFunc( attacker, tr, dmginfo )
			if ((tr.Entity:IsNPC()) or (tr.Entity:IsPlayer())) then
				
					if self.HealingBullets == true then
						tr.Entity:SetHealth( mth.min( tr.Entity:GetMaxHealth(), tr.Entity:Health() + self.HealAmount ) )
						tr.Entity:EmitSound("items/medshot4.wav")
					end
				
					if self.Hitmarker == true then
					self.MarkerOpacity = 225
				local random = mth.random(1, #HitSound)
  				self.Owner:EmitSound(HitSound[random])
					end
				return 
			end
		if self.Tracer == 0 or self.Tracer == 1 or self.Tracer == 2 or self.Tracer == 3 or self.Tracer == 4 then
			local effectdata = EffectData()
				effectdata:SetOrigin(tr.HitPos)
				effectdata:SetNormal(tr.HitNormal)
				effectdata:SetScale(20)
			util.Effect("AR2Impact", effectdata)
		elseif self.Tracer == 5 or self.Tracer == 7 then
			local effectdata = EffectData()
				effectdata:SetOrigin(tr.HitPos)
				effectdata:SetNormal(tr.HitNormal)
				effectdata:SetScale(20)
			util.Effect("StunstickImpact", effectdata)
		elseif self.Tracer == 6 then

		return 
	end
	return {damage = true, effects = DoDefaultEffect}
end

function SWEP:CustomHitFunc( attacker, tr, dmginfo )
end

function SWEP:CustomFireEvent( pos, ang, event, options )

end

function SWEP:FireAnimationEvent( pos, ang, event, options )
self:CustomFireEvent( pos, ang, event, options )
if self.DisableMuzzle == 1 then
	-- Disables animation based muzzle event
	--if ( event == 20 ) then return true end	
	if ( event == 21 ) or ( event == 20 ) then 		
		--if IsFirstTimePredicted() then
			if self.Owner:IsPlayer() and self.LuaShells == true then
				local fx = EffectData()
				fx:SetEntity(self.Weapon)
				fx:SetOrigin(self.Owner:GetShootPos())
				fx:SetNormal(self.Owner:GetAimVector())
				fx:SetAttachment(2)
				util.Effect(self.ShellName, fx)	
			end
		--end 
		return true 
	end	

	-- Disable thirdperson muzzle flash
	if ( event == 5001 ) then return true end
	if ( event == 5003 ) then return true end
	if ( event == 5011 ) then return true end
	if ( event == 5021 ) then return true end
	if ( event == 5031 ) then return true end
	if ( event == 6001 ) then return true end
end
end

function SWEP:CustomHud()//Функция для худа, если нужно оставить базовый код
end

local tstdata = {}

function SWEP:DrawHUDBackground()

end

function SWEP:DrawHUD()
self:CustomHud()
local trace = self.Owner:GetEyeTrace()

	if self.CustomCrosshair == true and !self.Owner:GetNWBool( "Guardening", false ) and GetConVarNumber( "hg_crosshair" ) == 1 then
		local x = ScrW() / 2.0--trace.HitPos:ToScreen().x
		local y = ScrH() / 2.0--trace.HitPos:ToScreen().y
		local scale = self.Primary.Cone * 5

		local LastShootTime = self.Weapon:GetNWFloat( "LastShootTime", 0 )
		scale = scale * (2 - mth.Clamp( (CurTime() - LastShootTime) * 5, 0.0, 1.0 ))
	
		local gap = 5 * scale
		local length = gap + 2.5 * scale
		srface.SetDrawColor( self.CrossColor )
		srface.DrawLine( x - length, y, x - gap, y )
		srface.DrawLine( x + length, y, x + gap, y )
		srface.DrawLine( x, y - length, x, y - gap )
		srface.DrawLine( x, y + length, x, y + gap )
	end
	
	if self.Hitmarker == true then
	
	local hitmarker = srface.GetTextureID("hobo_gus/hitmarker")
	
		srface.SetTexture( hitmarker )
		srface.SetDrawColor( 255, 255, 255, self.Weapon:GetNWInt( "Hitmarker", 0 ) )
		srface.DrawTexturedRect( ( ScrW() / 2.0 ) - 24.5, (ScrH() / 2.0) - 24.5, 49, 49, 0 )
	end
	
self:DrawScopeShit()

end

--[[---------------------------------------------------------

-----------------------------------------------------------]]
function SWEP:DrawWeaponSelection( x, y, wide, tall, alpha )
	
	-- Set us up the texture
	srface.SetDrawColor( 255, 255, 255, alpha )
	srface.SetTexture( self.WepSelectIcon )
	
	-- Lets get a sin wave to make it bounce
	local fsin = 0
	-- And fucking rotation
	local rsin = 0
	
	if ( self.BounceWeaponIcon == true ) then
		fsin = mth.sin( CurTime() * 10 ) * 5
		rsin = mth.sin( CurTime() * 5 ) * 10
	end
	
	-- Borders
	y = y + 10
	x = x + 10
	wide = wide - 20
	
	-- Draw that mother
	srface.DrawTexturedRectRotated( x + 80 + (fsin), y + 50 - (fsin),  wide-fsin*2 , ( wide / 2 ) + (fsin), rsin )
	
	-- Draw weapon info box
	self:PrintWeaponInfo( x + wide + 20, y + tall * 0.95, alpha )
	
end


--[[---------------------------------------------------------
	This draws the weapon info box
-----------------------------------------------------------]]
function SWEP:PrintWeaponInfo( x, y, alpha )

	if ( self.DrawWeaponInfoBox == false ) then return end

	if (self.InfoMarkup == nil ) then
		local str
		local title_color = "<color=230,230,230,255>"
		local text_color = "<color=150,150,150,255>"
		
		str = "<font=HudSelectionText>"
		if ( self.Author != "" ) then str = str .. title_color .. "Author:</color>\t"..text_color..self.Author.."</color>\n" end
		if ( self.Contact != "" ) then str = str .. title_color .. "Contact:</color>\t"..text_color..self.Contact.."</color>\n\n" end
		if ( self.Purpose != "" ) then str = str .. title_color .. "</color>\n"..text_color..self.Purpose.."</color>\n\n" end
		if ( self.Instructions != "" ) then str = str .. title_color .. "</color>\n"..text_color..self.Instructions.."</color>\n" end
				-- Moar info --
		--str = str .. title_color .. "Max Clip:</color>\t"..text_color..self.Primary.ClipSize .. "</color>\n"
		if self.RTScope == true then str = str .. title_color .. "Uses Render Target Scope</color>\n" end
		if self.SniperScope == true then str = str .. title_color .. "Uses Sniper Scope</color>\n" end
		if self.Skins == true then str = str .. title_color .. "Has ".. (table.Count(self.SkinsTable) - 1) .." Skins (E+G - change skin)</color>\n" end
		if self.DamageType != nil then str = str .. title_color .. "Damage type: ".. self.DamageType .."</color>\n" end
		str = str .. "</font>"
		
		self.InfoMarkup = markup.Parse( str, 250 )
	end
	
	srface.SetDrawColor( 60, 60, 60, alpha )
	srface.SetTexture( self.SpeechBubbleLid )
	
	srface.DrawTexturedRect( x, y - 64 - 5, 128, 64 ) 
	draw.RoundedBox( 8, x - 5, y - 6, 260, self.InfoMarkup:GetHeight() + 18, Color( 60, 60, 60, alpha ) )
	
	self.InfoMarkup:Draw( x+5, y+5, nil, nil, alpha )
	
end

function SWEP:RenderSomeShit()
		tstdata.angles = self.Owner:GetAngles() + self.Owner:GetViewPunchAngles()
		tstdata.origin = self.Owner:GetShootPos()
		tstdata.x = 0
		tstdata.y = 0
		tstdata.w = ScrW()
		tstdata.h = ScrH()
		tstdata.drawviewmodel  = false
		tstdata.fov = 15
		rndr.RenderView( tstdata )
end

local hudbopmul = 0

function SWEP:DrawScopeShit()

	local ply = self.Owner
	
	if self.Weapon:GetNWBool( "FuckDaModel") == true then
	
	local scoupe = srface.GetTextureID("gmod/scope")//"hobo_gus/scoupe")
	local scouperef = srface.GetTextureID("gmod/scope-refract")
		self.QuadTable = {}
		self.QuadTable.w = ScrH()
		self.QuadTable.h = ScrH()
		self.QuadTable.x = (ScrW() - ScrH()) * .5
		self.QuadTable.y = 0
		
		self:RenderSomeShit()	
srface.SetDrawColor( 0, 0, 0, 255 )		
		srface.SetTexture( scouperef )
		srface.DrawTexturedRect( ( ScrW() / 2.0 ) - ScrH()/2, (0), ScrH(), ScrH(), 0 )
		
		local x = ScrW() / 2.0
		local y = ScrH() / 2.0
	
		srface.SetDrawColor( self.CrossColor )
		srface.DrawLine( ScrH()/2, y, ScrW(), y )
		srface.DrawLine( x, 0, ScrW()/2, ScrH() )
		
		srface.SetDrawColor( 0, 0, 0, 255 )
		srface.SetTexture( scoupe )		
		srface.DrawTexturedRect( ( ScrW() / 2.0 ) - ScrH()/2, (0), ScrH(), ScrH(), 0 )
		
		srface.DrawRect(0, 0, (ScrW() - ScrH()) * .5, ScrH() )
		srface.DrawRect(ScrW() - ((ScrW() - ScrH()) * .5), 0, (ScrW() - ScrH()) * .5, ScrH() )
		
		if self.SightBreath == true then
			if ply:KeyDown(IN_SPEED) or self.Weapon:GetNWBool("over_breathhold") == true then
				hudbopmul = Lerp(FrameTime()*2, hudbopmul, 0)
			else
				hudbopmul = Lerp(FrameTime()*2, hudbopmul, 1)
			end
				draw.SimpleText("SHIFT - Hold your breath", "QuadFont", ScrW()/2, ScrH() - 60, Color(255, 255, 255, 255*hudbopmul), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			--draw.SimpleText(self.Weapon:GetNWBool("over_breathhold"), "QuadFont", ScrW()/2, ScrH() - 60, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
		
	end
end

function SWEP:NearWall()
if self.Owner:IsNPC() or !self.Owner:IsValid() then return end
	return self.Owner:GetShootPos():Distance(self.Owner:GetEyeTrace().HitPos) <= self.MaxDist and !self.Owner:GetEyeTrace().Entity:IsPlayer() and !self.Owner:GetEyeTrace().Entity:IsNPC()
end

function SWEP:TraceCollider(addforward, addright, addup)
local angles = self.Owner:EyeAngles()
	local collider = {}
		collider.start = self.Owner:EyePos()
		collider.endpos = collider.start + angles:Forward() * addforward
		collider.endpos = collider.endpos + angles:Right() * addright
		collider.endpos = collider.endpos + angles:Up() * addup
		collider.filter = self.Owner	
		local trace = util.TraceLine(collider)	
	return self.Owner:GetShootPos():Distance(trace.HitPos)
end

/********************************************************
	SWEP Construction Kit base code
		Created by Clavus
	Available for public use, thread at:
	   facepunch.com/threads/1032378
	   
	DESCRIPTION:
		This script is meant for experienced scripters 
		that KNOW WHAT THEY ARE DOING. Don't come to me 
		with basic Lua questions.
		
		Just copy into your SWEP or SWEP base of choice
		and merge with your own code.
		
		The SWEP.VElements, SWEP.WElements and
		SWEP.ViewModelBoneMods tables are all optional
		and only have to be visible to the client.
********************************************************/
if CLIENT then
surface.CreateFont( "QuadFont", {
	font = "Arial",
	size = 25,
	weight = 5,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false, 
} )

surface.CreateFont( "QuadFontSmall", {
	font = "Arial",
	size = 15,
	weight = 5,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false, 
} )

end

function SWEP:InitFunc()
end

function SWEP:QuadsHere()
end

function SWEP:GetSCKshitPos(vm)

	//local vm = self.VElements[vm].modelEnt
	local pos, ang
	pos = self.VElements[vm].modelEnt:GetPos()
	ang = self.VElements[vm].modelEnt:GetAngles()
	
	return pos, ang
end

function SWEP:GetCapabilities()

	return bit.bor( CAP_WEAPON_RANGE_ATTACK1, CAP_INNATE_RANGE_ATTACK1 )

end

function SWEP:ShouldDropOnDie()
	return true
end

function SWEP:Initialize()
self:InitFunc()
	if SERVER then
	
	end
	
	if CLIENT then

	self:SetHoldType( self.HoldType )	
	self:QuadsHere()
	if self.QuadAmmoCounter == true then
		self.VElements["quad"].draw_func = function( weapon )
			//surface.SetDrawColor(quadInnerColor)
			draw.SimpleText(weapon:Ammo1(), "QuadFont", 0, 0, self.AmmoQuadColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			--draw.SimpleText(weapon:Ammo1(), "QuadFont", 0, 25, self.AmmoQuadColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
	end
		
		self.VElements = table.FullCopy( self.VElements )
		self.WElements = table.FullCopy( self.WElements )
		self.ViewModelBoneMods = table.FullCopy( self.ViewModelBoneMods )

		self:CreateModels(self.VElements) // create viewmodels
		self:CreateModels(self.WElements) // create worldmodels

		if IsValid(self.Owner) and self.Owner:IsPlayer() then
			local vm = self.Owner:GetViewModel()
			if IsValid(vm) then
				self:ResetBonePositions(vm)
				
			end
		end
	end
end

function SWEP:OnDrop()
	if CLIENT and IsValid(self.Owner) and self.Owner:IsPlayer() then
	local vm = self.Owner:GetViewModel()
		if IsValid(vm) then
			self:ResetBonePositions(vm)
			vm:SetSubMaterial( 0, "" )
			vm:SetSubMaterial( 1, "" )
			vm:SetSubMaterial( 2, "" )
		end
	end
end

function SWEP:Holster()

	if CLIENT and IsValid(self.Owner) and self.Owner:IsPlayer() then
	local vm = self.Owner:GetViewModel()
		if IsValid(vm) then
		 self.Owner:SetNWBool( "Parry", false )
			self:ResetBonePositions(vm)
			vm:SetSubMaterial( 0, "" )
			vm:SetSubMaterial( 1, "" )
			vm:SetSubMaterial( 2, "" )
		end
		
	end
	
	if IsValid(self.Owner) and self.Owner:WaterLevel() == 3 then--or self:NearWall() then
	return false
	else
	return true
	end

end

function SWEP:OnRemove()
		 self.Owner:SetNWBool( "Parry", false )

	self:Holster()
end

function SWEP:CustomDrawn()
end

function SWEP:SubMatFunc()

	local vm = self.Owner:GetViewModel()--Get view model
	local wep = self.Weapon
	if vm:IsValid() then
	
		if self.SomeData.SubMat0 != nil and self.Skins == false then
			vm:SetSubMaterial( 0, self.SomeData.SubMat0 )--Change its material
		else
			vm:SetSubMaterial( 0, "" )
		end
		
		if self.Skins == true then -- yo skins managment here
			vm:SetSubMaterial( 0, self.SkinsTable[self.Weapon:GetNWInt( "hgskin" )].path )
		end

		if self.SomeData.SubMat1 != nil and self.Skins == false then
			vm:SetSubMaterial( 1, self.SomeData.SubMat1 )--Change its material
		else
			vm:SetSubMaterial( 1, "" )
		end
	
	end


end

function SWEP:CustomWorldDrawn()
end

if CLIENT then

local redflare = Material( "effects/redflare" ) 
	--[[function SWEP:PostDrawViewModel( vm, weapon ) 
		if self.Weapon:GetNetworkedBool( "FuckDaModel" ) then return false end
	end]]

	SWEP.vRenderOrder = nil
	function SWEP:ViewModelDrawn(vm)
		self:CustomDrawn(vm)
		
		self:SubMatFunc()
		
		//self:LaserDraw()
		local vm = self.Owner:GetViewModel()
		self:UpdateBonePositions(vm)
		if ( IsValid( vm ) ) and self.LaserSight == 1 then
	local tr = self.Owner:GetEyeTrace()
	local lsize = math.random(9,15)
	
	--[[local ent = self.Owner

	local mins = self.Owner:OBBMins()
	local maxs = self.Owner:OBBMaxs()
	local len = 6000
	
	local postst = self.Owner:GetViewModel():GetAttachment("1").Pos
	local angtst = self.Owner:GetViewModel():GetForward()

	local tracetst = util.TraceHull( {
		start = postst,
		endpos = postst + angtst * len,
		maxs = maxs,
		mins = mins,
		filter = ent
	} )]]
			local pos = self.Owner:GetViewModel():GetAttachment("1").Pos--vm:GetPos()
			local ang = self.Owner:GetViewModel():GetAttachment("1").Ang--GetAngles()--vm:GetAngles()
			local endpos, startpos
			
				endpos = pos + ang:Forward() * 10000 + ang:Up() * -250
				startpos = pos + ang:Forward() * 50 
				local trc = util.TraceLine({
					start = startpos,
					endpos = endpos
				})
		    rndr.SetMaterial( Material( "effects/redflare" ) )
			rndr.DrawBeam(startpos, trc.HitPos, 0.2, 0, 0.99, Color(255,255,255, 100))
            rndr.DrawSprite( trc.HitPos,lsize,lsize,Color( 255,255,255 ) )
		end
		
		if !IsValid(vm) then return end
		
		if (!self.VElements) then return end
		
		self:UpdateBonePositions(vm)

		if (!self.vRenderOrder) then

			self.vRenderOrder = {}

			for k, v in pairs( self.VElements ) do
				if (v.type == "Model") then
					table.insert(self.vRenderOrder, 1, k)
				elseif (v.type == "Sprite" or v.type == "Quad") then
					table.insert(self.vRenderOrder, k)
				end
			end
			
		end

		for k, name in ipairs( self.vRenderOrder ) do
		
			local v = self.VElements[name]
			if (!v) then self.vRenderOrder = nil break end
			if (v.hide) then continue end
			
			local model = v.modelEnt
			local sprite = v.spriteMaterial
			
			if (!v.bone) then continue end
			
			local pos, ang = self:GetBoneOrientation( self.VElements, v, vm )
			
			if (!pos) then continue end
			
			if (v.type == "Model" and IsValid(model)) then

				model:SetPos(pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z )
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)

				model:SetAngles(ang)
				local matrix = Matrix()
				matrix:Scale(v.size)
				model:EnableMatrix( "RenderMultiply", matrix )
				
				if (v.material == "") then
					model:SetMaterial("")
				elseif (model:GetMaterial() != v.material) then
					model:SetMaterial( v.material )
				end
				
				if (v.skin and v.skin != model:GetSkin()) then
					model:SetSkin(v.skin)
				end
				
				if (v.bodygroup) then
					for k, v in pairs( v.bodygroup ) do
						if (model:GetBodygroup(k) != v) then
							model:SetBodygroup(k, v)
						end
					end
				end
				
				if (v.surpresslightning) then
					rndr.SuppressEngineLighting(true)
				end
				
				rndr.SetColorModulation(v.color.r/255, v.color.g/255, v.color.b/255)
				rndr.SetBlend(v.color.a/255)
				model:DrawModel()
				rndr.SetBlend(1)
				rndr.SetColorModulation(1, 1, 1)
				
				if (v.surpresslightning) then
					rndr.SuppressEngineLighting(false)
				end
				
					if name == "Laser" then
							local pos = model:GetPos()
							local ang = model:GetAngles()
							local lsize = mth.random(3,5)
							local endpos, startpos			// = pos + ang:Up() * 10000
							
							if name == "Laser" then
								endpos = pos + ang:Right() * -1 + ang:Forward() * 10000 + ang:Up() * 1.2// + ang:Up() * 10
								startpos = pos + ang:Right() * -1 + ang:Forward() * 5 + ang:Up() * 1.2// + ang:Up() * 10
							end
							
							local trc = util.TraceLine({
								start = startpos,
								endpos = endpos
							})
					
							rndr.SetMaterial( redflare )
							rndr.DrawBeam(startpos, trc.HitPos, 0.2, 0, 0.99, Color(255,255,255, 100))
							rndr.DrawSprite( trc.HitPos,lsize,lsize,Color( 255,255,255 ) )
					
					end
				
			elseif (v.type == "Sprite" and sprite) then
				
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				rndr.SetMaterial(sprite)
				rndr.DrawSprite(drawpos, v.size.x, v.size.y, v.color)
				
			elseif (v.type == "Quad" and v.draw_func) then
				
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)
				
				cam.Start3D2D(drawpos, ang, v.size)
					v.draw_func( self )
				cam.End3D2D()

			end
			
		end
		
	end

	SWEP.wRenderOrder = nil
	function SWEP:DrawWorldModel()
		self:CustomWorldDrawn()
		if self.Owner:IsValid() and self.LaserSight == 1 then
	local tr = self.Owner:GetEyeTrace()
	local lsize = mth.random(9,15)
		          rndr.SetMaterial( Material( "effects/redflare" ) )
                  rndr.DrawSprite( tr.HitPos,lsize,lsize,Color( 255,255,255 ) )
		end
		
		if (self.ShowWorldModel == nil or self.ShowWorldModel) then
			self:DrawModel()
		end
		
		if (!self.WElements) then return end
		
		if (!self.wRenderOrder) then

			self.wRenderOrder = {}

			for k, v in pairs( self.WElements ) do
				if (v.type == "Model") then
					table.insert(self.wRenderOrder, 1, k)
				elseif (v.type == "Sprite" or v.type == "Quad") then
					table.insert(self.wRenderOrder, k)
				end
			end

		end
		
		if (IsValid(self.Owner)) then
			bone_ent = self.Owner
		else
			bone_ent = self
		end
		
		for k, name in pairs( self.wRenderOrder ) do
		
			local v = self.WElements[name]
			if (!v) then self.wRenderOrder = nil break end
			if (v.hide) then continue end
			
			local pos, ang
			
			if (v.bone) then
				pos, ang = self:GetBoneOrientation( self.WElements, v, bone_ent )
			else
				pos, ang = self:GetBoneOrientation( self.WElements, v, bone_ent, "ValveBiped.Bip01_R_Hand" )
			end
			
			if (!pos) then continue end
			
			local model = v.modelEnt
			local sprite = v.spriteMaterial
			
			if (v.type == "Model" and IsValid(model)) then

				model:SetPos(pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z )
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)

				model:SetAngles(ang)
				local matrix = Matrix()
				matrix:Scale(v.size)
				model:EnableMatrix( "RenderMultiply", matrix )
				
				if (v.material == "") then
					model:SetMaterial("")
				elseif (model:GetMaterial() != v.material) then
					model:SetMaterial( v.material )
				end
				
				if (v.skin and v.skin != model:GetSkin()) then
					model:SetSkin(v.skin)
				end
				
				if (v.bodygroup) then
					for k, v in pairs( v.bodygroup ) do
						if (model:GetBodygroup(k) != v) then
							model:SetBodygroup(k, v)
						end
					end
				end
				
				if (v.surpresslightning) then
					rndr.SuppressEngineLighting(true)
				end
				
				rndr.SetColorModulation(v.color.r/255, v.color.g/255, v.color.b/255)
				rndr.SetBlend(v.color.a/255)
				model:DrawModel()
				rndr.SetBlend(1)
				rndr.SetColorModulation(1, 1, 1)
				
				if (v.surpresslightning) then
					rndr.SuppressEngineLighting(false)
				end
				
			elseif (v.type == "Sprite" and sprite) then
				
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				rndr.SetMaterial(sprite)
				rndr.DrawSprite(drawpos, v.size.x, v.size.y, v.color)
				
			elseif (v.type == "Quad" and v.draw_func) then
				
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)
				
				cam.Start3D2D(drawpos, ang, v.size)
					v.draw_func( self )
				cam.End3D2D()

			end
			
		end
		
	end

	function SWEP:GetBoneOrientation( basetab, tab, ent, bone_override )
		
		local bone, pos, ang
		if (tab.rel and tab.rel != "") then
			
			local v = basetab[tab.rel]
			
			if (!v) then return end

			pos, ang = self:GetBoneOrientation( basetab, v, ent )
			
			if (!pos) then return end
			
			pos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
			ang:RotateAroundAxis(ang:Up(), v.angle.y)
			ang:RotateAroundAxis(ang:Right(), v.angle.p)
			ang:RotateAroundAxis(ang:Forward(), v.angle.r)
				
		else
		
			bone = ent:LookupBone(bone_override or tab.bone)

			if (!bone) then return end
			
			pos, ang = Vector(0,0,0), Angle(0,0,0)
			local m = ent:GetBoneMatrix(bone)
			if (m) then
				pos, ang = m:GetTranslation(), m:GetAngles()
			end
			
			if (IsValid(self.Owner) and self.Owner:IsPlayer() and 
				ent == self.Owner:GetViewModel() and self.ViewModelFlip) then
				ang.r = -ang.r 
			end
		
		end
		
		return pos, ang
	end

	function SWEP:CreateModels( tab )

		if (!tab) then return end

		for k, v in pairs( tab ) do
			if (v.type == "Model" and v.model and v.model != "" and (!IsValid(v.modelEnt) or v.createdModel != v.model) and 
					string.find(v.model, ".mdl") and file.Exists (v.model, "GAME") ) then
				
				v.modelEnt = ClientsideModel(v.model, RENDER_GROUP_VIEW_MODEL_OPAQUE)
				if (IsValid(v.modelEnt)) then
					v.modelEnt:SetPos(self:GetPos())
					v.modelEnt:SetAngles(self:GetAngles())
					v.modelEnt:SetParent(self)
					v.modelEnt:SetNoDraw(true)
					v.createdModel = v.model
				else
					v.modelEnt = nil
				end
				
			elseif (v.type == "Sprite" and v.sprite and v.sprite != "" and (!v.spriteMaterial or v.createdSprite != v.sprite) 
				and file.Exists ("materials/"..v.sprite..".vmt", "GAME")) then
				
				local name = v.sprite.."-"
				local params = { ["$basetexture"] = v.sprite }
				local tocheck = { "nocull", "additive", "vertexalpha", "vertexcolor", "ignorez" }
				for i, j in pairs( tocheck ) do
					if (v[j]) then
						params["$"..j] = 1
						name = name.."1"
					else
						name = name.."0"
					end
				end

				v.createdSprite = v.sprite
				v.spriteMaterial = CreateMaterial(name,"UnlitGeneric",params)
				
			end
		end
		
	end
	
	local allbones
	local hasGarryFixedBoneScalingYet = false

	function SWEP:UpdateBonePositions(vm)
		
		if self.ViewModelBoneMods then
			
			if (!vm:GetBoneCount()) then return end
			
			local loopthrough = self.ViewModelBoneMods
			if (!hasGarryFixedBoneScalingYet) then
				allbones = {}
				for i=0, vm:GetBoneCount() do
					local bonename = vm:GetBoneName(i)
					if (self.ViewModelBoneMods[bonename]) then 
						allbones[bonename] = self.ViewModelBoneMods[bonename]
					else
						allbones[bonename] = { 
							scale = Vector(1,1,1),
							pos = Vector(0,0,0),
							angle = Angle(0,0,0)
						}
					end
				end
				
				loopthrough = allbones
			end
			// !! ----------- !! //
			
			for k, v in pairs( loopthrough ) do
				local bone = vm:LookupBone(k)
				if (!bone) then continue end
				
				// !! WORKAROUND !! //
				local s = Vector(v.scale.x,v.scale.y,v.scale.z)
				local p = Vector(v.pos.x,v.pos.y,v.pos.z)
				local ms = Vector(1,1,1)
				if (!hasGarryFixedBoneScalingYet) then
					local cur = vm:GetBoneParent(bone)
					while(cur >= 0) do
						local pscale = loopthrough[vm:GetBoneName(cur)].scale
						ms = ms * pscale
						cur = vm:GetBoneParent(cur)
					end
				end
				
				s = s * ms
				// !! ----------- !! //
				
				if vm:GetManipulateBoneScale(bone) != s then
					vm:ManipulateBoneScale( bone, s )
				end
				if vm:GetManipulateBoneAngles(bone) != v.angle then
					vm:ManipulateBoneAngles( bone, v.angle )
				end
				if vm:GetManipulateBonePosition(bone) != p then
					vm:ManipulateBonePosition( bone, p )
				end
			end
		else
			self:ResetBonePositions(vm)
		end
		   
	end
	 
	function SWEP:ResetBonePositions(vm)
		
		if (!vm:GetBoneCount()) then return end
		for i=0, vm:GetBoneCount() do
			vm:ManipulateBoneScale( i, Vector(1, 1, 1) )
			vm:ManipulateBoneAngles( i, Angle(0, 0, 0) )
			vm:ManipulateBonePosition( i, Vector(0, 0, 0) )
		end
		
	end

	/**************************
		Global utility code
	**************************/
	
	function table.FullCopy( tab )

		if (!tab) then return nil end
		
		local res = {}
		for k, v in pairs( tab ) do
			if (type(v) == "table") then
				res[k] = table.FullCopy(v) // recursion ho!
			elseif (type(v) == "Vector") then
				res[k] = Vector(v.x, v.y, v.z)
			elseif (type(v) == "Angle") then
				res[k] = Angle(v.p, v.y, v.r)
			else
				res[k] = v
			end
		end
		
		return res
		
	end
	
end

print ('The Undergod is watching.')