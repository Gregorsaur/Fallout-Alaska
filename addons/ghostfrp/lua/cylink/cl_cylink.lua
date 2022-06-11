function nzWAYSHRINES:GetWayShrines(phase)
    return nzWAYSHRINES.PhaseMap[phase]
end

AUDIO_WAYSHRINE_STREAMS = AUDIO_WAYSHRINE_STREAMS or {}
NPC_WAYSHRINE_STREAM = NPC_WAYSHRINE_STREAM or {}

concommand.Add("test_csent", function(ply)
    local plyTr = ply:GetEyeTrace()
    local csEnt = ents.CreateClientProp("models/props_junk/watermelon01.mdl")
    csEnt:SetPos(plyTr.HitPos + plyTr.HitNormal * 24)
    csEnt:Spawn()
    csEnt.Portal = true
end)

concommand.Add("getlookvec", function(ply)
    local tr = util.TraceLine({
        start = LocalPlayer():EyePos(),
        endpos = LocalPlayer():EyePos() + EyeAngles():Forward() * 10000,
    })

    SetClipboardText("Vector(" .. tr.HitPos.x .. "," .. tr.HitPos.y .. "," .. tr.HitPos.z .. "),")
    print(("Vector(" .. tr.HitPos.x .. "," .. tr.HitPos.y .. "," .. tr.HitPos.z .. "),"))
end)

local function sign(p1, p2, p3)
    return (p1.x - p3.x) * (p2.y - p3.y) - (p2.x - p3.x) * (p1.y - p3.y)
end

local function PointInTriangle(pt, v1, v2, v3)
    local d1, d2, d3
    local has_neg, has_pos
    d1 = sign(pt, v1, v2)
    d2 = sign(pt, v2, v3)
    d3 = sign(pt, v3, v1)
    has_neg = (d1 < 0) or (d2 < 0) or (d3 < 0)
    has_pos = (d1 > 0) or (d2 > 0) or (d3 > 0)

    return not (has_neg and has_pos)
end

local disableInputE = false
local dev = false
local destAlpha = 0
local curAlpha = 0
local disableUntilMsg = true
points = points or {}

hook.Add("Move", "devMove_way", function()
    if dev then
        if input.WasKeyPressed(KEY_H) then
            local tr = LocalPlayer():GetEyeTrace()
            local v = tr.HitPos
            table.insert(points, v)
        end

        if input.WasKeyPressed(KEY_R) then
            for i = 1, 4 do
                print("Vector(", points[i].x, ",", points[i].y, ",", points[i].z, "),")
            end

            points = {}
        end
    end
end)

hook.Add("HUDPaint", "WAYSHRINE_CLIENT", function()
    disableInputE = false
    curAlpha = Lerp(FrameTime() * 6, curAlpha, destAlpha)

    if dev then
        local tr = LocalPlayer():GetEyeTrace()
        local v = tr.HitPos:ToScreen()
        surface.SetDrawColor(pip_color)
        draw.NoTexture()
        surface.DrawRect(v.x - 4, v.y - 4, 8, 8)

        for i, v in pairs(points) do
            local v = v:ToScreen()
            surface.DrawRect(v.x - 4, v.y - 4, 8, 8)
            local n = points[i == #points and 1 or i + 1]:ToScreen()
            surface.DrawLine(v.x, v.y, n.x, n.y)
        end
    end

    local ply = LocalPlayer()
    ply.Phase = ply.Phase or 0
    surface.SetFont("Default")
    surface.SetTextColor(255, 255, 255)
    surface.SetTextPos(128, 128)
    surface.SetDrawColor(0, 0, 0, curAlpha)
    surface.DrawRect(0, 0, ScrW(), ScrH())
    local poly = {}

    for c, ch in pairs(nzWAYSHRINES:GetWayShrines(ply.Phase)) do
        local Wayshrine = nzWAYSHRINES.Storage[ch]
        local warning = 0

        if Wayshrine[nzWAYSHRINE_STATE_TELEPORT_ORIGIN]:DistToSqr(ply:GetPos()) < 20000 then
            for i, v in pairs(Wayshrine[nzWAYSHRINE_STATE_TELEPORT_PINS]) do
                local s = v:ToScreen()
                warning = warning + (s.visible and 0 or 1)
                if warning == 4 then return end

                if dev then
                    surface.DrawRect(s.x - 4, s.y - 4, 8, 8)
                    surface.SetTextPos(s.x, s.y)
                    surface.DrawText(i)
                end

                poly[i] = {
                    ["x"] = s.x,
                    ["y"] = s.y
                }
            end

            local cx, cy = ScrW() * 0.5, ScrH() * 0.5

            local b = PointInTriangle({
                x = cx,
                y = cy
            }, poly[1], poly[2], poly[3]) or PointInTriangle({
                x = cx,
                y = cy
            }, poly[1], poly[3], poly[4])

            if b then
                disableInputE = b
                WAYSHRINE_LOOKING_AT = Wayshrine

                if disableUntilMsg then
                    FAKE_ENTITY_INTERACTABLE = Wayshrine[nzWAYSHRINE_STATE_TELEPORT_INTERACTABLE]
                end
            end
        end
    end
end)

hook.Add("PlayerBindPress", "!PlayerBindWayshrine", function(ply, bind, pressed, num)
    if disableInputE and pressed and disableUntilMsg and num == KEY_E then
        disableUntilMsg = false

        timer.Simple(0.5, function()
            netstream.Start("wayshrine", WAYSHRINE_LOOKING_AT.id)
        end)

        timer.Simple(1.2, function()
            destAlpha = 0
            disableUntilMsg = true
        end)

        destAlpha = 300

        return true
    end
end)

local volume = 0.2

local function init_wayshrine()
    netstream.Hook("wayshrine", function(id)
        timer.Simple(0.5, function()
            destAlpha = 0
        end)

        disableUntilMsg = true
        LocalPlayer().Phase = id
        hook.Run("wayshrine_npc_reload")

        for i, v in pairs(AUDIO_WAYSHRINE_STREAMS) do
            if IsValid(v) then
                local fadetime = 0.5
                local endtime = RealTime() + fadetime
                local starttime = RealTime()

                hook.Add("Think", v, function()
                    local p = (endtime - RealTime()) / fadetime
                    --print(p)
                    v:SetVolume(volume * p)
                end)

                timer.Simple(fadetime, function()
                    if IsValid(v) then
                        hook.Remove("Think", v)
                        v:Stop()
                        v = nil
                    end
                end)
            end
        end

        for i, v in pairs(nzWAYSHRINES.Audio[id]) do
            sound.PlayURL(v[1], "3d", function(station)
                chat.AddText("RADIO PLAY")

                if (IsValid(station)) then
                    station:SetPos(v[2])
                    station:Play()
                    station:SetVolume(volume)
                    station:Set3DFadeDistance(90000000, 90000000)
                    table.insert(AUDIO_WAYSHRINE_STREAMS, station)
                    local fadetime = 0.5
                    local endtime = RealTime() + fadetime
                    local starttime = RealTime()

                    hook.Add("Think", station, function()
                        local p = (endtime - RealTime()) / fadetime
                        --print(p)
                        station:SetVolume(volume * (1-p))
                    end)

                    timer.Simple(fadetime, function()
                        if IsValid(station) then
                            hook.Remove("Think", station)
                        end
                    end)
                end
            end)
        end
    end)
end

hook.Add("InitPostEntity", "sv_wayshrineInt", function()
    init_wayshrine()
end)

if netstream then
    init_wayshrine()
end

local function ClearNPCS()
    for i, v in pairs(NPC_WAYSHRINE_STREAM) do
        if IsValid(v) then
            for c, z in pairs(v.parts or {}) do
                if IsValid(z) then
                    z:Remove()
                end
            end

            v:Remove()
        end

        NPC_WAYSHRINE_STREAM = {}
    end
end

local player = nil

function RUN_BEHAVIOR_ENTITY(self)
    local ppos = self:GetPos()
    local np = player:GetPos()
    local n = player:GetPos():DistToSqr(ppos)
    local dist = 200 ^ 2
    self:SetPredictable(false)

    if n < dist and self.State == 0 then
        self.LastPaint = RealTime()
        local iSeq = self:LookupSequence("Sit_Ground_to_Idle")

        if (iSeq > 0) then
            self:ResetSequenceInfo()
            self:ResetSequence(iSeq)
        end

        self.State = 1

        timer.Simple(self:SequenceDuration(iSeq), function()
            local iSeq = self:LookupSequence("idle_subtle")
            self.State = 2

            if (iSeq > 0) then
                self:ResetSequenceInfo()
                self:ResetSequence(iSeq)
            end
        end)
    elseif self.State == 2 then
        if not (n > dist) then
            local vv = math.deg(math.atan2(ppos.y - np.y, ppos.x - np.x))
            vv = math.Clamp(vv, -45, 45)
            self:ManipulateBoneAngles(self:LookupBone("ValveBiped.Bip01_Neck1"), Angle(0, math.abs(vv / 16), vv))
        else
            self.State = 0
            self:ManipulateBoneAngles(self:LookupBone("ValveBiped.Bip01_Neck1"), angle_zero)
            local iSeq = self:LookupSequence("Idle_to_Sit_Ground")
            self.LastPaint = RealTime()

            if (iSeq > 0) then
                self:ResetSequenceInfo()
                self:ResetSequence(iSeq)
            end
        end
    end
end

hook.Add("wayshrine_npc_reload", "loadnpcs", function()
    ClearNPCS()
    local id = LocalPlayer().Phase

    for i, v in pairs(nzWAYSHRINES.NPCs[id]) do
        local entity = ClientsideModel(v.model)
        entity:SetPos(v.pos - Vector(0, 0, 64))
        table.insert(NPC_WAYSHRINE_STREAM, entity)
        entity:SetAngles(v.ang)
        entity:Spawn()
        entity.LastPaint = 0
        entity:SetIK(false)
        entity.State = 0
        -- Try to find a nice sequence to play
        local iSeq = entity:LookupSequence("Sit_Ground")

        if (iSeq > 0) then
            entity:ResetSequence(iSeq)
        end

        entity:ApplyMorph({
            bones = {},
            move_bones = {},
            hair = {8, Vector(255 / 255, 35 / 255, 35 / 255)},
            eyecolor = 2
        })
    end

    hook.Add("RenderScene", "nzWAYSHRINES", function()
        player = LocalPlayer()

        for i, Entity in pairs(NPC_WAYSHRINE_STREAM) do
            if IsValid(Entity) then
                local headboneid = Entity:LookupBone("ValveBiped.Bip01_Neck1")
                local pos = Entity:GetBonePosition(headboneid)

                if pos == Entity:GetPos() then
                    pos = Entity:GetBoneMatrix(headboneid):GetTranslation()
                end

                cam.Start2D()
                local c = pos:ToScreen()
                local r = 120

                if c.visible and ScrW() / 2 - r < c.x and ScrW() / 2 + r > c.x and ScrH() / 2 - r < c.y and ScrH() / 2 + r > c.y and player:GetPos():DistToSqr(pos) < 7000 then
                    FAKE_ENTITY_INTERACTABLE = {"AN", "TALK"}
                end

                cam.End2D()
                RUN_BEHAVIOR_ENTITY(Entity)
                Entity:FrameAdvance((RealTime() - Entity.LastPaint))
                Entity.LastPaint = RealTime()
            end
        end
    end)
end)

hook.Run("wayshrine_npc_reload")
init_wayshrine()
LocalPlayer():SetPlayerColor( Vector( 148/255, 213/255, 1 ) )