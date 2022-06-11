print("interactive quest api SV")

-- Get active raids 
local translate = {
    ["The Brotherhood of Steel"] = "BOS"
}

CUR_RAIDS = CUR_RAIDS or {}

net.Receive("RAID_update", function(pl)
    -- uncompress json data 
    local length = net.ReadUInt(32)
    local data = util.Decompress(net.ReadData(length))
    data = util.JSONToTable(data)
    print("====================")
    CUR_RAIDS = data
end)

hook.Add("InitPostEntity", "updateFac", function()
    net.Start("RAID_update")
    net.SendToServer()
end)

if nut then
    net.Start("RAID_update")
    net.SendToServer()
end

hook.Add("HUDPaint", "Worldboss", function()
    hook.Run("HUDOverPaint") 
    local _ = function()
        local ply = LocalPlayer()
        local width, height = ScrW(), ScrH()
        local xOF = 320
        local boxPaddingRight = xOF - 32
        local y = 50
        local halfofbox = boxPaddingRight / 2
        surface.SetFont("$MAIN_Font32")
        NzGUI.DrawShadowText("- CURRENT CONFLICTS -", width - xOF + (boxPaddingRight / 2), y, nil, true)

        for i, v in pairs(CUR_RAIDS) do
            y = y + 30
            surface.SetFont("$MAIN_Font24")
            local totalTeams = math.max(#v.teamA, #v.teamB)
            local teamA_x = width - xOF
            local teamB_x = width - xOF + (boxPaddingRight / 2) + 20
            local oldY = y - 12

            for c = 1, totalTeams do
                local teamA = v.teamA[c] or ""
                local teamB = v.teamB[c] or ""

                if teamA then
                    NzGUI.DrawTextRight((translate[teamA] or teamA):upper(), teamA_x - 20, y, boxPaddingRight / 2)
                end

                if teamB then
                    NzGUI.DrawShadowText((translate[teamB] or teamB):upper(), teamB_x, y, nil)
                end

                y = y + 24
            end

            NzGUI.DrawShadowText("VS", width - xOF + (boxPaddingRight / 2), oldY + (totalTeams * 12), nil, true)
            surface.SetDrawColor(pip_color_20)
            surface.DrawRect(width - xOF, y, boxPaddingRight, 6)
            surface.SetDrawColor(pip_color)
            surface.DrawRect(width - xOF, y, boxPaddingRight * ((v.time - CurTime()) / RAID_MANAGER.Duration), 6)
            --NzGUI.DrawShadowText( "CONSTUTIO                   BOS" ,width-xOF, y,nil,false) 
        end

        y = y + 28
        local character = ply:getChar()
        if character == nil then return end
          if true then return end
        for i, v in pairs(QUESTS:GetActiveQuests(character)) do
            local quest = QUESTS.Table[v]

            if quest then
                surface.SetFont("$MAIN_Font32")
                y = y + 12
                local quest_data = character.vars.quests[v]
                NzGUI.DrawShadowText(quest.title, width - xOF, y, nil, false)
                y = y + 26
                surface.SetFont("$MAIN_Font24")

                for index, stage in pairs(quest.stages) do
                    if quest_data.p == nil then return end
                    local progress = quest_data.p[index] or 0
                    local tx = progress .. "/" .. stage.amountneeded .. "	" .. stage.display
                    NzGUI.DrawShadowText(tx, width - xOF, y, nil, false)

                    -- Draw line though text
                    if progress / stage.amountneeded >= 1 then
                        surface.SetDrawColor(pip_color)
                        local textwidth, xgfaadas = surface.GetTextSize(tx)
                        surface.DrawLine(width - xOF, y + 12, width - xOF + textwidth, y + 12)
                        surface.DrawLine(width - xOF, y + 13, width - xOF + textwidth, y + 13)
                    end

                    y = y + 21
                end
            end
        end
    end

    _()
    hook.Run("HUDOverPaint")
end)
--NzGUI.DrawShadowText("You currently have FISSION, move away from people with DECAY" ,width/2, 64,nil,true)
--NzGUI.DrawShadowText("Unum has selected you to harvest your radiation. " ,width/2, 64,nil,true)