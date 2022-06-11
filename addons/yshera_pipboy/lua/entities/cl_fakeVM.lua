AddCSLuaFile()
print("FAKE VM")
ENT.Type = "anim"

ENT.RenderGroup = RENDERGROUP_OTHER

function ENT:Initialize()



end

function ENT:DoSetup( ply, spec )


end

function ENT:GetPlayerColor()


end

function ENT:ViewModelChanged( vm, old, new )


end

function ENT:AttachToViewmodel( vm )

	self:AddEffects( EF_BONEMERGE )
	self:SetParent( vm )
	self:SetMoveType( MOVETYPE_NONE )

	self:SetPos( vector_origin )
	self:SetAngles( angle_zero )

end