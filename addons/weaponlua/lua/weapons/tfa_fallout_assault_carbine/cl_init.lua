include('shared.lua')

SWEP.WepSelectIcon = surface.GetTextureID("vgui/entities/hud/weapon_tfa_dm_733")
killicon.Add("tfa_dm_733", "vgui/entities/hud/weapon_tfa_dm_733", Color(255, 255, 255, 255))

local soundData = {
    name 		= "Weapon_cm733_carbine.Magout" ,
    channel 	= CHAN_WEAPON,
    volume 		= 0.5,
    soundlevel 	= 80,
    pitchstart 	= 100,
    pitchend 	= 100,
    sound 		= "weapons/m733/AR15-Magout.wav"
}
sound.Add(soundData)
local soundData = {
    name 		= "Weapon_cm733_carbine.Magin" ,
    channel 	= CHAN_WEAPON,
    volume 		= 0.5,
    soundlevel 	= 80,
    pitchstart 	= 100,
    pitchend 	= 100,
    sound 		= "weapons/m733/AR15-Magin.wav"
}
sound.Add(soundData)
local soundData = {
    name 		= "Weapon_cm733_carbine.Magin2" ,
    channel 	= CHAN_WEAPON,
    volume 		= 0.5,
    soundlevel 	= 80,
    pitchstart 	= 100,
    pitchend 	= 100,
    sound 		= "weapons/m733/magin2.wav"
}
sound.Add(soundData)

local soundData = {
    name 		= "Weapon_cm733_carbine.bolt" ,
    channel 	= CHAN_WEAPON,
    volume 		= 0.5,
    soundlevel 	= 80,
    pitchstart 	= 100,
    pitchend 	= 100,
    sound 		= "weapons/m733/AR15-BoltRelease.wav"
}
sound.Add(soundData)

local soundData = {
    name 		= "Weapon_cm733_carbine.rifleload" ,
    channel 	= CHAN_WEAPON,
    volume 		= 0.5,
    soundlevel 	= 80,
    pitchstart 	= 100,
    pitchend 	= 100,
    sound 		= "weapons/m733/AR15-BoltFull.wav"
}
sound.Add(soundData)

local soundData = {
    name 		= "Weapon_cm733_carbine.select" ,
    channel 	= CHAN_WEAPON,
    volume 		= 0.5,
    soundlevel 	= 80,
    pitchstart 	= 100,
    pitchend 	= 100,
    sound 		= "weapons/m733/fire_select.wav"
}
sound.Add(soundData)

local soundData = {
    name 		= "Weapon_cm733_carbine.empty" ,
    channel 	= CHAN_WEAPON,
    volume 		= 0.5,
    soundlevel 	= 80,
    pitchstart 	= 100,
    pitchend 	= 100,
    sound 		= "weapons/m733/m4a1_empty.wav"
}
sound.Add(soundData)

TFA.AddFireSound( "Weapon_cm733_carbine.single", "weapons/m733/AR15-3.wav", false, "^" )