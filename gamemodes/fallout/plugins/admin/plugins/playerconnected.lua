PLUGIN.name = "Player Connected & Disconnected"
PLUGIN.author = "Barata"
PLUGIN.desc = "A plugin that shows a message in the chat wether a player has connected to the server or disconnected from it."

--[[
function PLUGIN:PlayerSpawn(ply)
	PrintMessage(HUD_PRINTTALK, ply:Name().." has connected from the server.")
end

function PLUGIN:PlayerDisconnected(client)
	PrintMessage(HUD_PRINTTALK, client:Name().." has disconnected from the server.")
end
]]
function PLUGIN:PlayerLoadout(ply)
    ply:SetEyeAngles(Angle(0, 0, 0))
end
