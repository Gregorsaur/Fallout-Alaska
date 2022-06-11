

SWEP.Gun = ("weapon_tylerspice_m16a1_supremenetworks") 
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
SWEP.PrintName				= "M16A1"	
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
SWEP.DrawCrosshairIS = true --Draw the crosshair in ironsights?	
SWEP.UseHands = true
SWEP.ViewModel = "models/weapons/cstrike/c_rif_galil.mdl"
SWEP.WorldModel = "models/f_anm.mdl"
SWEP.Base				= "tfa_gun_base"
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true
SWEP.FiresUnderwater = false
SWEP.Primary.Sound			= Sound("weapons/dingosM16A1/shoot.wav")		
SWEP.Primary.RPM			= 600			
SWEP.Primary.ClipSize			= 30	
SWEP.Primary.DefaultClip		= 400		
SWEP.Primary.KickUp				= 0.3		
SWEP.Primary.KickDown			= 0.3		
SWEP.Primary.KickHorizontal		= 0.3		
SWEP.Primary.Automatic			= true		
SWEP.Primary.Ammo			= "ar2"			
SWEP.Secondary.IronFOV			= 55		
SWEP.data 				= {}				
SWEP.data.ironsights			= 1
SWEP.DisableBurstFire	= false
SWEP.FireModes = {
	"Single"
}
SWEP.Primary.NumShots	= 1		
SWEP.Primary.Damage		= 20
SWEP.Primary.Spread		= .040
SWEP.Primary.IronAccuracy = .015 
SWEP.ViewModelBoneMods = {
	["v_weapon.galil"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) }
}
SWEP.VElements = {
	["smg"] = { type = "Model", model = "models/kali/black_ops/rif_m16a1.mdl", bone = "v_weapon.galil", rel = "", pos = Vector(0.5, 0.7, 0.19), angle = Angle(180, 0, -90.805), size = Vector(1.195, 1.195, 1.195), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
SWEP.WElements = {
	["smg"] = { type = "Model", model = "models/kali/black_ops/rif_m16a1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.59, 1.324, -3.276), angle = Angle(0, 90, -180.45), size = Vector(1.312, 1.312, 1.312), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
function SWEP:Reload()
	if self.Owner:KeyDown(IN_SPEED) then
	return
	end
	self.Weapon:DefaultReload( ACT_VM_RELOAD );
end
SWEP.ReloadSound = "weapon_45autosmg_reload.ogg"
SWEP.BlowbackVector = Vector(0,-3,0.025)
SWEP.Blowback_Only_Iron  = false
SWEP.DoProceduralReload = true
SWEP.ProceduralReloadTime = 2.5
SWEP.TracerCount = 1
SWEP.MuzzleFlashEffect = ""
SWEP.Secondary.IronFOV = 70
SWEP.Primary.KickUp = 1
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