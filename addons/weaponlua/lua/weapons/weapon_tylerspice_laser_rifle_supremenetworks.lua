SWEP.Gun = ("weapon_tylerspice_laser_rifle_supremenetworks") 
SWEP.BlowbackEnabled = true 
SWEP.BlowbackVector = Vector(0,-1,0)
SWEP.BlowbackCurrentRoot = 0 
SWEP.BlowbackCurrent = 0 
SWEP.BlowbackBoneMods = nil 
SWEP.Blowback_Only_Iron = true 
SWEP.Blowback_PistolMode = false 
SWEP.Category				= "Tyler/Spice SupremeNetworks Rifles"
SWEP.Author				= ""
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions				= ""
SWEP.MuzzleAttachment			= "1" 	
SWEP.ShellEjectAttachment			= "2" 	
SWEP.PrintName				= "Laser Rifle"	
SWEP.Slot				= 2				
SWEP.SlotPos				= 21		
SWEP.DrawAmmo				= true		
SWEP.DrawWeaponInfoBox			= false		
SWEP.BounceWeaponIcon   		= 	false	
SWEP.DrawCrosshair			= true		
SWEP.Weight				= 30			
SWEP.AutoSwitchTo			= true		
SWEP.AutoSwitchFrom			= true		
SWEP.HoldType 				= "ar2"		
SWEP.SelectiveFire		= true
SWEP.CanBeSilenced		= false
SWEP.ViewModelFOV			= 60
SWEP.ViewModelFlip			= false
SWEP.UseHands = true
SWEP.DrawCrosshairIS = true --Draw the crosshair in ironsights?	
SWEP.ViewModel = "models/weapons/cstrike/c_rif_galil.mdl"
SWEP.WorldModel = "models/weapons/w_laserrifle.mdl"
SWEP.Base				= "tfa_gun_base"
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true
SWEP.FiresUnderwater = false
SWEP.Primary.Sound			= Sound("weapons/laserrifle/wpn_rifle_laser_fire_2d.wav")		
SWEP.Primary.RPM			= 300			
SWEP.Primary.ClipSize			= 32		
SWEP.Primary.DefaultClip		= 265		
SWEP.Primary.KickUp				= 0.2		
SWEP.Primary.KickDown			= 0.2		
SWEP.Primary.KickHorizontal		= 0.2		
SWEP.Primary.Automatic			= false		
SWEP.Primary.Ammo			= "ar2"			
SWEP.Secondary.IronFOV			= 55		
SWEP.data 				= {}				
SWEP.data.ironsights			= 1
SWEP.FireModes = {
	"Single"
	
}
SWEP.Primary.NumShots	= 1		
SWEP.Primary.Damage		= 40	
SWEP.Primary.Spread		= .001
SWEP.Primary.IronAccuracy = .015 
SWEP.ViewModelBoneMods = {
	["v_weapon.galil"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) }
}
SWEP.VElements = {
	["rifle"] = { type = "Model", model = "models/halokiller38/fallout/weapons/energy weapons/laserrifle.mdl", bone = "v_weapon.galil", rel = "", pos = Vector(0, 7.083, -5.23), angle = Angle(180, 0, -89.169), size = Vector(1.2, 1.2, 1.2), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
SWEP.WElements = {
	["rifle"] = { type = "Model", model = "", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-1.109, 0.442, 3.23), angle = Angle(0, 90, -175.092), size = Vector(1.166, 1.166, 1.166), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
function SWEP:Reload()
self:EmitSound(Sound(self.ReloadSound)) 
        self.Weapon:DefaultReload( ACT_VM_RELOAD );
end
SWEP.ReloadSound = "weapon_minigun_reload.ogg"
SWEP.BlowbackVector = Vector(0,-3,0.025)
SWEP.Blowback_Only_Iron  = false
SWEP.DoProceduralReload = true
SWEP.ProceduralReloadTime = 2.5
SWEP.TracerCount = 1
SWEP.MuzzleFlashEffect = ""
SWEP.Secondary.IronFOV = 70
SWEP.Primary.KickUp = 0.3
SWEP.Primary.KickDown = 0.2
SWEP.Primary.KickHorizontal = 0.2
SWEP.Primary.KickRight = 0.1
SWEP.DisableChambering = true
SWEP.ImpactEffect = "effect_fo3_laser" 
SWEP.RunSightsPos  = Vector (-2.6657, 0, 3.5)
SWEP.RunSightsAng   = Vector (-20.0824, 0.5693, 0)
SWEP.IronSightsPos = Vector(0, 0, 0)
SWEP.IronSightsAng = Vector(0, 0, 0)
SWEP.BlowbackEnabled = true
SWEP.BlowbackVector = Vector(0,-3,0.1)
SWEP.Blowback_Shell_Enabled = false
SWEP.Blowback_Shell_Effect = ""
SWEP.ThirdPersonReloadDisable=false


DEFINE_BASECLASS( SWEP.Base )