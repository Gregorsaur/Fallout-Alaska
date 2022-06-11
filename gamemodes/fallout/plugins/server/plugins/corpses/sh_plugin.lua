PLUGIN.name = "Looting"
PLUGIN.author = "Ev / Theopathy / YsHeRa"
PLUGIN.desc = "Permits to search NPCs and players corpses."
PLUGIN.corpseMaxDist = 80 -- Max looking distance on a corpse

local dir = PLUGIN.folder.."/"

nut.util.includeDir(dir.."ragdolling", true, true)
nut.util.includeDir(dir.."looting", true, true)
