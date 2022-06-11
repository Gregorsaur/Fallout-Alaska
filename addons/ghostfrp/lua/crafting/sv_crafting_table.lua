util.AddNetworkString("CRAFTING")

net.Receive("CRAFTING", function(len, ply)
    local recipe = RECIPES:GetItemWithID(RECIPES.craftingIDToNumber[net.ReadString()])
    local char = ply:getChar()
    local plyInv = char:getInv()

    local hasItems = true

    if recipe[4] == nil or (char:getSkillLevel(recipe[4][1])>=recipe[4][2]) then
        for i, v in pairs(recipe[2]) do
            local amt = plyInv:getItemCount(v[1])

            if amt < v[2] then
                hasItems = false
                break
            end
        end

        if hasItems then
            for i, v in pairs(recipe[2]) do
                local amt = v[2]
                local items = plyInv:getItemsOfType(v[1]) 

                for i = 1, amt do
                    items[i]:remove()
                end

            end
			
			                if recipe[4] then
                print("ege")
                char:addSkillXP(recipe[4][1],recipe[4][3] or 0)
                end
				char:giveXP(4)
                plyInv:add(recipe[1], recipe[3] or 1):next(function(res)
                    if (IsValid(ply)) then
                        local append = (recipe[3] or 1) > 1 and " (" .. (recipe[3] or 1) .. ")" or ""
                        ply:notify(nut.item.list[recipe[1]].name .. append .. " Crafted")
            
                    end
                end)
        else
            ply:notify("You do not have enough items to craft this.")
        end
        else 
        ply:notify("You lack the required skills to make this.")
    end
end)