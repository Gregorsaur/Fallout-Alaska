AddCSLuaFile()
DEFINE_BASECLASS("base_anim")
ENT.Spawnable = true

function ENT:Initialize()
    self:SetModel("models/zerochain/props_mining/zrms_melter.mdl")
    -- wake up the physics
    self:PhysicsInit(SOLID_VPHYSICS)
    -- set the physics type to be launched
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)

    if SERVER then
        self:SetUseType(SIMPLE_USE)
    end
	self.rot = 0 
end

function ENT:Use(ply)
    -- open up miner UI
    netstream.Start(ply, "miner_openui")
end

netstream.Hook("miner_openui", function(ply)
    MINERS:CreateUI(ply)
end)

function ENT:Draw()
    if CLIENT then
        self:DrawModel()
        -- Is Local Player looking at me?
			local ang = Lerp(FrameTime()*15, self.rot ,  LocalPlayer():GetEyeTrace().Entity == self and LocalPlayer():GetPos():Distance(self:GetPos()) < 100 and -35 or 0)
			self:ManipulateBoneAngles(7, Angle(0,0,ang))
			self.rot = ang
			--print(ang)
    end
end