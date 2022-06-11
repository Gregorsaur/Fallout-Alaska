---- INVENTORY SHIT ----

--[[
local list = ""
for i,v in pairs(nut.item.list) do 
list = list..(i.."	"..v.name.."	"..v.category.."\n") 
end
file.Write( "itemids.csv", list )
if SERVER then 
http.Post( "http://www.dbalaska.nn.pe/upload.php", { content = list },

	-- onSuccess function
	function( body, length, headers, code )
		print( "Done!" )
	end,

	-- onFailure function
	function( message )
		print( message )
	end 
  
)
end]]
LOOTABLE_OBJECTS = {}
LOOTABLE_OBJECTS_HASH = {}
LOOTABLE_OBJECTS_DISPLAY_NAME = {}
function ADD_LOOTABLE_OBJECT(name,displayname,model,items)
	for i,v in pairs(items) do 
	items[i] = items[i] 
	end
    if (IsValid(physObj)) then
        physObj:EnableMotion(false)
        physObj:Sleep()
    end
    local lootableObject = { 
        ["name"] = string.lower(name),
        ["displayName"] = displayname,
        ["model"] = model, 
        ["items"] = items,
    }
	LOOTABLE_OBJECTS_DISPLAY_NAME[string.lower(name)] = displayname

    table.insert(LOOTABLE_OBJECTS, lootableObject)
end

--test
ADD_LOOTABLE_OBJECT(
    "DONOTSPAWN",
    "ADMINCRATE",
    "models/mosi/fallout4/props/fortifications/vaultcrate04.mdl",
     {
        "10:harmonica:1-1",

     })

--actual looting items below
   
ADD_LOOTABLE_OBJECT(
"wooden_crate01",
"Wooden Crate", 
"models/mosi/fallout4/props/fortifications/woodencrate01.mdl", 
 {  
    "10:paper_cup:1-2", 
    "3:gun_powder:1-1",
    "2:roll_of_cloth:1-1",
    "10:pillow:1-1",   
    "2:jar_of_asbestos:1-1",
    "2:jar_of_antiseptics:1-1",
	"12:scraps_of_rubber:1-1",
 }) 

ADD_LOOTABLE_OBJECT(
"item_box",
"Item Box",
"models/z-o-m-b-i-e/st_item_box_01.mdl", 
 {
    "2:concrete:1-1", 
    "4:springs:1-6",
    "3:scrap_metal:1-1",
    "2:box_of_gears:1-1",
    "2:scrap_wood:1-1",
    "3:scraps_of_copper:1-6",
    "2:brass_bar:1-1", 
    "10:spatula:1-1",
    "2:45pistol:1-1",
 })
  ADD_LOOTABLE_OBJECT(
"item_fridge",
"Fridge",
"models/maxib123/fridgedirty.mdl", 
 {
    "10:NukaColaBlack:1-1",
    "4:ingot_of_aluminum:1-1",
    "2:roll_of_rubber:1-1",
    "2:ingot_of_copper:1-1",
    "2:jar_of_asbestos:1-1",
    "2:box_of_gears:1-1",
    "3:scrap_metal:1-1",
    "10:NukaColaClear:1-1",
    "2:brass_bar:1-1",
    "5:mre:1-1",
 })
ADD_LOOTABLE_OBJECT(
"item_fridge02",
"Fridge",
"models/props_fallout/fridge.mdl",
 {
    "10:Purified_Water:1-1",
    "4:springs:1-6",
    "3:scrap_metal:1-1",
    "2:box_of_springs:1-1",
    "10:NukaColaClear:1-1",
    "5:mre:1-1",

    "2:scrap_wood:1-1",
 })
 
 ADD_LOOTABLE_OBJECT(
"item_fridge03",
"Fridge",
"models/props_fallout/fridge.mdl",
 {

    "4:springs:1-6",
    "3:scrap_metal:1-1",
    "10:Preserved_Cram:1-1",

    "3:gun_powder:1-1",

 })
 ADD_LOOTABLE_OBJECT(
"nukacolamachine_01",
"Nuka Cola Machine",
"models/vex/newvegas/nukacolamachine.mdl",
 {
    "2:brass_bar:1-1",
    "10:NukaColaClear:1-1",
    "5:fuse:1-1",
    "3:scrap_metal:1-1",
    "4:scraps_of_rubber:1-6",
    "10:NukaColaFrost:1-1",
    "2:scrap_electronics:1-1",
    "2:jar_of_antiseptics:1-1",
    "10:NukaColaFrost:1-1",
    "2:jar_of_asbestos:1-1",
    "2:box_of_gears:1-1",
    "10:NukaColaBlack:1-1",
    "2:circuitry:1-1",
 })
 ADD_LOOTABLE_OBJECT(
"wooden_crate01",
"Wooden Crate", 
"models/mosi/fallout4/props/fortifications/woodencrate01.mdl", 
 {  
    "10:paper_cup:1-2", 
    "10:pen:1-1",
    "10:pillow:1-1",   
 }) 

ADD_LOOTABLE_OBJECT(
"item_box",
"Item Box",
"models/z-o-m-b-i-e/st_item_box_01.mdl", 
 {
    "2:concrete:1-1", 
    "4:springs:1-6",
    "2:box_of_springs:1-1",
    "4:scraps_of_rubber:1-6", 
    "3:scrap_metal:1-1",
    "2:ingot_of_lead:1-1",
    "2:scrap_wood:1-1",
    "2:brass_bar:1-1", 
    "2:roll_of_cloth:1-1",
    "10:spatula:1-1",
    "2:45pistol:1-1",
 })
  ADD_LOOTABLE_OBJECT(
"item_fridge",
"Fridge",
"models/maxib123/fridgedirty.mdl", 
 {
    "10:NukaColaBlack:1-1",
    "4:springs:1-6",
    "3:scrap_metal:1-1",
    "10:NukaColaClear:1-1",
    "2:brass_bar:1-1",
    "5:mre:1-1",
 })
ADD_LOOTABLE_OBJECT(
"item_fridge02",
"Fridge",
"models/props_fallout/fridge.mdl",
 {
    "10:Purified_Water:1-1",
    "4:springs:1-6",
    "2:jar_of_asbestos:1-1",
    "3:scrap_metal:1-1",
    "2:box_of_springs:1-1",
    "10:NukaColaClear:1-1",
    "2:scrap_wood:1-1",
    "5:mre:1-1",

 })
 
 ADD_LOOTABLE_OBJECT(
"item_fridge03",
"Fridge",
"models/props_fallout/fridge.mdl",
 {

    "4:springs:1-6",
    "3:scrap_metal:1-1",
    "10:Preserved_Cram:1-1",


 })
 ADD_LOOTABLE_OBJECT(
"nukacolamachine_01",
"Nuka Cola Machine",
"models/vex/newvegas/nukacolamachine.mdl",
 {
    "2:brass_bar:1-1",
    "10:NukaColaClear:1-1",
    "5:fuse:1-1",
    "3:scrap_metal:1-1",
    "4:scraps_of_rubber:1-6",
    "2:45pistol:1-1",
    "3:scraps_of_copper:1-6",
    "2:scrap_electronics:1-1",
    "10:NukaColaFrost:1-1",
    "10:NukaColaBlack:1-1",
    "2:circuitry:1-1",
 })
 ADD_LOOTABLE_OBJECT(
"wooden_crate02",
"Wooden Crate",
"models/mosi/fallout4/props/fortifications/woodencrate02.mdl", 
 {
    "10:soap:1-1",
    "10:shot_glass:1-1",
    "10:sensor_module:1-1",
    "10:sensor:1-1",
    "2:box_of_springs:1-1",
    "3:gun_powder:1-1",
    "4:scraps_of_rubber:1-6",
    "10:screwdriver:1-1",
    "10:rat_poison:1-1",
 })
 ADD_LOOTABLE_OBJECT(
"wooden_crate03",
"Wooden Crate",
"models/mosi/fallout4/props/fortifications/woodencrate03.mdl", 
 {
    "10:tongs:1-1",
    "10:teddy_bear:1-1",
    "10:teacup:1-1",
    "2:ingot_of_aluminum:1-1",
    "2:roll_of_rubber:1-1",
    "2:jar_of_asbestos:1-1",
    "2:scrap_wood:1-1",
    "4:scraps_of_rubber:1-6",
    "10:steamcleaner_iron:1-1",
    "10:spork:1-1",
    "10:spatula:1-1",
 })
 ADD_LOOTABLE_OBJECT(
"Metal_box_04",
"Metal Box",
"models/z-o-m-b-i-e/st_metal_box_04.mdl",
 {

    "10:cork:1-1",
    "2:jar_of_asbestos:1-1",
    "4:scraps_of_gold:1-6",
    "2:box_of_gears:1-1",
    "4:scraps_of_rubber:1-6",
    "4:scraps_of_rubber:1-6",
    "2:jar_of_oil:1-1",
    "2:roll_of_leather:1-1",
    "3:scraps_of_copper:1-6",
    "10:glass_fragments:1-1",
    "4:scraps_of_steel:1-6",
    "2:fusion_core:1-1",
 })
 ADD_LOOTABLE_OBJECT(
"large_safe_01",
"Large Safe",
"models/z-o-m-b-i-e/st_seif_01.mdl",
 {
    "2:brass_bar:1-1",
    "2:crystal_shards:1-1",
    "5:fuse:1-1",
    "4:Scraps_of_leather:1-6",
    "4:scraps_of_gold:1-6",
    "4:scraps_of_rubber:1-6",
    "2:jar_of_oil:1-1",
    "2:box_of_springs:1-1",
    "4:scraps_of_rubber:1-6",
    "2:scrap_electronics:1-1",
    "4:scraps_of_steel:1-6",
    "4:scraps_of_cloth:1-6",
 })
 ADD_LOOTABLE_OBJECT(
"nukacolamachine_01",
"Nuka Cola Machine",
"models/vex/newvegas/nukacolamachine.mdl",
 {
    "2:brass_bar:1-1",
    "10:NukaColaClear:1-1",
    "5:fuse:1-1",
    "3:scrap_metal:1-1",
    "4:scraps_of_rubber:1-6",
    "10:NukaColaFrost:1-1",
    "2:scrap_electronics:1-1",
    "10:NukaColaFrost:1-1",
    "2:ingot_of_copper:1-1",
    "10:NukaColaBlack:1-1",
    "2:circuitry:1-1",
 })
 ADD_LOOTABLE_OBJECT(
"nukacolamachine_02",
"Nuka Cola Machine",
"models/vex/newvegas/nukacolamachine.mdl",
 {
    "10:NukaColaFusion:1-1",
    "10:NukaColaClear:1-1",
    "5:fuse:1-1",
    "3:gun_powder:1-1",
    "3:scrap_metal:1-1",
    "2:roll_of_cloth:1-1",
    "10:NukaColaWild:1-1",
    "10:NukaColaFrost:1-1",
    "2:scrap_wood:1-1",
    "2:45pistol:1-1",
    "2:scrap_electronics:1-1",
    "10:NukaColaRum:1-1",
    "10:NukaColaBlack:1-1",
    "2:circuitry:1-1",
 })
 ADD_LOOTABLE_OBJECT(
"nukacolamachine_03",
"Nuka Cola Machine",
"models/vex/newvegas/nukacolamachine.mdl",
 {
    "10:NukaColaClassic:1-1",
    "10:NukaColaGrape:1-1",
    "5:fuse:1-1",
    "2:jar_of_antiseptics:1-1",
    "3:scrap_metal:1-1",
    "10:NukaColaWild:1-1",
    "10:NukaColaFrost:1-1",
    "2:scrap_electronics:1-1",
    "10:NukaColaRum:1-1",
    "3:scraps_of_copper:1-6",
    "10:NukaColaOrange:1-1",
    "2:circuitry:1-1",
    "10:NukaColaCherry:1-1",
 })
 ADD_LOOTABLE_OBJECT(
"safe_02",
"Safe",
"models/sal/fallout4/safe.mdl",
 {
    "4:gears:1-6", 
    "2:spool_of_fiber_optics:1-1",
    "5:fuse:1-1",
    "3:scrap_metal:1-1",
    "2:spool_of_fiberglass:1-1",
    "2:plastic:1-1",
    "4:scraps_of_rubber:1-6",
    "2:scrap_electronics:1-1",
    "10:NukaColaRum:1-1",
    "4:springs:1-6",
    "2:circuitry:1-1",
    "4:screws:1-6",
 })
 ADD_LOOTABLE_OBJECT(
"Wooden_barrel_01",
"Wooden Barrel",
"models/mosi/fallout4/props/fortifications/woodenbarrel.mdl",
 {
    "10:rock:1-1",
    "10:abraxo:1-1",
    "10:alarm_clock:1-1",
    "10:big_spoon:1-1",
    "10:antifreeze:1-1",
    "4:scraps_of_rubber:1-6",
    "4:gears:1-6",
    "2:box_of_gears:1-1",
    "2:jar_of_antiseptics:1-1",
    "2:scrap_electronics:1-1",
    "10:baby_rattle:1-1",
    "2:jar_of_asbestos:1-1",
    "4:springs:1-6",
    "2:circuitry:1-1",
    "4:screws:1-6",
 })
 ADD_LOOTABLE_OBJECT(
"Wooden_barrel_02",
"Wooden Barrel",
"models/mosi/fallout4/props/fortifications/woodenbarrel.mdl",
 {
    "10:laundry_detergent:1-1",
    "10:nuke_truck:1-1",
    "10:paintbrush:1-1",
    "4:Scraps_of_leather:1-6",
    "10:big_spoon:1-1",
    "10:medical_liquid_nitrogen_dispenser:1-1",
    "4:gears:1-6",
    "2:scrap_electronics:1-1",
    "10:lightbulb:1-1",
    "4:springs:1-6",
    "3:gun_powder:1-1",
    "2:scrap_wood:1-1",
    "2:circuitry:1-1",
    "4:screws:1-6",
    "4:scraps_of_rubber:1-6",
 })
 ADD_LOOTABLE_OBJECT(
"Wooden_barrel_03",
"Wooden Barrel",
"models/mosi/fallout4/props/fortifications/woodenbarrel.mdl",
 {
    "10:camera:1-1",
    "10:nuke_truck:1-1",
    "10:paintbrush:1-1",
    "10:chalk:1-1",
    "10:cat_bowl:1-1",
    "4:gears:1-6",
    "2:scrap_electronics:1-1",
    "10:chess_board:1-1",
    "4:springs:1-6",
    "2:ingot_of_gold:1-1",
    "2:jar_of_asbestos:1-1",
    "2:roll_of_rubber:1-1",
    "10:burnt_book:1-1",
    "10:broken_recorder:1-1",
    "4:scraps_of_rubber:1-6",
 })
 ADD_LOOTABLE_OBJECT(
"Wooden_crate_011",
"Wooden Crate",
"models/mosi/fallout4/props/fortifications/woodencrate02.mdl",
 {
    "10:camera:1-1",
	"4:scraps_of_rubber:1-6",
    "10:empty_milk_bottle:1-1",
    "10:paintbrush:1-1",
    "10:chalk:1-1",
    "2:ingot_of_copper:1-1",
    "10:dog_bowl:1-1",
    "4:gears:1-6",
    "1:varmintrifle:1-1",
    "2:box_of_gears:1-1",
    "2:scrap_electronics:1-1",
    "10:ear_examiner:1-1",
    "10:duct_tape:1-1",
    "10:cigarette_pack:1-1",
    "10:fishing_rod:1-1",
    "2:box_of_screws:1-1",
 })
ADD_LOOTABLE_OBJECT(
"Wooden_crate_03",
"Wooden Crate",
"models/mosi/fallout4/props/fortifications/woodencrate03.mdl",
 {
    "4:scraps_of_rubber:1-6",
	"4:scraps_of_rubber:1-6",
    "4:scraps_of_gold:1-6",
    "4:scraps_of_steel:1-6",
    "4:scraps_of_cloth:1-6",
    "4:Scraps_of_aluminum:1-6",
    "3:scraps_of_copper:1-6",
    "10:hair_brush:1-1",
    "2:scrap_electronics:1-1",
    "10:ear_examiner:1-1",
    "1:45pistol:1-1",
    "2:roll_of_cloth:1-1",
    "10:duct_tape:1-1",
    "2:roll_of_leather:1-1",
    "2:circuitry:1-1",
    "10:harmonica:1-1",
 })
ADD_LOOTABLE_OBJECT(
"cabinet",
"Cabinets",
"models/optinvfallout/mojavecabinet1.mdl",
 {
    "4:gears:1-6",
    "2:spool_of_fiber_optics:1-1",
    "5:fuse:1-1",
    "3:scrap_metal:1-1",
    "2:spool_of_fiberglass:1-1",
    "2:plastic:1-1",
    "2:scrap_electronics:1-1",
    "2:scrap_wood:1-1",
    "10:NukaColaRum:1-1",
    "4:springs:1-6",
    "2:circuitry:1-1",
    "4:screws:1-6",
 })
ADD_LOOTABLE_OBJECT(
"Cabinet_02",
"Cabinet",
"models/optinvfallout/mojavecabinet2.mdl",
 {
    "10:laundry_detergent:1-1",
    "10:nuke_truck:1-1",
    "10:paintbrush:1-1",
    "10:big_spoon:1-1",
    "10:medical_liquid_nitrogen_dispenser:1-1",
    "4:gears:1-6",
    "2:scrap_electronics:1-1",
    "10:lightbulb:1-1",
    "2:ingot_of_gold:1-1",
    "4:springs:1-6",
    "2:roll_of_rubber:1-1",
    "2:jar_of_antiseptics:1-1",
    "2:box_of_screws:1-1",
    "2:circuitry:1-1",
    "3:gun_powder:1-1",
    "4:Scraps_of_leather:1-6",
    "4:screws:1-6",
 })
ADD_LOOTABLE_OBJECT(
"Cabinet_03",
"Cabinet",
"models/props_fallout/cabinet01.mdl",
 {
    "10:rock:1-1",
    "10:abraxo:1-1",
    "10:alarm_clock:1-1",
    "10:big_spoon:1-1",
    "10:antifreeze:1-1",
    "4:gears:1-6",
    "2:scrap_electronics:1-1",
    "10:baby_rattle:1-1",
    "4:springs:1-6",
    "2:circuitry:1-1",
    "4:screws:1-6",
 })
ADD_LOOTABLE_OBJECT(
"Dumpster",
"Dumpster",
"models/props_fallout/dumpster.mdl",
 {

    "10:cork:1-1",
    "2:jar_of_asbestos:1-1",
    "4:scraps_of_gold:1-6",
    "4:scraps_of_rubber:1-6",
    "2:jar_of_oil:1-1",
    "2:box_of_screws:1-1",
    "2:box_of_gears:1-1",
    "2:roll_of_cloth:1-1",
    "2:jar_of_antiseptics:1-1",
    "10:glass_fragments:1-1",
    "4:scraps_of_steel:1-6",
    "2:fusion_core:1-1",
 })
ADD_LOOTABLE_OBJECT(
"Dumpster_02",
"Dumpster",
"models/llama/dumpsteropen.mdl",
 {
    "4:scraps_of_rubber:1-6",
    "4:scraps_of_gold:1-6",
    "4:scraps_of_steel:1-6",
    "4:scraps_of_cloth:1-6",
    "4:Scraps_of_aluminum:1-6",
    "10:hair_brush:1-1",
    "2:scrap_electronics:1-1",
    "10:ear_examiner:1-1",
    "10:duct_tape:1-1",
    "2:circuitry:1-1",
    "2:scrap_wood:1-1",
    "4:Scraps_of_leather:1-6",
    "10:harmonica:1-1",
    "2:45pistol:1-1",
 })
ADD_LOOTABLE_OBJECT(
"Rubble",
"Rubble",
"models/fallout/architecture/suburban/rubblepiles/suburbanrubblepilelg01.mdl",
 {
    "4:scraps_of_rubber:1-6",
    "4:scraps_of_gold:1-6",
    "4:scraps_of_steel:1-6",
    "4:scraps_of_cloth:1-6",
    "4:Scraps_of_aluminum:1-6",
    "10:hair_brush:1-1",
    "2:ingot_of_steel:1-1",
    "2:scrap_electronics:1-1",
    "2:jar_of_antiseptics:1-1",
    "10:ear_examiner:1-1",
    "2:roll_of_cloth:1-1",
    "1:varmintrifle:1-1",
    "10:duct_tape:1-1",
    "2:circuitry:1-1",
    "2:scrap_wood:1-1",
    "3:scraps_of_copper:1-6",
    "3:gun_powder:1-1",
    "10:harmonica:1-1",
 })
ADD_LOOTABLE_OBJECT(
"trashcan",
"trashcan",
"models/maxib123/trashcan.mdl",
 {
	 
    "4:scraps_of_rubber:1-6",
    "4:scraps_of_gold:1-6",
    "4:scraps_of_steel:1-6",
    "2:ingot_of_copper:1-1",
    "4:scraps_of_cloth:1-6",
    "4:Scraps_of_aluminum:1-6",
    "10:hair_brush:1-1",
    "2:roll_of_leather:1-1",
    "2:scrap_electronics:1-1",
    "10:ear_examiner:1-1",
    "1:varmintrifle:1-1",
    "10:duct_tape:1-1",
    "2:circuitry:1-1",
    "2:scrap_wood:1-1",
    "10:harmonica:1-1",
 })
     
 
ADD_LOOTABLE_OBJECT(
"cig",
"cig",
"models/mosi/fnv/props/junk/cigarettepack.mdl",
 {
    "4:scraps_of_rubber:1-6",
    "4:scraps_of_gold:1-6",
    "4:scraps_of_steel:1-6",
    "100:scraps_of_cloth:1-1",
    "4:Scraps_of_aluminum:1-6",
    "10:hair_brush:1-1",
    "2:box_of_screws:1-1",
    "2:scrap_electronics:1-1",
    "10:ear_examiner:1-1",
    "5:varmintrifle:1-1",
    "10:duct_tape:1-1",
    "2:circuitry:1-1",
    "2:scrap_wood:1-1",
    "10:harmonica:1-1",
 })

 ADD_LOOTABLE_OBJECT(
"vaultcrate1",
"Vault-tec Crate",
"models/mosi/fallout4/props/fortifications/vaultcrate01.mdl",
 {
    "4:scraps_of_rubber:1-6",
    "4:scraps_of_gold:1-6",
    "4:scraps_of_steel:1-6",
    "100:scraps_of_cloth:1-1",
    "4:Scraps_of_aluminum:1-6",
    "10:hair_brush:1-1",
    "2:box_of_screws:1-1",
    "2:scrap_electronics:1-1",
    "2:jar_of_antiseptics:1-1",
    "10:ear_examiner:1-1",
    "5:varmintrifle:1-1",
    "10:duct_tape:1-1",
    "2:circuitry:1-1",
    "2:scrap_wood:1-1",
    "10:harmonica:1-1",
 })
ADD_LOOTABLE_OBJECT(
"vaultcrate2",
"Vault-tec Crate",
"models/mosi/fallout4/props/fortifications/vaultcrate02.mdl",
 {
    "4:scraps_of_rubber:1-6",
    "4:scraps_of_gold:1-6",
    "4:scraps_of_steel:1-6",
    "100:scraps_of_cloth:1-1",
    "4:Scraps_of_aluminum:1-6",
    "10:hair_brush:1-1",
    "2:box_of_screws:1-1",
    "2:scrap_electronics:1-1",
    "2:jar_of_asbestos:1-1",
    "10:ear_examiner:1-1",
    "5:varmintrifle:1-1",
    "10:duct_tape:1-1",
    "2:circuitry:1-1",
    "2:scrap_wood:1-1",
    "10:harmonica:1-1",
    "3:gun_powder:1-1",
 })
ADD_LOOTABLE_OBJECT(
"vaultcrate3",
"Vault-tec Crate",
"models/mosi/fallout4/props/fortifications/vaultcrate03.mdl",
 {
    "4:scraps_of_rubber:1-6",
    "4:scraps_of_gold:1-6",
    "4:scraps_of_steel:1-6",
    "100:scraps_of_cloth:1-1",
    "4:Scraps_of_aluminum:1-6",
    "10:hair_brush:1-1",
    "2:box_of_screws:1-1",
    "2:scrap_electronics:1-1",
    "10:ear_examiner:1-1",
    "5:varmintrifle:1-1",
    "10:duct_tape:1-1",
    "2:circuitry:1-1",
    "2:scrap_wood:1-1",
    "10:harmonica:1-1",
 })
ADD_LOOTABLE_OBJECT(
"vaultcrate4",
"Vault-tec Crate",
"models/mosi/fallout4/props/fortifications/vaultcrate04.mdl",
 {
    "4:scraps_of_rubber:1-6",
    "4:scraps_of_gold:1-6",
    "4:scraps_of_steel:1-6",
    "100:scraps_of_cloth:1-1",
    "4:Scraps_of_aluminum:1-6",
    "10:hair_brush:1-1",
    "2:box_of_screws:1-1",
    "2:scrap_electronics:1-1",
    "10:ear_examiner:1-1",
    "5:varmintrifle:1-1",
    "10:duct_tape:1-1",
    "2:circuitry:1-1",
    "2:scrap_wood:1-1",
    "2:jar_of_antiseptics:1-1",
    "10:harmonica:1-1",
 })
 ADD_LOOTABLE_OBJECT(
"desk1",
"Desk",
"models/maxib123/metaldesk1.mdl",
 {
    "4:scraps_of_rubber:1-6",
    "4:scraps_of_gold:1-6",
    "4:scraps_of_steel:1-6",
    "100:scraps_of_cloth:1-1",
    "4:Scraps_of_aluminum:1-6",
    "10:hair_brush:1-1",
    "2:box_of_screws:1-1",
    "2:scrap_electronics:1-1",
    "10:ear_examiner:1-1",
    "5:varmintrifle:1-1",
    "10:duct_tape:1-1",
    "2:circuitry:1-1",
    "2:scrap_wood:1-1",
    "10:harmonica:1-1",
 })
 ADD_LOOTABLE_OBJECT(
"desk2",
"Desk",
"models/maxib123/metaldesk2.mdl",
 {
    "4:scraps_of_rubber:1-6",
    "4:scraps_of_gold:1-6",
    "4:scraps_of_steel:1-6",
    "100:scraps_of_cloth:1-1",
    "4:Scraps_of_aluminum:1-6",
    "10:hair_brush:1-1",
    "2:box_of_screws:1-1",
    "2:scrap_electronics:1-1",
    "10:ear_examiner:1-1",
    "5:varmintrifle:1-1",
    "10:duct_tape:1-1",
    "2:ingot_of_copper:1-1",
    "2:circuitry:1-1",
    "2:scrap_wood:1-1",
    "10:harmonica:1-1",
 })
 ADD_LOOTABLE_OBJECT(
"desk3",
"Desk",
"models/optinvfallout/officedesk1.mdl",
 {
    "4:scraps_of_rubber:1-6",
    "4:scraps_of_gold:1-6",
    "4:scraps_of_steel:1-6",
    "100:scraps_of_cloth:1-1",
    "3:gun_powder:1-1",
    "4:Scraps_of_aluminum:1-6",
    "10:hair_brush:1-1",
    "2:box_of_screws:1-1",
    "2:scrap_electronics:1-1",
    "10:ear_examiner:1-1",
    "5:varmintrifle:1-1",
    "10:duct_tape:1-1",
    "2:circuitry:1-1",
    "2:scrap_wood:1-1",
    "10:harmonica:1-1",
 })
 ADD_LOOTABLE_OBJECT(
"desk4",
"Desk",
"models/optinvfallout/officedeskcorner1.mdl",
 {
    "4:scraps_of_rubber:1-6",
    "4:scraps_of_gold:1-6",
    "4:scraps_of_steel:1-6",
    "100:scraps_of_cloth:1-1",
    "4:Scraps_of_aluminum:1-6",
    "10:hair_brush:1-1",
    "2:box_of_screws:1-1",
    "2:scrap_electronics:1-1",
    "10:ear_examiner:1-1",
    "5:varmintrifle:1-1",
    "10:duct_tape:1-1",
    "2:circuitry:1-1",
    "2:jar_of_antiseptics:1-1",
    "2:scrap_wood:1-1",
    "10:harmonica:1-1",
 })

 ADD_LOOTABLE_OBJECT(
"Tool_box",
"Tool Box", 
"models/clutter/toolbox.mdl", 
{  
    "10:paper_cup:1-2", 
    "100:pen:1-1",
    "3:scraps_of_copper:1-6",
    "10:pillow:1-1",   
    "12:scraps_of_rubber:1-1",
}) 
ADD_LOOTABLE_OBJECT(
"Ammo_box",
"Ammo Box", 
"models/clutter/ammobox.mdl", 
{  
    "5:22lrammo:1-1", 
    "5:308ammo:1-1",
    "5:38ammo:1-1",   
    "5:50ammo:1-1",
    "5:10ammo:1-1",
    "5:127ammo:1-1",
    "5:2ecammo:1-1",
    "5:556ammo:1-1",
    "5:5mmammo:1-1",
    "5:9mmammo:1-1",
    "5:mcfcammo:1-1",
    "5:plasmaammo:1-1",

}) 

    --plants
ADD_LOOTABLE_OBJECT(
"mutfruit",
"Mutfruit", 
"models/a31/fallout4/props/plants/mutfruit_plant.mdl", 
{  
    "35:mutfruit:1-1", 
    "2:mutfruitseeds:1-1", 
})
ADD_LOOTABLE_OBJECT(
"Corn",
"Corn", 
"models/a31/fallout4/props/plants/corn_stalk01.mdl", 
{  
    "35:cornstalk:1-1", 
    "2:cornseeds:1-1", 

})
ADD_LOOTABLE_OBJECT(
"Gourd",
"Gourd", 
"models/a31/fallout4/props/plants/melon_vine.mdl", 
{  
    "35:Gourd:1-1", 
    "2:Gourdseeds:1-1", 
})
ADD_LOOTABLE_OBJECT(
"Carrot",
"Carrot", 
"models/a31/fallout4/props/plants/carrot.mdl", 
{  
    "35:Carrot:1-1", 
    "2:Carrotseeds:1-1", 
    
})
ADD_LOOTABLE_OBJECT(
"Tato",
"Tato", 
"models/a31/fallout4/props/plants/carrot.mdl", 
{  
    "35:tato:1-1", 
    "2:tatoseeds:1-1", 
    
})
ADD_LOOTABLE_OBJECT(
"Tarberry",
"Tarberry", 
"models/a31/fallout4/props/plants/carrot.mdl", 
{  
    "35:tarberry:1-1", 
    "2:tarberryseeds:1-1", 
        
})   



POPULATE_READY = #player.GetAll() > 0 -- if there are players in the game then we can populate the map. 
 
 
function POPULATE_LOOTABLE() 
    POPULATE_READY = true
    for index,entityData in pairs(LOOTABLE_OBJECTS) do  
    local self = scripted_ents.Get("base_lootable")
    self.mdl = entityData.model
    self.items = entityData.items 

	self.PrintName = entityData.displayName  
    -- register ent as a lootable object
	LOOTABLE_OBJECTS_HASH[entityData.name] = self.items
	self.LootName = displayName
    scripted_ents.Register(self, entityData.name)
    end
end

-- this function will be called when the map loads
hook.Add("InitPostEntity", "POPULATE_LOOTABLE", POPULATE_LOOTABLE)
hook.Add("POPULATE_LOOTABLE", "POPULATE_LOOTABLE", POPULATE_LOOTABLE)
if POPULATE_READY then 
    POPULATE_LOOTABLE()
end

























































CY_LINK_LOADED = false
CHAT_LIB = CHAT_LIB or {}
CHAT_LIB.cache = CHAT_LIB.cache or {}
CHAT_LIB.currentPath = "1"
CHAT_LIB.Shop = CHAT_LIB.Shop or {}
 
local PANEL = {}   

AccessorFunc(PANEL, "horizontalMargin", "HorizontalMargin", FORCE_NUMBER)
AccessorFunc(PANEL, "verticalMargin", "VerticalMargin", FORCE_NUMBER)
AccessorFunc(PANEL, "columns", "Columns", FORCE_NUMBER)

function PANEL:Init()
	self:SetHorizontalMargin(0)
	self:SetVerticalMargin(0)  
	
	self.Rows = {}
	self.Cells = {}
end

function PANEL:AddCell(pnl)
	local cols = self:GetColumns()
	local idx = math.floor(#self.Cells/cols)+1
	self.Rows[idx] = self.Rows[idx] || self:CreateRow()

	local margin = self:GetHorizontalMargin()
	
	pnl:SetParent(self.Rows[idx])
	pnl:Dock(LEFT)
	pnl:DockMargin(0, 0, #self.Rows[idx].Items+1 < cols && self:GetHorizontalMargin() || 0, 0)
	pnl:SetWide((self:GetWide()-margin*(cols-1))/cols)

	table.insert(self.Rows[idx].Items, pnl)
	table.insert(self.Cells, pnl)
	self:CalculateRowHeight(self.Rows[idx])
end

function PANEL:CreateRow()
	local row = self:Add("DPanel")
	row:Dock(TOP)
	row:DockMargin(0, 0, 0, self:GetVerticalMargin())
	row.Paint = nil
	row.Items = {}
	return row
end

function PANEL:CalculateRowHeight(row)
	local height = 0

	for k, v in pairs(row.Items) do
		height = math.max(height, v:GetTall())
	end

	row:SetTall(height)
end

function PANEL:Skip()
	local cell = vgui.Create("DPanel")
	cell.Paint = nil
	self:AddCell(cell)
end

function PANEL:Clear()
	for _, row in pairs(self.Rows) do
		for _, cell in pairs(row.Items) do
			cell:Remove()
		end
		row:Remove()
	end

	self.Cells, self.Rows = {}, {}
end

PANEL.OnRemove = PANEL.Clear


if vgui then vgui.Register("ThreeGrid", PANEL, "DScrollPanel") end





print([[===================CHAT LIB IS LOADING LOADED===================]])
function CHAT_LIB:Focus(data)
CHAT_LIB.cache = data
CHAT_LIB.currentPath = "1"
--hook.Call("ChatFocus",data)

end

function CHAT_LIB:DisplayText()
print("[CHAT] "..self.cache.name..": "..self.cache[self.currentPath].data)
--hook.Call("ChatDisplayText",self.cache.name,self.cache[self.currentPath].data)
end

function CHAT_LIB:GetTasks()
 local e = {}
        string.gsub(self.cache[self.currentPath].choices..",bye", '([^,]+)', function(v) e[#e + 1] =    v;  end);
 return e
end
function CHAT_LIB:getTasks()
  return self:GetTasks()
end
function CHAT_LIB:getTaskResponse(id)
  return self.cache[id].response
end
function CHAT_LIB:getTaskText(id)
  return self.cache[id].data
end
function CHAT_LIB:getCurTaskText()
  return self:getTaskText(CHAT_LIB.currentPath)
end
function CHAT_LIB:DoTask(taskID,ent)
local action = CHAT_LIB.cache[taskID].action
if action == "say" then 
  self.currentPath = taskID
  self:DisplayText()
  elseif action == "close" then 
    hook.Run("goodbye_chat_api")
      elseif action == "open_shop" then 
      CHAT_LIB:construct_shop(CHAT_LIB.cache[taskID].data,ent)
    hook.Run("shop_chat_api", CHAT_LIB.cache[taskID].data)
end
end

function CHAT_LIB:doTask(taskID,ent)
  return self:DoTask(taskID,ent)
end


local meta = {} 
meta.__index = meta
function meta.__call( self )
	self.x = ( self.x or 0 ) + 1
	return self.x
end

function meta:AddNewItem(id,creditcost,materialcost)
  self.sales =  self.sales or {}
  self.sales[id] = {id,creditcost or 0 ,materialcost or {}}
  return "added item"
end

function CHAT_LIB:RegisterShop(id) 
  CHAT_LIB.Shop[id] = {["id"] = id}
      setmetatable(CHAT_LIB.Shop[id], meta)


  return CHAT_LIB.Shop[id]
end

print([[===================CHAT LIB REGISTERED FUNCTIONS===================]])
if CLIENT then  
surface.CreateFont("npc_name", {
    font = "MicrogrammaDEEBolExt", --  Use the font-name which is shown to you by your operating system Font Viewer, not the file name
    extended = false,
    size = 32,
    weight = 100,
})
surface.CreateFont("preview-desc222", {
    font = "mynamejeff", --  Use the font-name which is shown to you by your operating system Font Viewer, not the file name
    extended = false,
    size = 24,
    weight = 100,
})
surface.CreateFont("preview-desc222_baby", {
    font = "seoge ui light", --  Use the font-name which is shown to you by your operating system Font Viewer, not the file name
    extended = false,
    size = 16,
    weight = 60,
})
surface.CreateFont("preview-desc222_baby", {
    font = "seoge ui light", --  Use the font-name which is shown to you by your operating system Font Viewer, not the file name
    extended = false,
    size = 16,
    weight = 60,
})
surface.CreateFont("preview-choices", {
    font = "seoge ui light", --  Use the font-name which is shown to you by your operating system Font Viewer, not the file name
    extended = false,
    size = 24,
    weight = 600,
})
 surface.CreateFont("DermaDefault2", {
    font = "seoge ui light", --  Use the font-name which is shown to you by your operating system Font Viewer, not the file name
    extended = false,
    size = 42,
    weight = 600,
}) 
function CHAT_LIB:construct(data,npc) 
GLOBAL_STOP_PLAYERMOVE = true
if Frame then Frame:Remove() end
 Frame = vgui.Create( "DPanel" )
gui.EnableScreenClicker(true)
Frame:SetSize( ScrW(), ScrH() ) 
hook.Add("goodbye_chat_api","chat_window_npc", 
function() 
 -- npc:SetNoDraw(false)
  NPC_CURRENT_INTERACT_WITH = nil
Frame:Remove()  
GLOBAL_STOP_PLAYERMOVE = false
gui.EnableScreenClicker(false)
end)
Frame:SetVisible( true )  


local icon = vgui.Create( "DModelPanel", Frame )
icon:SetSize(ScrW()/2,60)
icon:Dock(LEFT)
icon:SetFOV(29.69)
icon:SetVisible(false)
icon:SetModel( npc:GetModel() )
function icon:LayoutEntity( ent ) return ent:SetAngles(Angle(0, 60,  0)) end 
function icon.Entity:GetPlayerColor() return Vector (1, 0, 0) end
local e = icon:GetEntity()
e:SetPos(e:GetPos()-Vector(0,0,15)) 


local rightpanel =  vgui.Create( "DPanel", Frame )
rightpanel:SetSize(ScrW()/2,60)
rightpanel:Dock(RIGHT)
function rightpanel:Paint(w,h)
surface.DrawShadow(0,0,4,h,pip_color)
surface.SetDrawColor(pip_color.r,pip_color.g,pip_color.b,5)
surface.DrawRect(0,0,w,h)
end
local Chat =  vgui.Create( "DPanel", rightpanel )
Chat:SetSize(ScrW()/2,400)
Chat:SetPos(0,ScrH()/2-60)
local mouseisdown = false 
local timeSinceLastTextUpdate = 0
local NextSfx = 0
function Chat:Paint(w,h) 
	
    surface.SetDrawColor(255, 255, 255, 255) 
  
	surface.DrawShadow(100,64,w-60,2,pip_color)
    draw.SimpleText(CHAT_LIB.cache.name, "npc_name", w/2, 32, Color( 255, 255, 255, 255 ),TEXT_ALIGN_CENTER,TEXT_ALIGN_TOP)

    local agenda,height = surface.textWrap2(CHAT_LIB:getCurTaskText(), "preview-desc222", w-64)
	timeSinceLastTextUpdate = timeSinceLastTextUpdate  + (FrameTime()*100 )
		if #agenda < timeSinceLastTextUpdate then NextSfx = timeSinceLastTextUpdate+10 end
	agenda = agenda:sub(0,timeSinceLastTextUpdate)

		if timeSinceLastTextUpdate > NextSfx then 
		surface.PlaySound( "pipboy/ui_talk.wav" )
		NextSfx =  timeSinceLastTextUpdate+math.random(10,15) 
		end
    draw.DrawNonParsedText(agenda, "preview-desc222", 32, 70, color_white, 0)
    height = height * 26 
    height = height + 92 
    local tasks = CHAT_LIB:GetTasks()
    for i,v in pairs(tasks) do 

		
    local x,y = input.GetCursorPos() 
    x,y = self:ScreenToLocal(x,y)
    local rs = CHAT_LIB:getTaskResponse(v)
    local tlen = surface.GetTextSize(rs)
    local isHover = 80 < x and x < 16+tlen and  height < y and y < height+28  
      draw.SimpleText(rs, "preview-choices", 100, height, isHover and Color( pip_color.r/2,pip_color.g/2, pip_color.b/2 ) or pip_color ,TEXT_ALIGN_LEFT,TEXT_ALIGN_TOP)
    height = height+32
    if isHover  and input.IsMouseDown(MOUSE_LEFT) then 
    CHAT_LIB:DoTask(v,npc)
	timeSinceLastTextUpdate=0
	NextSfx = 0
    end
end

    gui.InternalMouseReleased( MOUSE_LEFT)
end

end

function CHAT_LIB:construct_shop(data, plyr) 
print("data",plyr)
local r_dt = data
data = CHAT_LIB.Shop[data]
PrintTable(CHAT_LIB.Shop)
if Frame then Frame:Remove() end
 Frame = vgui.Create( "DPanel" )
gui.EnableScreenClicker(true)
Frame:SetSize( ScrW(), ScrH() ) 
hook.Add("goodbye_chat_api","chat_window_npc", 
function() 
Frame:Remove()  

gui.EnableScreenClicker(false)
end)
Frame:SetVisible( true ) 


local icon = vgui.Create( "DModelPanel", Frame )
icon:SetSize(ScrW()/2,60)
icon:Dock(LEFT)
icon:SetFOV(29.69)
icon:SetModel( plyr:GetModel() )
icon:SetVisible(false)
function icon:LayoutEntity( ent ) return ent:SetAngles(Angle(0, 60,  0)) end 
function icon.Entity:GetPlayerColor() return Vector (1, 0, 0) end
local e = icon:GetEntity()
e:SetPos(e:GetPos()-Vector(0,0,15)) 


local rightpanel =  vgui.Create( "DPanel", Frame )
rightpanel:SetSize(ScrW()/2,60)
rightpanel:Dock(RIGHT)

local Chat =  vgui.Create( "DPanel", rightpanel )
Chat:SetSize(ScrW()/2,600+32)
Chat:SetPos(0,ScrH()/2-300)
local grid =  vgui.Create( "ThreeGrid", Chat )
function Chat:Paint(w,h) 
surface.DrawRect(0, 0, w, h)
end

function rightpanel:PaintOver(w,h) 
local x,y = Chat:GetPos()
surface.DrawLine(w/4, y-5, w-(w/4),y-5)
surface.DrawLine(w/4, y-4, w-(w/4),y-4)
draw.SimpleText(CHAT_LIB.cache.name, "npcdisplayname", w/2, y-8, color_white, TEXT_ALIGN_CENTER,TEXT_ALIGN_BOTTOM)
end
local mouseisdown = false 

gui.InternalMouseReleased( MOUSE_LEFT)




local PANEL={}
 
function PANEL:Init()
end

function PANEL:SetItemID(itemID,cost,matcost)
itemID = string.lower( itemID )
print("PNL",itemID)
self.cost = cost or 0
self.ref = nut.item.list[itemID]
self.matcost = matcost or 0

   local agenda,height = surface.textWrap2(self.ref.name, "preview-desc222", self:GetWide()-100)


  self.agenda = agenda
  self.lines = height

end


function PANEL:Paint(x,y) 

  surface.SetDrawColor(self.ref.color or color_white) -- RARITY
  surface.DrawOutlinedRect(0, 0, x, y)
  surface.DrawOutlinedRect(0, 0, 92, y)
   draw.DrawNonParsedText(self.agenda, "preview-desc222", 100, 32 + 26 - (self.lines*26), color_white, 0)

    surface.SetFont("preview-desc222_baby")
      surface.SetTextPos(100, 54)
  surface.DrawText(self.ref.category)
      surface.SetTextPos(100, 70)
        surface.SetDrawColor(color_white)
  surface.DrawText("Cost: ")
 -- surface.SetMaterial(self.ref.Icon)
  if !(LocalPlayer():getChar():getMoney() >= self.cost) then 
        surface.SetTextColor(255,100,100,255)
        else 
 surface.SetTextColor(100,255,100,255)
        end 
    surface.DrawText(self.cost .." cR")
 
      if self.matcost[1] then 
     surface.DrawText(" 1x " .. nut.item.list[self.matcost[1][1]]:getName())
     end
  surface.DrawTexturedRect(1, 1, 90, 90)
  return true
end
 
  vendor_hover_item = nil

function PANEL:OnMousePressed()
local built_string = "Buy " .. self.ref:getName() .. " For " .. "100" .. " Credits"
  Derma_Query(built_string,"Confirmation", 
  "Buy", function () net.Start("chat_merchant_start") 
  net.WriteString(self.ref.uniqueID) 
  net.WriteString(r_dt)
  net.SendToServer()
  end,  
  "Cancel", function() end)
 end
function PANEL:OnCursorEntered() 
    vendor_hover_item = self.ref
    local built_ = ""
    for i,v in pairs (self.matcost) do 
    local V = nut.item.list[v[1]]
    local canAfford = "'155,251,321'" -- TODO Add Color 
      built_ = built_.."<color="..canAfford..">\n       "..v[2] .."x " .. V:getName() .. "</color>"
    end
        self.ref.markup =  nut.markup.parse(
        "<font=nutItemDescFont>"..self.ref:getDesc().."\n\nCost: "..self.cost.." Credits"..built_.."</font>",
        300
    )
end
function PANEL:OnCursorExited()
    vendor_hover_item = nil
end

hook.Add("DrawOverlay", "ItemGIveDESC", function() 
    local x,y = input.GetCursorPos()
    
if vendor_hover_item then 
local self = vendor_hover_item


if (self.markup) then
    local s_W,s_H = math.max(300,self.markup:getWidth()), self.markup:getHeight()
    x = x - (s_W/2)
    y = y + 32
    surface.SetDrawColor(0, 0, 0, 230)
    surface.DrawRect(x-8, y-8, s_W+16, s_H+32+16)
    draw.SimpleText(self:getName(), "DermaDefault2", s_W/2+x, y, self.color or Color(255,255,255,255), TEXT_ALIGN_CENTER)
    self.markup:draw(x, y+32, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 255) 
    
else 


end

end

end)

vgui.Register( "merchant_item_frame", PANEL, "Panel" )






grid:Dock(FILL)
grid:DockMargin(4, 4, 4, 4)
grid:InvalidateParent(true)
grid:SetColumns(3)
grid:SetHorizontalMargin(7)
grid:SetVerticalMargin(7)


local DermaButton = vgui.Create( "DPanel", Chat ) 

DermaButton:Dock(BOTTOM)
DermaButton:SetSize( 250, 48 )		
DermaButton:InvalidateLayout(true)
DermaButton:InvalidateParent(true)
local wide = DermaButton:GetWide()
local DermaButtonBACK = vgui.Create( "DButton", DermaButton ) 


DermaButtonBACK:SetSize( 48, 48 )		
DermaButtonBACK:SetText("<")
DermaButtonBACK:SetPos((wide/2)-96)
DermaButtonBACK:SetTextColor(color_white)
local DermaButtonForward = vgui.Create( "DButton", DermaButton ) 


DermaButtonForward:SetSize( 48, 48 )		
DermaButtonForward:SetText(">")
DermaButtonForward:SetPos((wide/2)+96)
DermaButtonForward:SetTextColor(color_white)
local selectedPage = 0
function DermaButton:Paint(w,h)
draw.SimpleText(self.TEXT, "preview-desc222", w/2 +24, 24, Color( 255, 255, 255, 255 ),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
end
DermaButton.TEXT = "error"
local GoBack_ = vgui.Create( "DButton", DermaButton ) 


GoBack_:SetSize( 128, 48 )		
GoBack_:SetText("Go Back")
GoBack_:SetFont("preview-desc222")
GoBack_:SetTextColor(color_white)
local offset = 12

local amtOfItems = table.Count(data.sales)
local maxpages = math.ceil(amtOfItems/offset)
DermaButton.TEXT = "PAGE " .. selectedPage+1 .. "/" .. maxpages
function GoBack_:DoClick() 
 CHAT_LIB:construct(nil,NPC_CURRENT_INTERACT_WITH)
end
local function construct_itempnl(page)
grid:Clear()
  page = page or 0
  local db_items = data.sales

    
  local start = page * offset

  local _end = start + offset -- OFFSET HOW MANY ITEMS PER PAGE
  local curIt = -1 
  
  for i,v in pairs(db_items) do
  curIt = curIt + 1 

    if (curIt >= start and curIt < _end ) then   
    local pnl = vgui.Create("merchant_item_frame")
    pnl:SetHeight(92)
    grid:AddCell(pnl)
    pnl:SetItemID(v[1],v[2],v[3])
   
    end
  end
end
construct_itempnl(selectedPage) 

local function Nextpage(c) 
selectedPage = (selectedPage + (c and 1 or -1)) % maxpages
DermaButton.TEXT = "PAGE " .. selectedPage+1 .. "/" .. maxpages
construct_itempnl(selectedPage)
end
function DermaButtonForward:DoClick() 
Nextpage(true)
end
function DermaButtonBACK:DoClick() 
Nextpage(false)
end
end


end






local shop = CHAT_LIB:RegisterShop("basic_shop")
shop:AddNewItem("weapon_revolver",99999999)


local shop2 = CHAT_LIB:RegisterShop("upgrade_shop")


if SERVER then util.AddNetworkString("network_npc_interact") util.AddNetworkString("chat_merchant_start") 
  net.Receive("chat_merchant_start", function(len,ply)
    local item = net.ReadString()
    local info = CHAT_LIB.Shop[net.ReadString()]
 
    if ply:getChar():getMoney() > info.sales[item][2] then 
    ply:getChar():setMoney( ply:getChar():getMoney() - info.sales[item][2]) 
    ply:getChar():getInv():add(item, 1)
    end
   end)
end
 
if CLIENT then 
local function safeText(text)
    return string.match(text, "^#([a-zA-Z_]+)$") and text .. " " or text
end

local function charWrap(text, remainingWidth, maxWidth)
    local totalWidth = 0

    text = text:gsub(".", function(char)
        totalWidth = totalWidth + surface.GetTextSize(char)

        -- Wrap around when the max width is reached
        if totalWidth >= remainingWidth then
            -- totalWidth needs to include the character width because it's inserted in a new line
            totalWidth = surface.GetTextSize(char)
            remainingWidth = maxWidth
            return "\n" .. char
        end

        return char
    end)

    return text, totalWidth
end

function draw.DrawNonParsedText(text, font, x, y, color, xAlign)
    return draw.DrawText(   (text), font, x, y, color, xAlign)
end

function draw.DrawNonParsedSimpleText(text, font, x, y, color, xAlign, yAlign)
    return draw.SimpleText(safeText(text), font, x, y, color, xAlign, yAlign)
end

function draw.DrawNonParsedSimpleTextOutlined(text, font, x, y, color, xAlign, yAlign, outlineWidth, outlineColor)
    return draw.SimpleTextOutlined(safeText(text), font, x, y, color, xAlign, yAlign, outlineWidth, outlineColor)
end

function surface.DrawNonParsedText(text)
    return surface.DrawText(safeText(text))
end

function surface.textWrap(text, font, maxWidth)
    local totalWidth = 0
    local spaces = 0
    surface.SetFont(font)

    local spaceWidth = surface.GetTextSize(' ')
    text = text:gsub("(%s?[%S]+)", function(word)
            local char = string.sub(word, 1, 1)
            if char == "\n" or char == "\t" then
                totalWidth = 0
            end

            local wordlen = surface.GetTextSize(word)
            totalWidth = totalWidth + wordlen

            -- Wrap around when the max width is reached
            if wordlen >= maxWidth then -- Split the word if the word is too big
                local splitWord, splitPoint = charWrap(word, maxWidth - (totalWidth - wordlen), maxWidth)
                totalWidth = splitPoint
                return splitWord
            elseif totalWidth < maxWidth then
                return word
            end

            -- Split before the word
            if char == ' ' then
                totalWidth = wordlen - spaceWidth
                return '\n' .. string.sub(word, 2)
            end

            totalWidth = wordlen
            return '\n' .. word
        end)

    return text
end

function surface.textWrap2(text, font, maxWidth)
    local totalWidth = 0
    local spaces = 1
    surface.SetFont(font)

    local spaceWidth = surface.GetTextSize(' ')
    text = text:gsub("(%s?[%S]+)", function(word)
            local char = string.sub(word, 1, 1)
            if char == "\n" or char == "\t" then
                totalWidth = 0
            end

            local wordlen = surface.GetTextSize(word)
            totalWidth = totalWidth + wordlen

            -- Wrap around when the max width is reached
            if wordlen >= maxWidth then -- Split the word if the word is too big
                local splitWord, splitPoint = charWrap(word, maxWidth - (totalWidth - wordlen), maxWidth)
                totalWidth = splitPoint
                return splitWord
            elseif totalWidth < maxWidth then
                return word
            end

            -- Split before the word
            if char == ' ' then
                totalWidth = wordlen - spaceWidth
                spaces = spaces + 1
                return '\n' .. string.sub(word, 2)
            end

            totalWidth = wordlen
            spaces = spaces + 1
            return '\n' .. word
        end)

    return text,spaces
end
local Appoc = 0
net.Receive("network_npc_interact", function () 
    local self = net.ReadEntity()
    vendor_hover_item = nil
    CHAT_LIB:Focus(self.Dialog)
    CHAT_LIB:construct(nil,self)
    NPC_CURRENT_INTERACT_WITH = self
   Appoc = 0
   NextSfx = 0
end)


hook.Add( "CalcView", "_", function( ply, pos, angles, fov )
	if NPC_CURRENT_INTERACT_WITH then 
		Appoc = math.Approach( Appoc, 1, FrameTime()*5 )

		    local eyes = NPC_CURRENT_INTERACT_WITH:GetAttachment(NPC_CURRENT_INTERACT_WITH:LookupAttachment("eyes"))  
    local view = {
        origin = eyes.Pos,
        angles = eyes.Ang,
        fov = 60, 
        }

    
		local e = NPC_CURRENT_INTERACT_WITH
	 view = {
		origin = LerpVector(Appoc,pos,eyes.Pos -  (e:GetRight()*5) -  (e:GetForward()*-15)), --- ( angles:Forward() * 100 ),
		angles = LerpAngle( Appoc, angles, Angle(eyes.Ang.x,eyes.Ang.y+160,eyes.Ang.z) )  ,
		fov = Lerp(Appoc,fov,100),
		drawviewer = false
	}
	
	return view
	end
end )


end 

local filefunc = CLIENT and include or function(n) AddCSLuaFile(n) return include(n) end
for i,v in pairs(file.Find( "npcs/*.lua" , "LUA" )) do
    print(v)
  local npc = filefunc("npcs/" .. v)
  if npc then 
  function npc:Use(user)  
    if SERVER then 
    net.Start("network_npc_interact") 
    net.WriteEntity(self) 
    net.Send(user) 
    end
  end 
  
  scripted_ents.Register( npc, "npc_"..v )
  print("LOGGED","npc_"..v) 
  end
end filefunc = nil -- Clear memory 

GLOBAL_STOP_PLAYERMOVE = false
if CLIENT then 
  hook.Add("CreateMove","LockPlayerMove",function(cmd)

  if GLOBAL_STOP_PLAYERMOVE then 
  cmd:ClearMovement()
  cmd:SetMouseX(0)
  cmd:SetMouseY(0)
  end
  end)
end 


CY_LINK_LOADED = true


local parentLookup = {}
local function cacheParents()
	parentLookup = {}
	local tbl = ents.GetAll()
	for i=1, #tbl do
		local v = tbl[i]
		if v:EntIndex() == -1 then
			local parent = v:GetInternalVariable("m_hNetworkMoveParent")
			local children = parentLookup[parent]
			if not children then children = {}; parentLookup[parent] = children end
			children[#children + 1] = v
		end
	end
end

local function fixChildren(parent, transmit)
	local tbl = parentLookup[parent]
	if tbl then
		for i=1, #tbl do
			local child = tbl[i]
			if transmit then
				print("parented " .. tostring(child) .. " to " .. tostring(parent))
				child:SetNoDraw(false)
				child:SetParent(parent)
				fixChildren(child, transmit)
			else
				print("parent " .. tostring(parent) .. " is dorment. hiding " .. tostring(child))
				child:SetNoDraw(true)
				fixChildren(child, transmit)
			end
		end
	end
end

local lastTime = 0
hook.Add("NotifyShouldTransmit", "npc_fix", function(ent, transmit)
	local time = RealTime()
	if lastTime < time  and not ent:IsPlayer() then
	
		cacheParents()
		lastTime = time
		
	end
	if  not ent:IsPlayer() then
	fixChildren(ent, transmit)
	end
end)
