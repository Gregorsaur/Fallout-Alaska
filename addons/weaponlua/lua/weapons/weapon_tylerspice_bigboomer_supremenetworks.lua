SWEP.Gun = ("weapon_tylerspice_bigboomer_supremenetworks") 
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
SWEP.PrintName				= "Big Boomer"	
SWEP.Slot				= 2				
SWEP.SlotPos				= 21		
SWEP.DrawAmmo				= true		
SWEP.DrawWeaponInfoBox			= false		
SWEP.BounceWeaponIcon   		= 	false	
SWEP.DrawCrosshair			= true		
SWEP.Weight				= 30			
SWEP.DrawCrosshairIS = true --Draw the crosshair in ironsights?	
SWEP.AutoSwitchTo			= true		
SWEP.AutoSwitchFrom			= true		
SWEP.HoldType 				= "pistol"		
SWEP.SelectiveFire		= true
SWEP.CanBeSilenced		= false
SWEP.ViewModelFOV			= 60
SWEP.ViewModelFlip			= false
SWEP.UseHands = true
SWEP.ViewModel = "models/weapons/c_shotgun.mdl"
SWEP.WorldModel = "models/f_anm.mdl"
SWEP.Base				= "tfa_gun_base"
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true
SWEP.FiresUnderwater = false
SWEP.Primary.Sound			= Sound("weapon_shotgunhunting1.ogg")		
SWEP.Primary.RPM			= 200		
SWEP.Primary.ClipSize			= 2
SWEP.Primary.DefaultClip		= 50
SWEP.Primary.KickUp				= 2	
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
SWEP.Primary.NumShots	= 7
SWEP.Primary.Damage		= 6
SWEP.Primary.Spread		= .050
SWEP.Primary.IronAccuracy = .015
SWEP.ViewModelBoneMods = {
	["ValveBiped.Gun"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) }
}
SWEP.VElements = {
	["shotgun"] = { type = "Model", model = "models/halokiller38/fallout/weapons/shotguns/sawedoffshotgun.mdl", bone = "ValveBiped.Gun", rel = "", pos = Vector(0.331, 6.636, -18.731), angle = Angle(-180, 0, -90), size = Vector(1.5, 1.5, 1.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
SWEP.WElements = {
	["shotgun"] = { type = "Model", model = "models/halokiller38/fallout/weapons/shotguns/sawedoffshotgun.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(1, 1.886, 0.889), angle = Angle(0, 92.188, -170.872), size = Vector(1.115, 1.115, 1.115), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
function SWEP:Reload()
self:EmitSound(Sound(self.ReloadSound)) 
        self.Weapon:DefaultReload( ACT_VM_RELOAD );
end
SWEP.ReloadSound = "weapon_45autosmg_reload.ogg"
SWEP.BlowbackVector = Vector(0,-3,0.025)
SWEP.Blowback_Only_Iron  = false
SWEP.DoProceduralReload = true
SWEP.ProceduralReloadTime = 3.5
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