

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
--
print("CRAFTING INIT")

function RECIPES:AddItemToCategory(category, craftingID, itemID, matsRequired, amt, skills, unlocked)
    local shouldIncrement = true
    local UID = itemIDN
 
    if nut.item.list[itemID] == nil then
        MsgC(Color(255, 255, 0), "[CRAFTING] ", Color(255, 0, 0), "INVALID ITEM ID: ", Color(255, 255, 255), itemID, "\n")

        return
    end

    if RECIPES.craftingIDToNumber[craftingID] then
        shouldIncrement = false
        UID = RECIPES.craftingIDToNumber[craftingID]
    end

    RECIPES.Categories[category] = RECIPES.Categories[category] or {}

    RECIPES.Categories[category][UID] = {itemID, matsRequired, amt or 1, skills, unlocked}

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
    print("REC:", rec, "ITEMCATEGORY", self:GetItemCategory(x), "X", x)
    --if rec then hook.Run("RECIPES_Add") return RECIPES:GetItemWithID(x) end 

    return rec[x]
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
            if self:GetPos():DistToSqr(activator:GetPos()) < 6000 then
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

    if plyTrace.Interactable and plyTrace:GetPos():DistToSqr(LocalPlayer():GetPos()) < 6000 then
        halo.Add({plyTrace}, pip_color, 5, 5, 5, true)
    end
end)

hook.Add("InitializedPlugins", "zzzzzzCreateTables2", function()
    RECIPES.IsReadyToCreateCrafting = true
 
       timer.Simple(FrameTime(),function() hook.Run("RECIPES_Add") end) 

       timer.Simple(30,function() hook.Run("RECIPES_Add") end)
        if CLIENT then
        hook.Add("KeyPress", "RECFIXUI_FUC", function(ply, key)
            hook.Run("RECIPES_Add")
            print("REMOVED")
            hook.Remove("KeyPress", "RECFIXUI_FUC")
        end)
    end
end) 

hook.Add("RECIPES_Add", "recipe02", function()
    if nut == nil then return end
    RECIPES.IsReadyToCreateCrafting = true
    RECIPES:CreateCraftingTable("crafting_medical", "Medical", "models/mosi/fallout4/furniture/workstations/chemistrystation01.mdl", {"Medical"}, {"Chemistry Station", "Use"})

    RECIPES:CreateCraftingTable("crafting_normal", "Crafting_Table", "models/mosi/fallout4/furniture/workstations/weaponworkbench01.mdl", {"Junk"}, {"Crafting Table", "Use"})

    RECIPES:CreateCraftingTable("crafting_armors", "Armor_Workshop", "models/mosi/fallout4/furniture/workstations/armorworkbench.mdl", {"Armor", "HeadGear"}, {"Armor Workbench", "Use"})

    RECIPES:CreateCraftingTable("crafting_weapons", "Weapon_Workshop", "models/mosi/fallout4/furniture/workstations/weaponworkbench02.mdl", {"Sniper", "Rifle", "Shotgun", "Side Arm", "Melee", "Ammo",}, {"Smithing Table", "Use"})

    RECIPES:CreateCraftingTable("crafting_cooking1", "Campfire", "models/mosi/fnv/props/workstations/campfire05.mdl", {"Cooking"}, {"Campfire With Stove", "Cook"})

    RECIPES:CreateCraftingTable("crafting_cooking2", "Campfire2", "models/mosi/fallout4/furniture/workstations/cookingstation02.mdl", {"Cooking"}, {"Campfire", "Cook"})

    RECIPES:CreateCraftingTable("crafting_cooking3", "Campfire3", "models/mosi/fallout4/furniture/workstations/cookingstation01.mdl", {"Cooking"}, {"Stove", "Cook"})

    RECIPES:CreateCraftingTable("crafting_cooking4", "Campfire4", "models/mosi/fallout4/furniture/workstations/cookingstation01.mdl", {"Cooking"}, {"Stove", "Cook"})

    RECIPES:CreateCraftingTable("crafting_furnace", "Furnace", "models/zerochain/props_mining/zrms_melter.mdl", {"Smelt"}, {"Smelting Furnace", "Use"})
    
    RECIPES:AddItemToCategory("Cooking", "wb_crafting_radaway", "cookedroach", {
        {"rawroach", 1},
    })



    RECIPES:AddItemToCategory("Side Arm", "tfa_fwp_piperevolver", "piprevolver", {
        {"scrap_wood", 4},
        {"box_of_screws", 4},
        {"box_of_springs", 4},
        {"ingot_of_steel", 8},
        {"roll_of_leather", 4},
        {"roll_of_rubber", 14}
    })

    RECIPES:AddItemToCategory("Rifle", "tfa_fwp_piperiflesemi", "SemiAutomaticPipeRifle", {
        {"scrap_wood", 4},
        {"box_of_screws", 4},
        {"box_of_springs", 2},
        {"ingot_of_steel", 4},
        {"roll_of_leather", 4},
        {"roll_of_rubber", 2}
    })

    RECIPES:AddItemToCategory("Sniper", "tfa_fwp_pipeboltscoped", "BoltActionPipeRiflescooped", {
        {"scrap_wood", 6},
        {"box_of_screws", 4},
        {"box_of_springs", 2},
        {"ingot_of_steel", 4},
        {"glass_fragments", 4},
        {"roll_of_leather", 2},
        {"roll_of_rubber", 2},
        {"BoltActionPipeRifle", 1}
    })

    RECIPES:AddItemToCategory("Rifle", "tfa_fwp_pipebolt", "BoltActionPipeRifle", {
        {"scrap_wood", 6},
        {"box_of_screws", 4},
        {"box_of_springs", 2},
        {"ingot_of_steel", 4},
        {"glass_fragments", 4},
        {"roll_of_leather", 6},
        {"roll_of_rubber", 2}
    })

    RECIPES:AddItemToCategory("Rifle", "handmaderifle", "handmaderifle", {
        {"scrap_wood", 12},
        {"box_of_screws", 12},
        {"box_of_springs", 8},
        {"ingot_of_steel", 16},
        {"roll_of_rubber", 4}
    })

    RECIPES:AddItemToCategory("Rifle", "huntingrifle", "huntingrifle", {
        {"scrap_wood", 8},
        {"box_of_screws", 6},
        {"box_of_springs", 8},
        {"ingot_of_steel", 8},
        {"roll_of_rubber", 1}
    })

    RECIPES:AddItemToCategory("Rifle", "lrsmg", "lrsmg", {
        {"scrap_wood", 34},
        {"box_of_screws", 23},
        {"box_of_springs", 17},
        {"ingot_of_steel", 14},
        {"roll_of_rubber", 19}
    })

    RECIPES:AddItemToCategory("Rifle", "laserrifle", "laserrifle", {
        {"circuitry", 34},
        {"box_of_screws", 23},
        {"box_of_springs", 17},
        {"ingot_of_aluminum", 17},
        {"glass_fragments", 16},
        {"spool_of_fiberglass", 15},
        {"spool_of_fiber_optics", 15},
        {"fuse", 1}
    })

    RECIPES:AddItemToCategory("Rifle", "plasmarifle", "plasmarifle", {
        {"circuitry", 37},
        {"box_of_screws", 29},
        {"box_of_springs", 19},
        {"ingot_of_aluminum", 19},
        {"glass_fragments", 19},
        {"spool_of_fiberglass", 18},
        {"spool_of_fiber_optics", 17},
        {"fusion_core", 8} -- replace with nuclear canisters
    })

    RECIPES:AddItemToCategory("Side Arm", "plasmapistol", "plasmapistol", {
        {"circuitry", 6},
        {"box_of_screws", 7},
        {"box_of_springs", 9},
        {"ingot_of_aluminum", 9},
        {"glass_fragments", 9},
        {"spool_of_fiberglass", 8},
        {"spool_of_fiber_optics", 7},
        {"fusion_core", 4} -- replace with nuclear canisters
    })

    RECIPES:AddItemToCategory("Side Arm", "laserpistol", "laserpistol", {
        {"circuitry", 4},
        {"box_of_screws", 3},
        {"box_of_springs", 7},
        {"ingot_of_aluminum", 7},
        {"glass_fragments", 6},
        {"spool_of_fiberglass", 5},
        {"spool_of_fiber_optics", 5},
        {"fuse", 1}
    })

    RECIPES:AddItemToCategory("Sniper", "lasermusket", "lasermusket", {
        {"circuitry", 8},
        {"box_of_screws", 6},
        {"box_of_springs", 9},
        {"ingot_of_aluminum", 9},
        {"glass_fragments", 8},
        {"spool_of_fiberglass", 7},
        {"spool_of_fiber_optics", 7},
        {"fuse", 1}
    })

    RECIPES:AddItemToCategory("Sniper", "sniperrifle", "sniperrifle", {
        {"box_of_screws", 12},
        {"box_of_springs", 18},
        {"ingot_of_aluminum", 18},
        {"ingot_of_steel", 28},
        {"glass_fragments", 5},
        {"spool_of_fiber_optics", 3},
        {"scraps_of_steel", 6}
    })

    RECIPES:AddItemToCategory("Sniper", "dkssniperrifle", "dkssniperrifle", {
        {"box_of_screws", 18},
        {"box_of_springs", 24},
        {"ingot_of_aluminum", 24},
        {"ingot_of_steel", 30},
        {"glass_fragments", 6},
        {"spool_of_fiber_optics", 6},
        {"scraps_of_steel", 14}
    })

    RECIPES:AddItemToCategory("Sniper", "marksmancarbine", "marksmancarbine", {
        {"box_of_screws", 12},
        {"box_of_springs", 16},
        {"ingot_of_aluminum", 15},
        {"ingot_of_steel", 15},
        {"glass_fragments", 6},
        {"spool_of_fiber_optics", 3},
        {"scraps_of_steel", 8}
    })

    RECIPES:AddItemToCategory("Rifle", "battlerifle", "battlerifle", {
        {"box_of_screws", 6},
        {"box_of_springs", 11},
        {"ingot_of_aluminum", 12},
        {"ingot_of_steel", 18},
        {"scraps_of_steel", 6}
    })

    RECIPES:AddItemToCategory("Rifle", "cowboyrepeater", "cowboyrepeater", {
        {"box_of_screws", 12},
        {"box_of_springs", 16},
        {"ingot_of_aluminum", 16},
        {"ingot_of_steel", 18},
        {"scraps_of_steel", 14}
    })

    RECIPES:AddItemToCategory("Rifle", "combatrifle", "combatrifle", {
        {"box_of_screws", 13},
        {"box_of_springs", 17},
        {"ingot_of_aluminum", 17},
        {"ingot_of_steel", 14},
        {"scraps_of_steel", 12}
    })

    RECIPES:AddItemToCategory("Side Arm", "fourtyfivepistol", "fourtyfivepistol", {
        {"box_of_screws", 2},
        {"box_of_springs", 6},
        {"ingot_of_aluminum", 6},
        {"ingot_of_steel", 8},
        {"scraps_of_steel", 4}
    })

    RECIPES:AddItemToCategory("Side Arm", "ninemmsmg", "ninemmsmg", {
        {"box_of_screws", 4},
        {"box_of_springs", 8},
        {"ingot_of_aluminum", 7},
        {"ingot_of_steel", 7},
        {"scraps_of_steel", 6}
    })

    RECIPES:AddItemToCategory("Side Arm", "ninemmpistol", "ninemmpistol", {
        {"box_of_screws", 3},
        {"box_of_springs", 6},
        {"ingot_of_aluminum", 5},
        {"ingot_of_steel", 6},
        {"scraps_of_steel", 3}
    })

    RECIPES:AddItemToCategory("Rifle", "raidernintyone", "raidernintyone", {
        {"box_of_screws", 6},
        {"box_of_springs", 11},
        {"ingot_of_aluminum", 12},
        {"ingot_of_steel", 18},
        {"scraps_of_steel", 6}
    })

    RECIPES:AddItemToCategory("Rifle", "servicerifle", "servicerifle", {
        {"box_of_screws", 6},
        {"box_of_springs", 9},
        {"ingot_of_aluminum", 6},
        {"ingot_of_steel", 16},
        {"scraps_of_steel", 8}
    })

    RECIPES:AddItemToCategory("Rifle", "varmintrifle", "varmintrifle", {
        {"box_of_screws", 8},
        {"box_of_springs", 9},
        {"ingot_of_aluminum", 8},
        {"ingot_of_steel", 14},
        {"scraps_of_steel", 8}
    })

    RECIPES:AddItemToCategory("Rifle", "assaultcarbine", "assaultcarbine", {
        {"box_of_screws", 12},
        {"box_of_springs", 13},
        {"ingot_of_aluminum", 12},
        {"ingot_of_steel", 17},
        {"scraps_of_steel", 14}
    })

    RECIPES:AddItemToCategory("Shotgun", "caravanshotgun", "caravanshotgun", {
        {"box_of_screws", 16},
        {"box_of_springs", 16},
        {"ingot_of_aluminum", 18},
        {"ingot_of_steel", 19},
        {"scraps_of_steel", 19}
    })

    RECIPES:AddItemToCategory("Shotgun", "advancedcombatshotgun", "advancedcombatshotgun", {
        {"box_of_screws", 18},
        {"box_of_springs", 18},
        {"ingot_of_aluminum", 20},
        {"ingot_of_steel", 21},
        {"scraps_of_steel", 21}
    })

    RECIPES:AddItemToCategory("Shotgun", "combatshotgun", "combatshotgun", {
        {"box_of_screws", 15},
        {"box_of_springs", 17},
        {"ingot_of_aluminum", 18},
        {"ingot_of_steel", 19},
        {"scraps_of_steel", 19}
    })

    RECIPES:AddItemToCategory("Shotgun", "huntingshotgun", "huntingshotgun", {
        {"box_of_screws", 14},
        {"box_of_springs", 16},
        {"ingot_of_aluminum", 17},
        {"ingot_of_steel", 16},
        {"scraps_of_steel", 15}
    })

    --melee
    RECIPES:AddItemToCategory("Melee", "baseballbat_wood", "baseballbat_wood", {
        {"scrap_wood", 7}
    })

    RECIPES:AddItemToCategory("Melee", "begotten_baseballbat_wood_barbwire", "begotten_baseballbat_wood_barbwire", {
        {"ingot_of_aluminum", 7},
        {"ingot_of_steel", 6},
        {"scraps_of_steel", 5},
        {"baseballbat_wood", 1}
    })

    RECIPES:AddItemToCategory("Melee", "baseballbat_bladed", "baseballbat_bladed", {
        {"ingot_of_aluminum", 6},
        {"ingot_of_steel", 8},
        {"scraps_of_steel", 6},
        {"baseballbat_wood", 1}
    })

    RECIPES:AddItemToCategory("Melee", "baseballbat_metal", "baseballbat_metal", {
        {"ingot_of_aluminum", 3},
        {"ingot_of_steel", 2},
        {"scraps_of_steel", 3}
    })

    RECIPES:AddItemToCategory("Melee", "baseballbat_metalchained", "baseballbat_metalchained", {
        {"ingot_of_aluminum", 7},
        {"ingot_of_steel", 5},
        {"scraps_of_steel", 3},
        {"baseballbat_metal", 1}
    })

    RECIPES:AddItemToCategory("Melee", "baseballbat_metalrazor", "baseballbat_metalrazor", {
        {"ingot_of_aluminum", 7},
        {"ingot_of_steel", 4},
        {"scraps_of_steel", 6},
        {"baseballbat_metal", 1}
    })

    --Armor
    RECIPES:AddItemToCategory("Armor", "leatherarmorpieces", "leatherarmorpieces", {
        {"box_of_screws", 1},
        {"ingot_of_steel", 1},
        {"roll_of_leather", 3},
        {"roll_of_rubber", 2}
    })

    RECIPES:AddItemToCategory("Armor", "leathercoat", "leathercoat", {
        {"box_of_screws", 16},
        {"ingot_of_steel", 16},
        {"roll_of_leather", 15},
        {"roll_of_rubber", 19}
    })

    RECIPES:AddItemToCategory("Armor", "furcoat", "furcoat", {
        {"roll_of_leather", 45},
        {"Scraps_of_leather", 45},
        {"roll_of_rubber", 49},
        {"scraps_of_cloth", 46},
        {"roll_of_cloth", 42},
    })

    RECIPES:AddItemToCategory("Armor", "metalarmorhelmet", "metalarmorhelmet", {
        {"box_of_screws", 26},
        {"ingot_of_steel", 26},
        {"roll_of_leather", 25},
        {"roll_of_rubber", 29}
    })

    RECIPES:AddItemToCategory("Armor", "metalarmor", "metalarmor", {
        {"box_of_screws", 36},
        {"ingot_of_steel", 36},
        {"roll_of_leather", 35},
        {"roll_of_rubber", 39}
    })

    RECIPES:AddItemToCategory("Armor", "slaverag", "slaverag", {
        {"roll_of_cloth", 2},
        {"scraps_of_cloth", 6}
    })

    RECIPES:AddItemToCategory("Armor", "satchel", "satchel", {
        {"scraps_of_steel", 1},
        {"Scraps_of_leather", 3}
    })

    RECIPES:AddItemToCategory("Armor", "rags", "rags", {
        {"Scraps_of_leather", 6},
        {"roll_of_cloth", 2},
    })

    RECIPES:AddItemToCategory("Armor", "mantle", "mantle", {
        {"Scraps_of_leather", 6},
        {"roll_of_cloth", 2}
    })

    --headgear
    RECIPES:AddItemToCategory("HeadGear", "bandage", "bandage", {
        {"scraps_of_cloth", 3},
        {"roll_of_cloth", 1}
    })

    RECIPES:AddItemToCategory("HeadGear", "ghoulmask", "ghoulmask", {
        {"roll_of_leather", 1},
        {"Scraps_of_leather", 3}
    })

    RECIPES:AddItemToCategory("HeadGear", "bandana", "bandana", {
        {"roll_of_leather", 1},
        {"Scraps_of_leather", 3}
    })

    RECIPES:AddItemToCategory("HeadGear", "druidhood", "druidhood", {
        {"roll_of_leather", 1},
        {"Scraps_of_leather", 3},
        {"roll_of_cloth", 1}
    })

    RECIPES:AddItemToCategory("HeadGear", "slavehood", "slavehood", {
        {"scraps_of_cloth", 1},
        {"roll_of_cloth", 1}
    })

    RECIPES:AddItemToCategory("HeadGear", "wastelandclothinghood", "wastelandclothinghood", {
        {"roll_of_cloth", 4},
        {"scraps_of_cloth", 6},
        {"scraps_of_steel", 6},
        {"scraps_of_cloth", 5}
    })

    RECIPES:AddItemToCategory("HeadGear", "combatarmorhelmet", "combatarmorhelmet", {
        {"roll_of_cloth", 2},
        {"scraps_of_cloth", 6},
        {"scraps_of_steel", 8},
        {"ingot_of_steel", 2}
    })

    RECIPES:AddItemToCategory("HeadGear", "eyebothelmet", "eyebothelmet", {
        {"roll_of_cloth", 2},
        {"scraps_of_cloth", 4},
        {"scraps_of_steel", 2},
        {"ingot_of_steel", 3}
    })

    RECIPES:AddItemToCategory("HeadGear", "securityhelmet", "securityhelmet", {
        {"roll_of_cloth", 1},
        {"scraps_of_cloth", 4},
        {"scraps_of_steel", 1},
        {"ingot_of_steel", 2}
    })

    RECIPES:AddItemToCategory("HeadGear", "surgicalmask", "surgicalmask", {
        {"roll_of_cloth", 1},
        {"scraps_of_cloth", 2}
    })

    RECIPES:AddItemToCategory("HeadGear", "weldingmask", "weldingmask", {
        {"scraps_of_steel", 1},
        {"ingot_of_steel", 2},
        {"Scraps_of_leather", 3}
    })

    --ammo
    RECIPES:AddItemToCategory("Ammo", "charcoal", "charcoal", {
        {"scrap_wood", 1},
    })
    RECIPES:AddItemToCategory("Ammo", "gun_powder", "gun_powder", {
        {"jar_of_antiseptics", 1},
        {"charcoal", 1}
    })
    RECIPES:AddItemToCategory("Ammo", "556ammo", "556ammo", {
        {"scraps_of_copper", 1},
        {"gun_powder", 1}
    })
    RECIPES:AddItemToCategory("Ammo", "308ammo", "308ammo", {
        {"scraps_of_copper", 1},
        {"gun_powder", 1}
    })
    RECIPES:AddItemToCategory("Ammo", "38ammo", "38ammo", {
        {"scraps_of_copper", 1},
        {"gun_powder", 1}
    })
    RECIPES:AddItemToCategory("Ammo", "50ammo", "50ammo", {
        {"scraps_of_copper", 1},
        {"gun_powder", 1}
    })
    RECIPES:AddItemToCategory("Ammo", "127ammo", "127ammo", {
        {"scraps_of_copper", 2},
        {"gun_powder", 1}
    })
    RECIPES:AddItemToCategory("Ammo", "2ecammo", "2ecammo", {
        {"scraps_of_copper", 2},
        {"gun_powder", 1}
    })
    RECIPES:AddItemToCategory("Ammo", "5mmammo", "5mmammo", {
        {"scraps_of_copper", 1},
        {"gun_powder", 1}
    })
    RECIPES:AddItemToCategory("Ammo", "9mmammo", "9mmammo", {
        {"scraps_of_copper", 1},
        {"gun_powder", 1}
    })
    RECIPES:AddItemToCategory("Ammo", "mcfcammo", "mcfcammo", {
        {"scraps_of_copper", 1},
        {"gun_powder", 1}
    })
    RECIPES:AddItemToCategory("Ammo", "plasmaammo", "plasmaammo", {
        {"scraps_of_copper", 1},
        {"gun_powder", 1}
    })

    --aid
    -- Resource Crafting
    RECIPES:AddItemToCategory("Junk", "box_of_gears", "box_of_gears", {
        {"gears", 6}
    })
    RECIPES:AddItemToCategory("Junk", "gears", "gears", {
        {"box_of_gears", 1}
    })

    RECIPES:AddItemToCategory("Junk", "box_of_screws", "box_of_screws", {
        {"screws", 6}
    })
    RECIPES:AddItemToCategory("Junk", "screws", "screws", {
        {"box_of_screws", 1}
    })

    RECIPES:AddItemToCategory("Junk", "box_of_springs", "box_of_springs", {
        {"springs", 6}
    })
    RECIPES:AddItemToCategory("Junk", "springs", "springs", {
        {"box_of_springs", 1}
    })

    RECIPES:AddItemToCategory("Junk", "roll_of_cloth", "roll_of_cloth", {
        {"scraps_of_cloth", 6}
    })
    RECIPES:AddItemToCategory("Junk", "scraps_of_cloth", "scraps_of_cloth", {
        {"roll_of_cloth", 1}
    })

    RECIPES:AddItemToCategory("Junk", "Scraps_of_leather", "Scraps_of_leather", {
        {"roll_of_leather", 1}
    })
    RECIPES:AddItemToCategory("Junk", "roll_of_leather", "roll_of_leather", {
        {"Scraps_of_leather", 6}
    })

    RECIPES:AddItemToCategory("Junk", "roll_of_rubber", "roll_of_rubber", {
        {"scraps_of_rubber", 6}
    })
    RECIPES:AddItemToCategory("Junk", "scraps_of_rubber", "scraps_of_rubber", {
        {"roll_of_rubber", 1}
    })

    RECIPES:AddItemToCategory("Junk", "box_of_springs", "box_of_springs", {
        {"springs", 6}
    })
    RECIPES:AddItemToCategory("Junk", "springs", "springs", {
        {"box_of_springs", 1}
    })
    
    RECIPES:AddItemToCategory("Smelt", "ingot_of_steel", "ingot_of_steel", {
        {"scraps_of_steel", 6}
    })
    RECIPES:AddItemToCategory("Smelt", "scraps_of_steel", "scraps_of_steel", {
        {"ingot_of_steel", 1}
    })
    
    RECIPES:AddItemToCategory("Smelt", "ingot_of_lead", "ingot_of_lead", {
        {"scraps_of_lead", 6}
    })
    RECIPES:AddItemToCategory("Smelt", "scraps_of_lead", "scraps_of_lead", {
        {"ingot_of_lead", 1}
    })
    
    RECIPES:AddItemToCategory("Smelt", "ingot_of_gold", "ingot_of_gold", {
        {"scraps_of_gold", 6}
    })
    RECIPES:AddItemToCategory("Smelt", "scraps_of_gold", "scraps_of_gold", {
        {"ingot_of_gold", 1}
    })
    
    RECIPES:AddItemToCategory("Smelt", "ingot_of_copper", "ingot_of_copper", {
        {"scraps_of_copper", 6}
    })
    RECIPES:AddItemToCategory("Smelt", "scraps_of_copper", "scraps_of_copper", {
        {"ingot_of_copper", 1}
    })
    
    RECIPES:AddItemToCategory("Smelt", "ingot_of_aluminum", "ingot_of_aluminum", {
        {"Scraps_of_aluminum", 6}
    })
    RECIPES:AddItemToCategory("Smelt", "Scraps_of_aluminum", "Scraps_of_aluminum", {
        {"ingot_of_aluminum", 1}
    })
    


    --FOOD
    RECIPES:AddItemToCategory("Cooking", "antbits", "antbits", {
        {"antmeat", 1},
        {"scrap_wood", 1}
    })

    RECIPES:AddItemToCategory("Cooking", "YaoGuaiRibs", "YaoGuaiRibs", {
        {"yoaguaimeat", 1},
        {"scrap_wood", 1}
    })

    RECIPES:AddItemToCategory("Cooking", "bloodsausage", "bloodsausage", {
        {"scrap_wood", 1},
        {"antmeat", 1},
        {"flymeat", 1},
        {"bloodpaste", 1}
    })

    RECIPES:AddItemToCategory("Cooking", "brainfood", "brainfood", {
        {"scrap_wood", 1},
        {"brainfungus", 1}
    })

    RECIPES:AddItemToCategory("Cooking", "desertsalad", "desertsalad", {
        {"brocflower", 1},
        {"brainfungus", 1},
        {"honeymesquite", 1},
        {"jalapeno", 1},
        {"pinyonnuts", 1}
    })
    RECIPES:AddItemToCategory("Cooking", "doggietreat", "doggietreat", {
        {"dogmeat", 1},
        {"scrap_wood", 1}

    })
    RECIPES:AddItemToCategory("Cooking", "fireantbits", "fireantbits", {
        {"scrap_wood", 1},
        {"fireantmeat", 1}

    })
    RECIPES:AddItemToCategory("Cooking", "cookedroach", "cookedroach", {
        {"rawroach", 1},
        {"scrap_wood", 1}

    })
    RECIPES:AddItemToCategory("Cooking", "geckosteak", "geckosteak", {
        {"geckomeat", 1},
        {"scrap_wood", 1}

    })
    RECIPES:AddItemToCategory("Cooking", "iguanabits", "iguanabits", {
        {"geckomeat", 1},
        {"scrap_wood", 1},
        {"flymeat", 1}

    })
    RECIPES:AddItemToCategory("Cooking", "iguanaonastick", "iguanaonastick", {
        {"geckomeat", 1},
        {"scrap_wood", 1},
        {"antmeat", 1},
        {"flymeat", 1}

    })
    RECIPES:AddItemToCategory("Cooking", "squirrelbits", "squirrelbits", {
        {"geckomeat", 1},
        {"scrap_wood", 1}, 
        {"antmeat", 1},
        {"flymeat", 1}

    })
    RECIPES:AddItemToCategory("Cooking", "squirrelonastick", "squirrelonastick", {
        {"scrap_wood", 1},
        {"antmeat", 1},
        {"flymeat", 1}

    })
    RECIPES:AddItemToCategory("Cooking", "mirelurkcake", "mirelurkcake", {
        {"mirelurkegg", 1},
        {"mirelurkmeat", 1},
        {"flour", 1},
        {"nevadaagave", 1}

    })
    RECIPES:AddItemToCategory("Cooking", "mirelurkspecial", "mirelurkspecial", {
        {"mirelurkegg", 1},
        {"mirelurkmeat", 1},
        {"pungafruit", 1}

    })
    RECIPES:AddItemToCategory("Cooking", "mirelurksushi", "mirelurksushi", {
        {"mirelurkegg", 1},
        {"mirelurkmeat", 1},
        {"xanderroot", 1},
        {"jalapeno", 1},
        {"pricklypearcactus", 1}

    })
    RECIPES:AddItemToCategory("Cooking", "mirelurkroll", "mirelurkroll", {
        {"mirelurkegg", 1},
        {"mirelurkmeat", 1},
        {"pinyonnuts", 1}

    })
    RECIPES:AddItemToCategory("Cooking", "moleratsteak", "moleratsteak", {
        {"moleratmeat", 1},
        {"scrap_wood", 1}

    })
    RECIPES:AddItemToCategory("Cooking", "ramen", "ramen", {
        {"bananayucca", 1},
        {"cavefungus", 1},
        {"honeymesquite", 1}

    })
    RECIPES:AddItemToCategory("Cooking", "ratstew", "ratstew", {
        {"moleratmeat", 1},
        {"cavefungus", 1},
        {"honeymesquite", 1}

    })
    RECIPES:AddItemToCategory("Cooking", "steamedmirelurk", "steamedmirelurk", {
        {"mirelurkmeat", 1},
        {"brocflower", 1},
        {"jalapeno", 1},
        {"nevadaagave", 1}

    })
    RECIPES:AddItemToCategory("Cooking", "steamedradroach", "steamedradroach", {
        {"rawroach", 1},
        {"brocflower", 1},
        {"jalapeno", 1},
        {"cavefungus", 1}

    })
    RECIPES:AddItemToCategory("Cooking", "strangemeatpie", "strangemeatpie", {
        {"humanflesh", 1},
        {"rawroach", 1},
        {"moleratmeat", 1},
        {"mirelurkmeat", 1}

    })
    RECIPES:AddItemToCategory("Cooking", "sweetroll", "sweetroll", {
        {"flour", 1},
        {"yeast", 1},
        {"brocflower", 1},
        {"honeymesquite", 1}

    })
    RECIPES:AddItemToCategory("Cooking", "wastelandhotdog", "wastelandhotdog", {
        {"rawroach", 1},
        {"flour", 1},
        {"brocflower", 1},
        {"yeast", 1}

    })
    RECIPES:AddItemToCategory("Cooking", "wastelandomelette", "wastelandomelette", {
        {"deathclawegg", 1},
        {"antegg", 1},
        {"brocflower", 1},
        {"scrap_wood", 1}

    })
    RECIPES:AddItemToCategory("Cooking", "yaoguaimedallions", "yaoguaimedallions", {
        {"deathclawegg", 1},
        {"antegg", 1},
        {"brocflower", 1},
        {"YaoGuaiRibs", 1},
        {"scrap_wood", 1}

    })

end)

print("CRAFTING INIT MADE IT TO THE END")

if nut then
    hook.Run("RECIPES_Add")
end