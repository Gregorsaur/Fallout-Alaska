RECIPES = RECIPES or {}
RECIPES.Categories = {}
RECIPES.IDToCategory = {}
RECIPES.NumericalPath = {}
RECIPES.craftingIDToNumber = {}
local meta = {}
local metaIndex = {}
meta.__index = metaIndex
local itemIDN = 0
local institute = {}
--
-- Here we get a callback from the game/client code on Lua errors, and display a nice notification.
--
-- This should help `newbs` find out which addons are crashing.
--
 print("CRAFTING INIT") 
function RECIPES:AddItemToCategory(category, craftingID, itemID, matsRequired, amt, skills,unlocked)
    local shouldIncrement = true 
    local UID = itemIDN
	if nut.item.list[itemID] == nil then 
		MsgC(Color(255,255,0),"[CRAFTING] ",Color(255,0,0), "INVALID ITEM ID: " , Color(255,255,255), itemID ,"\n")
		return 
	end
    if RECIPES.craftingIDToNumber[craftingID] then
        shouldIncrement = false
        UID = RECIPES.craftingIDToNumber[craftingID]
    end

    RECIPES.Categories[category] = RECIPES.Categories[category] or {}

    RECIPES.Categories[category][UID] = {itemID, matsRequired, amt or 1, skills,unlocked}

    RECIPES.Categories[category][UID].id = UID
    RECIPES.craftingIDToNumber[craftingID] = UID
    RECIPES.NumericalPath[UID] = craftingID 
    setmetatable(RECIPES.Categories[category][UID], meta)
    RECIPES.IDToCategory[craftingID] = category
    RECIPES.IDToCategory[UID] = category

    if shouldIncrement then
        itemIDN = itemIDN + 1
    end
end

function RECIPES:GetItemForNumericalID(x)
    return RECIPES.NumericalPath[x]
end

function RECIPES:GetItemWithID(x)
	print(x)
	local rec = RECIPES.Categories[self:GetItemCategory(x)]
	print ("REC:",rec,"ITEMCATEGORY",self:GetItemCategory(x),"X",x)
	--if rec then hook.Run("RECIPES_Add") return RECIPES:GetItemWithID(x) end 
    return rec [x]
end

function metaIndex:GetName()
	local i = nut.item.list[self[1]]
    return i and i.name or self[1] .. "ERROR"
end

function metaIndex:GetSkillRequired()
    return self[4][1]
end

function metaIndex:GetRegantName(i)
    return nut.item.list[self[2][i][1]].name
end

function metaIndex:GetRegantAmount(i)
    return self[2][i][2]
end

function metaIndex:GetRegantID(i)
    return self[2][i][1]
end

function RECIPES:GetAllItemsFromCategoryRaw(c)
    return RECIPES.Categories[c]
end

function RECIPES:GetItemCategory(x)
    return RECIPES.IDToCategory[x]
end

function RECIPES:GetAllItemsFromCategory(c)
    return RECIPES.Categories[c]
end

RECIPES.CraftingTables = RECIPES.CraftingTables or {}
RECIPES.IsReadyToCreateCrafting = RECIPES.IsReadyToCreateCrafting or false
INTERACTABLE_OBJECT_TYPE_DATA_STORE = INTERACTABLE_OBJECT_TYPE_DATA_STORE or {}

function RECIPES:CreateCraftingTable(id, displayname, mdl, recipescategories, Interactable)
	print("UPDATE")
    if RECIPES.IsReadyToCreateCrafting then
        local ENT = scripted_ents.Get("crafting_station")
        ENT.Type = "anim" 
        ENT.Base = "crafting_station"
        ENT.PrintName = displayname and "Crafting Station " .. displayname or "Crafting Station - UNSET"
        ENT.Author = "Yshera"
        ENT.Spawnable = true
        ENT.AdminSpawnable = true
        ENT.Category = "Crafting"

        ENT.model = mdl
        local n = Interactable

        function ENT:Interactable()
            return n
        end

        ENT.Skills = type(recipescategories) == "string" and {recipescategories} or recipescategories

        -- ENT.Interactable = Interactable
        function ENT:Initialize()
            self:SetModel(self.model or "models/props_c17/furnitureStove001a.mdl") 
            self:SetMoveType(MOVETYPE_VPHYSICS)
            self:SetSolid(SOLID_VPHYSICS)

            if SERVER then
                self:SetUseType(SIMPLE_USE)
            end

            local phys = self:GetPhysicsObject()

            if phys:IsValid() then
                phys:Wake()
            end
        end

        function ENT:Use(activator, caller, type, value)
          
            if self:GetPos():DistToSqr(activator:GetPos()) < 10000 then
                net.Start("CRAFTING")
                net.WriteTable(self.Skills)
                net.Send(activator)
            end
        end

        function ENT:Draw()
            self:DrawModel()
            --halo.Add( {self}, Color(255,255,255), 0, 0, 2, true, true )
        end

        scripted_ents.Register(ENT, id)
    else
        RECIPES.CraftingTables[id] = {id, displayname, mdl, recipescategories, Interactable}
    end
end

hook.Add("PreDrawHalos", "CraftingTableInteract", function()
    local plyTrace = LocalPlayer():GetEyeTrace().Entity

    if plyTrace.Interactable and plyTrace:GetPos():DistToSqr(LocalPlayer():GetPos()) < 10000 then
        halo.Add({plyTrace}, pip_color, 5, 5, 5, true)
    end
end)

hook.Add("InitializedPlugins", "CreateTables", function()
    RECIPES.IsReadyToCreateCrafting = true
    print("INIT: CRAFTING")
    hook.Run("RECIPES_Add")

    if CLIENT then
        hook.Add("KeyPress", "RECFIXUI_FUC", function(ply, key)
            hook.Run("RECIPES_Add")
            print("REMOVED")
            hook.Remove("KeyPress", "RECFIXUI_FUC")
        end)
    end
end)
print("CRAFTING")
hook.Add("RECIPES_Add", "recipe02", function()
    RECIPES:CreateCraftingTable("crafting_medical", "Medical", "models/mosi/fallout4/furniture/workstations/chemistrystation01.mdl", {"Medical"}, {"Chemistry Station", "Use"})

    RECIPES:CreateCraftingTable("crafting_normal", "Crafting_Table", "models/mosi/fallout4/furniture/workstations/weaponworkbench01.mdl", {"Junk"}, {"Crafting Table", "Use"})

    RECIPES:CreateCraftingTable("crafting_armors", "Armor_Workshop", "models/mosi/fallout4/furniture/workstations/armorworkbench.mdl", {"Armor"}, {"Armor Workbench", "Use"})

    RECIPES:CreateCraftingTable("crafting_weapons", "Weapon_Workshop", "models/mosi/fallout4/furniture/workstations/weaponworkbench02.mdl", {"Weapons", "Ammo"}, {"Smithing Table", "Use"})

    RECIPES:CreateCraftingTable("crafting_cooking1", "Campfire", "models/mosi/fnv/props/workstations/campfire05.mdl", {"Cooking"}, {"Campfire With Stove", "Cook"})

    RECIPES:CreateCraftingTable("crafting_cooking2", "Campfire2", "models/mosi/fallout4/furniture/workstations/cookingstation02.mdl", {"Cooking"}, {"Campfire", "Cook"})

    RECIPES:CreateCraftingTable("crafting_cooking3", "Campfire3", "models/mosi/fallout4/furniture/workstations/cookingstation01.mdl", {"Cooking"}, {"Stove", "Cook"})
    RECIPES:CreateCraftingTable("crafting_cooking4", "Campfire4", "models/mosi/fallout4/furniture/workstations/cookingstation01.mdl", {"Cooking"}, {"Stove", "Cook"})
    RECIPES:AddItemToCategory("Cooking", "wb_crafting_radaway", "cookedroach", {
        {"rawroach", 1},

    })
	
		print("EE") 
    RECIPES:AddItemToCategory("Weapons", "tfa_fwp_piperevolver", "piprevolver", {
        {"scrap_wood", 4},
        {"box_of_screws", 4},
        {"box_of_springs", 4},
        {"ingot_of_steel", 8},
        {"roll_of_leather", 4},
        {"roll_of_rubber", 14}
    })

     RECIPES:AddItemToCategory("Weapons", "tfa_fwp_piperiflesemi", "SemiAutomaticPipeRifle", {
        {"scrap_wood", 4},
        {"box_of_screws", 4},
        {"box_of_springs", 2},
        {"ingot_of_steel", 4},
        {"roll_of_leather", 4},
        {"roll_of_rubber", 2}
    })

     RECIPES:AddItemToCategory("Weapons", "tfa_fwp_pipeboltscoped", "BoltActionPipeRiflescooped", {
        {"scrap_wood", 6},
        {"box_of_screws", 4},
        {"box_of_springs", 2},
        {"ingot_of_steel", 4},
        {"glass_fragments", 4},
        {"roll_of_leather", 2},
        {"roll_of_rubber", 2},
        {"BoltActionPipeRifle", 1}
    })

     RECIPES:AddItemToCategory("Weapons", "tfa_fwp_pipebolt", "BoltActionPipeRifle", {
        {"scrap_wood", 6},
        {"box_of_screws", 4},
        {"box_of_springs", 2},
        {"ingot_of_steel", 4},
        {"glass_fragments", 4},
        {"roll_of_leather", 6},
        {"roll_of_rubber", 2}
    })

     RECIPES:AddItemToCategory("Weapons", "handmaderifle", "handmaderifle", {
        {"scrap_wood", 12},
        {"box_of_screws", 12},
        {"box_of_springs", 8},
        {"ingot_of_steel", 16},
        {"roll_of_rubber", 4}
    })

     RECIPES:AddItemToCategory("Weapons", "huntingrifle", "huntingrifle", {
        {"scrap_wood", 8},
        {"box_of_screws", 6},
        {"box_of_springs", 8},
        {"ingot_of_steel", 8},
        {"roll_of_rubber", 1}
    })
     RECIPES:AddItemToCategory("Weapons", "huntingrifle", "huntingrifle2", {
        {"scrap_wood", 8},
        {"box_of_screws", 6},
        {"box_of_springs", 8},
        {"ingot_of_steel", 8},
        {"roll_of_rubber", 1}
    })
    --Armor

    RECIPES:AddItemToCategory("Armor", "leatherarmorpieces", "leatherarmorpieces", {
        {"box_of_screws", 1},
        {"ingot_of_steel", 1},
        {"roll_of_leather", 3},
        {"roll_of_rubber", 2}
    })
    RECIPES:AddItemToCategory("Armor", "leathercoat", "leathercoat", {
        {"box_of_screws", 2},
        {"ingot_of_steel", 3},
        {"roll_of_leather", 5},
        {"roll_of_rubber", 3}
    })
   -- RECIPES:AddItemToCategory("Armor", "Leathergear", "Leathergear", {
   --     {"box_of_screws", 1},
   --     {"ingot_of_steel", 3},
   --     {"roll_of_leather", 8},
   --     {"roll_of_rubber", 6}
   -- })
     
     
end)

print("READD")
hook.Run("RECIPES_Add")
timer.Simple(120,function() hook.Run("RECIPES_Add") end)