--
-- This tool is the most important aspect of Garry's Mod
--

TOOL.Category		= "Construction"
TOOL.Name			= "#Leafblower"
TOOL.Command		= nil
TOOL.ConfigName		= nil
TOOL.LeftClickAutomatic = true

if CLIENT then
language.Add("tool.leafblower.name", "Leafblower Tool")
language.Add("tool.leafblower.desc", "WHIIIIIRRRRRRRRRRRRRRRRRRRRRRRR")
language.Add("tool.leafblower.0", "Left click to blow things away")
language.Add("tool.leafblower.force", "Blow Force")
language.Add("tool.leafblower.maxdistance", "Maximum Distance")
end

TOOL.ClientConVar["force"] = 32
TOOL.ClientConVar["maxdistance"] = 512

function TOOL:LeftClick( trace )

	if ( CLIENT ) then return end
	
	util.PrecacheSound( "ambient/wind/wind_hit2.wav" )
	self:GetOwner():EmitSound( "ambient/wind/wind_hit2.wav" )

	if ( trace.Entity:IsValid() ) then
	
		if ( trace.Entity:GetPhysicsObject():IsValid() ) then
		
			local phys = trace.Entity:GetPhysicsObject()		-- The physics object
			local direction = trace.StartPos - trace.HitPos		-- The direction of the force
			local force = self:GetClientNumber( "force" ) 		-- The ideal amount of force
			local distance = direction:Length()			-- The distance the phys object is from the gun
			local maxdistance = self:GetClientNumber( "maxdistance" )	-- The max distance the gun should reach
			
			-- Lessen the force from a distance
			local ratio = math.Clamp( (1 - (distance/maxdistance)), 0, 1 )
			
			-- Set up the 'real' force and the offset of the force
			local vForce = -1*direction * (force * ratio)
			local vOffset = trace.HitPos
			
			-- Apply it!
			phys:ApplyForceOffset( vForce, vOffset )
						
		end
		
	end

end

function TOOL.BuildCPanel( panel )	
	panel:AddControl( "Header", { Text = "#tool.leafblower.name", Description	= "#tool.leafblower.desc" }  )
	panel:AddControl( "Slider", { Label = "#tool.leafblower.force", Type = "Float", Command = "leafblower_force", Min = "0", Max = "256" }  )
	panel:AddControl( "Slider", { Label = "#tool.leafblower.maxdistance", Type = "Float", Command = "leafblower_maxdistance", Min = "0", Max = "1024" }  )
end