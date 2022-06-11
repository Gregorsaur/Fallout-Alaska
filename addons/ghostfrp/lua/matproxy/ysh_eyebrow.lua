AddCSLuaFile()
local blakc =  Vector(0.1,0.1,0.1)
matproxy.Add( {
	name = "eye_brow",
	init = function( self, mat, values )
	 self.ResultTo = values.resultvar
	end,
	bind = function( self, mat, ent )
		local c = ent.eyelash or blakc
		
		mat:SetVector(self.ResultTo, c)
	end
} )