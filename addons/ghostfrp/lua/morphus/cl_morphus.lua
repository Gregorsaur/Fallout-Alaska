local parentLookup = {}
CLIENT_CREATED_MODELS = CLIENT_CREATED_MODELS or {}
local Player = FindMetaTable("Entity")

local function cacheParents()
    parentLookup = {}
    local tbl = ents.GetAll()

    for i = 1, #tbl do
        local v = tbl[i]

        if v:EntIndex() == -1 then
            local parent = v:GetInternalVariable("m_hNetworkMoveParent")
            local children = parentLookup[parent]

            if not children then
                children = {}
                parentLookup[parent] = children
            end

            children[#children + 1] = v
        end
    end
end

local function fixChildren(parent, transmit)
    local isDirty = false

    if transmit and parent:GetClass() == "player" and parent.Morph then
        parent:ApplyMorph()
    end
end

local lastTime = 0

hook.Add("NotifyShouldTransmit", "test", function(ent, transmit)
    local time = RealTime()

    if lastTime < time then
        --	cacheParents() 
        lastTime = time
    end

    if transmit and ent:IsPlayer() and ent:getChar() and LocalPlayer():getChar() then
        ent:ApplyMorph(ent:getChar():getApperance())
    end

    fixChildren(ent, transmit)
end)

local alias = {}

net.Receive("getDataRequestCC, Create", function(len, player)
    local e = net.ReadEntity(e)
    local c = net.ReadTable(self:getApperance())
    e.Morph = c
    e:ApplyMorph(c)
end)

function Player:ApplyMorph(data, muteCall)
    RunConsoleCommand("r_eyemove", "0")
    if self == nil and not self:IsValid() then return end -- REALLY
    data = data or self.Morph

    if data == nil then
        net.Start("getDataRequestCC")
        net.WriteEntity(self)
        net.SendToServer()

        return
    end

    data.scale = data.height or 1 --(math.random(90,110)/100  )

    if data.scale then
        self:SetModelScale(data.scale)
    end

    data.ghoul = data.ghoul or 0
    self.Morph = data
    self.marking = (data and data.marking or 1) - 1
    self.eyecolor = data and data.eyecolor or 1
    self.skincolor = data.skin or Vector(1, 1, 1)
    self.parts = self.parts or {}
    self.player = self
    local mdx = string.Replace(self:GetModel(), "npc", "pm")
    local mdl = TRANS:GetDataByModel(mdx or self:GetModel())
    local n = string.lower(self:GetModel())
    local parent = TRANS.ModelToID[n]
    if parent == nil then return end -- THANK FUCK
    local boneCache = TRANS.MDLBoneCache[parent] or TRANS:BuildModelCache(self, mdx)
    self:SetMaterial("")

    for i, v in pairs(self:GetMaterials()) do
        self:SetSubMaterial(i - 1, "")
    end

    if IsValid(self) and data.ghoul > 0 then
        local headMat = "models/lazarusroleplay/humans/shared/skin/ghoul/ghoul_facemap"
        local bodyMat = "models/lazarusroleplay/humans/shared/skin/ghoul/anatomy_g_body"
        local handMat = "models/lazarusroleplay/humans/shared/skin/ghoul/anatomy_g_hands"

        if data.ghoul > 1 then
            headMat = headMat .. data.ghoul
            bodyMat = bodyMat .. data.ghoul
            handMat = handMat .. data.ghoul
        end

        self:SetSubMaterial(mdl.materialIndex.head - 1, headMat)
        self:SetSubMaterial(mdl.materialIndex.body - 1, bodyMat)
        self:SetSubMaterial(mdl.materialIndex.hands - 1, handMat)
    end

    -- Apply Bonescaling
    for i, v in pairs(self.parts or {}) do
        if IsValid(v) then
            v:Remove()
        end
    end

    local parts = data.parts or {}
    local hide_flags = {}

    for i, v in pairs(parts) do
        for j, k in pairs(v.skipFlags or {}) do
            hide_flags[k] = true
        end
    end

    self.parts = {}
    data = data or {}

    data.hair = data.hair or {1, Vector(0, 0, 0)}

    data.move_bones = data.move_bones or {}
    local eyebrowcolor = data.hair[3] or data.hair[2]
    data.bones = data.bones or {}
    --[[
    for i, v in pairs(data.bones) do
        local CurBone = mdl.Bones[i]

        if CurBone[1] then
            self:ManipulateBoneScale(boneCache[CurBone[3] ], v)
            self:ManipulateBoneScale(boneCache[CurBone[2] ], v)
        else
            self:ManipulateBoneScale(boneCache[CurBone[2] ], v)
        end
    end

    for i, v in pairs(data.move_bones) do
        local CurBone = mdl.BonesT[i]

        if CurBone then
            if CurBone[1] == true then
                self:ManipulateBonePosition(boneCache[CurBone[3] ], v)
                self:ManipulateBonePosition(boneCache[CurBone[2] ], v)
            else
                self:ManipulateBonePosition(boneCache[CurBone[2] ], v)
            end
        end
    end
]]
    self.parts = {}
    TRANSFORM_LOCALLY_BG(self, data)
    --self:ManipulateBoneScale(self:LookupBone("skin_bone_C_ForeheadMid"), Vector(0, 0, 0))
    -- self:ManipulateBoneAngles(self:LookupBone("PipboyBone"), Angle(0, 0, 0))
    self.Pip = ClientsideModel("models/pipboy.mdl")

    if self.Pip then
        self.Pip:SetModel("models/pipboy.mdl")
        self.Pip:SetPos(self:GetPos())
        self.Pip:FollowBone(self, self:LookupBone("ValveBiped.Bip01_L_Forearm"))
        self.Pip:SetModelScale(0.85 * data.scale)
        self.parts["pips"] = self.Pip
        self.Pip:SetLocalPos(Vector(7, 0, 1))
        self.Pip:SetLocalAngles(Angle(270, 270, 90))
        self.Pip:Spawn()
        self.Pip:Remove()
        self.parts["pipboy"] = nil
    end

    if not (hide_flags[HIDE_HEAD] or hide_flags[HIDE_FACIAL_HAIR]) then
        local facial_hair_data = {
            [1] = {"models/mosi/fallout4/character/facialhair/bard.mdl", Vector(0.6, -5.7, 0)},
            [2] = {"models/mosi/fallout4/character/facialhair/beast.mdl", Vector(1.4, -5.8, 0)},
            [3] = {"models/mosi/fallout4/character/facialhair/chopper.mdl", Vector(2.4, -1.5, 0)},
            [4] = {"models/mosi/fallout4/character/facialhair/doomsdayprepper.mdl", Vector(2.3, -1., 0), Vector(1.1, 1.1, 1.1)},
            [5] = {"models/mosi/fallout4/character/facialhair/gettysburg.mdl", Vector(0, -5, 0)},
            [6] = {"models/mosi/fallout4/character/facialhair/goatee.mdl", Vector(0.2, -5.5, 0)},
            [7] = {"models/mosi/fallout4/character/facialhair/hombre.mdl", Vector(0.7, -5.45, 0)},
            [8] = {"models/mosi/fallout4/character/facialhair/prospector.mdl", Vector(0.8, -5.45, 0)},
            [9] = {"models/mosi/fallout4/character/facialhair/shenandoah.mdl", Vector(-0.5, -3.6, 0)},
            [10] = {"models/mosi/fallout4/character/facialhair/survivalist.mdl", Vector(0.7, -5, 0), Vector(0.9, 1.1, 1.1)},
            [11] = {"models/mosi/fallout4/character/facialhair/straightflush.mdl", Vector(0.8, -5.4, 0)},
        }

        local okjhga = 1

        if data.facial_hair and data.facial_hair >= 1 then
            local hc = eyebrowcolor
            local facial_hair_d = facial_hair_data[data.facial_hair or 1]
            self.FacialHair = ents.CreateClientside("cl_bonem") --ClientsideModel(facial_hair_d[1])
            if  self.FacialHair and IsValid( self.FacialHair) then 
            self.FacialHair:SetModel(facial_hair_d[1])
            self.FacialHair.whomOwns = self
            self.parts.FacialHair = self.FacialHair
            self.FacialHair:SetPos(self:GetPos())
            self.FacialHair:FollowBone(self, self:LookupBone("valvebiped.bip01_head1"))
            self.FacialHair.DoTint = true
            table.insert(CLIENT_CREATED_MODELS, self.FacialHair)

            for i = 0, 3 do
                timer.Simple(FrameTime() * i, function()
                    if IsValid(self.FacialHair) then
                        self.FacialHair:SetLocalPos(facial_hair_d[2])
                    end
                end)
            end

            facial_hair_d[3] = facial_hair_d[3] or 1

            if type(facial_hair_d[3]) == "number" then
                self.FacialHair:SetModelScale(facial_hair_d[3])
            else
                local scale = facial_hair_d[3]
                local mat = Matrix()
                mat:Scale(scale)
                self.FacialHair:EnableMatrix("RenderMultiply", mat)
            end

            self.FacialHair:SetLocalPos(facial_hair_d[2])
            self.FacialHair:SetLocalAngles(Angle(0, 270, 270))
            self.FacialHair:SetColor(Color(hc.x * 255, hc.y * 255, hc.z * 255))
            self.FacialHair:Spawn()
            self.FacialHair.col = hc
            end
        end
    end

    if not (hide_flags[HIDE_HEAD] or hide_flags[HIDE_HAIR]) and data.hair and mdl.Hairstyles[data.hair[1]] ~= "" and mdl.Hairstyles[data.hair[1]] then
        local hr = mdl.Hairstyles[data.hair[1]]

        self.Hair =  ents.CreateClientside("cl_bonem")
        
        if self.Hair and IsValid(self.Hair)  and not IsUselessModel( hr[1] ) then 
        self.Hair:SetModel(hr[1]) 
        -- if model not exists remove

        local scale = mdl.HairGlobalScale or 1

        if IsValid(self.Hair) then
            self.Hair:SetPos(self:GetPos())
            self.Hair:FollowBone(self, self:LookupBone("valvebiped.bip01_head1"))
            self.Hair.DoTint = true
            self.Hair:SetParent(self)
            self.Hair:AddEffects(EF_BONEMERGE_FASTCULL)
            table.insert(CLIENT_CREATED_MODELS, self.Hair)

            if type(hr[2]) == "number" then
                self.Hair:SetModelScale(hr[2] * scale * data.scale)
            else
                local scale = hr[2] * scale * data.scale
                local mat = Matrix()
                mat:Scale(scale)
                self.Hair:EnableMatrix("RenderMultiply", mat)
            end

            self.Hair:SetLocalPos(Vector(1.3, -0.7, 0.4) - hr[3] + (mdl.HairGlobalPosition or Vector(0, 0, 0)))
            self.Hair:SetLocalAngles(Angle(0, 270, 270))
            self.Hair:Spawn()
            table.insert(self.parts, self.Hair)
            self.Hair.col = data.hair[2]
            self.Hair:SetColor(Color(data.hair[2].x * 255, data.hair[2].y * 255, data.hair[2].z * 255))
            end
        end
    end

    local part = self
    local prefix = 5

    for i, v in pairs(data.parts or {}) do
        if v.model then
            local part = ents.CreateClientside("cl_bonem") --or  ClientsideModel(v.model)
            table.insert(CLIENT_CREATED_MODELS, part)
            local _i = i
            part:SetModel(v.model)
            self.parts[i] = part

            if self.parts[i] then
                self.parts[i]:SetParent(self)
                self.parts[i]:AddEffects(EF_BONEMERGE + EF_BONEMERGE_FASTCULL)
                self.parts[i]:Spawn() --[[EF_BONEMERGE + EF_BONEMERGE_FASTCULL]]
                --self.parts[i]:SetNoDraw( true )
            end
        end 
    end

    --table.insert(self.parts, self.Torso)
    table.insert(self.parts, self.Pip)
    table.insert(self.parts, self.Hair)
    self.eyelash = eyebrowcolor
    self.parts["pip"] = self.pip
    if true == false then 
    if self == LocalPlayer() then
        local bind = not self:ShouldDrawLocalPlayer()

        for i, v in pairs(self.parts) do
            if IsValid(v) then
                --v:SetNoDraw(bind)
            end
        end

        hook.Add("Think", self, function()
            -- if noclip then
            local bind = not self:ShouldDrawLocalPlayer() or self:GetMoveType() == MOVETYPE_NOCLIP and not self:InVehicle()

            for i, v in pairs(self.parts) do
                if IsValid(v) then
                  --  v:SetNoDraw(bind)
                end
            end
        end)
    else
        if self:IsPlayer() then
            hook.Add("Think", self, function()
                local ali = not self:Alive() or self:GetMoveType() == MOVETYPE_NOCLIP  and not self:InVehicle()
                --self:SetNoDraw(ali)

                for i, v in pairs(self.parts) do
                    if IsValid(v) then
                      --  v:SetNoDraw(ali)
                    end
                end
            end)
        end
    end
    end
    for i, v in pairs(self.parts) do
        if IsValid(v) then
            v:SetPredictable(true)
            v:CreateShadow()
        end
    end

    if muteCall == nil then
        hook.Run("YSHERA_MORPH_UPDATE", self, data)
    end
end

timer.Simple(120, function()
    netstream.Hook("corpseApp", function(corpse, victim)
        corpse = Entity(corpse)
        victim = Entity(victim)
        corpse:ApplyMorph(victim:getChar():getApperance())
    end)
end)

for i, ent in pairs(player.GetAll()) do
    ent:ApplyMorph(ent:getChar():getApperance())
end

timer.Create("fixMorph", 10, 0, function()
    for i, ent in pairs(player.GetAll()) do
        local char = ent:getChar()

        if char and (ent.parts == nil or #ent.parts == 0) then
            ent:ApplyMorph(ent:getChar():getApperance())
        end
    end

    -- check all clientside models, check for parent if not valid or parent is non existant remove
    local len = #CLIENT_CREATED_MODELS

    -- do loop backwards as we are removing from the table
    for i = len, 1, -1 do
        local v = CLIENT_CREATED_MODELS[i]

        if v and IsValid(v) and not IsValid(v:GetParent()) then
            v:Remove()
            table.remove(CLIENT_CREATED_MODELS, i)
        end
    end
end)



