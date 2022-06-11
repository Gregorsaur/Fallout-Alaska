AddCSLuaFile()
local blakc = Vector(0.1, 0.5, 0.1)

matproxy.Add({
    name = "makeup",
    init = function(self, mat, values)
        self.ResultTo = values.resultvar
    end,
    bind = function(self, mat, ent)
        local c = ent.eyecolorTex or "models/yshera/solesurvivor_vault111_female/textures/face_markings/" .. (ent.marking or 0)
        mat:SetFloat("$detailblendfactor", 1)
        mat:SetTexture(self.ResultTo, c)
    end
})

local suits = {"models/yshera/solesurvivor_vault111_female/textures/vault111number_d", "models/yshera/solesurvivor_vault111_female/textures/vault92number_d", "models/yshera/solesurvivor_vault111_female/textures/vault102number_d"}
local suitsN = {"models/yshera/solesurvivor_vault111_female/textures/vault111number_n", "models/yshera/solesurvivor_vault111_female/textures/vault92number_n", "models/yshera/solesurvivor_vault111_female/textures/vault102number_n"}

matproxy.Add({
    name = "suitnumber",
    init = function(self, mat, values)
        self.ResultTo = values.resultvar
    end,
    bind = function(self, mat, ent)
		local c=  ent.numbersuit or 1
        mat:SetTexture(self.ResultTo,  suits[c])
		mat:SetTexture("$bumpmap", suitsN[c] )
    end
})

local skin =  Vector(3,3,3)

matproxy.Add({
    name = "skincolor",
    init = function(self, mat, values)
        self.ResultTo = values.resultvar
    end,
    bind = function(self, mat, ent)
        local c = ent.skintint or skin
        mat:SetVector(self.ResultTo, c)
    end
})