local VJConvars = {
	["vj_npc_corpsefade"] = 1,
	["vj_npc_corpsefadetime"] = 5,
	["vj_npc_nogib"] = 1,
	["vj_npc_nosnpcchat"] = 1,
	["vj_npc_slowplayer"] = 1,
	["vj_npc_noproppush"] = 1,
	["vj_npc_nothrowgrenade"] = 1,
	["vj_npc_fadegibstime"] = 5,
	["vj_npc_knowenemylocation"] = 1,
	["vj_npc_dropweapon"] = 0,
	["vj_npc_plypickupdropwep"] = 0,
}

function setupVJ()
	for k,v in pairs(VJConvars) do
		RunConsoleCommand(k,tostring(v))
	end
end

function optimizeVJ()
	local count = #player.GetAll()
	RunConsoleCommand("vj_npc_processtime", 1 + (count/40))
end

function cleanupEmptyStorages()
	for _,v in pairs(ents.GetAll()) do
		if v:GetClass() == "nut_storage" then
			v:Remove()
		end
	end
end

local vjThink = 0
hook.Add("Think", "sfgsdfhgdghrftghjdfghj", function()
	if vjThink <= CurTime() then
		setupVJ()
		optimizeVJ()
		vjThink = CurTime() + 180
	end
end)
