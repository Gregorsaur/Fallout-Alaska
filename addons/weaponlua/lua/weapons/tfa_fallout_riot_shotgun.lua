local path = "/weapons/fallout_new_vegas/riot_shotgun/"
local pref = "TFA_Fallout.Riot_Shotgun"
local hudcolor = Color(255, 80, 0, 191)

TFA.AddFireSound(pref .. ".Fire", {path .. "fire.wav"})

TFA.AddWeaponSound(pref .. ".Deploy", path .. "draw.wav")

TFA.AddWeaponSound(pref .. ".ClipOut", path .. "magout.wav")
TFA.AddWeaponSound(pref .. ".ClipIn", path .. "magin.wav")
TFA.AddWeaponSound(pref .. ".BoltBack", path .. "boltback.wav")
TFA.AddWeaponSound(pref .. ".BoltForward", path .. "boltrelease.wav")