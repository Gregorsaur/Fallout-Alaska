AddCSLuaFile()
local blakc =  Vector(0.1,0.5,0.1)

local eyecolors = {
	"eye_brown",
	"eye_blue",
	"eyecoloured3",
	"eye_dichromatic",
	"eyecoloured1",
	"eyecoloured2",
	"models/lazarusroleplay/humans/shared/skin/ghoul/eyes/eye_ghoul"

}

local istruepath = {}

istruepath[7] = true
 
matproxy.Add( {
	name = "eye_color",
	init = function( self, mat, values )
	 self.ResultTo = values.resultvar
	end,
	bind = function( self, mat, ent )
	ent.eyecolor = (ent and (ent.eyecolor or 1)) or 1
	local s = (istruepath[ent.eyecolor] and eyecolors[ent.eyecolor] or ("models/yshera/shared/" .. (eyecolors[ent.eyecolor] or "" )))
		local c = ( s or "" ) .. ".vtf"

		mat:SetTexture(self.ResultTo, c)
	end
} )





