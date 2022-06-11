AddCSLuaFile()
local blakc =  Vector(1,1,1)
matproxy.Add( {
	name = "skincolor",
	init = function( self, mat, values )
	 self.ResultTo = values.resultvar
	end,
	bind = function( self, mat, ent )
		local c = ent.player and  ent.player.skincolor or blakc

		mat:SetVector(self.ResultTo, c)
	end
} )