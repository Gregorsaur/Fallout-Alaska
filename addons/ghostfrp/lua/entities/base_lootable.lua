AddCSLuaFile()
ENT.Spawnable = true
ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Base Spawnable"
ENT.Author = "Ev/ ieLoot"
ENT.Contact = "FUCK OFF"
ENT.LootName = "Fridge"
ENT.RespawnCycle = 300
ENT.DoNotBurn = true
ENT.Category = "Fallout Flask: Looting"
function ENT:Initialize()
    self:SetModel(self.mdl or "models/props_fallout/nukafridge.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS) 
	self.items = LOOTABLE_OBJECTS_HASH[self:GetClass()]
    local phys = self:GetPhysicsObject()

    if (phys:IsValid()) then
        phys:Wake()
    end

    self.NextGeneration = RealTime() + math.random(1, 1)
    
   self:SetNW2String("n",  LOOTABLE_OBJECTS_DISPLAY_NAME[self:GetClass()])
    self:SetNW2Int("corpse", true)
     self:SetNW2String("corpse", util.TableToJSON({}))
end
 
function ENT:Draw()
    self:DrawModel() -- Draw the model.
end

local function GetValuesFromItemString(itemString)
    local arr_item_string = string.Explode(":",itemString)
    local itemPercentageChance = tonumber(arr_item_string[1]) 
    local itemId = (arr_item_string[2])
    -- since item range is seperated with a dash we need to split it.
    local itemRange = string.Explode( "-",arr_item_string[3] or "1-1")
    local itemMin = tonumber(itemRange[1])
    local itemMax = tonumber(itemRange[2])
    return itemPercentageChance, itemId, itemMin, itemMax
end
 

function ENT:generateLoot()
    self.Inventory = {} 
	local itm = LOOTABLE_OBJECTS_HASH[self:GetClass():lower()]
	if self.items == nil then self:Remove() return end
	for i,v in pairs(self.items ) do 
		local itemPercentageChance, itemId, itemMin, itemMax = GetValuesFromItemString(v)
		local chanceRoll = math.random(1,100)

		if chanceRoll <= itemPercentageChance then 

		table.insert(self.Inventory, itemId .."|" ..(math.random(itemMin or 1,itemMax or 1) or 1 ) )
	end
	end
	if #self.Inventory  == 0 then 
		self:generateLoot()
	end
end
 
function ENT:NetworkLoot()
     self:SetNW2String("n",  LOOTABLE_OBJECTS_DISPLAY_NAME[self:GetClass()] or "UNDEFINED")
    self:SetNW2Int("corpse", true)
    self:generateLoot()
    self:SetNW2String("corpse", util.TableToJSON(self.Inventory))
end
if SERVER then 
function ENT:Think()

    if RealTime() > (self.NextGeneration or 0) then 
    self:NetworkLoot()
    self.NextGeneration = RealTime() + self.RespawnCycle
    end

end
else 
function ENT:Think()


end
end

hook.Run("POPULATE_LOOTABLE")
NOCLIP_PARDON = CurTime() 

if CLIENT then 
local ply = LocalPlayer()
timer.Create( "PreventLootAfterNoclip", 1, 0, function() 
	if ply:GetMoveType() == MOVETYPE_NOCLIP then 
	NOCLIP_PARDON = CurTime()+-1
	end 
end)

end

 