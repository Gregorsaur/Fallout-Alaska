local FoodItems = {}

local function FOODstruct(self)
    return {
        {0.5, "HP: +" .. self.HPHeal},
        {0.5, "RAD: +" .. self.Rads},
        {1, "HUNGER: +" .. self.hunger},
        {1, "THIRST: +" .. self.thirst},
    }
end

local function Drinkstruct(self)
    return {
        {0.5, "HP: +" .. self.HPHeal},
        {0.5, "RAD: +" .. self.Rads},
        {1, "HUNGER: +" .. self.hunger},
        {1, "THIRST: +" .. self.thirst},
    }
end

local items_to_give = {"scraps_of_rubber", "Scraps_of_leather", "scraps_of_cloth", "scraps_of_steel", "scraps_of_lead", "scraps_of_gold", "scraps_of_copper", "Scraps_of_aluminum", "springs", "screws", "gears", "scrap_metal", "scrap_wood", "scrap_electronics",}

local items_to_change = {"rock", "abraxo", "alarm_clock", "antifreeze", "baby_rattle", "baseball", "big_spoon", "broken_recorder", "burnt_book", "camera", "cat_bowl", "chalk", "chess_board", "cigarette_pack", "dog_bowl", "duct_tape", "ear_examiner", "empty_milk_bottle", "fishing_rod", "folder", "hair_brush", "hallucigen_gas_canister", "handcuffs", "handheld_iron", "harmonica", "high_powered_magnet", "injector", "laundry_detergent", "lightbulb", "medical_liquid_nitrogen_dispenser", "nuke_truck", "paintbrush", "paper_cup", "pen", "pencil", "pillow", "plunger", "pool_ball", "rat_poison", "screwdriver", "sensor", "sensor_module", "shot_glass", "soap", "spatula", "spork", "steamcleaner_iron", "teacup", "teddy_bear", "tongs", "toothpaste", "trifold_american_flag", "tritool", "turpentine", "vaccum_tube", "wrench"}

local function OnUse(self, client)
    local pl = self:getOwner()
    local hunger = pl:getChar():getData("hunger")
    local thirst = pl:getChar():getData("thirst")
    pl:SetHunger(math.Clamp(hunger + self.hunger or 0, 0, 200))
    pl:SetThirst(math.Clamp(thirst + self.thirst or 0, 0, 200))
    pl:getChar():setData("rad", pl:getChar():getData("rad", 0) + self.Rads)

    if self.HPHeal then
        for i = 1, 4 do
            timer.Simple(0.2 * i, function()
                pl:Heal(self.HPHeal * 0.5)
            end)
        end
    end

    if self.thirst > 0 and self.hunger == 0 then
        pl:EmitSound("items/ui_cold_drink.wav")
    else
        pl:EmitSound("ui/eating_food_01.wav")
    end

    return true
end

function FoodItems:Create(id, Display, weight, m, model, drink)
    local ITEM = nut.item.list[id] or nut.item.register(id, nil, nil, nil, true)
    ITEM.name = Display
    ITEM.weight = weight or 0.001
    ITEM.desc = "NULL"
    ITEM.category = "FOOD"
    ITEM.model = model
    ITEM.isStackable = true
    ITEM.maxQuantity = 1
    ITEM.type = "FOOD"
    ITEM.HPHeal = 0
    ITEM.Rads = 1
    ITEM.STARVATION = 0
    ITEM.CacheStruct = false
    ITEM.hunger = 0
    ITEM.thirst = 0

    function ITEM:struct()
        return {
            {0.5, "HP: +" .. self.HPHeal},
            {0.5, "RAD: " .. (self.Rads > 0 and "+" or "") .. self.Rads},
            {1, "HUNGER: +" .. self.hunger},
            {1, "THIRST: +" .. self.thirst},
        }
    end

    if drink then
        ITEM.struct = Drinkstruct
    end

    -- sorry, for name order.
    ITEM.functions.Banish = {
        name = "Banish",
        tip = "equipTip",
        icon = "icon16/cross.png",
        onRun = function(item) return false end,
        onCanRun = function(item) return true end
    }

    ITEM.functions.use = {
        onRun = OnUse,
        onCanRun = function(item) return true end
    }

    ITEM.Icon = Material("icons/" .. m)

    return nut.item.list[id]
end

local function CreateFoodItems()
    local carrot = FoodItems:Create("(f)carrot", "(f) Carrot", 0.5, "alaskaicon/items/items_carrot.png", "models/a31/fallout4/props/plants/carrot_item.mdl")
    carrot.value = 5
    carrot.HPHeal = 12
    carrot.hunger = 45
    carrot.Rads = 3
    carrot.category = "FOOD"
    local tarberry = FoodItems:Create("tarberry", "(f) Tarberry", 0.5, "alaskaicon/items/item_caravan_lunch.png", "models/fallout/consumables/tarberry.mdl")
    tarberry.value = 5
    tarberry.HPHeal = 5
    tarberry.hunger = 45
    tarberry.Rads = 1
    tarberry.category = "FOOD"
    local gourd = FoodItems:Create("gourd", "(f) Gourd", 0.5, "alaskaicon/items/item_caravan_lunch.png", "models/mosi/fnv/props/buffalogourd.mdl")
    gourd.value = 5
    gourd.HPHeal = 10
    gourd.hunger = 45
    gourd.Rads = 1
    gourd.category = "FOOD"
    local tato = FoodItems:Create("tato", "(f) Tato", 0.5, "alaskaicon/items/item_caravan_lunch.png", "models/a31/fallout4/props/plants/tato_item.mdl")
    tato.value = 5
    tato.HPHeal = 5
    tato.hunger = 45
    tato.Rads = 1
    tato.category = "FOOD"
    local mutfruit = FoodItems:Create("mutfruit", "(f) Mutfruit", 0.5, "alaskaicon/items/item_caravan_lunch.png", "models/mosi/fallout4/props/food/mutfruit.mdl")
    mutfruit.value = 5
    mutfruit.HPHeal = 5
    mutfruit.hunger = 45
    mutfruit.Rads = 1
    mutfruit.category = "FOOD"
    local cornstalk = FoodItems:Create("cornstalk", "(f) Corn", 0.5, "alaskaicon/items/item_caravan_lunch.png", "models/a31/fallout4/props/plants/corn_item.mdl")
    cornstalk.value = 5
    cornstalk.HPHeal = 5
    cornstalk.hunger = 45
    cornstalk.Rads = 1
    cornstalk.category = "FOOD"
    --drinks 
    local stimmy = FoodItems:Create("Stimpack", "(f) Stimpack", 0.5, "alaskaicon/items/items_cola.png", "models/fallout/autoinjectstimpak.mdl", true)
    stimmy.value = 5
    stimmy.HPHeal = 100
    stimmy.category = "AID"
    stimmy.type = "AID"

    stimmy.functions.use.onRun = function(item, n)
        item:getOwner():addMoney(1)
        item:getOwner():notify("You inject a stimpack")
        item:getOwner():EmitSound("ui/stim.wav")

        return OnUse(item, n)
    end

    local sstimmy = FoodItems:Create("Super-Stimpack", "(f) Super-Stimpack", 0.5, "alaskaicon/items/items_cola.png", "models/fallout/autoinjectstimpak.mdl", true)
    sstimmy.value = 5
    sstimmy.HPHeal = 150
    sstimmy.category = "AID"
    sstimmy.type = "AID"

    sstimmy.functions.use.onRun = function(item, n)
        item:getOwner():addMoney(1)
        item:getOwner():notify("You inject a super-stimpack")
        item:getOwner():EmitSound("ui/stim.wav")

        return OnUse(item, n)
    end

    local cola = FoodItems:Create("NukaColaClassic", "(f) Nuka-Cola Classic", 0.5, "alaskaicon/items/items_cola.png", "models/nukacola/nukacola_classic.mdl", true)
    cola.value = 5
    cola.HPHeal = 20
    cola.thirst = 40
    cola.Rads = 1
    cola.category = "FOOD"

    cola.functions.use.onRun = function(item, n)
        item:getOwner():addMoney(1)
        item:getOwner():notify("You place the bottlecap in your pocket.")

        return OnUse(item, n)
    end

    local colacherry = FoodItems:Create("NukaColaCherry", "(f) Nuka-Cola Cherry", 0.5, "alaskaicon/items/items_cola.png", "models/nukacola/nukacola_cherry.mdl", true)
    colacherry.value = 5
    colacherry.HPHeal = 20
    colacherry.thirst = 40
    colacherry.Rads = 1
    colacherry.category = "FOOD"

    colacherry.functions.use.onRun = function(item, n)
        item:getOwner():addMoney(1)
        item:getOwner():notify("You place the bottlecap in your pocket.")

        return OnUse(item, n)
    end

    local coladark = FoodItems:Create("NukaColaDark", "(f) Nuka-Cola Dark", 0.5, "alaskaicon/items/items_cola.png", "models/nukacola/nukacola_dark.mdl", true)
    coladark.value = 5
    coladark.HPHeal = 20
    coladark.thirst = 40
    coladark.Rads = 1
    coladark.category = "FOOD"

    coladark.functions.use.onRun = function(item, n)
        item:getOwner():addMoney(1)
        item:getOwner():notify("You place the bottlecap in your pocket.")

        return OnUse(item, n)
    end

    local colagrape = FoodItems:Create("NukaColaGrape", "(f) Nuka-Cola Grape", 0.5, "alaskaicon/items/items_cola.png", "models/nukacola/nukacola_grape.mdl", true)
    colagrape.value = 5
    colagrape.HPHeal = 20
    colagrape.thirst = 40
    colagrape.Rads = 1
    colagrape.category = "FOOD"

    colagrape.functions.use.onRun = function(item, n)
        item:getOwner():addMoney(1)
        item:getOwner():notify("You place the bottlecap in your pocket.")

        return OnUse(item, n)
    end

    local colaorange = FoodItems:Create("NukaColaOrange", "(f) Nuka-Cola Orange", 0.5, "alaskaicon/items/items_cola.png", "models/nukacola/nukacola_orange.mdl", true)
    colaorange.value = 5
    colaorange.HPHeal = 20
    colaorange.thirst = 40
    colaorange.Rads = 1
    colaorange.category = "FOOD"

    colaorange.functions.use.onRun = function(item, n)
        item:getOwner():addMoney(1)
        item:getOwner():notify("You place the bottlecap in your pocket.")

        return OnUse(item, n)
    end

    local colaquantum = FoodItems:Create("NukaColaQuantum", "(f) Nuka-Cola Quantum", 0.5, "alaskaicon/items/items_cola.png", "models/nukacola/nukacola_quantum.mdl", true)
    colaquantum.value = 5
    colaquantum.HPHeal = 20
    colaquantum.thirst = 40
    colaquantum.Rads = 1
    colaquantum.category = "FOOD"

    colaquantum.functions.use.onRun = function(item, n)
        item:getOwner():addMoney(1)
        item:getOwner():notify("You place the bottlecap in your pocket.")

        return OnUse(item, n)
    end

    local colaquartz = FoodItems:Create("NukaColaQuartz", "(f) Nuka-Cola Quartz", 0.5, "alaskaicon/items/items_cola.png", "models/nukacola/nukacola_quartz.mdl", true)
    colaquartz.value = 5
    colaquartz.HPHeal = 20
    colaquartz.thirst = 40
    colaquartz.Rads = 1
    colaquartz.category = "FOOD"

    colaquartz.functions.use.onRun = function(item, n)
        item:getOwner():addMoney(1)
        item:getOwner():notify("You place the bottlecap in your pocket.")

        return OnUse(item, n)
    end

    local colavictory = FoodItems:Create("NukaColaVictory", "(f) Nuka-Cola Victory", 0.5, "alaskaicon/items/items_cola.png", "models/nukacola/nukacola_victory.mdl", true)
    colavictory.value = 5
    colavictory.HPHeal = 20
    colavictory.thirst = 40
    colavictory.Rads = 1
    colavictory.category = "FOOD"

    colavictory.functions.use.onRun = function(item, n)
        item:getOwner():addMoney(1)
        item:getOwner():notify("You place the bottlecap in your pocket.")

        return OnUse(item, n)
    end

    local colawild = FoodItems:Create("NukaColaWild", "(f) Nuka-Cola Wild", 0.5, "alaskaicon/items/items_cola.png", "models/nukacola/nukacola_wild.mdl", true)
    colawild.value = 5
    colawild.HPHeal = 20
    colawild.thirst = 40
    colawild.Rads = 1
    colawild.category = "FOOD"

    colawild.functions.use.onRun = function(item, n)
        item:getOwner():addMoney(1)
        item:getOwner():notify("You place the bottlecap in your pocket.")

        return OnUse(item, n)
    end

    local colarum = FoodItems:Create("NukaColaRum", "(f) Nuka-Cola Rum", 0.5, "alaskaicon/items/items_cola.png", "models/fallout/rumnuka.mdl", true)
    colarum.value = 5
    colarum.HPHeal = 20
    colarum.thirst = 40
    colarum.Rads = 1
    colarum.category = "FOOD"

    colarum.functions.use.onRun = function(item, n)
        item:getOwner():addMoney(1)
        item:getOwner():notify("You place the bottlecap in your pocket.")

        return OnUse(item, n)
    end

    local colafusion = FoodItems:Create("NukaColaFusion", "(f) Nuka-Cola Fusion", 0.5, "alaskaicon/items/items_cola.png", "models/maxib123/nukafusion.mdl", true)
    colafusion.value = 5
    colafusion.HPHeal = 20
    colafusion.thirst = 40
    colafusion.Rads = 1
    colafusion.category = "FOOD"

    colafusion.functions.use.onRun = function(item, n)
        item:getOwner():addMoney(1)
        item:getOwner():notify("You place the bottlecap in your pocket.")

        return OnUse(item, n)
    end

    local colafrost = FoodItems:Create("NukaColaFrost", "(f) Nuka-Cola Frost", 0.5, "alaskaicon/items/items_cola.png", "models/maxib123/nukafrost.mdl", true)
    colafrost.value = 5
    colafrost.HPHeal = 20
    colafrost.thirst = 40
    colafrost.Rads = 1
    colafrost.category = "FOOD"

    colafrost.functions.use.onRun = function(item, n)
        item:getOwner():addMoney(1)
        item:getOwner():notify("You place the bottlecap in your pocket.")

        return OnUse(item, n)
    end

    local colaclear = FoodItems:Create("NukaColaClear", "(f) Nuka-Cola Clear", 0.5, "alaskaicon/items/items_cola.png", "models/maxib123/nukaclear.mdl", true)
    colaclear.value = 5
    colaclear.HPHeal = 20
    colaclear.thirst = 40
    colaclear.Rads = 1
    colaclear.category = "FOOD"

    colaclear.functions.use.onRun = function(item, n)
        item:getOwner():addMoney(1)
        item:getOwner():notify("You place the bottlecap in your pocket.")

        return OnUse(item, n)
    end

    local colablack = FoodItems:Create("NukaColaBlack", "(f) Nuka-Cola Black", 0.5, "alaskaicon/items/items_cola.png", "models/maxib123/nukablack.mdl", true)
    colablack.value = 5
    colablack.HPHeal = 20
    colablack.thirst = 40
    colablack.Rads = 1
    colablack.category = "FOOD"

    colablack.functions.use.onRun = function(item, n)
        item:getOwner():addMoney(1)
        item:getOwner():notify("You place the bottlecap in your pocket.")

        return OnUse(item, n)
    end

    --food

    local cram = FoodItems:Create("PreservedCram", "(f) Preserved Cram", 0.5, "food/Icon_MRE.png", "models/fallout 3/cram.mdl", false)
    cram.value = 1
    cram.HPHeal = 3
    cram.hunger = 22
    cram.Rads = 10
    cram.category = "FOOD"

    local dba = FoodItems:Create("DandyBoyApples", "(f) Dandy Boy Apples", 0.5, "food/Icon_MRE.png", "models/fallout 3/dandy_apples.mdl", false)
    dba.value = 1
    dba.HPHeal = 3
    dba.hunger = 45
    dba.Rads = 10
    dba.category = "FOOD"

    local instamash = FoodItems:Create("instaMash", "(f) instaMash", 0.5, "food/Icon_MRE.png", "models/fallout 3/insta_mash.mdl", false)
    instamash.value = 1
    instamash.HPHeal = 3
    instamash.hunger = 45
    instamash.Rads = 1
    instamash.category = "FOOD"

    local potatocrisps = FoodItems:Create("potatocrisps", "(f) potatocrisps", 0.5, "food/Icon_MRE.png", "models/mosi/fnv/props/food/potatocrisps.mdl", false)
    potatocrisps.value = 1
    potatocrisps.HPHeal = 3
    potatocrisps.hunger = 35
    potatocrisps.Rads = 1
    potatocrisps.category = "FOOD"

    local bubblegum = FoodItems:Create("Bubblegum", "(f) Bubblegum", 0.5, "food/Icon_MRE.png", "models/fallout 3/gum.mdl", false)
    bubblegum.value = 1
    bubblegum.HPHeal = 3
    bubblegum.hunger = 35
    bubblegum.Rads = 1
    bubblegum.category = "FOOD"

    local radioactivegumdrops = FoodItems:Create("radioactivegumdrops", "(f) radioactive gum-drops", 0.5, "food/Icon_MRE.png", "models/mosi/fnv/props/food/radioactivegumdrops.mdl", false)
    radioactivegumdrops.value = 1
    radioactivegumdrops.HPHeal = 3
    radioactivegumdrops.hunger = 55
    radioactivegumdrops.Rads = 26
    radioactivegumdrops.category = "FOOD"

    local blanco = FoodItems:Create("blancomacandcheese", "(f) Blanco Mac n Cheese", 0.5, "food/Icon_MRE.png", "models/mosi/fnv/props/food/blamcomacncheese.mdl", false)
    blanco.value = 4
    blanco.HPHeal = 10
    blanco.hunger = 25
    blanco.Rads = 10
    blanco.category = "FOOD"

    local yumyumdeviledeggs = FoodItems:Create("yumyumdeviledeggs", "(f) yum-yum deviled eggs", 0.5, "food/Icon_MRE.png", "models/mosi/fnv/props/food/yumyumdeviledeggs.mdl", false)
    yumyumdeviledeggs.value = 4
    yumyumdeviledeggs.HPHeal = 10
    yumyumdeviledeggs.hunger = 25
    yumyumdeviledeggs.Rads = 20
    yumyumdeviledeggs.category = "FOOD"

    local sb = FoodItems:Create("SugarBombs", "(f) Sugar Bombs", 0.5, "food/Icon_MRE.png", "models/fo3_sugar_bombs.mdl", false)
    sb.value = 1
    sb.HPHeal = 3
    sb.hunger = 35
    sb.Rads = 1
    sb.category = "FOOD"

    local pwater = FoodItems:Create("PurifiedWater", "(f) Purified Water", 0.5, "food/Icon_MRE.png", "models/fallout 3/water.mdl", false)
    pwater.value = 1
    pwater.HPHeal = 3
    pwater.thirst = 85
    pwater.Rads = 0
    pwater.category = "FOOD"

    local water = FoodItems:Create("DirtyWater", "(f) Dirty Water", 0.5, "food/Icon_MRE.png", "models/fallout 3/water.mdl", false)
    water.value = 1
    water.HPHeal = 3
    water.thirst = 40
    water.Rads = 10
    water.category = "FOOD"

    local ss = FoodItems:Create("SalisburySteak", "(f) Salisbury Steak", 0.5, "food/Icon_MRE.png", "models/fallout 3/steak.mdl", false)
    ss.value = 1
    ss.HPHeal = 3
    ss.hunger = 45
    ss.Rads = 1
    ss.category = "FOOD"

    local fancyladssnackcakes = FoodItems:Create("fancyladssnackcakes", "(f) Fancy-lad Snackcakes", 0.5, "food/Icon_MRE.png", "models/mosi/fnv/props/food/fancyladssnackcakes.mdl", false)
    fancyladssnackcakes.value = 5
    fancyladssnackcakes.HPHeal = 12
    fancyladssnackcakes.hunger = 35
    fancyladssnackcakes.Rads = 12
    fancyladssnackcakes.category = "FOOD"

    local flour = FoodItems:Create("flour", "(f) flour", 0.5, "food/Icon_MRE.png", "models/mosi/fnv/props/food/flour.mdl", false)
    flour.value = 5
    flour.HPHeal = 12
    flour.hunger = 35
    flour.Rads = 12
    flour.category = "FOOD"

    local yeast = FoodItems:Create("yeast", "(f) yeast", 0.5, "food/Icon_MRE.png", "models/mosi/fnv/props/food/yeast.mdl", false)
    yeast.value = 5
    yeast.HPHeal = 3
    yeast.hunger = 25
    yeast.Rads = 22
    yeast.category = "FOOD"


    --aid
    local radaway = FoodItems:Create("radaway", "(f) RadAway", 2, "food/Icon_RadAway.png", "models/mosi/fallout4/props/aid/radaway.mdl", false)
    radaway.value = 5
    radaway.HPHeal = 0
    radaway.Rads = -50
    radaway.category = "AID"
    local bloodbag = FoodItems:Create("bloodbag", "(f) Blood Bag", 2, "food/Icon_RadAway.png", "models/mosi/fallout4/props/aid/bloodbag.mdl", false)
    bloodbag.value = 5
    bloodbag.HPHeal = 50
    bloodbag.Rads = 0
    bloodbag.category = "AID"
    local doctorbag = FoodItems:Create("doctorbag", "(f) Doctor's Bag", 2, "food/Icon_RadAway.png", "models/fallout new vegas/doctor_bag.mdl", false)
    doctorbag.value = 5
    doctorbag.HPHeal = 300
    doctorbag.Rads = 0
    doctorbag.category = "AID"
    local healingpowder = FoodItems:Create("healingpowder", "(f) Healing Powder", 2, "food/Icon_RadAway.png", "models/maxib123/healingpowder.mdl", false)
    healingpowder.value = 5
    healingpowder.HPHeal = 100
    healingpowder.Rads = 0
    healingpowder.category = "AID"


    --FULLY COOKED FOOD
    local antbits = FoodItems:Create("antbits", "(f) Ant Bits", 2, "food/Icon_RadAway.png", "models/mosi/fnv/props/food/antbits.mdl", false)
    antbits.value = 55
    antbits.HPHeal = 100
    antbits.Rads = 5
    antbits.category = "FOOD"

    local yaoguai = FoodItems:Create("YaoGuaiRibs", "(f) YaoGuai Ribs", 0.5, "food/Icon_MRE.png", "models/fallout 3/meat.mdl", false)
    yaoguai.value = 1
    yaoguai.HPHeal = 3
    yaoguai.hunger = 250
    yaoguai.Rads = 15
    yaoguai.category = "FOOD"

    local bloodsausage = FoodItems:Create("bloodsausage", "(f) Blood Sausage", 0.5, "food/Icon_MRE.png", "models/mosi/fnv/props/food/bloodsausage.mdl", false)
    bloodsausage.value = 35
    bloodsausage.HPHeal = 50
    bloodsausage.hunger = 112
    bloodsausage.Rads = 5
    bloodsausage.category = "FOOD"

    local brainfood = FoodItems:Create("brainfood", "(f) Brainfood", 0.5, "food/Icon_MRE.png", "models/mosi/fnv/props/food/brainfood.mdl", false)
    brainfood.value = 35
    brainfood.HPHeal = 50
    brainfood.hunger = 107
    brainfood.Rads = 5
    brainfood.category = "FOOD"

    local desertsalad = FoodItems:Create("desertsalad", "(f) Desert Salad", 0.5, "food/Icon_MRE.png", "models/mosi/fnv/props/food/desertsalad.mdl", false)
    desertsalad.value = 12
    desertsalad.HPHeal = 3
    desertsalad.hunger = 125
    desertsalad.thist = 65
    desertsalad.Rads = 1
    desertsalad.category = "FOOD"

    local doggietreat = FoodItems:Create("doggietreat", "(f) Doggie Treat", 0.5, "food/Icon_MRE.png", "models/mosi/fnv/props/food/doggietreat.mdl", false)
    doggietreat.value = 12
    doggietreat.HPHeal = 3
    doggietreat.hunger = 85
    doggietreat.thist = 0
    doggietreat.Rads = 4
    doggietreat.category = "FOOD"

    local fireantbits = FoodItems:Create("fireantbits", "(f) Fire-Ant Bits", 0.5, "food/Icon_MRE.png", "models/mosi/fnv/props/food/fireantbits.mdl", false)
    fireantbits.value = 12
    fireantbits.HPHeal = 3
    fireantbits.hunger = 175
    fireantbits.thist = 0
    fireantbits.Rads = 4
    fireantbits.category = "FOOD"

    local roachC = FoodItems:Create("cookedroach", "(f) Roach Steak", 0.5, "food/Icon_MRE.png", "models/mosi/fallout4/props/food/radroachsteak.mdl", false)
    roachC.value = 5
    roachC.HPHeal = 15
    roachC.hunger = 150
    roachC.thirst = 100
    roachC.Rads = 6
    roachC.Angle = Angle(90, 0, 90)
    roachC.category = "FOOD"

    local geckosteak = FoodItems:Create("geckosteak", "(f) gecko steak", 0.5, "food/Icon_MRE.png", "models/mosi/fnv/props/food/geckosteak.mdl", false)
    geckosteak.value = 25
    geckosteak.HPHeal = 25
    geckosteak.hunger = 155
    geckosteak.thirst = 135
    geckosteak.Rads = 7
    geckosteak.Angle = Angle(90, 0, 90)
    geckosteak.category = "FOOD"

    local iguanabits = FoodItems:Create("iguanabits", "(f) iguanabits", 0.5, "food/Icon_MRE.png", "models/mosi/fnv/props/food/iguanabits.mdl", false)
    iguanabits.value = 15
    iguanabits.HPHeal = 25
    iguanabits.hunger = 145
    iguanabits.thirst = 125
    iguanabits.Rads = 7
    iguanabits.Angle = Angle(90, 0, 90)
    iguanabits.category = "FOOD"

    local iguanaonastick = FoodItems:Create("iguanaonastick", "(f) iguana on a stick", 0.5, "food/Icon_MRE.png", "models/mosi/fnv/props/food/iguanaonastick.mdl", false)
    iguanaonastick.value = 25
    iguanaonastick.HPHeal = 35
    iguanaonastick.hunger = 145
    iguanaonastick.thirst = 135
    iguanaonastick.Rads = 9
    iguanaonastick.Angle = Angle(90, 0, 90)
    iguanaonastick.category = "FOOD"

    local squirrelbits = FoodItems:Create("squirrelbits", "(f) squirrel bits", 0.5, "food/Icon_MRE.png", "models/mosi/fnv/props/food/squirrelbits.mdl", false)
    squirrelbits.value = 25
    squirrelbits.HPHeal = 35
    squirrelbits.hunger = 145
    squirrelbits.thirst = 135
    squirrelbits.Rads = 9
    squirrelbits.Angle = Angle(90, 0, 90)
    squirrelbits.category = "FOOD"

    local squirrelonastick = FoodItems:Create("squirrelonastick", "(f) squirrel on a stick", 0.5, "food/Icon_MRE.png", "models/mosi/fnv/props/food/squirrelonastick.mdl", false)
    squirrelonastick.value = 15
    squirrelonastick.HPHeal = 25
    squirrelonastick.hunger = 145
    squirrelonastick.thirst = 125
    squirrelonastick.Rads = 7
    squirrelonastick.Angle = Angle(90, 0, 90)
    squirrelonastick.category = "FOOD"

    local mirelurkcake = FoodItems:Create("mirelurkcake", "(f) mirelurk cake", 0.5, "food/Icon_MRE.png", "models/mosi/fnv/props/food/mirelurkcake.mdl", false)
    mirelurkcake.value = 25
    mirelurkcake.HPHeal = 25
    mirelurkcake.hunger = 145
    mirelurkcake.thirst = 165
    mirelurkcake.Rads = 4
    mirelurkcake.Angle = Angle(90, 0, 90)
    mirelurkcake.category = "FOOD"

    local mirelurkspecial = FoodItems:Create("mirelurkspecial", "(f) mirelurk special", 0.5, "food/Icon_MRE.png", "models/mosi/fnv/props/food/mirelurkspecial.mdl", false)
    mirelurkspecial.value = 55
    mirelurkspecial.HPHeal = 35
    mirelurkspecial.hunger = 155
    mirelurkspecial.thirst = 185
    mirelurkspecial.Rads = 7
    mirelurkspecial.Angle = Angle(90, 0, 90)
    mirelurkspecial.category = "FOOD"

    local mirelurksushi = FoodItems:Create("mirelurksushi", "(f) mirelurk sushi", 0.5, "food/Icon_MRE.png", "models/mosi/fnv/props/food/nukalurksushi.mdl", false)
    mirelurksushi.value = 45
    mirelurksushi.HPHeal = 33
    mirelurksushi.hunger = 165
    mirelurksushi.thirst = 175
    mirelurksushi.Rads = 5
    mirelurksushi.Angle = Angle(90, 0, 90)
    mirelurksushi.category = "FOOD"

    local mirelurkroll = FoodItems:Create("mirelurkroll", "(f) mirelurk roll", 0.5, "food/Icon_MRE.png", "models/mosi/fnv/props/food/nukalurksushi.mdl", false)
    mirelurkroll.value = 35
    mirelurkroll.HPHeal = 33
    mirelurkroll.hunger = 155
    mirelurkroll.thirst = 165
    mirelurkroll.Rads = 5
    mirelurkroll.Angle = Angle(90, 0, 90)
    mirelurkroll.category = "FOOD"

    local moleratsteak = FoodItems:Create("moleratsteak", "(f) molerat steak", 0.5, "food/Icon_MRE.png", "models/mosi/fnv/props/food/moleratsteak.mdl", false)
    moleratsteak.value = 35
    moleratsteak.HPHeal = 35
    moleratsteak.hunger = 155
    moleratsteak.thirst = 145
    moleratsteak.Rads = 7
    moleratsteak.Angle = Angle(90, 0, 90)
    moleratsteak.category = "FOOD"

    local ramen = FoodItems:Create("ramen", "(f) ramen", 0.5, "food/Icon_MRE.png", "models/mosi/fnv/props/food/ramen.mdl", false)
    ramen.value = 35
    ramen.HPHeal = 35
    ramen.hunger = 135
    ramen.thirst = 155
    ramen.Rads = 7
    ramen.Angle = Angle(90, 0, 90)
    ramen.category = "FOOD"

    local ratstew = FoodItems:Create("ratstew", "(f) rat stew", 0.5, "food/Icon_MRE.png", "models/mosi/fnv/props/food/ratstew.mdl", false)
    ratstew.value = 25
    ratstew.HPHeal = 15
    ratstew.hunger = 135
    ratstew.thirst = 125
    ratstew.Rads = 5
    ratstew.Angle = Angle(90, 0, 90)
    ratstew.category = "FOOD"

    local steamedmirelurk = FoodItems:Create("steamedmirelurk", "(f) steamed mirelurk", 0.5, "food/Icon_MRE.png", "models/mosi/fnv/props/food/steamedmirelurk.mdl", false)
    steamedmirelurk.value = 35
    steamedmirelurk.HPHeal = 25
    steamedmirelurk.hunger = 145
    steamedmirelurk.thirst = 165
    steamedmirelurk.Rads = 3
    steamedmirelurk.Angle = Angle(90, 0, 90)
    steamedmirelurk.category = "FOOD"

    local steamedradroach = FoodItems:Create("steamedradroach", "(f) steamed radroach", 0.5, "food/Icon_MRE.png", "models/mosi/fnv/props/food/steamedradroach.mdl", false)
    steamedradroach.value = 25
    steamedradroach.HPHeal = 15
    steamedradroach.hunger = 125
    steamedradroach.thirst = 125
    steamedradroach.Rads = 3
    steamedradroach.Angle = Angle(90, 0, 90)
    steamedradroach.category = "FOOD"

    local strangemeatpie = FoodItems:Create("strangemeatpie", "(f) strange meatpie", 0.5, "food/Icon_MRE.png", "models/mosi/fnv/props/food/strangemeatpie.mdl", false)
    strangemeatpie.value = 25
    strangemeatpie.HPHeal = 15
    strangemeatpie.hunger = 125
    strangemeatpie.thirst = 125
    strangemeatpie.Rads = 35
    strangemeatpie.Angle = Angle(90, 0, 90)
    strangemeatpie.category = "FOOD"

    local sweetroll = FoodItems:Create("sweetroll", "(f) sweetroll", 0.5, "food/Icon_MRE.png", "models/mosi/fnv/props/food/sweetroll.mdl", false)
    sweetroll.value = 35
    sweetroll.HPHeal = 25
    sweetroll.hunger = 155
    sweetroll.thirst = 125
    sweetroll.Rads = 1
    sweetroll.Angle = Angle(90, 0, 90)
    sweetroll.category = "FOOD"

    local wastelandhotdog = FoodItems:Create("wastelandhotdog", "(f) wasteland hotdog", 0.5, "food/Icon_MRE.png", "models/mosi/fnv/props/food/wastelandhotdog.mdl", false)
    wastelandhotdog.value = 35
    wastelandhotdog.HPHeal = 15
    wastelandhotdog.hunger = 125
    wastelandhotdog.thirst = 115
    wastelandhotdog.Rads = 1
    wastelandhotdog.Angle = Angle(90, 0, 90)
    wastelandhotdog.category = "FOOD"

    local wastelandomelette = FoodItems:Create("wastelandomelette", "(f) wasteland omelette", 0.5, "food/Icon_MRE.png", "models/mosi/fnv/props/food/wastelandomelette.mdl", false)
    wastelandomelette.value = 23
    wastelandomelette.HPHeal = 25
    wastelandomelette.hunger = 145
    wastelandomelette.thirst = 125
    wastelandomelette.Rads = 1
    wastelandomelette.Angle = Angle(90, 0, 90)
    wastelandomelette.category = "FOOD"

    local yaoguaimedallions = FoodItems:Create("yaoguaimedallions", "(f) yaoguai medallions", 0.5, "food/Icon_MRE.png", "models/mosi/fnv/props/food/yaoguaimedallions.mdl", false)
    yaoguaimedallions.value = 20
    yaoguaimedallions.HPHeal = 5
    yaoguaimedallions.hunger = 125
    yaoguaimedallions.thirst = 115
    yaoguaimedallions.Rads = 3
    yaoguaimedallions.Angle = Angle(90, 0, 90)
    yaoguaimedallions.category = "FOOD"


    --BASE FOOD
    local antegg = FoodItems:Create("antegg", "(f) Ant Eggs", 2, "food/Icon_RadAway.png", "models/mosi/fnv/props/food/antegg.mdl", false)
    antegg.value = 15
    antegg.HPHeal = 15
    antegg.Rads = 15
    antegg.hunger = 15
    antegg.category = "FOOD"

    local nightstalkeregg = FoodItems:Create("nightstalkeregg", "(f) night-stalker egg", 2, "food/Icon_RadAway.png", "models/mosi/fnv/props/food/nightstalkeregg.mdl", false)
    nightstalkeregg.value = 15
    nightstalkeregg.HPHeal = 5
    nightstalkeregg.Rads = 25
    nightstalkeregg.hunger = 5
    nightstalkeregg.category = "FOOD"

    local nightstalkertail = FoodItems:Create("nightstalkeregg", "(f) night-stalker tail", 2, "food/Icon_RadAway.png", "models/mosi/fnv/props/food/nightstalkertail.mdl", false)
    nightstalkertail.value = 15
    nightstalkertail.HPHeal = 5
    nightstalkertail.Rads = 27
    nightstalkertail.hunger = 25
    nightstalkertail.category = "FOOD"

    local fireantegg = FoodItems:Create("fireantegg", "(f) Fire Ant Eggs", 2, "food/Icon_RadAway.png", "models/mosi/fnv/props/food/fireantegg.mdl", false)
    fireantegg.value = 5
    fireantegg.HPHeal = 25
    fireantegg.Rads = 15
    fireantegg.hunger = 15
    fireantegg.category = "FOOD"

    local geckoegg = FoodItems:Create("geckoegg", "(f) gecko egg", 2, "food/Icon_RadAway.png", "models/mosi/fnv/props/food/geckoegg.mdl", false)
    geckoegg.value = 5
    geckoegg.HPHeal = 5
    geckoegg.Rads = 15
    geckoegg.hunger = 15
    geckoegg.category = "FOOD"

    local goldengeckoegg = FoodItems:Create("goldengeckoegg", "(f) golden gecko egg", 2, "food/Icon_RadAway.png", "models/mosi/fnv/props/food/goldengeckoegg.mdl", false)
    goldengeckoegg.value = 5
    goldengeckoegg.HPHeal = 5
    goldengeckoegg.Rads = 15
    goldengeckoegg.hunger = 15
    goldengeckoegg.category = "FOOD"

    local firegeckoegg = FoodItems:Create("firegeckoegg", "(f) fire-gecko egg", 2, "food/Icon_RadAway.png", "models/mosi/fnv/props/food/firegeckoegg.mdl", false)
    firegeckoegg.value = 5
    firegeckoegg.HPHeal = 5
    firegeckoegg.Rads = 15
    firegeckoegg.hunger = 15
    firegeckoegg.category = "FOOD"

    local geckomeat = FoodItems:Create("geckomeat", "(f) gecko meat", 2, "food/Icon_RadAway.png", "models/mosi/fnv/props/food/doggietreat.mdl", false)
    geckomeat.value = 5
    geckomeat.HPHeal = 5
    geckomeat.Rads = 15
    geckomeat.hunger = 15
    geckomeat.category = "FOOD"

    local moleratmeat = FoodItems:Create("moleratmeat", "(f) mole rat meat", 2, "food/Icon_RadAway.png", "models/mosi/fnv/props/food/doggietreat.mdl", false)
    moleratmeat.value = 5
    moleratmeat.HPHeal = 5
    moleratmeat.Rads = 15
    moleratmeat.hunger = 15
    moleratmeat.category = "FOOD"

    local mirelurkegg = FoodItems:Create("mirelurkegg", "(f) mirelurk egg", 2, "food/Icon_RadAway.png", "models/mosi/fnv/props/food/mirelurkegg.mdl", false)
    mirelurkegg.value = 5
    mirelurkegg.HPHeal = 5
    mirelurkegg.Rads = 25
    mirelurkegg.hunger = 5
    mirelurkegg.category = "FOOD"

    local radscorpionegg = FoodItems:Create("radscorpionegg", "(f) radscorpion egg", 2, "food/Icon_RadAway.png", "models/mosi/fnv/props/food/radscorpionegg.mdl", false)
    radscorpionegg.value = 5
    radscorpionegg.HPHeal = 5
    radscorpionegg.Rads = 35
    radscorpionegg.hunger = 15
    radscorpionegg.category = "FOOD"

    local scorpionpoisongland = FoodItems:Create("scorpionpoisongland", "(f) rad-scorpion poison gland", 2, "food/Icon_RadAway.png", "models/mosi/fnv/props/food/scorpionpoisongland.mdl", false)
    scorpionpoisongland.value = 5
    scorpionpoisongland.HPHeal = -25
    scorpionpoisongland.Rads = 55
    scorpionpoisongland.hunger = 15
    scorpionpoisongland.category = "FOOD"

    local antmeat = FoodItems:Create("antmeat", "(f) Ant Meat", 2, "food/Icon_RadAway.png", "models/mosi/fnv/props/food/antmeat.mdl", false)
    antmeat.value = 5
    antmeat.HPHeal = 15
    antmeat.Rads = 12
    antmeat.hunger = 15
    antmeat.category = "FOOD"

    local fireantmeat = FoodItems:Create("fireantmeat", "(f) fire Ant Meat", 2, "food/Icon_RadAway.png", "models/mosi/fnv/props/food/fireantmeat.mdl", false)
    fireantmeat.value = 5
    fireantmeat.HPHeal = 5
    fireantmeat.Rads = 5
    fireantmeat.hunger = 15
    fireantmeat.category = "FOOD"

    local roach = FoodItems:Create("rawroach", "(f) Raw Roach Meat", 0.5, "food/Icon_MRE.png", "models/mosi/fallout4/props/food/radroachmeat.mdl", false)
    roach.value = 1
    roach.HPHeal = 3
    roach.hunger = 45
    roach.Rads = 11
    roach.category = "FOOD"

    local flymeat = FoodItems:Create("flymeat", "(f) fly meat", 0.5, "food/Icon_MRE.png", "models/mosi/fnv/props/food/flymeat.mdl", false)
    flymeat.value = 1
    flymeat.HPHeal = 3
    flymeat.hunger = 45
    flymeat.Rads = 11
    flymeat.category = "FOOD"

    local dogmeat = FoodItems:Create("DogMeat", "(f) Dog Meat", 0.5, "food/Icon_MRE.png", "models/fallout 3/meat.mdl", false)
    dogmeat.value = 1
    dogmeat.HPHeal = 3
    dogmeat.hunger = 35
    dogmeat.Rads = 16
    dogmeat.category = "FOOD"

    local deathclawmeat = FoodItems:Create("DeathclawMeat", "(f) Deathclaw Meat", 0.5, "food/Icon_MRE.png", "models/fallout 3/meat.mdl", false)
    deathclawmeat.value = 1
    deathclawmeat.HPHeal = 19
    deathclawmeat.hunger = 105
    deathclawmeat.Rads = 55
    deathclawmeat.category = "FOOD"

    local yoaguaimeat = FoodItems:Create("yoaguaimeat", "(f) yoaguai meat", 0.5, "food/Icon_MRE.png", "models/mosi/fnv/props/food/yoaguaimeat.mdl", false)
    yoaguaimeat.value = 1
    yoaguaimeat.HPHeal = 19
    yoaguaimeat.hunger = 95
    yoaguaimeat.Rads = 45
    yoaguaimeat.category = "FOOD"

    local rat = FoodItems:Create("RadratMeat", "(f) Rat Meat", 0.5, "food/Icon_MRE.png", "models/fallout 3/meat.mdl", false)
    rat.value = 1
    rat.HPHeal = 3
    rat.hunger = 5
    rat.Rads = 15
    rat.category = "FOOD"

    local meat = FoodItems:Create("RawMeat", "(f) Raw Meat", 0.5, "food/Icon_MRE.png", "models/fallout 3/meat.mdl", false)
    meat.value = 1
    meat.HPHeal = 3
    meat.hunger = 5
    meat.Rads = 16
    meat.category = "FOOD"

    local molemeat = FoodItems:Create("molemeat", "(f) mole meat", 0.5, "food/Icon_MRE.png", "models/mosi/fnv/props/food/molemeatsteak.mdl", false)
    molemeat.value = 1
    molemeat.HPHeal = 3
    molemeat.hunger = 15
    molemeat.Rads = 36
    molemeat.category = "FOOD"

    local mirelurkmeat = FoodItems:Create("mirelurkmeat", "(f) mirelurk meat", 0.5, "food/Icon_MRE.png", "models/mosi/fnv/props/food/mirelurkmeat.mdl", false)
    mirelurkmeat.value = 1
    mirelurkmeat.HPHeal = 3
    mirelurkmeat.hunger = 25
    mirelurkmeat.Rads = 56
    mirelurkmeat.category = "FOOD"

    local bloodpaste = FoodItems:Create("bloodpaste", "(f) Blood Paste", 0.5, "food/Icon_MRE.png", "models/mosi/fnv/props/food/bloodpaste.mdl", false)
    bloodpaste.value = 1
    bloodpaste.HPHeal = 3
    bloodpaste.hunger = 35
    bloodpaste.Rads = 16
    bloodpaste.category = "FOOD"

    local soylentgreen = FoodItems:Create("soylentgreen", "(f) soylent green", 0.5, "food/Icon_MRE.png", "models/mosi/fnv/props/food/soylentgreen.mdl", false)
    soylentgreen.value = 1
    soylentgreen.HPHeal = 3
    soylentgreen.hunger = 15
    soylentgreen.Rads = 26
    soylentgreen.category = "FOOD"

    local cazadoregg = FoodItems:Create("cazadoregg", "(f) Cazador Egg", 0.5, "food/Icon_MRE.png", "models/mosi/fnv/props/food/cazadoregg.mdl", false)
    cazadoregg.value = 4
    cazadoregg.HPHeal = 5
    cazadoregg.hunger = 25
    cazadoregg.Rads = 12
    cazadoregg.category = "FOOD"

    local cazadorpoisongland = FoodItems:Create("cazadorpoisongland", "(f) Cazador Poison Gland", 0.5, "food/Icon_MRE.png", "models/mosi/fnv/props/food/cazadorpoisongland.mdl", false)
    cazadorpoisongland.value = 12
    cazadorpoisongland.HPHeal = 3
    cazadorpoisongland.hunger = 15
    cazadorpoisongland.Rads = 43
    cazadorpoisongland.category = "FOOD"

    local deathclawegg = FoodItems:Create("deathclawegg", "(f) deathclaw egg", 0.5, "food/Icon_MRE.png", "models/mosi/fnv/props/food/deathclawegg.mdl", false)
    deathclawegg.value = 12
    deathclawegg.HPHeal = 3
    deathclawegg.hunger = 5
    deathclawegg.Rads = 3
    deathclawegg.category = "FOOD"

    local dogmeat = FoodItems:Create("dogmeat", "(f) Dog Meat", 0.5, "food/Icon_MRE.png", "models/mosi/fnv/props/food/dogmeat.mdl", false)
    dogmeat.value = 13
    dogmeat.HPHeal = 3
    dogmeat.hunger = 6
    dogmeat.Rads = 36
    dogmeat.category = "FOOD"

    local humanflesh = FoodItems:Create("humanflesh", "(f) human flesh", 0.5, "food/Icon_MRE.png", "models/mosi/fnv/props/food/humanflesh.mdl", false)
    humanflesh.value = 13
    humanflesh.HPHeal = 43
    humanflesh.hunger = 96
    humanflesh.Rads = 46
    humanflesh.category = "FOOD"

    local mantisclaw = FoodItems:Create("mantisclaw", "(f) mantis claw", 0.5, "food/Icon_MRE.png", "models/mosi/fnv/props/food/mantisclaw.mdl", false)
    mantisclaw.value = 3
    mantisclaw.HPHeal = 3
    mantisclaw.hunger = 6
    mantisclaw.Rads = 46
    mantisclaw.category = "FOOD"

    --BASE FLOWER INGREDIANTS

    local bananayucca = FoodItems:Create("bananayucca", "(f) banana yucca", 0.5, "food/Icon_MRE.png", "models/mosi/fnv/props/food/crops/bananayucca.mdl", false)
    bananayucca.value = 3
    bananayucca.HPHeal = 3
    bananayucca.hunger = 6
    bananayucca.Rads = 16
    bananayucca.category = "FOOD"

    local barrelcactus = FoodItems:Create("barrelcactus", "(f) barrel cactus", 0.5, "food/Icon_MRE.png", "models/mosi/fnv/props/food/crops/barrelcactus.mdl", false)
    barrelcactus.value = 3
    barrelcactus.HPHeal = 3
    barrelcactus.hunger = 2
    barrelcactus.Rads = 15
    barrelcactus.category = "FOOD"

    local brainfungus = FoodItems:Create("brainfungus", "(f) brain fungus", 0.5, "food/Icon_MRE.png", "models/mosi/fnv/props/food/crops/brainfungus.mdl", false)
    brainfungus.value = 3
    brainfungus.HPHeal = 3
    brainfungus.hunger = 2
    brainfungus.Rads = 15
    brainfungus.category = "FOOD"

    local brocflower = FoodItems:Create("brocflower", "(f) broc flower", 0.5, "food/Icon_MRE.png", "models/mosi/fnv/props/food/crops/brocflower.mdl", false)
    brocflower.value = 3
    brocflower.HPHeal = 3
    brocflower.hunger = 2
    brocflower.Rads = 15
    brocflower.category = "FOOD"

    local cavefungus = FoodItems:Create("cavefungus", "(f) cave fungus", 0.5, "food/Icon_MRE.png", "models/mosi/fnv/props/food/crops/cavefungus.mdl", false)
    cavefungus.value = 3
    cavefungus.HPHeal = 3
    cavefungus.hunger = 2
    cavefungus.Rads = 15
    cavefungus.category = "FOOD"

    local glowingmushrooms = FoodItems:Create("glowingmushrooms", "(f) glowing mushrooms", 0.5, "food/Icon_MRE.png", "models/mosi/fnv/props/food/crops/glowingmushrooms.mdl", false)
    glowingmushrooms.value = 3
    glowingmushrooms.HPHeal = 3
    glowingmushrooms.hunger = 2
    glowingmushrooms.Rads = 15
    glowingmushrooms.category = "FOOD"

    local honeymesquite = FoodItems:Create("honeymesquite", "(f) honey mesquite", 0.5, "food/Icon_MRE.png", "models/mosi/fnv/props/food/crops/honeymesquite.mdl", false)
    honeymesquite.value = 3
    honeymesquite.HPHeal = 3
    honeymesquite.hunger = 2
    honeymesquite.Rads = 15
    honeymesquite.category = "FOOD"

    local jalapeno = FoodItems:Create("jalapeno", "(f) jalapeno", 0.5, "food/Icon_MRE.png", "models/mosi/fnv/props/food/crops/jalapeno.mdl", false)
    jalapeno.value = 3
    jalapeno.HPHeal = 3
    jalapeno.hunger = 2
    jalapeno.Rads = 15
    jalapeno.category = "FOOD"

    local maize = FoodItems:Create("maize", "(f) maize", 0.5, "food/Icon_MRE.png", "models/mosi/fnv/props/food/crops/maize.mdl", false)
    maize.value = 3
    maize.HPHeal = 3
    maize.hunger = 2
    maize.Rads = 15
    maize.category = "FOOD"

    local nevadaagave = FoodItems:Create("nevadaagave", "(f) nevada agave", 0.5, "food/Icon_MRE.png", "models/mosi/fnv/props/food/crops/nevadaagave.mdl", false)
    nevadaagave.value = 3
    nevadaagave.HPHeal = 3
    nevadaagave.hunger = 2
    nevadaagave.Rads = 15
    nevadaagave.category = "FOOD"

    local pinyonnuts = FoodItems:Create("pinyonnuts", "(f) pinyon nuts", 0.5, "food/Icon_MRE.png", "models/mosi/fnv/props/food/crops/pinyonnuts.mdl", false)
    pinyonnuts.value = 3
    pinyonnuts.HPHeal = 3
    pinyonnuts.hunger = 2
    pinyonnuts.Rads = 15
    pinyonnuts.category = "FOOD"

    local potato = FoodItems:Create("potato", "(f) potato", 0.5, "food/Icon_MRE.png", "models/mosi/fnv/props/food/crops/potato.mdl", false)
    potato.value = 3
    potato.HPHeal = 3
    potato.hunger = 2
    potato.Rads = 15
    potato.category = "FOOD"

    local pricklypearcactus = FoodItems:Create("pricklypearcactus", "(f) prickly pear cactus", 0.5, "food/Icon_MRE.png", "models/mosi/fnv/props/food/crops/pricklypearcactus.mdl", false)
    pricklypearcactus.value = 3
    pricklypearcactus.HPHeal = 3
    pricklypearcactus.hunger = 2
    pricklypearcactus.Rads = 15
    pricklypearcactus.category = "FOOD"

    local pungafruit = FoodItems:Create("pungafruit", "(f) punga fruit", 0.5, "food/Icon_MRE.png", "models/mosi/fnv/props/food/crops/pungafruit.mdl", false)
    pungafruit.value = 3
    pungafruit.HPHeal = 3
    pungafruit.hunger = 2
    pungafruit.Rads = 15
    pungafruit.category = "FOOD"

    local sporepod = FoodItems:Create("sporepod", "(f) spore pod", 0.5, "food/Icon_MRE.png", "models/mosi/fnv/props/food/crops/sporepod.mdl", false)
    sporepod.value = 3
    sporepod.HPHeal = 3
    sporepod.hunger = 2
    sporepod.Rads = 15
    sporepod.category = "FOOD"

    local whitehorsenettleberries = FoodItems:Create("whitehorsenettleberries", "(f) white horse nettle berries", 0.5, "food/Icon_MRE.png", "models/mosi/fnv/props/food/crops/whitehorsenettleberries.mdl", false)
    whitehorsenettleberries.value = 3
    whitehorsenettleberries.HPHeal = 3
    whitehorsenettleberries.hunger = 2
    whitehorsenettleberries.Rads = 15
    whitehorsenettleberries.category = "FOOD"

    local xanderroot = FoodItems:Create("xanderroot", "(f) xander root", 0.5, "food/Icon_MRE.png", "models/mosi/fnv/props/food/crops/xanderroot.mdl", false)
    xanderroot.value = 3
    xanderroot.HPHeal = 3
    xanderroot.hunger = 2
    xanderroot.Rads = 15
    xanderroot.category = "FOOD"

-------------
    local mre = FoodItems:Create("mre", "(f) MRE", 0.5, "food/Icon_MRE.png", "models/mosi/fallout4/props/food/mre.mdl", false)
    mre.value = 5
    mre.HPHeal = 20
    mre.hunger = 450
    mre.Rads = 0
    mre.Angle = Angle(45, 0, 45)
    mre.category = "FOOD"

    function mre:struct()
        return {
            {1, "RAD: " .. (self.Rads > 0 and "+" or "") .. self.Rads},
        }
    end

    local mre = FoodItems:Create("gameanaconda", "Anaconda", 1, "misc/icon_cassette.png", "models/mosi/fallout4/props/food/mre.mdl", false)
    mre.value = 5
    mre.HPHeal = 0
    mre.Rads = 0
    mre.category = "MISC"

    function mre:struct()
        return {
            {1, "AN OLD VINTAGE GAME"},
        }
    end

    mre.functions.use = {
        onRun = function(self, client)
            local pl = self:getOwner()

            return false
        end,
        onRunClient = function(self, client)
            pipboy.SelectedHeader = "snake"

            return false
        end,
        onCanRun = function(item) return true end,
    }

    timer.Simple(5, function()
        for i, v in pairs(items_to_change) do
            local cv = nut.item.list[v]
            cv.idd = cv

            if cv and table.HasValue(items_to_change, v) then
                cv.functions.use = {
                    onRun = function(self, client)
                        if not self.idd then return false end
                        local pl = self:getOwner()
                        pl:EmitSound("cuszsda/gear1.wav", 100, 100)
                        -- random item to give 
                        local item = items_to_give[math.random(1, #items_to_give)]
                        local itemList = nut.item.list[item]
                        pl:notify("Scarpped " .. self:getName() .. " gained " .. itemList.name)
                        -- get player inventory 
                        local inv = pl:getChar():getInv()
                        -- add item to inventory
                        inv:add(item)

                        return true
                    end,
                    onRunClient = function(self, client) return false end, --pipboy.SelectedHeader = "snake"
                    onCanRun = function(item) return true end,
                }
            end
        end
    end)
end

hook.Add("InitializedPlugins", "InitializedPlugins_gen_research", function()
    CreateFoodItems()
end)

if nut or Nut or NUT then
    CreateFoodItems()
end

hook.Add("InitializedPlugins", "InitializedPlugins_gen_research", function()
    CreateFoodItems()
end)

hook.Add("InitializedPlugins", "InitializedPluginsCreateArmors", function()
    CreateArmors()
end)

function CreateArmors()
    local itemid = "powerarmor_raider"
    local ITEM = nut.item.list[id] or nut.item.register(itemid, "base_armor", nil, nil, true)

    local v = {
        name = "Wastelander Power Armor",
        desc = "A power armor made for wastelander.",
        model = "models/player/cgcclothing/humans/powerarmor_raider/powerarmor_raider.mdl",
        weight = 10,
        type = "armor",
        armor = 100,
        armorType = "powerarmor",
        price = 100,
        slot = "torso",
        maxArmor = 100,
        price = 0,
        flag = {HIDE_PANTS, HIDE_BODY, HIDE_HANDS},
    }

    ITEM.name = v["name"]
    ITEM.model = v["model"] or "models/hunter/blocks/cube025x025x025.mdl"
    ITEM.isPA = v["training"] or false
    ITEM.type = i
    ITEM.price = v["price"] or 0
    ITEM.female = v["female"] or v.model
    ITEM.male = v["male"] or v.model
    ITEM.weight = v["weight"] or 5
    ITEM.category = "ARMOR"
    ITEM.resisbody = 0
    ITEM.resishead = 0
    ITEM.slot = v["slot"] or "torso"

    ITEM.hideflag = v["flag"] or {HIDE_PANTS, HIDE_HANDS, HIDE_FACIAL_HAIR, HIDE_HAIR, HIDE_BODY, HIDE_TORSO}

    ITEM.boosts = {
        luc = 10,
    }

    function UPDATE_ATTRIBS(char)
        local boosts = {}

        for k, v in pairs(char:getInv()) do
            boosts[k] = v
        end
    end

    ITEM.functions.use = {
        name = "Use",
        tip = "useTip",
        icon = "icon16/add.png",
        onRun = function(item)
            print("EE")
            local hookRun = hook.Run
            local char = item.player:getChar()
            local items = char:getInv():getItems()

            for id, other in pairs(items) do
                if item ~= other and item.slot == other.slot and other:getData("equip") then
                    other:setData("equip", false)
                    local player = item.player
                    player:getChar():RemoveSlot(other.slot)
                end
            end

            if not IsValid(item.entity) and item:getData("equip") ~= true then
                local player = item.player
                local character = player:getChar()

                if item.isPA and not character:getData("PATraining", false) then
                    player:notifyLocalized("You don't have power armor training.")

                    return false
                end

                item:setData("equip", true)
                -- player:CalculateArmorValue()
                player:EmitSound("items/ammo_pickup.wav", 80)

                --character:setVar("armor", item.type)
                if not player:isFemale() then
                    player:getChar():AddPartSlot({
                        slot = item.slot,
                        model = item.male,
                        skipFlags = item.hideflag or {}
                    })
                end

                if player:isFemale() then
                    player:getChar():AddPartSlot({
                        slot = item.slot,
                        model = item.female,
                        skipFlags = item.hideflag or {}
                    })
                end

                return false
            else
                local player = item.player
                player:getChar():RemoveSlot(item.slot)
                local character = player:getChar()
                item:setData("equip", false)
                --player:CalculateArmorValue()
                character:setVar("armor", nil)
                -- player:SetJumpPower(160)

                return false
            end
        end
    }
end

if nut or Nut or NUT then
    CreateArmors()
end