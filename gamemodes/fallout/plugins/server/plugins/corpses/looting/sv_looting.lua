local PLUGIN = PLUGIN

-- Create a corpse when a player die and transfer his loot in it
function PLUGIN:OnCorpseCreated(corpse, victim, char)
    local victimInventory = char:getInv()
    local victimMoney = char:getMoney()

    -- Check that players are near and looking the corpses
    function corpse:EyeTraceCheck()
        if (CurTime() < (self.NextTraceCheck or 0)) then return end
        self.NextTraceCheck = CurTime() + 0.1

        PLUGIN:SearchersFunction(self.Searchers, function(searcher)
            if (PLUGIN:EyeTrace(searcher) ~= self) then
                PLUGIN:CloseLoot(searcher, false)
            end
        end)
    end

    hook.Add("Think", corpse, corpse.EyeTraceCheck)
end

local function findInventoryPlayer(inv)
    local char = inv.owner
    char = nut.char.loaded[char]
    if (char) then return char:getPlayer() end
end

function PLUGIN:CanItemBeTransfered(item, curInv, newInv)
    if (curInv.corpse) then
        local client = findInventoryPlayer(newInv)
        if (not IsValid(client)) then return end

        return (client:GetVar("LootCorpse") == curInv.corpse)
    elseif (newInv.corpse) then
        local client = findInventoryPlayer(curInv)
        if (not IsValid(client)) then return end

        return (client:GetVar("LootCorpse") == newInv.corpse)
    end
end

-- Attach a new inventory to a corpse
function PLUGIN:CreateInventory(corpse, width, height)
end

-- Transfer inventory items to another
function PLUGIN:TransferInventory(from, to)
    if (not (from and to)) then return end
    local fromSlots = from.slots
    local fromChar = nut.char.loaded[from.owner]
    local fromPlayer = fromChar:getPlayer()
    local toSlots = to.slots

    if (fromSlots) then
        for x, items in pairs(fromSlots) do
            for y, item in pairs(items) do
                if (not PLUGIN.IgnoredItems[item.uniqueID]) then
                    if (fromPlayer and item:getData("equip")) then
                        item:call("EquipUn", fromPlayer)
                    end

                    if (not toSlots[x]) then
                        toSlots[x] = {}
                    end

                    toSlots[x][y] = item
                    fromSlots[x][y] = nil
                end
            end
        end

        -- Sync victim's character inventory
        for k, v in ipairs(fromChar:getInv(true)) do
            if (type(v) == "table") then
                v:sync(fromPlayer)
            end
        end
    end
end

-- Transfer the money from a character to another
function PLUGIN:TransferMoney(victim, corpse)
    local char = victim:getChar()
    local money = char:getMoney()
    corpse:SetVar("LootMoney", money)
    char:setMoney(0)
end

-- Make know that a player is currently seaching the corpse
function PLUGIN:RegSearcher(corpse, client)
    if (not corpse.Searchers) then
        corpse.Searchers = {}
    end

    corpse.Searchers[client] = true
    client:SetVar("LootCorpse", corpse)
end

-- Make know that a player is no longer seaching the corpse
function PLUGIN:UnregSearcher(corpse, client)
    if (corpse.Searchers) then
        corpse.Searchers[client] = nil
    end

    client:SetVar("LootCorpse", nil)
end

-- Close corpse loot
function PLUGIN:CloseLoot(client, share)
    local corpse = client:GetVar("LootCorpse")

    if (IsValid(corpse)) then
        PLUGIN:UnregSearcher(corpse, client)

        if (share) then
            netstream.Start(client, "corpses_ext")
        end
    end
end

netstream.Hook("corpses_ext", function(client)
    PLUGIN:CloseLoot(client)
end)

-- Open corpse loot
function PLUGIN:OpenLoot(corpse, client)
    if (IsValid(corpse)) then
        local inv = corpse:GetVar("LootInv")

        if (inv) then
            PLUGIN:RegSearcher(corpse, client)
            inv:sync(client)
            netstream.Start(client, "corpses_opn", inv:getID(), corpse:GetVar("LootMoney"))
        end
    end
end

-- Stared action to open the inventory of a corpse
netstream.Hook("corpses_opn", function(client)
    if (not IsValid(client)) then return end
    local corpse = PLUGIN:EyeTrace(client)

    if (IsValid(corpse) and corpse:IsCorpse()) then
        client:setAction("Searching...", 1)

        client:doStaredAction(corpse, function()
            if (IsValid(corpse)) then
                PLUGIN:OpenLoot(corpse, client)
            end
        end, 1, function()
            if (IsValid(client)) then
                client:setAction()
            end
        end, PLUGIN.corpseMaxDist)
    end
end)

function PLUGIN:SearchersFunction(searchers, func)
    if (searchers) then
        for k, _ in pairs(searchers) do
            if (IsValid(k)) then
                func(k)
            end
        end
    end
end

-- Send corpse money to all corpse searchers
function PLUGIN:ShareCorpseMoney(corpse)
    local searchers = corpse.Searchers

    PLUGIN:SearchersFunction(searchers, function(searcher)
        netstream.Start(searcher, "corpses_mny", corpse:GetVar("LootMoney"))
    end)
end

-- Widthdraw money from loot reserve
function PLUGIN:WidthdrawMoney(client, corpse, amount)
    local oldCorpseMoney = corpse:GetVar("LootMoney")

    if (amount <= oldCorpseMoney) then
        corpse:SetVar("LootMoney", oldCorpseMoney - amount)
        PLUGIN:ShareCorpseMoney(corpse)
        local char = client:getChar()
        char:giveMoney(amount)
    end
end

netstream.Hook("corpses_WdMny", function(client, amount)
    if (not isnumber(amount)) then return end
    if (not IsValid(client)) then return end
    local corpse = client:GetVar("LootCorpse")

    if (IsValid(corpse)) then
        PLUGIN:WidthdrawMoney(client, corpse, amount)
    end
end)

-- Deposit money to corpse reserve
function PLUGIN:DepositMoney(client, corpse, amount)
    local char = client:getChar()
    local oldCharMoney = char:getMoney()

    if (amount <= oldCharMoney) then
        local oldCorpseMoney = corpse:GetVar("LootMoney")
        corpse:SetVar("LootMoney", oldCorpseMoney + amount)
        PLUGIN:ShareCorpseMoney(corpse)
        char:takeMoney(amount)
    end
end

netstream.Hook("corpses_DpMny", function(client, amount)
    if (not isnumber(amount)) then return end
    if (not IsValid(client)) then return end
    local corpse = client:GetVar("LootCorpse")

    if (IsValid(corpse)) then
        PLUGIN:DepositMoney(client, corpse, amount)
    end
end)

netstream.Hook("loot_corpse", function(client, strply)
    local data = {}
    data.filter = client
    data.start = client:GetShootPos()
    data.endpos = data.start + client:GetAimVector() * 80
    local ent = util.TraceLine(data).Entity

    if strply == "FIRE" and ent:IsRagdoll() then
        ent:Ignite(10, 5)

        timer.Simple(10, function()
            ent:Remove()
        end)

        return
    elseif strply == "EAT" and ent.IsBussyAte == nil  and ent:IsRagdoll() then
        local vPoint = client:GetEyeTrace().HitPos
        local effectdata = EffectData()
        effectdata:SetOrigin(vPoint)
         ent:SetMaterial("models/flesh")
        ent:SetColor(Color(255,81,81))
        ent.IsBussyAte  = true
		client:forceSequence("MeleeAttack01", 0,   nil)   
			local d = DamageInfo()


	
        for i = 1, 4 do
            timer.Simple(0.1 * i, function()
                for _i = 1, 4 do
                    util.Effect("BloodImpact", effectdata)

	client:SetHealth(client:Health()+25)
	d:SetAttacker( client )
	d:SetDamageType( DMG_RADIATION ) 
		d:SetDamage( 0.01 )
					client:TakeDamageInfo( d )
                end
            end)
        end

        return
    end

    result = {strply}

    if strply == "all" then
        result = {}

        for i, v in pairs(ent.Inventory) do
            table.insert(result, v)
        end
    end

    for i, rev in pairs(result) do
        local item = {}

        for match in (rev .. "|"):gmatch("(.-)" .. "|") do
            table.insert(item, match)
        end

        item[2] = tonumber(item[2])

        if table.RemoveByValue(ent.Inventory, rev) then
            ent:SetNW2String("corpse", util.TableToJSON(ent.Inventory))

            if item[1] == "Caps" then
                client:getChar():giveMoney(item[2])
            else
                local target = client

                client:getChar():getInv():add(item[1], item[2] or 1):next(function(res)
                    if (IsValid(target)) then
                        target:notify(nut.item.list[item[1]].name .. "Added")
                    end

                    if (IsValid(client) and client ~= target) then
                        client:notify("itemCreated")
                    end
                end):catch(function(err)
                    if (IsValid(client)) then
                        client:notifyLocalized(err)
                        print(err)
                    end
                end)
            end
        end
    end
end)