AddCSLuaFile()
print("FAKE bonem")
ENT.Type = "anim"
--ENT.RenderGroup = RENDERGROUP_OTHER
local materials = {}
local suffix = "sgaxxaxxx"

function ENT:PrepareMaterial(mat, i)
    local shader = "VertexLitGeneric"
    local params = util.KeyValuesToTable(file.Read("materials/" .. mat .. ".vmt", "GAME")) or {}
    params.Proxies = params.proxies or {}
    print("parent", self.p)
    self.p = self:GetOwner()
    params["$cloakpassenabled"] = 1
    params["$cloakfactor"] = 1
    params.Proxies["PlayerCloak2"] = {}
    print(mat .. "-clxoaked")
    materials[mat] = CreateMaterial(mat .. suffix, shader, params)
    self:SetSubMaterial(i, mat .. suffix)
end

ENT.RenderGroup = 7

function ENT:Initialize()
    self.Materials = {}
end

local function Draw3DText(pos, ang, scale, text, flipView)
    if flipView then
        -- Flip the angle 180 degrees around the UP axis
        ang:RotateAroundAxis(Vector(0, 0, 1), 180)
    end

    cam.Start3D2D(pos, ang, scale)
    -- Actually draw the text. Customize this to your liking.
    draw.DrawText(text, "Default", 0, 0, Color(0, 255, 0, 255), TEXT_ALIGN_CENTER)
    cam.End3D2D()
end

function ENT:DrawTranslucent()
end

hook.Add("PrePlayerDraw", "HideNoclip", function(parent)
    parent.visible = parent:GetMoveType() == MOVETYPE_NOCLIP and not parent:InVehicle() 
	-- is parent, in PVS 

    if parent.visible then return true end
end)

-- PreWorld
hook.Add("PreDrawOpaqueRenderables", "HideNoclip", function(parent)
    local parent = LocalPlayer()
    parent.visible = parent:GetMoveType() == MOVETYPE_NOCLIP and not parent:InVehicle()

    if parent == LocalPlayer() and not parent:ShouldDrawLocalPlayer() then
        parent.visible = true
    end
end)

function ENT:Draw(flags)
    --render.MaterialOverrideByIndex()
    -- get the owner of the entity
    local parent = self.whomOwns or self:GetParent()
	-- if parent == nil or it exists but IsEffectActive(ef_followbone) then return end
	if parent == nil or parent:IsValid() == false then return end
    --print(self:GetModel(), parent)
    if not parent.visible then
        self:DrawModel(flags)
    end
end

matproxy.Add{
    name = "PlayerCloak2",
    init = function() end,
    bind = function(self, mat, ent)
        --if not IsValid( ent ) or not ent.CloakFactor then return end 
        print("nige")
        mat:SetFloat("$cloakfactor", 1)
    end
}