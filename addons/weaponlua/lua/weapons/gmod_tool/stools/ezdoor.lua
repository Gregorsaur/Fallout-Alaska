
TOOL.Category = "#tool.ezdoor.name"
TOOL.Name = "#tool.ezdoor.name"
TOOL.Information = {
	{name = "left", stage = 0},
	{name = "left_1", stage = 1},
	{name = "right", stage = 1},
	{name = "reload"}
}

if (CLIENT) then
	language.Add("tool.ezdoor.name", "EZ Door")
	language.Add("tool.ezdoor.desc", "Pair two doors together for teleporting")
	language.Add("tool.ezdoor.left", "Left click on a door to begin pairing operation")
	language.Add("tool.ezdoor.left_1", "Left click on another door to pair doors")
	language.Add("tool.ezdoor.right", "Right click to restart door pairing operation")
	language.Add("tool.ezdoor.reload", "Reload to remove door pairing")
end

--[[-------------------------------------------------------------------------
Purpose: Set sisters
---------------------------------------------------------------------------]]
function TOOL:LeftClick(trace)
	if trace.Entity:GetClass() != "sent_ezdoor" then return false end

	-- Make sure our entites are always valid
	if self:NumObjects() > 0 then
		for i = 1, self:NumObjects() do
			if not IsValid(self:GetEnt(i)) then
				self:ClearObjects()
			end
		end
	end

	if self:NumObjects() == 0 then
		self:SetObject(1, trace.Entity, trace.Entity:GetPos(), trace.Entity:GetPhysicsObject(), 0, trace.Entity:GetPos():GetNormalized())
	elseif self:NumObjects() == 1 and self:GetEnt(1) != trace.Entity then
		self:SetObject(2, trace.Entity, trace.Entity:GetPos(), trace.Entity:GetPhysicsObject(), 0, trace.Entity:GetPos():GetNormalized())

		-- Remove any previous sisters
		for i = 1, 2 do
			if self:GetEnt(i):HasSister() then
				EZDoor:FindByID(self:GetEnt(i):GetSister()):RemoveSister()
			end
		end

		self:GetEnt(1):SetSister(self:GetEnt(2):GetID())
		self:GetEnt(2):SetSister(self:GetEnt(1):GetID())

		self:ClearObjects()
	end

	self:SetStage(self:NumObjects())

	return true
end

--[[-------------------------------------------------------------------------
Purpose: Reset setting sisters
---------------------------------------------------------------------------]]
function TOOL:RightClick(trace)
	self:ClearObjects()
end

--[[-------------------------------------------------------------------------
Purpose: Reset the door
---------------------------------------------------------------------------]]
function TOOL:Reload(trace)
	if trace.Entity:GetClass() != "sent_ezdoor" then return false end

	local sisterEnt = EZDoor:FindByID(trace.Entity:GetSister())
	if IsValid(sisterEnt) then
		sisterEnt:RemoveSister()
	end

	trace.Entity:RemoveSister()

	return true
end

function TOOL:Think()
	local mdl = "models/maxofs2d/cube_tool.mdl"
	local ent = self:GetOwner():GetEyeTrace().Entity

	if IsValid(ent) then
		if ent:GetClass() == "sent_ezdoor" then
			self:MakeGhostEntity(mdl, ent:TeleportVec(true), ent:TeleportAng(true))

			if IsValid(self.GhostEntity) then
				self.GhostEntity:SetBodygroup(1, 1)
				self.GhostEntity:SetModelScale(0.5)
			end
		end
	else
		self:ReleaseGhostEntity()
	end
end

if (CLIENT) then
	function TOOL:DrawHUD()
		-- Create connection line
		if self:NumObjects() == 1 and IsValid(self:GetEnt(1)) then
			local thisEntPos = self:GetEnt(1):LocalToWorld(self:GetEnt(1):OBBCenter()):ToScreen()
			local cursorX, cursorY = input.GetCursorPos()

			surface.DrawLine(thisEntPos.x, thisEntPos.y, cursorX, cursorY)
		end

		local traceEntity = LocalPlayer():GetEyeTrace().Entity
		if not IsValid(traceEntity) then return end
		if traceEntity:GetClass() != "sent_ezdoor" then return end

		-- Show its connection via line
		local sisterEnt = EZDoor:FindByID(traceEntity:GetSister())
		if IsValid(sisterEnt) then
			local thisEntPos = traceEntity:LocalToWorld(traceEntity:OBBCenter()):ToScreen()
			local thatEntPos = sisterEnt:LocalToWorld(sisterEnt:OBBCenter()):ToScreen()

			surface.DrawLine(thisEntPos.x, thisEntPos.y, thatEntPos.x, thatEntPos.y)
		end

		-- Draw bounding box if it uses trigger bounds
		if traceEntity:GetUseTriggerBounds() then
			local centerPos = traceEntity:LocalToWorld(traceEntity:OBBCenter())
			color = Color(0, 255, 0)
			for _, ent in ipairs(ents.FindInSphere(centerPos, traceEntity:GetDistanceToUse())) do
				if ent == self.GhostEntity then
					color = Color(255, 0, 0)
					break
				end
			end
			cam.Start3D()
				render.DrawWireframeSphere(centerPos, traceEntity:GetDistanceToUse(), 12, 12, color)
			cam.End3D()
		end
	end
end