local WepItems = {}

local function FOODstruct(self)
    return {
        {0.5, "HP: +" .. self.HPHeal},
        {0.5, "RAD: +" .. self.Rads},
        {1, "STARVATION: -" .. self.STARVATION},
    }
end

local function Drinkstruct(self)
    return {
        {0.5, "HP: +" .. self.HPHeal},
        {0.5, "RAD: +" .. self.Rads},
        {1, "THIRST: -" .. self.STARVATION},
    }
end

local brokenshit = Material("brokenshit")

hook.Add("HUDPaint", "BrokenWeaponnn", function()
    local player = LocalPlayer()
    local wep = player:GetActiveWeapon()

    if wep.ref and wep.ref:getData("HP", 0) == wep.ref.MaxHP then
        local pip_color = Color(255, 100, 100)
        local player = LocalPlayer()
        local ply = player:getChar()
        surface.SetMaterial(brokenshit)
        local width = 405
        surface.SetDrawColor(pip_color.r * 0.8, pip_color.g * 0.8, pip_color.b * 0.8, 55)
        surface.DrawRect(ScrW() / 2 - (width / 2), 128, width, 128)
        surface.SetDrawColor(Color(0, 0, 0, 255))
        surface.DrawTexturedRectUV((ScrW() / 2) - (width / 2) - 18, 128, 140, 128, 0, 0.2, 1, 1)
        surface.SetDrawColor(pip_color)
        surface.DrawTexturedRectUV((ScrW() / 2) - (width / 2) - 20, 128, 140, 128, 0, 0.2, 1, 1)
        surface.DrawRect(ScrW() / 2 - (width / 2), 128, width, 4)
        surface.DrawRect(ScrW() / 2 - (width / 2), 128 + 124, width, 4)
        surface.DrawRect(ScrW() / 2 - (width / 2), 128, 4, 128)
        surface.DrawRect(ScrW() / 2 - (width / 2) + width - 4, 128, 4, 128)
        surface.DrawRect(ScrW() / 2 - 72, 174, 80, 3)
        surface.SetFont("Morton Medium@42")
        NzGUI.DrawShadowText("NOTICE", (ScrW() / 2) - (width / 2) + 128, 135, pip_color)
        surface.SetFont("Morton Medium@32")
        NzGUI.DrawShadowText("Your current weapon is broken", (ScrW() / 2) - (width / 2) + 128, 170, pip_color)
        NzGUI.DrawShadowText("please look at repairing or", (ScrW() / 2) - (width / 2) + 128, 188, pip_color)
        NzGUI.DrawShadowText("switching your current weapon", (ScrW() / 2) - (width / 2) + 128, 206, pip_color)
    end
end)

local function update_item_details(swep, item)
    print(swep, item)

    if swep and item and IsValid(swep) then
        print("OVERWROTE DAMAGE")
        if swep.SetStatRawL then swep:SetStatRawL("Primary.Damage", item.damage or swep.Primary.Damage) end
        --swep:SetStatL("Primary.Damage",5000000)
        swep.Primary.Damage = item.damage or swep.Primary.Damage
    end
end

hook.Add("PostPlayerLoadout_", "GiveWeps", function(player)
    local ply = player:getChar()
    local wep1 = ply:getData("Weapon1" or 0) or 0
    local wep2 = ply:getData("Weapon2" or 0) or 0
    local wep1_inst = ply:getInv().items[wep1]
    local wep2_inst = ply:getInv().items[wep2]

    if wep2_inst then
        local wepx = player:Give(wep2_inst.Weapon, true)
        player:GetWeapon(wep2_inst.Weapon):SetClip1(wep2_inst:getData("ammo1", 0))
        player:GetWeapon(wep2_inst.Weapon).ref = nil
        update_item_details(wepx, wep2_inst)
    end

    if wep1_inst then
        local wepx = player:Give(wep1_inst.Weapon, true)
        player:GetWeapon(wep1_inst.Weapon):SetClip1(wep1_inst:getData("ammo1", 0))
        player:GetWeapon(wep1_inst.Weapon).ref = nil
        update_item_details(wepx, wep1_inst)
    end
end)

function WEAPON_USE_FUNC2(item, client)
    --self:setData("HP", math.random(1, 100))
    local player = item:getOwner()
    local ply = player:getChar()
    local wep1 = ply:getData("Weapon1" or 0) or 0
    local wep2 = ply:getData("Weapon2" or 0) or 0
    ply:setData("Weapon1", 0)
    ply:setData("Weapon2", 0)
    local wep1_inst = ply:getInv().items[wep1]
    local wep2_inst = ply:getInv().items[wep2]
    local stripItems = {}
    local areWeUneqiup = (wep1_inst and wep1_inst.Weapon == item.Weapon and wep1_inst.id) or (wep2_inst and wep2_inst.Weapon == item.Weapon and wep2_inst.id)
    print(areWeUneqiup and "found dupe" or "we're good")

    if wep1_inst then
        wep1_inst:setData("Equipped", false)
        table.insert(stripItems, wep1_inst.Weapon)
        wep1_inst:setData("ammo1", player:GetWeapon(wep1_inst.Weapon):Clip1())
    end

    if wep2_inst then
        wep2_inst:setData("Equipped", false)
        table.insert(stripItems, wep2_inst.Weapon)
        wep2_inst:setData("ammo1", player:GetWeapon(wep2_inst.Weapon):Clip1())
    end

    local wep_inventory = {}
    local itemPos = false
    local freeslot = 2

    if wep1 > 0 then
        table.insert(wep_inventory, wep1)
    end

    if wep2 > 0 then
        table.insert(wep_inventory, wep2)
    end

    print(item:getData("Equipped", false) and "true" or "falsew")

    if table.HasValue(wep_inventory, item.id) then
        table.RemoveByValue(wep_inventory, item.id)
        item:setData("ammo1", player:GetWeapon(item.Weapon):Clip1())
        areWeUneqiup = false
    else
        table.insert(wep_inventory, 1, item.id)
    end

    if areWeUneqiup then
        table.RemoveByValue(wep_inventory, areWeUneqiup)
        print("test")
    end

    ply:setData("Weapon1", wep_inventory[1])
    ply:setData("Weapon2", wep_inventory[2])
    wep1_inst = ply:getInv().items[wep_inventory[1]]
    wep2_inst = ply:getInv().items[wep_inventory[2]]

    if wep1_inst then
        wep1_inst:setData("Equipped", true)
        table.RemoveByValue(stripItems, wep1_inst.Weapon)
        local wepX = item:getOwner():Give(wep1_inst.Weapon)
        update_item_details(wepX, wep1_inst)

        timer.Simple(FrameTime(), function()
            update_item_details(wepX, wep1_inst)
        end)

        player:GetWeapon(wep1_inst.Weapon):SetClip1(wep1_inst:getData("ammo1", 0))
        player:GetWeapon(wep1_inst.Weapon).ref = nil
        netstream.Start(player, "weapon_reset_ref")
    end

    if wep2_inst then
        wep2_inst:setData("Equipped", true)
        local wepX = item:getOwner():Give(wep2_inst.Weapon)

        timer.Simple(FrameTime(), function()
            update_item_details(wepX, wep2_inst)
        end)

        table.RemoveByValue(stripItems, wep2_inst.Weapon)
    end

    for i, v in pairs(stripItems) do
        if IsValid(player) and player:GetWeapon(v) then
            player.StripWeapon(player, stripItems[i])
        end
    end

    return false
end


local function OnUseAmmo(self, client)
    local pl = self:getOwner()

    pl:EmitSound("items/ui_cold_drink.wav")
    pl:GiveAmmo(self.amountOfAmmoToRestore, self.ammoType)
    return true
end

function WepItems:CreateAmmoRaw(itemID, Bnme,mdl,AmmoEntity,amt,price)

   -- local SENT = scripted_ents.GetStored(AmmoEntity) 
   -- if SENT == nil then print("error with ammo entity",AmmoEntity) return end
    local ITEM = nut.item.list[itemID] or nut.item.register(itemID, nil, nil, nil, true)
    ITEM.name = Display
    ITEM.weight = (weight or 0)
    ITEM.ammoType = AmmoEntity
    ITEM.desc = "NULL"
    ITEM.amountOfAmmoToRestore = amt
    ITEM.category = "WEAPONS"
    -- check if mdl exists as a model and if not, use the default, "models/props_junk/cardboard_box004a.mdl"
    -- check if mdl isUselessModel 
    ITEM.model = (IsUselessModel(mdl or "") and "models/props_junk/cardboard_box004a.mdl") or mdl
    ITEM.isStackable = true
    ITEM.maxQuantity = 1
    ITEM.type = "WEAPONS"
    ITEM.HPHeal = 0
    ITEM.Rads = 1
    ITEM.STARVATION = 0
    ITEM.CacheStruct = false
    ITEM.hunger = 0
    ITEM.thirst = 0
    ITEM.cost = price or 8
    ITEM.price = ITEM.cost 
     
    function ITEM:struct()
        return {

        }
    end

    if drink then
        ITEM.struct = Drinkstruct
    end


    ITEM.functions.use = {
        onRun = OnUseAmmo,
        onCanRun = function(item) return true end
    }



    
    ITEM.name = "(AMMO) " .. Bnme
  return nut.item.list[id]
end


function WepItems:CreateAmmo(itemID, Bnme,mdl,AmmoEntity,amt)
    self:CreateAmmoRaw(itemID, Bnme,mdl,AmmoEntity,amt)
    self:CreateAmmoRaw(itemID.."xl", Bnme .. " XL",mdl,AmmoEntity,amt*3)
end


function WepItems:Create(id, Display, weight, ent, hp)
    local ITEM = nut.item.list[id] or nut.item.register(id, nil, nil, nil, true)
    ITEM.name = Display
    ITEM.weight = weight or 0.001
    ITEM.Weapon = ent
    local mod = weapons.GetStored(ent)
    ITEM.desc = "NULL"
    ITEM.category = "WEAPONS"
    ITEM.model = mod.WorldModel or "models/props_junk/cardboard_box001a.mdl"
    ITEM.isStackable = false
    ITEM.maxQuantity = 1
    ITEM.type = "WEAPON"
    ITEM.HPHeal = 0
    ITEM.Rads = 1
    ITEM.STARVATION = 0
    ITEM.MaxHP = hp or 250
    ITEM.Stackable = true
    ITEM.CacheStruct = false
    
    ITEM.functions.drop.onCanRun = function(item) return (not IsValid(item.entity) and not item.noDrop) and item:getData("Equipped", false) == false end

    function ITEM:DrawLabel(x, y)
        surface.SetDrawColor(255, 255, 255, 255)
        local of = x + FUSION_ITEM_BUTTON_SIZE.w - 100
        local p = 0.2
        local hf = FUSION_ITEM_BUTTON_SIZE.ho * (1 - p) + 2
        local hs = FUSION_ITEM_BUTTON_SIZE.ho * p
        surface.SetDrawColor(pip_color)

        if self:getData("Equipped", false) then
            surface.DrawRect(x - 18, y + (FUSION_ITEM_BUTTON_SIZE.ho / 2) - 2, 14, 14)
        end

        local ply = self:getOwner():getChar()
        local wep1 = ply:getData("Weapon1" or 0)
        local wep2 = ply:getData("Weapon2" or 0)
        local s = "CND"
        surface.SetTextPos(of, y + hf - 35)
        surface.DrawText(s)
        surface.DrawRect(of, y + hf, 80 * (1 - (self:getData("HP", 0) / self.MaxHP)), hs)
        surface.DrawOutlinedRect(of, y + hf, 80, hs)
    end

    function ITEM:struct()
        --  {0.5, "HP: +" .. self.HPHeal},
        local curWep = weapons.GetStored(self.Weapon)
        --{1, "SKILL: ".. "SCIENCE"}, 

        return {
            {0.5, "DMG: " .. (self.damage or (curWep.Primary and curWep.Primary.Damage) or 25)},
            {0.5, "CRIT X: " .. (self.critmp or 1.5) .. "x"},
        }
    end

    if drink then
        ITEM.struct = Drinkstruct
    end

    ITEM.functions.use = {
        onRun = function(n, e)
            WEAPON_USE_FUNC2(n, e)

            return false
        end,
        onCanRun = function(item) return true end
    }

    return nut.item.list[id]
end

local function CreateWeapons()

   timer.Simple(1, function() 
WepItems:CreateAmmo("22lrammo", "22lr Ammunition", "models/fallout new vegas/22_ammo.mdl", "pistol", 30)
WepItems:CreateAmmo("308ammo", "308 Ammunition", "models/mosi/fallout4/ammo/308.mdl", "SniperRound", 30)
WepItems:CreateAmmo("38ammo", "38 Ammunition", "models/mosi/fallout4/ammo/38.mdl", "CombineCannon", 30)
WepItems:CreateAmmo("44magnumammo", "44 Magnum Ammunition", "models/mosi/fallout4/ammo/44.mdl", "57", 30)
WepItems:CreateAmmo("45ammo", "45 Ammunition", "models/mosi/fallout4/ammo/45.mdl", "SMG1_Grenade", 30)
WepItems:CreateAmmo("50ammo", "50 Ammunition", "models/mosi/fallout4/ammo/50.mdl", "AlyxGun", 30)
WepItems:CreateAmmo("10ammo", "10mm Ammunition", "models/mosi/fallout4/ammo/10mm.mdl", "smg1", 30)
WepItems:CreateAmmo("127ammo", "127 Ammunition", "models/illusion/fwp/127ammobox.mdl", "SniperPenetratedRound", 30)
WepItems:CreateAmmo("2ecammo", "2ec Ammunition", "models/fallout new vegas/22_ammo.mdl", "HelicopterGun", 30)
WepItems:CreateAmmo("556ammo", "5.56 Ammunition", "models/mosi/fallout4/ammo/556.mdl", "GaussEnergy", 30)
WepItems:CreateAmmo("5mmammo", "5mm Ammunition", "models/mosi/fallout4/ammo/5mm.mdl", "ar2", 30)
WepItems:CreateAmmo("9mmammo", "9mm Ammunition", "models/illusion/fwp/9mmammo.mdl", "9mmRound", 30)
WepItems:CreateAmmo("mcfcammo", "Microfusion Cells", "models/mosi/fallout4/ammo/microfusioncell.mdl", "StriderMinigun", 30)
WepItems:CreateAmmo("plasmaammo", "Plasma Cartridge", "models/mosi/fallout4/ammo/plasma.mdl", "XBowBolt", 30)
WepItems:CreateAmmo("shotgunammo", "Shotgun Ammunition", "models/mosi/fallout4/ammo/shotgunshells.mdl", "buckshot", 30)
end)

    nut.flag.add("L", "faction inviter", callback)
    nut.flag.add("I", "We Vibe Here", callback)
    WepItems:Create("weapon_revolver", ".44 Revolver", 6, "tfa_fwp_44magnum", 128)
    local evi_revolver = WepItems:Create("weapon_revolver_evi", "Evi's Revolver", 6, "tfa_fwp_44magnum", 128)
    evi_revolver.critmp = 3
    evi_revolver.damage = 5000000
    local evi_musket = WepItems:Create("weapon_musket", "Modified Musket", 6, "aus_w_lasermusket", 128)
    evi_musket.critmp = 4
    evi_musket.damage = 380
   
    local lrsmg =  WepItems:Create("lrsmg", ".22 LR SMG", 6, "aus_w_22_smg", 128) --
    lrsmg.model = "models/halokiller38/fallout/weapons/smgs/22smg.mdl"
    WepItems:Create("sniperrifle", "Sniper Rifle", 6, "tfa_fallout_sniper_rifle", 128) --
    WepItems:Create("CobiSniperRifle", "Cobi Sniper Rifle", 6, "weapon_sniperrifleu", 128) --
    WepItems:Create("CobiSniperRiflesilenced", "Cobi Sniper Rifle Silenced", 6, "weapon_sniperriflesilu", 128) --
    WepItems:Create("sniperriflecarboned", "Sniper Rifle Carboned", 6, "weapon_sniperriflesilcf", 128) --
    WepItems:Create("sniperriflecarbonedsilenced", "Sniper Rifle Carboned Silenced", 6, "weapon_sniperriflesil", 128) --
    WepItems:Create("bar", "Bar", 6, "aus_w_bar", 128) --
    local battlerifle =  WepItems:Create("battlerifle", "Battle Rifle", 6, "aus_w_battle_rifle", 128) --
    battlerifle.model = "models/weapons/battlerifle/c_battlerifle_len.mdl"
    battlerifle.Angle = Angle(90, 0, 90)
    local dkssniperrifle = WepItems:Create("dkssniperrifle", "DKS Sniper Rifle", 6, "aus_w_sniperrifle", 128) --
    dkssniperrifle.critmp = 4
    dkssniperrifle.damage = 100
    WepItems:Create("huntingrifle", "Hunting Rifle", 6, "aus_w_huntingrifle", 128) --
    WepItems:Create("BoltActionPipeRifle", "Bolt-Action Pipe Rifle", 6, "aus_w_pipebolt", 128) --
    WepItems:Create("BoltActionPipeRiflescooped", "Bolt-Action Pipe Rifle Scooped", 6, "aus_w_pipeboltscoped", 128) --
    WepItems:Create("piprevolver", "Pipe Revolver", 6, "aus_w_piperevolver", 128) --
    WepItems:Create("SemiAutomaticPipeRifle", "Semi-Automatic Pipe Rifle", 6, "aus_w_piperiflesemi", 128) --
    WepItems:Create("cowboyrepeater", "Cowboy Repeater", 6, "aus_w_cowboyrepeater", 128) --
    WepItems:Create("45pistol", ".45 Pistol", 6, "aus_w_45pistol", 128) --
    WepItems:Create("combatrifle", "Combat Rifle", 6, "aus_w_combatrifle", 128) --
    WepItems:Create("submachinegun", "Sub-Machine Gun", 6, "aus_w_submachinegun", 128) --
    local AntiMaterialRifleScooped =  WepItems:Create("AntiMaterialRifleScooped", "Anti-Material Rifle Un-Scooped", 6, "tfa_fallout_amru", 128) --
    AntiMaterialRifleScooped.critmp = 10
    AntiMaterialRifleScooped.damage = 170   
    AntiMaterialRifleScooped.model = "models/halokiller38/fallout/weapons/sniperrifles/antimaterielrifle.mdl"   
    local AntiMaterialRifleunScooped =  WepItems:Create("AntiMaterialRifleunScooped", "Anti-Material Rifle Scooped", 6, "tfa_fallout_amr", 128) --
    AntiMaterialRifleunScooped.critmp = 10
    AntiMaterialRifleunScooped.damage = 170
    WepItems:Create("10mmpistol", "10mm Pistol", 6, "tfa_fallout_pist_10", 128) --
    WepItems:Create("prestine10mmpistol", "Prestine 10mm Pistol", 6, "aus_w_10mmpistol", 128) --
    WepItems:Create("10mmsmg", "10mm SMG", 6, "tfa_fallout_10mmsmg", 128) --
    WepItems:Create("prestine10mmsmg", "Prestine 10mm SMG", 6, "aus_w_10mmsmg", 128) --
    WepItems:Create("shouldermountedmachinegun", "Shoulder Mounted MAchin-Gun", 6, "aus_w_smmg", 128) --
    WepItems:Create("127mmpistol", "12.7mm Pistol", 6, "aus_w_127pistol", 128) --
    local gaussrifle =  WepItems:Create("gaussrifle", "Gauss Rifle", 6, "aus_w_gauss", 128) --
    gaussrifle.critmp = 6
    gaussrifle.damage = 270
    gaussrifle.model = "models/hub/weapons/gauss/gaussrifle.mdl"
    WepItems:Create("grenadelauncher", "Grenade Launcher", 6, "aus_w_launcher_nade", 128) --
    WepItems:Create("Assualtrifle", "Assualt Rifle", 6, "aus_w_assaultrifle", 128) --
    WepItems:Create("chineseassaultrifle", "Chinese Assault Rifle", 6, "tfa_fallout_chinese_ar", 128) --
    WepItems:Create("prestinechineseassaultrifle", "Prestine Chinese Assault Rifle", 6, "aus_w_chinesear", 128) --
    WepItems:Create("handmaderifle", "Handmade Rifle", 6, "aus_w_hmar", 128)
    WepItems:Create("marksmancarbine", "Marksman Carbine", 6, "aus_w_marksmancarbine", 128) --
    WepItems:Create("raider91", "Raider 91", 6, "aus_w_r91", 128) --
    WepItems:Create("raidernintyone", "Raider 91", 6, "aus_w_r91", 128) --
    WepItems:Create("servicerifle", "Service Rifle", 6, "aus_w_servicerifle", 128) --
    local amservicerifle = WepItems:Create("amservicerifle", "AM Service Rifle", 6, "aus_w_servicerifle", 128) --
    amservicerifle.critmp = 6
    amservicerifle.damage = 35
    local varmintrifle =  WepItems:Create("varmintrifle", "Varmint Rifle", 6, "tfa_fallout_varmint", 128) --
    varmintrifle.model = "models/illusion/fwp/w_varmintrifle.mdl"
    WepItems:Create("PrestineVarmintRifle", "Prestine Varmint Rifle", 6, "aus_w_varmintrifle", 128) --
    WepItems:Create("minigun", "Minigun", 6, "tfa_fallout_minigun", 128) --
    WepItems:Create("assaultcarbine", "Assault Carbine", 6, "aus_w_assaultcarbine", 128) --
    WepItems:Create("9mmpistol", "9mm Pistol", 6, "aus_w_9mmpistol", 128) --
    WepItems:Create("ninemmpistol", "9mm Pistol", 6, "aus_w_9mmpistol", 128) --
    WepItems:Create("9mmsmg", "9mm SMG", 6, "aus_w_9mmsmg", 128) --
    WepItems:Create("ninemmsmg", "9mm SMG", 6, "aus_w_9mmsmg", 128) --
   local gatlaser =  WepItems:Create("gatlinglaser", "Gatling Laser", 6, "aus_w_gatlinglaser", 128) --
   gatlaser.damage = 17
   local lasermusket =  WepItems:Create("lasermusket", "Laser Musket", 6, "aus_w_lasermusket", 128) --
   lasermusket.critmp = 5
   lasermusket.damage = 150
    local laserpistol = WepItems:Create("laserpistol", "Laser Pistol", 6, "tfa_fallout_laserpistol", 128) --
    laserpistol.model = "models/weapons/laserpistol/w_laserpistol.mdl"
    WepItems:Create("pristinelaserpistol", "Prestine Laser Pistol", 6, "aus_w_laserpistol", 128) --
    WepItems:Create("laserrcw", "Laser RCW", 6, "aus_w_rcw", 128) --
    local laserrifle = WepItems:Create("laserrifle", "Laser Rifle", 6, "tfa_fallout_laserrifle", 128) --
    laserrifle.model = "models/weapons/w_laserrifle.mdl"
    WepItems:Create("pristinelaserrifle", "Prestine Laser Rifle", 6, "aus_w_laserrifle", 128) --
    WepItems:Create("tribeamlaserrifle", "Tri-Beam Laser Rifle", 6, "aus_w_tribeam", 128) --
    WepItems:Create("watzlaserrifle", "Watz Laser Rifle", 6, "aus_w_wattzlasergun", 128) --
    local plasmarifle =  WepItems:Create("plasmarifle", "Plasma Rifle", 6, "aus_w_plasmarifle", 128) --
    plasmarifle.critmp = 2
    plasmarifle.damage = 23
    WepItems:Create("prestineplasmarifle", "Prestine Plasma Rifle", 6, "aus_w_plasmarifle", 128) --
    WepItems:Create("prestineplasmapistol", "Plasma Pistol", 6, "aus_w_plasmapistol", 128) --
    local plasmapistol = WepItems:Create("plasmapistol", "Plasma Pistol", 6, "tfa_fallout_plasmapistol", 128) --
    plasmapistol.model = "models/fallout/weapons/w_plasmapistol.mdl"
    local caravanshotgun = WepItems:Create("caravanshotgun", "Caravan Shotgun", 6, "tfa_fallout_caravan_sg", 128) --
    caravanshotgun.model = "models/weapons/tfa_fallout/w_fallout_caravan_shotgun.mdl"
    WepItems:Create("prestinecaravanshotgun", "Prestine Caravan Shotgun", 6, "aus_w_caravanshotgun", 128) --
    local advancedcombatshotgun = WepItems:Create("advancedcombatshotgun", "Advanced Combat Shotgun", 6, "aus_w_combatshotgun", 128) --
    advancedcombatshotgun.damage = 14
    local combatshotgun = WepItems:Create("combatshotgun", "Combat Shotgun", 6, "aus_w_combatshotgundrum", 128) --
    combatshotgun.model = "models/halokiller38/fallout/weapons/shotguns/combatshotgun.mdl"
    combatshotgun.damage = 15
    WepItems:Create("huntingshotgun", "Hunting Shotgun", 6, "aus_w_huntingshotgun", 128) --
    local arisaka = WepItems:Create("arisaka", "Arisaka", 6, "robotnik_waw_ari", 128) --
    arisaka.critmp = 5
    arisaka.damage = 200
    local arisakascooped = WepItems:Create("Arisakascooped", "Arisaka Scooped", 6, "robotnik_waw_ari_s", 128) --
    arisakascooped.critmp = 6
    arisakascooped.damage = 100
    WepItems:Create("bazooka", "Bazooka", 6, "robotnik_waw_baz", 128) --
    WepItems:Create("BrowningM1919", "Browning M1919", 6, "robotnik_waw_30c", 128) --
    WepItems:Create("fg42", "FG42", 6, "robotnik_waw_fg", 128) --
    WepItems:Create("Gewehr43", "Gewehr 43", 6, "robotnik_waw_g43", 128) --
    WepItems:Create("kar98k", "Kar98k", 6, "robotnik_waw_kar_i", 128) --
    WepItems:Create("Kar98kscooped", "Kar98k Scooped", 6, "robotnik_waw_kar_s", 128) --
    WepItems:Create("M1987TrenchShotgun", "M1987 Trench Shotgun", 6, "robotnik_waw_tg", 128) --
    WepItems:Create("flamethrower", "Flamethrower", 6, "tfa_fallout_flamer", 128) --
    WepItems:Create("PreWarFlamethrower", "Pre-War Flamethrower", 6, "robotnik_waw_m2", 128) --
    WepItems:Create("MG42", "MG42", 6, "robotnik_waw_mg42", 128) --
    WepItems:Create("mosinnagant", "Mosin Nagant", 6, "robotnik_waw_mosi", 128) --
    WepItems:Create("mosinnagantscooped", "Mosin Nagant Scooped", 6, "robotnik_waw_moss", 128) --
    WepItems:Create("MP40", "MP40", 6, "robotnik_waw_mp40", 128) --
    WepItems:Create("nambu", "Nambu", 6, "robotnik_waw_nbu", 128) --
    WepItems:Create("Panzerschrek", "Panzerschrek", 6, "robotnik_waw_pzsk", 128) --
    WepItems:Create("ppsh41", "PPSH-41", 6, "robotnik_waw_ppsh", 128) --
    WepItems:Create("ptrs41", "PTRS-41", 6, "robotnik_waw_ptrs", 128) --
    WepItems:Create("stg44", "STG-44", 6, "robotnik_waw_stg", 128) --
    WepItems:Create("SVT-40", "SVT-40", 6, "robotnik_waw_svt", 128) --
    WepItems:Create("thompson", "Thompson", 6, "robotnik_waw_tom", 128) --
    WepItems:Create("TokerevTT23", "Tokerev TT-23", 6, "robotnik_waw_tok", 128) --
    WepItems:Create("type100", "Type-100", 6, "robotnik_waw_t100", 128) --
    WepItems:Create("type99", "Type-99", 6, "robotnik_waw_t99", 128) --
    WepItems:Create("walterp38", "Walter P38", 6, "robotnik_waw_p38", 128) --
    local gatlaser2 = WepItems:Create("plasmagatling", "Plasma Gatling", 6, "tfa_fallout_plasmagatling", 128)
    gatlaser2.damage = 17
    WepItems:Create("instituterifle", "Insitute Laser Rifle", 6, "weapon_fo4instituterif_nope", 128)
    WepItems:Create("begotten_baseballbat_wood_barbwire", "Barbwire Bat", 6, "aus_m_baseballbat_wood_barbwire", 5000)
    WepItems:Create("spear_poolcue", "Pool Cue Spear", 4, "aus_m_spear_poolcue", 5000)
    WepItems:Create("spear_poolcue_shield", "Pool Cue Spear and shield", 4, "aus_m_spear_poolcue_shielded", 5000)
    WepItems:Create("f4supersledge", "Super Sledge", 14, "aus_m_twohanded_supersledge", 5000)
    WepItems:Create("f4powerfist", "Crafted Power Fist", 8, "aus_m_fists_powerfist", 5000)
    WepItems:Create("f4_wrench_spiked", "Spiked Wrench", 4, "aus_m_wrench_spiked", 5000)
    WepItems:Create("f4_hooked_spiked", "Hooked Wrench", 4, "aus_m_wrench_hooked", 5000)
    WepItems:Create("f4_wrench", "Wrench", 4, "aus_m_wrench_hooked", 5000)
    WepItems:Create("f4_knife_switchblade", "Switch Blade", 4, "aus_m_knife_switchblade", 5000)
    WepItems:Create("f4_sledgemaul", "Sledge Maul", 4, "aus_m_twohanded_sledgehammer_maul", 5000)
    WepItems:Create("f4_sledgehammer", "Sledge hammer", 4, "aus_m_twohanded_sledgehammer", 5000)
    WepItems:Create("spikedknuckles", "Spiked Knuckles", 4, "aus_m_fists_spikedknuckles", 5000)
    WepItems:Create("baseballbat_wood", "Baseball Bat", 4, "aus_m_baseballbat_wood", 5000)
    WepItems:Create("baseballbat_metal", "Baseball Bat metal", 4, "aus_m_baseballbat_metal", 5000)
    WepItems:Create("baseballbat_bladed", "Baseball Bat bladded", 4, "aus_m_baseballbat_wood_bladed", 5000)
    WepItems:Create("baseballbat_metalchained", "Baseball Bat metal chained", 4, "aus_m_baseballbat_metal_chained", 5000)
    WepItems:Create("baseballbat_metalrazor", "Baseball Bat metal Razor", 4, "aus_m_baseballbat_metal_razor", 5000)
    WepItems:Create("shishkebab", "Shishkebab", 14, "aus_m_shishkebab", 5000)
    WepItems:Create("board_bladed", "Bladed Board", 6, "aus_m_board_bladed", 5000)
    WepItems:Create("bladdedcommiewacker", "Bladed Commie Wacker", 6, "aus_m_commiewhacker_bladed", 5000)
    WepItems:Create("bladdedrollingpin", "Bladed Rolling Pin", 6, "aus_m_rollingpin_bladed", 5000)
    WepItems:Create("leadpipe", "lead Pipe", 6, "aus_m_leadpipe", 5000)
    WepItems:Create("deathclawgauntlet", "Deathclaw Gauntlet", 14, "aus_m_fists_deathclawgauntlet", 5000)
    WepItems:Create("walkingcane", "Walking Cane", 4, "aus_m_walkingcane", 5000)
    WepItems:Create("spikedwalkingcane", "Spiked Walking Cane", 4, "aus_m_walkingcane_spiked", 5000)
    WepItems:Create("combatknife", "Combat Knife", 2, "aus_m_knife_combatknife", 5000)
    WepItems:Create("Chinesesword", "Cinese Sword", 12, "aus_m_chineseofficersword", 5000)
    WepItems:Create("machete", "Machete", 4, "aus_m_machete", 600)
    WepItems:Create("serratedboard", "Serrated Board", 4, "aus_m_board_serrated", 600)
    WepItems:Create("tireironaxe", "Tireiron Fireaxe", 10, "aus_m_tireiron_axe", 750)
    WepItems:Create("ifak", "Infantry medkit", 10, "tfa_fas2_ifak", 750)
    WepItems:Create("WaterCan", "Water Can", 10, "ch_farming_water_can", 750)
    WepItems:Create("OldCowboyRepeater", "Old Cowboy Repeater", 10, "tfa_fallout_cowboy_repeater", 750)
    WepItems:Create("handcuffs", "Handcuffs", 10, "weapon_cuff_rope", 750)
    local fourtyfivepistol =  WepItems:Create("fourtyfivepistol", ".45 Pistol", 6, "aus_w_45pistol", 128) --
    fourtyfivepistol.model = "models/halokiller38/fallout/weapons/pistols/45pistol.mdl"
    local rangersequoia =  WepItems:Create("rangersequoia", "Ranger Sequoia", 10, "tfa_fallout_ranger_sequoia", 750)
    rangersequoia.damage = 100
    

    --badlanders
    local badlanderrifle =  WepItems:Create("badlandershandmaderifle", "Badlander's Handmade Rifle", 6, "aus_w_hmar", 128)
    badlanderrifle.damage = 40
    local badlanderminigun =  WepItems:Create("badlanderminigun", "Badlander's Minigun", 6, "tfa_fallout_minigun", 128)
    badlanderminigun.damage = 20
end

hook.Add("InitializedPlugins", "InitializedPlugins_wep", function()
    CreateWeapons()
end)

hook.Add("PlayerSwitchWeapon", "WeaponSwitchExample", function(ply, oldWeapon, newWeapon)
    if ply.PlayerSwitchWeapon ~= newWeapon then
        ply.PlayerSwitchWeapon = newWeapon
    end
end)

if nut or Nut or NUT then
    CreateWeapons()
end

local function SetWeapon(n)
    local player = LocalPlayer()
    local char = player:getChar()
    local item = n == 3 and "nut_hands" or char:getInv().items[char:getData("Weapon" .. n)]

    if item ~= "nut_hands" then
        if item == nil then return end
        item = item.Weapon
    end

    hook.Add("StartCommand", "selectWeapon", function(p, CUserCmd)
        if not IsFirstTimePredicted() then
            CUserCmd:SelectWeapon(p:GetWeapon(item))

            return
        end
    end)
end

STORE_REF_ITEM_SELECT = STORE_REF_ITEM_SELECT or {}

hook.Add("PlayerBindPress", "1", function(ply, bind, pressed, num)
    if pressed then
        if num == KEY_1 then
            SetWeapon(1)

            return true
        elseif num == KEY_2 then
            SetWeapon(2)

            return true
        elseif num == KEY_3 then
            SetWeapon(3)

            return true
        end
    else
        hook.Remove("StartCommand", "selectWeapon")
    end
end)

local function getSwepRef(swep)
    local char = swep:GetOwner():getChar()
    local inv = char:getInv().items

    if char then
        local wep1 = char:getData("Weapon1", 0) ~= 0 and inv[char:getData("Weapon1", 0)]
        local wep2 = char:getData("Weapon2", 0) ~= 0 and inv[char:getData("Weapon2", 0)]
        local selfC = swep:GetClass()

        if wep1 and wep1.Weapon == selfC then
            swep.ref = wep1
        elseif wep2 and wep2.Weapon == selfC then
            swep.ref = wep2
        end
    end
end

if SERVER then
    hook.Add("TFA_PostPrimaryAttack", "weapon_durabilty_deal", function(swep)
        if swep.ref == nil then
            getSwepRef(swep)
        end

        swep.ref:setData("HP", swep.ref:getData("HP", 0))
    end)
end

hook.Add("TFA_PrimaryAttack", "weapon_durabilty_prevent", function(swep)
    if swep.ref == nil then
        getSwepRef(swep)
    end

    --swep.Primary.Damage = 1000000000
    if swep.ref == nil then return end

    if CLIENT then
        update_item_details(swep, swep.ref)
    end

    if swep.ref:getData("HP", 0) >= swep.ref.MaxHP then
        local clip1, maxclip1 = 0, swep:GetMaxClip1()
        local soundname = ((clip1 - (swep:GetStat("Primary.AmmoConsumption", 1) * (swep:GetStat("Akimbo") and 2 or 1))) <= 0) and swep:GetStat("LastAmmoSound", "") or swep:GetStat("LowAmmoSound", "")
        swep:EmitSound(swep:GetStat("Primary.Sound_DrySafety"))

        return true
    end
end)

if CLIENT then
    netstream.Hook("weapon_reset_ref", function(id)
        for i, v in pairs(LocalPlayer():GetWeapons()) do
            v.ref = nil
        end
    end)
end