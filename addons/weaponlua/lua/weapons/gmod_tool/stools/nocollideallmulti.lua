TOOL.Category		= "Constraints"
TOOL.Name			= "#No-Collide All Multi"
TOOL.Command		= nil
TOOL.ConfigName		= ""

TOOL.ClientConVar[ "freeze" ] = 1
TOOL.ClientConVar[ "on" ] = 1
TOOL.ClientConVar[ "base" ] = 0

if ( CLIENT ) then
    language.Add( "tool.nocollideallmulti.name", "Multi No-Collide All tool" )
    language.Add( "tool.nocollideallmulti.desc", "No-Collide All one or multiple props. You can also No-Collide everything just to what you are looking at" )
    language.Add( "tool.nocollideallmulti.0", "Primary: Select a prop to No-Collide. (Use to select all) Secondary: Confirm No-Collide. Reload: Clear Targets." )
end
 
TOOL.enttbl = {}
TOOL.data = {}
local group

local function SetGroup(_,Entity,Data)
	if not Data.Group then return false end
	Entity:SetCollisionGroup(Data.Group)
	duplicator.StoreEntityModifier( Entity, "nocollideall" , Data)
end
duplicator.RegisterEntityModifier( "nocollideall", SetGroup )

function TOOL:LeftClick(Trace)
	if CLIENT then return true end
	local ent = Trace.Entity
	
	local freeze = self:GetClientNumber( "freeze" )
	local onoff = self:GetClientNumber( "on" )
	local nocollidetobase = self:GetClientNumber( "base" )
	
	if !ent:IsValid() or ent:IsPlayer() or ent:IsWorld() then return false end
	
	if (ent:IsValid() and !ent:IsPlayer() and !ent:IsWorld() and !self:GetOwner():KeyDown(IN_USE)) then
		ind = ent:EntIndex()
		local col = Color(0,0,0,0)
		col = ent:GetColor()
		self.enttbl[ind] = col
		ent:SetColor(Color(40,255,0,150))
		ent:SetRenderMode(RENDERMODE_TRANSALPHA)
	end
	
	if (ent:IsValid() and !ent:IsPlayer() and !ent:IsWorld() and self:GetOwner():KeyDown(IN_USE)) then
		for k,v in pairs(constraint.GetAllConstrainedEntities(ent)) do
			eind = v:EntIndex()
			if !self.enttbl[eind] then
				local col = Color(0,0,0,0)
				col = v:GetColor()
				self.enttbl[eind] = col
				v:SetColor(Color(40,255,0,150))
				v:SetRenderMode(RENDERMODE_TRANSALPHA)
			end
		end
	end
	return true
end

function TOOL:RightClick(trace)
	if CLIENT then return true end
	if table.Count(self.enttbl) < 1 then return end
	
	local freeze = self:GetClientNumber( "freeze" )
	local onoff = self:GetClientNumber( "on" )
	local nocollidetobase = self:GetClientNumber( "base" )
	
	local ent = trace.Entity
	
	for k,v in pairs(self.enttbl) do
		local prop = ents.GetByIndex(k)
		if IsValid(prop) then
			prop:SetColor(Color(v.r,v.g,v.b,v.a))
			if onoff == 1 then
				group = COLLISION_GROUP_WORLD
			end
			if onoff == 0 then
				group = COLLISION_GROUP_NONE
			end	
			SetGroup(_,prop,{Group = group})
			
			if nocollidetobase == 1 and ent:IsValid() and !ent:IsWorld() then
				local constraint = constraint.NoCollide(ent,prop,0,0)
				undo.Create("No-collide to base")
					undo.AddEntity( constraint )
					undo.SetPlayer( self:GetOwner() )
				undo.Finish()
			end
			if freeze == 1 then
				phys = prop:GetPhysicsObject()
				if phys:IsMoveable() then
					phys:EnableMotion(false)
					phys:Wake()
				end
			end
			if freeze == 0 then
				phys = prop:GetPhysicsObject()
				phys:EnableMotion(true)
				phys:Wake()
			end
		end
	end
	self.enttbl = {}
	return true
end


function TOOL:Reload()
	if table.Count(self.enttbl) < 1 then return end
	
	for k,v in pairs(self.enttbl) do
		local prop = ents.GetByIndex(k)
		if (IsValid(prop)) then
			prop:SetColor(Color(v.r,v.g,v.b,v.a))
			self.enttbl[k] = nil
		end 
	end
	self.enttbl = {}
	return true
end

function TOOL.BuildCPanel(Panel)
	Panel:AddControl("Header",{Text = "#nocollideallmulti.name", Description	= "No-Collide All one or multiple props. You can also No-Collide everything just to what you are looking at"})	
	Panel:AddControl("CheckBox", {Label = "On or Off", Description ="No-Collide all or don't NO-Collide all the props", Command = "nocollideallmulti_on"})
	Panel:AddControl("CheckBox", {Label = "Freeze or Unfreeze", Description ="Freeze or UnFreeze the props", Command = "nocollideallmulti_freeze"})
	Panel:AddControl("CheckBox", {Label = "No-Collide to Base", Description ="No-Collide to what you are looking at", Command = "nocollideallmulti_base"})
end