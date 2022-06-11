
TOOL.Category		= "Constraints"
TOOL.Name			= "Multi-Parent"
TOOL.Command		= nil
TOOL.ConfigName		= ""

if ( CLIENT ) then
    language.Add( "tool.multi_parent.name", "Multi-Parent Tool" )
    language.Add( "tool.multi_parent.desc", "Parent multiple props to one prop." )
    language.Add( "tool.multi_parent.0", "Primary: Select a prop to Parent. (Use to select all) Secondary: Parent all selected props to prop. Reload: Clear Targets." )
end

TOOL.enttbl = {}

function TOOL:LeftClick( trace )

	if (CLIENT) then return true end
	if (trace.Entity:IsValid()) and (trace.Entity:IsPlayer()) then return end
	if ( SERVER && !util.IsValidPhysicsObject( trace.Entity, trace.PhysicsBone ) ) then return false end
	if (trace.Entity:IsWorld()) then return false end
	
	local ent = trace.Entity
	if (self:GetOwner():KeyDown(IN_USE)) then
		for k,v in pairs(constraint.GetAllConstrainedEntities(ent)) do
			local eid = v:EntIndex()
			if not (self.enttbl[eid]) then
				local col = Color(0,0,0,0)
				col  = v:GetColor()
				self.enttbl[eid] = col
				v:SetColor(Color(0,255,0,100))
				v:SetRenderMode(RENDERMODE_TRANSALPHA)
			else
				local col = self.enttbl[eid]
				v:SetColor(col)
				self.enttbl[eid] = nil
			end
		end
	else
		local eid = ent:EntIndex()
		if not (self.enttbl[eid]) then
			local col = Color(0,0,0,0)
			col = ent:GetColor()
			self.enttbl[eid] = col
			ent:SetColor(Color(0,255,0,100))
			ent:SetRenderMode(RENDERMODE_TRANSALPHA)
		else
			local col = self.enttbl[eid]
			ent:SetColor(col)
			self.enttbl[eid] = nil
		end
	end

	
	return true
end

function TOOL:RightClick( trace )

	if (CLIENT) then return true end
	if (table.Count(self.enttbl) < 1) then return end
	if (trace.Entity:IsValid()) and (trace.Entity:IsPlayer()) then return end
	if ( SERVER && !util.IsValidPhysicsObject( trace.Entity, trace.PhysicsBone ) ) then return false end
	if (trace.Entity:IsWorld()) then return false end
	
	local ent = trace.Entity
	for k,v in pairs(self.enttbl) do
	PrintTable(self.enttbl)
		local prop = ents.GetByIndex(k)
		if (prop:IsValid()) then
			local phys = prop:GetPhysicsObject()
			if phys:IsValid() then
				constraint.NoCollide(prop,ent,0,0)
				phys:EnableCollisions(true)
				phys:EnableMotion(true)
				phys:Sleep()
				local col = Color(v.r,v.g,v.b,v.a)
				prop:SetColor(col)
				prop:SetParent(ent)
				self.enttbl[k] = nil
			end
		end
	end
	self.enttbl = {}
	return true
end

function TOOL:Reload()
	if (CLIENT) then return false end
	if (table.Count(self.enttbl) < 1) then return end
	for k,v in pairs(self.enttbl) do
		local prop = ents.GetByIndex(k)
		if (prop:IsValid()) then
			prop:SetColor(Color(v.r,v.g,v.b,v.a))
			self.enttbl[k] = nil
		end
	end
	self.enttbl = {}
	return true
end

