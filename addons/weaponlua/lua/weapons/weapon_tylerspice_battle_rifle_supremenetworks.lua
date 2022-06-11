SWEP.Gun = ("weapon_tylerspice_battle_rifle_supremenetworks") 
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
SWEP.PrintName				= "Battle Rifle"	
SWEP.Slot				= 2				
SWEP.SlotPos				= 21		
SWEP.DrawAmmo				= true		
SWEP.DrawWeaponInfoBox			= false		
SWEP.BounceWeaponIcon   		= 	false	
SWEP.DrawCrosshairIS = true --Draw the crosshair in ironsights?	
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
SWEP.ViewModel = "models/weapons/v_m1garand.mdl"
SWEP.WorldModel = "models/f_anm.mdl"
SWEP.Base				= "tfa_gun_base"
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true
SWEP.FiresUnderwater = false
SWEP.Primary.Sound			= Sound("weapons/riflebrushgun/wpn_brushgun.wav")		
SWEP.Primary.RPM			= 300			
SWEP.Primary.ClipSize			= 8
SWEP.Primary.DefaultClip		= 150	
SWEP.Primary.KickUp				= 0.3		
SWEP.Primary.KickDown			= 0.3		
SWEP.Primary.KickHorizontal		= 0.3		
SWEP.Primary.Automatic			= true		
SWEP.Primary.Ammo			= "ar2"			
SWEP.Secondary.IronFOV			= 55		
SWEP.data 				= {}				
SWEP.data.ironsights			= 1
SWEP.FireModes = {
	"Single"
}
SWEP.Primary.NumShots	= 1		
SWEP.Primary.Damage		= 22	
SWEP.Primary.Spread		= .025
SWEP.Primary.IronAccuracy = .015 
if (CLIENT) then
SWEP.VElements = {
	["garand"] = { type = "Model", model = "models/halokiller38/fallout/weapons/rifles/thismachine.mdl", bone = "skin1.bmp", rel = "", pos = Vector(0.143, 3.141, -22.614), angle = Angle(0, 180, 90), size = Vector(1.5, 1.5, 1.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
SWEP.WElements = {
	["rifle"] = { type = "Model", model = "models/Halokiller38/fallout/weapons/Rifles/thismachine.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-4.062, 1.7, 2.667), angle = Angle(0, 90, -172.67), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
end
function SWEP:Reload()
self:EmitSound(Sound(self.ReloadSound)) 
        self.Weapon:DefaultReload( ACT_VM_RELOAD );
end
SWEP.ReloadSound = "weapon_r91_reload.mp3"
SWEP.BlowbackVector = Vector(0,-3,0.025)
SWEP.Blowback_Only_Iron  = false
SWEP.DoProceduralReload = true
SWEP.ProceduralReloadTime = 2.5
SWEP.TracerCount = 1
SWEP.MuzzleFlashEffect = ""
SWEP.Secondary.IronFOV = 70
SWEP.Primary.KickUp = 0.2
SWEP.Primary.KickDown = 0.1
SWEP.Primary.KickHorizontal = 0.1
SWEP.Primary.KickRight = 0.1
SWEP.DisableChambering = true
SWEP.ImpactEffect = "" 
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