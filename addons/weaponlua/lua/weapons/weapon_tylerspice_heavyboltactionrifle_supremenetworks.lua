-------------------------------------------------------------------
--Misc-------------------------------------------------------------
-------------------------------------------------------------------

SWEP.Gun					= ("weapon_tylerspice_heavyboltactionrifle_supremenetworks")
SWEP.Base				= "tfa_bash_base"
SWEP.Category				= "Tyler/Spice SupremeNetworks Rifles"
SWEP.Author				= ""
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true
SWEP.PrintName				= "Heavy Bolt Action Rifle (Not Lore)"
SWEP.Slot				= 2
SWEP.SlotPos				= 39
SWEP.Shotgun 			= true
SWEP.ShellTime			= 0.85
SWEP.BoltAction			= false
SWEP.Type 				= "Rifle"
SWEP.UseHands = true
SWEP.DrawCrosshairIS = true --Draw the crosshair in ironsights?	

-------------------------------------------------------------------
--Sounds-----------------------------------------------------------
-------------------------------------------------------------------

SWEP.Primary.Sound 			= Sound("weapon_huntingrifle1.ogg")

-------------------------------------------------------------------
--Damage-----------------------------------------------------------
-------------------------------------------------------------------

SWEP.Primary.PenetrationMultiplier = 1.5
SWEP.Primary.Damage		= 80
SWEP.Primary.NumShots	= 1
SWEP.Primary.Automatic			= false
SWEP.Primary.RPM				= 39
SWEP.SelectiveFire		= false
SWEP.DisableBurstFire	= true
SWEP.OnlyBurstFire		= false
SWEP.FireModeName = "Bolt-Action"
SWEP.Primary.ClipSize			= 5
SWEP.Primary.DefaultClip			= 300
SWEP.Primary.Ammo			= "ar2"
SWEP.DisableChambering = true

-------------------------------------------------------------------
--Accuracy And Recoil----------------------------------------------
-------------------------------------------------------------------

SWEP.Primary.KickUp			= 2.25
SWEP.Primary.KickDown			= 0.75
SWEP.Primary.KickHorizontal			= 0.6
SWEP.Primary.StaticRecoilFactor = 0
SWEP.Primary.Spread		= .025
SWEP.Primary.IronAccuracy = .0001
SWEP.WeaponLength = 30
SWEP.MoveSpeed = 1

function SWEP:Reload()
self:EmitSound(Sound(self.ReloadSound)) 
        self.Weapon:DefaultReload( ACT_VM_RELOAD );
end

SWEP.ReloadSound = "weapon_huntingrifle_reload.ogg"

-------------------------------------------------------------------
--Viewmodel--------------------------------------------------------
-------------------------------------------------------------------

SWEP.ViewModel			= "models/weapons/cstrike/c_snip_scout.mdl"
SWEP.ViewModelFOV			= 70
SWEP.ViewModelFlip			= false
SWEP.ViewModelBoneMods = {
	["v_weapon.scout_Parent"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) }
}
SWEP.VElements = {
	["rifle"] = { type = "Model", model = "models/7554/weapons/mas-36.mdl", bone = "v_weapon.scout_Parent", rel = "", pos = Vector(0, -0.611, -20.19), angle = Angle(-90, 0, -90.805), size = Vector(1.092, 1.092, 1.092), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
SWEP.WElements = {
	["rifle"] = { type = "Model", model = "models/7554/weapons/mas-36.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(22.59, 1.324, -2.276), angle = Angle(0, 0.018, -180.45), size = Vector(1.092, 1.092, 1.092), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}



-------------------------------------------------------------------
--World Model------------------------------------------------------
-------------------------------------------------------------------

SWEP.WorldModel			= "models/f_anm.mdl"
SWEP.HoldType 				= "ar2"
SWEP.ShowWorldModel 		= false

-------------------------------------------------------------------
--Angle Things----------------------------------------------------
-------------------------------------------------------------------

SWEP.data 				= {}
SWEP.data.ironsights			= 1
SWEP.Secondary.IronFOV			= 70
SWEP.RunSightsPos = Vector(0.402, -2.412, 0)
SWEP.RunSightsAng = Vector(-13.367, 37.99, -19.698)
SWEP.IronSightsPos = Vector(-2.589, -0.08, 1.679)
SWEP.IronSightsAng = Vector(0.209, 0.032, 0)
SWEP.InspectPos = Vector(2.605, -7.564, -4.107)
SWEP.InspectAng = Vector(42.501, 26.415, 13.421)
-------------------------------------------------------------------
--Shell and Muzzle-------------------------------------------------
-------------------------------------------------------------------

SWEP.MuzzleAttachment			= "1"
SWEP.ShellAttachment			= "2"
SWEP.LuaShellEject = true
SWEP.LuaShellEjectDelay = 0.88
SWEP.LuaShellEffect = "RifleShellEject"