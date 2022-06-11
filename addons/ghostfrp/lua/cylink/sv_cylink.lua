util.AddNetworkString("WAYSHRINE")

function nzWAYSHRINES:GetWayShrinesInPhase(phase)
    self.Storage[id] = data
end

function nzWAYSHRINES:GetWayShrinesForPlayer(p)
    return self:GetWayShrinesInPhase(p.Phase)
end

hook.Add("InitPostEntity", "sv_wayshrineInt", function()
    netstream.Hook("wayshrine", function(ply, wayshrine)
        local w = nzWAYSHRINES.Storage[wayshrine]
        ply:SetPos(w[nzWAYSHRINE_STATE_TELEPORT_DEST]-Vector(0,0,72))
        
        netstream.Start(ply, "wayshrine", w[nzWAYSHRINE_STATE_TELEPORT_DEST_PHASE])
        ply:getChar():setData("phase", w[nzWAYSHRINE_STATE_TELEPORT_DEST_PHASE])
    end)
end)

hook.Add("PlayerDeath", "phase_reset", function(ply)
    netstream.Start(ply, "wayshrine", 0)
    ply:getChar():setData("phase", 0)
end)

hook.Add("PlayerLoadedChar", "phase_save_load", function(ply, char, lastchar)
    netstream.Start(ply, "wayshrine", char:getData("phase", 0))
end)


concommand.Add("debug_fallout_setstate", function( ply, cmd, args )
         netstream.Start(ply, "wayshrine", args[1])
        ply:getChar():setData("phase", args[1]) 
end)