SWEP.Gun = ("weapon_tylerspice_infiltrator_supremenetworks") 
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
SWEP.PrintName				= "Infiltrator"	
SWEP.Slot				= 2				
SWEP.SlotPos				= 21		
SWEP.DrawAmmo				= true		
SWEP.DrawWeaponInfoBox			= false		
SWEP.BounceWeaponIcon   		= 	false	
SWEP.DrawCrosshairIS = false --Draw the crosshair in ironsights?	
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
SWEP.ViewModel = "models/weapons/cstrike/c_smg_ump45.mdl"
SWEP.WorldModel = "models/f_anm.mdl"
SWEP.Base				= "tfa_gun_base"
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true
SWEP.FiresUnderwater = false
SWEP.Primary.Sound			= Sound("weapons/22smgsil/wpn_silenced22smg.wav")		
SWEP.Primary.RPM			= 600		
SWEP.Primary.ClipSize			= 24
SWEP.Primary.DefaultClip		= 200	
SWEP.Primary.KickUp				= 0.1		
SWEP.Primary.KickDown			= 0.3		
SWEP.Primary.KickHorizontal		= 0.3		
SWEP.Primary.Automatic			= true		
SWEP.Primary.Ammo			= "ar2"			
SWEP.Secondary.IronFOV			= 40
SWEP.data 				= {}				
SWEP.data.ironsights			= 1
SWEP.FireModes = {
	"Auto",
	"Single"
}
SWEP.Scoped				= true
SWEP.Primary.NumShots	= 1		
SWEP.Primary.Damage		= 30
SWEP.Primary.Spread		= .040
SWEP.Primary.IronAccuracy = .015 
SWEP.ViewModelBoneMods = {
	["v_weapon.ump45_Parent"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) }
}
SWEP.VElements = {
	["smg"] = { type = "Model", model = "models/halokiller38/fallout/weapons/assaultrifles/infiltratorsilscp.mdl", bone = "v_weapon.ump45_Parent", rel = "", pos = Vector(0.162, 0.343, 5.757), angle = Angle(0, 0, -90.388), size = Vector(1.003, 1.003, 1.003), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
SWEP.WElements = {
	["smg"] = { type = "Model", model = "models/halokiller38/fallout/weapons/assaultrifles/infiltratorsilscp.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-3.589, 0.786, 2.664), angle = Angle(0, 90, -167.956), size = Vector(1.003, 1.003, 1.003), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
function SWEP:Reload()
self:EmitSound(Sound(self.ReloadSound)) 
        self.Weapon:DefaultReload( ACT_VM_RELOAD );
end
SWEP.ReloadSound = "weapon_127mmsmg_reload.ogg"
SWEP.BlowbackVector = Vector(0,-3,0.025)
SWEP.Blowback_Only_Iron  = false
SWEP.DoProceduralReload = true
SWEP.ProceduralReloadTime = 2.5
SWEP.TracerCount = 1
SWEP.MuzzleFlashEffect = ""
SWEP.Secondary.IronFOV = 40
SWEP.Primary.KickUp = 0.2
SWEP.Primary.KickDown = 0.1
SWEP.Primary.KickHorizontal = 0.1
SWEP.Primary.KickRight = 0.1
SWEP.DisableChambering = true
SWEP.ImpactEffect = "" 
SWEP.RunSightsPos  = Vector (-2.6657, 0, 3.5)
SWEP.RunSightsAng   = Vector (-20.0824, 0.5693, 0)
SWEP.IronSightsPos = Vector(0, -90, 0)
SWEP.IronSightsAng = Vector(0, 0, 0)
SWEP.BlowbackEnabled = true
SWEP.BlowbackVector = Vector(0,-3,0.1)
SWEP.Blowback_Shell_Enabled = false
SWEP.Blowback_Shell_Effect = ""
SWEP.ThirdPersonReloadDisable=false


DEFINE_BASECLASS( SWEP.Base )