AddCSLuaFile()
ENT.Spawnable = true
ENT.Type = "anim"
ENT.Base = "base_lootable"
ENT.PrintName = "Loot Example"
ENT.Author = "Ev"
ENT.LootName = "Loot Example"
ENT.RespawnCycle = 300
ENT.mdl = "error.mdl"
--[[
local commoninventories = {self.CommonInventory, self.CommonInventory2, self.CommonInventory3, self.CommonInventory4}

local uncommoninventories = {self.UncommonInventory, self.UncommonInventory2, self.UncommonInventory3, self.UncommonInventory4}

local epicinventories = {self.EpicInventory, self.EpicInventory2, self.EpicInventory3, self.EpicInventory4}

local legendaryinventories = {self.LegendaryInventory, self.LegendaryInventory2, self.LegendaryInventory3, self.LegendaryInventory4}

local listingcommon = math.random(1, table.getn(commoninventories))
local listinguncommon = math.random(1, table.getn(uncommoninventories))
local listingepic = math.random(1, table.getn(epicinventories))
local listinglegendary = math.random(1, table.getn(legendaryinventories))

function ENT:generateLoot()
    self.CommonInventory = {"food_dirtywater|1", "cumsock|1"}

    self.CommonInventory2 = {"food_dirtywater|1", "cumsock|1"}

    self.CommonInventory3 = {"food_dirtywater|1", "cumsock|1"}

    self.CommonInventory4 = {"food_dirtywater|1", "cumsock|1"}

    self.UncommonInventory = {"food_dirtywater|1", "cumsock|1"}

    self.UncommonInventory2 = {"food_dirtywater|1", "cumsock|1"}

    self.UncommonInventory3 = {"food_dirtywater|1", "cumsock|1"}

    self.UncommonInventory4 = {"food_dirtywater|1", "cumsock|1"}

    self.EpicInventory = {"food_dirtywater|1", "cumsock|1"}

    self.EpicInventory2 = {"food_dirtywater|1", "cumsock|1"}

    self.EpicInventory3 = {"food_dirtywater|1", "cumsock|1"}

    self.EpicInventory4 = {"food_dirtywater|1", "cumsock|1"}

    self.LegendaryInventory = {"food_dirtywater|1", "cumsock|1"}

    self.LegendaryInventory2 = {"food_dirtywater|1", "cumsock|1"}

    self.LegendaryInventory3 = {"food_dirtywater|1", "cumsock|1"}

    self.LegendaryInventory4 = {"food_dirtywater|1", "cumsock|1"}

    -- Uncommon
    if math.random(1, 100) == 1 then    -- 1%
        -- Legendary 
        table.insert(commoninventories[listingcommon], legendaryinventories[listinglegendary])
    elseif math.random(1, 100) <= 10 then
        -- Epic
        table.insert(commoninventories[listingcommon], epicinventories[listingepic])
    elseif math.random(1, 100) <= 25 then
        table.insert(commoninventories[listingcommon], uncommoninventories[listinguncommon])
    else
        -- Normal
        table.insert(commoninventories[listingcommon])
    end
end
]]