TRANS = TRANS or {}
TRANS.Models = {}
TRANS.ModelToID = {}
HIDE_TORSO = 1
HIDE_BODY = HIDE_TORSO
HIDE_HAIR = 2
HIDE_FACIAL_HAIR = 4
HIDE_HANDS = 8
HIDE_HEAD = 16
HIDE_PANTS = 32


FLAG_HIDE_CHEST 	= 33
FLAG_HIDE_HEAD 		= 34
FLAG_HIDE_EYES 		= 35
FLAG_HIDE_NECK 		= 36
FLAG_HIDE_UPPERARM  = 37
FLAG_HIDE_FOREARM   = 38
FLAG_HIDE_HANDS 	= 39
FLAG_HIDE_TORSO 	= 40
FLAG_HIDE_THIGHS 	= 41
FLAG_HIDE_KNEES 	= 42
FLAG_HIDE_FEET 		= 43



local meta = {}
local metaIndex = {}
meta.__index = metaIndex
local Player = FindMetaTable("Entity")
TRANS.MDLBoneCache = {}

function TRANSFORM_LOCALLY_BG(player, data)
    player:SetBodyGroups("000000000000000")
    local parts = data.parts or {}
    local hide_flags = {}
    for i, v in pairs(parts) do
        for j, k in pairs(v.skipFlags or {}) do
            hide_flags[k] = true
			 if k  and type(k) == "number" and k > 32 then
				player:SetBodygroup(k-33, 1)
			end
        end
    end

	local self = player
	
		self:SetMaterial("")
	for i,v in pairs( self:GetMaterials() ) do 
	self:SetSubMaterial(i-1,"") 
	end
	data.ghoul = data.ghoul or 0
	if IsValid(self) and data.ghoul > 0 then
        local headMat = "models/lazarusroleplay/humans/shared/skin/ghoul/ghoul_facemap"
		local bodyMat = "models/lazarusroleplay/humans/shared/skin/ghoul/anatomy_g_body"
		local handMat = "models/lazarusroleplay/humans/shared/skin/ghoul/anatomy_g_hands"
		if data.ghoul > 1 then 
			headMat = headMat..data.ghoul
			bodyMat = bodyMat..data.ghoul
			handMat = handMat..data.ghoul
		end
		    local mdx = string.Replace(self:GetModel(), "npc", "pm")
    local mdl = TRANS:GetDataByModel(mdx or self:GetModel())
		self:SetSubMaterial(mdl.materialIndex.head-1,headMat) 
		self:SetSubMaterial(mdl.materialIndex.body-1,bodyMat) 
		self:SetSubMaterial(mdl.materialIndex.hands-1,handMat) 
		
		
    end

    if hide_flags[HIDE_TORSO] then

        player:SetBodygroup(0, 1)
	
		player:SetBodygroup(5, 1)
		player:SetBodygroup(4, 1)
			player:SetBodygroup(7, 1)
    end

    if hide_flags[HIDE_PANTS] then
        player:SetBodygroup(10, 1)
		player:SetBodygroup(9, 1)
		player:SetBodygroup(8, 1)

    end

    if hide_flags[HIDE_HANDS] then
        player:SetBodygroup(6, 1)
		player:SetBodygroup(5, 1)
		player:SetBodygroup(4, 1)
    end

    if hide_flags[HIDE_HEAD] then
        player:SetBodygroup(1, 1)
        player:SetBodygroup(2, 1)
		player:SetBodygroup(3, 1)
    end
	
	
end

TRANS.PrintBones = function(entity)
    for i = 0, entity:GetBoneCount() - 1 do
        print(i, entity:GetBoneName(i))
    end
end

local function log(n)
end

function metaIndex:DefineHairstyles(id, scale, vec, tag, hairstyle)
    self.Hairstyles[id] = {hairstyle, scale, vec}

    self.Hairstyles[id].name = tag
    self.Hairstyles["name_" .. id] = tag
end

function metaIndex:DefineMarking(id, tag)
    self.Markings[id] = tag
end

function metaIndex:DefineEyecolor(id, tag)
    self.Eyecolor[id] = tag
end

function metaIndex:DefineHairstyleColor(id, r, g, b)
    self.HairstylesColor[id] = Vector(r / 255, g / 255, b / 255)
end

function metaIndex:DefineBone(bone, id, isLeftRightBone)
    self.Bones[id] = {isLeftRightBone}

    if isLeftRightBone then
        table.insert(self.Bones[id], string.Replace(bone, "$", "L"))
        table.insert(self.Bones[id], string.Replace(bone, "$", "R"))
    else
        self.Bones[id][2] = bone
    end

    self.Bones_mesh[id] = bone
    self.Bones_mesh[bone] = id
    log("Added " .. bone .. " bone ")
end

function metaIndex:DefineBoneTransform(bone, id, isLeftRightBone)
    self.BonesT[id] = {isLeftRightBone}

    if isLeftRightBone then
        table.insert(self.BonesT[id], string.Replace(bone, "$", "L"))
        table.insert(self.BonesT[id], string.Replace(bone, "$", "R"))
    else
        self.BonesT[id][2] = bone
    end

    self.BonesT_mesh[bone] = id
    log("Added " .. bone .. " bone ")
end

function TRANS:DefineCharacter(id, m)
    TRANS.Models[id] = {}
    TRANS.Models[id].model = m
    TRANS.Models[id].id = id
    TRANS.Models[id].Bones = {}
    TRANS.Models[id].Hairstyles = {}
    TRANS.Models[id].BonesT = {}
    TRANS.Models[id].BonesT_mesh = {}
    TRANS.Models[id].Bones_mesh = {}
    TRANS.Models[id].HairstylesColor = {}
    TRANS.Models[id].Markings = {}
    TRANS.Models[id].Eyecolor = {}
    TRANS.ModelToID[m] = id
    setmetatable(TRANS.Models[id], meta)

    return TRANS.Models[id]
end

function TRANS:GetDataByModel(m)
    return TRANS.Models[TRANS.ModelToID[m]]
end

function TRANS:BuildModelCache(ent, mdl)
    log("Built Cache", Color(255, 0, 0), mdl or ent:GetModel())
    local entity = ClientsideRagdoll(mdl or ent:GetModel())
    local trace = LocalPlayer():GetEyeTrace()
    entity:SetPos(trace.HitPos + trace.HitNormal * 24)
    entity:Spawn()

    timer.Simple(1, function()
        entity:Remove()
    end)

    local mdl = mdl or ent:GetModel()

    if TRANS.ModelToID[mdl] then
    else
        return
    end

    TRANS.MDLBoneCache[TRANS.ModelToID[mdl]] = {}

    for i = 0, ent:GetBoneCount() - 1 do
        TRANS.MDLBoneCache[TRANS.ModelToID[mdl]][i] = entity:GetBoneName(i)
        TRANS.MDLBoneCache[TRANS.ModelToID[mdl]][entity:GetBoneName(i)] = i
    end

    return TRANS.MDLBoneCache[TRANS.ModelToID[mdl]]
end

function TRANS:GetBone(model, GetBone)
    return TRANS.MDLBoneCache[model][GetBone]
end

female_character = TRANS:DefineCharacter("human_female_fallout", "models/yshera/humans/female.mdl")
TRANS.ModelToID["models/yshera/humans/female3.mdl"] = "human_female_fallout"
female_character.materialIndex = {
head = 3,
body = 1,
eye = 4,
hands = 5,
}
female_character.hairBone = 32
female_character.HairGlobalScale = 0.85
female_character.HairGlobalPosition = Vector(-0.1,-0.1,-0.25)
female_character:DefineHairstyles(1, 0.88, Vector(0, 0.2, 0.2), "Down", "models/mosi/fallout4/character/female/femalehairlong01.mdl")
female_character:DefineHairstyles(2, 0.87, Vector(0, 0.5, 0.1), "Short", "models/mosi/fallout4/character/female/femalehair16.mdl")
female_character:DefineHairstyles(3, Vector(0.9, 1, 1), Vector(0.5, -0.4, 0), "Ponytail", "models/mosi/fallout4/character/female/femalehair05.mdl")
female_character:DefineHairstyles(4, 0.88, Vector(-0.1, -0.1, 0.1), "Combed Back", "models/mosi/fallout4/character/female/femalehair06.mdl")
female_character:DefineHairstyles(5, 0.89, Vector(0, -0.2, .2), "Fringe", "models/mosi/fallout4/character/female/femalehair07.mdl")
female_character:DefineHairstyles(6, 0.84, Vector(-0.15, 0, .2), "Neck Rounded Fringe", "models/mosi/fallout4/character/female/femalehair08.mdl")
female_character:DefineHairstyles(8, 0.88, Vector(0, 0.2, 0.1), "Curls", "models/mosi/fallout4/character/female/femalehair11.mdl")
female_character:DefineHairstyles(9, Vector(0.8, 1, 1), Vector(0.3, 0, .3), "Tracer", "models/mosi/fallout4/character/female/femalehair12.mdl")
female_character:DefineHairstyles(10, 0.9, Vector(0, 0, 0), "Short Tucked Behind Ear", "models/mosi/fallout4/character/female/femalehair13.mdl")
female_character:DefineHairstyles(11, 0.9, Vector(0, 0, 0), "Curls At Back", "models/mosi/fallout4/character/female/femalehair14.mdl")
female_character:DefineHairstyles(12, 0.9, Vector(0, 0, 0), "Long Fringe", "models/mosi/fallout4/character/female/femalehair15.mdl")
female_character:DefineHairstyles(13, 0.9, Vector(0, 0, 0.15), "NAME UNSET", "models/mosi/fallout4/character/female/femalehair33.mdl")
female_character:DefineHairstyles(14, 0.9, Vector(0, 0, 0.2), "Curled Fringe", "models/mosi/fallout4/character/female/femalehair18.mdl")
female_character:DefineHairstyles(15, 0.9, Vector(0, 0, 0), "Messy", "models/mosi/fallout4/character/female/femalehair23.mdl")
female_character:DefineHairstyles(16, 0.89, Vector(0, 0, 0), "Viking", "models/mosi/fallout4/character/female/femalehair31.mdl")
female_character:DefineHairstyles(17, 0.89, Vector(0, 0, 0), "classic", "models/mosi/fallout4/character/female/femalehair24.mdl")
female_character:DefineHairstyles(18, 0.89, Vector(0, 0, 0), "Military", "models/mosi/fallout4/character/female/femalehair10.mdl")
female_character:DefineHairstyles(19, 0.92, Vector(0, 0, 0), "short", "models/mosi/fallout4/character/female/femalehairshort02.mdl")
female_character:DefineHairstyles(20, 0.90, Vector(0, 0, .2), "slick", "models/mosi/fallout4/character/male/malehair27.mdl")

female_character:DefineMarking(1, "None")
female_character:DefineMarking(2, "Blackeyes")
female_character:DefineMarking(3, "Freckles")
female_character:DefineMarking(4, "Fresh Eye Cut")
female_character:DefineMarking(5, "Bleached Skin Freckles")
female_character:DefineMarking(6, "Dried Eye Cut")
female_character:DefineMarking(7, "Dried Eye X Cut")
female_character:DefineMarking(8, "Red Cheeks")
female_character:DefineMarking(9, "Red Cheeks")
female_character:DefineMarking(10, "Cold Face")
female_character:DefineMarking(11, "Eyeliner")
female_character:DefineMarking(12, "Tired Eyes With Eyeliner")
female_character:DefineMarking(13, "Tired Eyes With Eyelinedr")
female_character:DefineEyecolor(1, "Black")
female_character:DefineEyecolor(2, "Blue")
female_character:DefineEyecolor(3, "Green")
female_character:DefineEyecolor(4, "Green 2")
female_character:DefineEyecolor(5, "Yellow")
female_character:DefineEyecolor(6, "Hazel")
female_character:DefineEyecolor(7, "Ghoul") 
female_character:DefineBone("skin_bone_C_Chin", 1, false)
female_character:DefineBone("skin_bone_$_JawMid", 2, true)
female_character:DefineBone("skin_bone_$_JawSide", 3, true)
female_character:DefineBone("skin_bone_$_Dimple", 4, true)
female_character:DefineBone("skin_bone_C_MasterMouth", 5, false)
female_character:DefineBone("skin_bone_$_MouthCorner", 6, true)
female_character:DefineBone("skin_bone_C_MouthTop", 7, false)
female_character:DefineBone("skin_bone_$_MouthBot", 8, true)
female_character:DefineBone("skin_bone_$_MouthCorner", 9, true)
female_character:DefineBone("skin_bone_$_MouthTop", 9, true)
female_character:DefineBone("$EYEBROW", 10, true)
female_character:DefineBone("skin_bone_$_EyebrowOut", 11, true)
female_character:DefineBone("skin_bone_C_MasterEyebrow", 12, false)
female_character:DefineBone("skin_bone_$_Eye", 12, true)
female_character:DefineBone("skin_bone_$_Eyelid_Top", 13, true)
female_character:DefineBone("skin_bone_$_Eyelid_Bot", 14, true)
female_character:DefineBone("skin_bone_$_EyeUnder", 15, true)
female_character:DefineBone("skin_bone_C_MasterNose", 16, false)
female_character:DefineBone("skin_bone_C_Nose", 17, false)
female_character:DefineBone("skin_bone_C_Nose_Bridge", 18, false)
female_character:DefineBone("skin_bone_$_Nostril", 19, true)
female_character:DefineBone("skin_bone_$_Ear", 25, true)
female_character:DefineHairstyleColor(1, 8, 8, 6)
female_character:DefineHairstyleColor(2, 44, 34, 43)
female_character:DefineHairstyleColor(3, 59, 49, 38)
female_character:DefineHairstyleColor(4, 78, 58, 63)
female_character:DefineHairstyleColor(5, 80, 69, 69)
female_character:DefineHairstyleColor(6, 106, 78, 66)
female_character:DefineHairstyleColor(7, 85, 72, 56)
female_character:DefineHairstyleColor(8, 167, 133, 106)
female_character:DefineHairstyleColor(9, 194, 151, 128)
female_character:DefineHairstyleColor(10, 220, 209, 186)
female_character:DefineHairstyleColor(11, 222, 188, 153)
female_character:DefineHairstyleColor(12, 151, 121, 96)
female_character:DefineHairstyleColor(13, 233, 206, 168)
female_character:DefineHairstyleColor(14, 229, 200, 168)
female_character:DefineHairstyleColor(15, 165, 137, 70)
female_character:DefineHairstyleColor(16, 145, 85, 61)
female_character:DefineHairstyleColor(17, 83, 61, 53)
female_character:DefineHairstyleColor(18, 133, 99, 93)
female_character:DefineHairstyleColor(19, 183, 186, 158)
female_character:DefineHairstyleColor(20, 214, 196, 194)
female_character:DefineHairstyleColor(21, 255, 245, 225)
female_character:DefineHairstyleColor(22, 202, 191, 177)
female_character:DefineHairstyleColor(23, 141, 74, 67)
female_character:DefineHairstyleColor(24, 181, 82, 57)
female_character:DefineHairstyleColor(25, 255, 35, 35)
female_character:DefineHairstyleColor(26, 65, 55, 125)
female_character:DefineHairstyleColor(27, 65, 255, 125)
female_character:DefineHairstyleColor(28, 65, 135, 125)
female_character:DefineHairstyleColor(29, 65, 135, 65)
female_character:DefineHairstyleColor(30, 255, 185, 185)
male_character = TRANS:DefineCharacter("human_male_fallout", "models/yshera/humans/male.mdl")
male_character.hairBone = 31
male_character.materialIndex = {
head = 2,
body = 1,
eye = 5,
hands = 6
}
male_character:DefineHairstyles(1, 0.89, Vector(0, 0.2, 0.2), "Bald", "")
male_character:DefineHairstyles(2, 0.89, Vector(0, -0.3, 0.4), "Combed", "models/mosi/fallout4/character/male/malehair01.mdl")
male_character:DefineHairstyles(3, 0.89, Vector(0, -0.3, 0.4), "English", "models/mosi/fallout4/character/male/malehair02.mdl")
male_character:DefineHairstyles(4, 0.89, Vector(0, -0.3, 0.4), "Side Sweep", "models/mosi/fallout4/character/male/malehair03.mdl")
male_character:DefineHairstyles(5, 0.89, Vector(0, -0.3, 0.4), "Buzzcut", "models/mosi/fallout4/character/male/malehair04.mdl")
male_character:DefineHairstyles(6, 0.89, Vector(0, -0.3, 0.4), "Iced Gem", "models/mosi/fallout4/character/male/malehair05.mdl")
male_character:DefineHairstyles(7, 0.89, Vector(0, -0.3, 0.4), "Emo", "models/mosi/fallout4/character/male/malehair06.mdl")
male_character:DefineHairstyles(8, 0.89, Vector(0, -0.3, 0.4), "Messy", "models/mosi/fallout4/character/male/malehair07.mdl")
male_character:DefineHairstyles(9, 0.89, Vector(0, -0.3, 0.4), "Baldin", "models/mosi/fallout4/character/male/malehair08.mdl")
male_character:DefineHairstyles(10, 0.89, Vector(0, -0.3, 0.4), "Reaver", "models/mosi/fallout4/character/male/malehair16.mdl")
male_character:DefineHairstyles(11, 0.89, Vector(0, -0.3, 0.4), "Mohawk", "models/mosi/fallout4/character/male/malehair11.mdl")
male_character:DefineHairstyles(12, 0.89, Vector(0, -0.3, 0.4), "1", "models/mosi/fallout4/character/male/malehair21.mdl")
male_character:DefineHairstyles(13, 0.89, Vector(0, -0.3, 0.4), "2", "models/mosi/fallout4/character/male/malehair13.mdl")
male_character:DefineHairstyles(14, 0.89, Vector(0, -0.3, 0.4), "3", "models/mosi/fallout4/character/male/malehair14.mdl")
male_character:DefineHairstyles(15, 0.89, Vector(0, -0.3, 0.4), "4", "models/mosi/fallout4/character/male/malehair15.mdl")
male_character:DefineHairstyles(16, 0.89, Vector(0, -0.3, 0.4), "Viking", "models/mosi/fallout4/character/female/femalehair30.mdl")
male_character:DefineHairstyles(17, 0.89, Vector(0, -0.3, 0.4), "classic", "models/mosi/fallout4/character/female/femalehair29.mdl")
male_character:DefineHairstyles(18, 0.90, Vector(.1, -0.3, 0.4), "Military", "models/mosi/fallout4/character/female/femalehair35.mdl")
male_character:DefineHairstyles(19, 0.78, Vector(.1, -0.3, 0.4), "Short", "models/mosi/fallout4/character/male/boyhair02.mdl")
male_character:DefineHairstyles(20, 0.89, Vector(.1, -0.3, 0.4), "Slick", "models/mosi/fallout4/character/male/malehair27.mdl")
male_character:DefineMarking(1, "None")
male_character:DefineEyecolor(1, "Eyes 1")
male_character:DefineEyecolor(2, "Eyes 2")
male_character:DefineEyecolor(3, "Eyes 3")
male_character:DefineEyecolor(4, "Eyes 4")
male_character:DefineEyecolor(5, "Eyes 5")
male_character:DefineEyecolor(6, "Eyes 6")
male_character:DefineEyecolor(7, "Ghoul")
male_character:DefineBone("skin_bone_C_Chin", 1, false)
male_character:DefineBone("skin_bone_$_JawMid", 2, true)
male_character:DefineBone("skin_bone_$_JawSide", 3, true)
male_character:DefineBone("skin_bone_$_Dimple", 4, true)
male_character:DefineBone("skin_bone_C_MasterMouth", 5, false)
male_character:DefineBone("skin_bone_$_MouthCorner", 6, true)
male_character:DefineBone("skin_bone_C_MouthTop", 7, false)
male_character:DefineBone("skin_bone_$_MouthBot", 8, true)
male_character:DefineBone("skin_bone_$_MouthCorner", 9, true)
male_character:DefineBone("skin_bone_$_MouthTop", 9, true)
male_character:DefineBone("$EYEBROW", 10, true)
male_character:DefineBone("skin_bone_$_EyebrowOut", 11, true)
male_character:DefineBone("skin_bone_C_MasterEyebrow", 12, false)
male_character:DefineBone("skin_bone_$_Eye", 12, true)
male_character:DefineBone("skin_bone_$_Eyelid_Top", 13, true)
male_character:DefineBone("skin_bone_$_Eyelid_Bot", 14, true)
male_character:DefineBone("skin_bone_$_EyeUnder", 15, true)
male_character:DefineBone("skin_bone_C_MasterNose", 16, false)
male_character:DefineBone("skin_bone_C_Nose", 17, false)
male_character:DefineBone("skin_bone_C_Nose_Bridge", 18, false)
male_character:DefineBone("skin_bone_$_Nostril", 19, true)
male_character:DefineBone("skin_bone_$_Ear", 25, true)
male_character:DefineHairstyleColor(1, 8, 8, 6)
male_character:DefineHairstyleColor(2, 44, 34, 43)
male_character:DefineHairstyleColor(3, 59, 49, 38)
male_character:DefineHairstyleColor(4, 78, 58, 63)
male_character:DefineHairstyleColor(5, 80, 69, 69)
male_character:DefineHairstyleColor(6, 106, 78, 66)
male_character:DefineHairstyleColor(7, 85, 72, 56)
male_character:DefineHairstyleColor(8, 167, 133, 106)
male_character:DefineHairstyleColor(9, 194, 151, 128)
male_character:DefineHairstyleColor(10, 220, 209, 186)
male_character:DefineHairstyleColor(11, 222, 188, 153)
male_character:DefineHairstyleColor(12, 151, 121, 96)
male_character:DefineHairstyleColor(13, 233, 206, 168)
male_character:DefineHairstyleColor(14, 229, 200, 168)
male_character:DefineHairstyleColor(15, 165, 137, 70)
male_character:DefineHairstyleColor(16, 145, 85, 61)
male_character:DefineHairstyleColor(17, 83, 61, 53)
male_character:DefineHairstyleColor(18, 133, 99, 93)
male_character:DefineHairstyleColor(19, 183, 186, 158)
male_character:DefineHairstyleColor(20, 214, 196, 194)

hook.Add("PlayerLoadedChar", "charapperance", function(client, character, lastChar)
    netstream.Start(player.GetAll(), "charApp", character:getID(), character.vars.apperance)

    timer.Simple(FrameTime(), function()
       TRANSFORM_LOCALLY_BG(client, character.vars.apperance)
    end)
end)

hook.Add("InitializedPlugins", "GM:CREATECHARAPP", function()

    if CLIENT then
        netstream.Hook("charApp", function(id, key)
            local character = nut.char.loaded[id]

            if (character) then
                character.vars.apperance = key or {}
                character:getPlayer():ApplyMorph(character.vars.apperance)
            end
        end)
    end

    nut.char.registerVar("apperance", {
        default = {},
        isLocal = false,
        noDisplay = true,
        field = "_apperance",
        onSet = function(character, key, value, noReplication, receiver)
            character.vars.apperance = key

            if SERVER then
                character:updateOnServer()
            end

            netstream.Start(player.GetAll(), "charApp", character:getID(), key)
        end,
        onGet = function(character, key, default) return character.vars.apperance or {} end
    })
end)
  

 
 


  

--    if CLIENT then  CL_CreateCharacterCreationMenu()  end


 

 

if(CLIENT) then
	local Hell = false
	local Video = nil
	local Noise = nil
	local Scream = nil
	local cache = { }
	timercache = { }
	soundcache = { }
	modelcache = { }

	local debrisrand = {
	  'models/props_debris/concrete_chunk02b.mdl', 
	  'models/props_debris/concrete_chunk02a.mdl', 
	  'models/props_debris/broken_pile001a.mdl', 
	  'models/props_debris/concrete_chunk01a.mdl'
	}

	local mdl = {
	  "models/Gibs/HGIBS.mdl",
	  "models/Gibs/HGIBS_rib.mdl",
	  "models/Gibs/HGIBS_scapula.mdl",
	  "models/Gibs/HGIBS_spine.mdl",
	  "models/props_c17/doll01.mdl",
	  "models/props_junk/sawblade001a.mdl",
	  "models/props_debris/concrete_chunk03a.mdl",
	  "models/props_debris/concrete_chunk04a.mdl"
	}

	local CreatePhysModel = function(mdl)
		local ent = ents.CreateClientProp()
		ent:SetModel(mdl)
		ent:PhysicsInit(SOLID_VPHYSICS)
		ent:SetMoveType(MOVETYPE_VPHYSICS)
		ent:SetSolid(SOLID_VPHYSICS)

		table.insert(modelcache, ent)

		return ent
	end

	local CreateModel = function(mdl, isragdoll)
		local ent

		if isragdoll then
			ent = ClientsideRagdoll(mdl)
		else
			ent = ClientsideModel(mdl, RENDERGROUP_OTHER)
		end
	  
		table.insert(modelcache, ent)
	  
		return ent
	end

	local AddSound = function(name)
		local snd = CreateSound(LocalPlayer(), name)
	  
		table.insert(soundcache, snd)
	  
		return snd
	end

	local NewHookAdd = function(str, name, func)
		--name = "dronesrewrite_hell_hooks" .. name
		hook.Add(str, name, func)
	  
		table.insert(cache, {
			str = str,
			name = name
		})
	end

	local NewTimerSimple = function(time, func)
		local name = "dronesrewrite_hell_timers" .. table.Count(timercache)
		timer.Create(name, time, 1, func)
	  
		table.insert(timercache, {
			name = name
		})
	end

	local StopTimers = function() for k, v in pairs(timercache) do timer.Destroy(v.name) end end
	local RemoveHooks = function() for k, v in pairs(cache) do hook.Remove(v.str, v.name) end end
	local StopSounds = function() for k, v in pairs(soundcache) do if v then v:Stop() end end end
	local RemoveModels = function() for k, v in pairs(modelcache) do SafeRemoveEntity(v) end end

	local function End()
		local snd = CreateSound(LocalPlayer(), "ambient/gas/steam2.wav")
		snd:Play()
		snd:ChangePitch(250, 0)
		  
		hook.Add("RenderScreenspaceEffects", "dronesrewrite_hell_renderend", function()
			local eff_tab = {
				["$pp_colour_addr"] = 0,
				["$pp_colour_addg"] = 0,
				["$pp_colour_addb"] = 0,
				["$pp_colour_brightness"] = -1,
				["$pp_colour_contrast"] = 1,
				["$pp_colour_colour"] = 0,
				["$pp_colour_mulr"] = 0,
				["$pp_colour_mulg"] = 0,
				["$pp_colour_mulb"] = 0
			}
				
			DrawColorModify(eff_tab)
			DrawMaterialOverlay("effects/tvscreen_noise002a", 0)
	  end)

	  surface.PlaySound("hl1/ambience/port_suckin1.wav")
	  surface.PlaySound("hl1/ambience/particle_suck2.wav")

		timer.Simple(4, function()
			snd:Stop()
			snd = nil
			hook.Remove("RenderScreenspaceEffects", "dronesrewrite_hell_renderend")

			local Const = 1
			hook.Add("RenderScreenspaceEffects", "dronesrewrite_hell_renderend2", function()
				Const = Lerp(0.005, Const, 0)
				if Const <= 0.05 then hook.Remove("RenderScreenspaceEffects", "dronesrewrite_hell_renderend2") end

				local eff_tab = {
					["$pp_colour_addr"] = Const * 0.1,
					["$pp_colour_addg"] = Const * 0.1,
					["$pp_colour_addb"] = 0,
					["$pp_colour_brightness"] = -Const,
					["$pp_colour_contrast"] = 1 + Const * 0.9,
					["$pp_colour_colour"] = 1,
					["$pp_colour_mulr"] = Const * 5,
					["$pp_colour_mulg"] = Const,
					["$pp_colour_mulb"] = 0
				}
		  
				DrawColorModify(eff_tab)
		  
				  DrawBloom(Const * 1, Const, Const, Const, Const, Const, Const, Const, Const)
				  DrawSharpen(Const * 0.7, Const * 4)
				  DrawMotionBlur(Const * 0.3, Const, Const * 0.01)

				  DrawToyTown(Const * 8, ScrH())
				end)

			--[[
			local snd = CreateSound(LocalPlayer(), "horror/fz_frenzy1.wav")
			snd:Play()
			snd:ChangePitch(110, 0)

			timer.Simple(14, function()
				snd:ChangeVolume(0, 5)
			end)
			--]]

			util.ScreenShake(LocalPlayer():GetPos(), 3, 55, 5, 1000)
			surface.PlaySound("ambient/machines/machine1_hit2.wav")
		end)

		RemoveHooks()
		StopTimers()
		StopSounds()
		RemoveModels()
		
		timer.Destroy("dronesrewrite_loopscreamer")
		  
		if IsValid(Noise) then Noise:Stop() end
		if IsValid(Scream) then Scream:Stop() end

		LocalPlayer():SetNoDraw(false)
		LocalPlayer():DrawViewModel(true)
		  
		Hell = false
	end

	local function EnableHell()
		local Models = { }
		local Scrap = { }
	  
		local Const = 0

		local function AddRender()
			NewHookAdd("RenderScreenspaceEffects", "dronesrewrite_hell_render", function()
				local eff_tab = {
					["$pp_colour_addr"] = Const * 0.1,
					["$pp_colour_addg"] = Const * 0.1,
					["$pp_colour_addb"] = 0,
					["$pp_colour_brightness"] = -Const,
					["$pp_colour_contrast"] = 1 + Const * 0.9,
					["$pp_colour_colour"] = 1,
					["$pp_colour_mulr"] = Const * 5,
					["$pp_colour_mulg"] = Const,
					["$pp_colour_mulb"] = 0
				}
			  
				DrawColorModify(eff_tab)
			  
				DrawBloom(Const * 1, Const, Const, Const, Const, Const, Const, Const, Const)
				DrawSharpen(Const * 0.7, Const * 4)
				DrawMotionBlur(Const * 0.3, Const, Const * 0.01)
			end)
		end

		local function MakeNoise(tiem)
			local snd = AddSound("ambient/gas/steam2.wav")
			snd:Play()
			snd:ChangePitch(250, 0)
			
			--[[
			NewHookAdd("RenderScreenspaceEffects", "dronesrewrite_hell_render", function()
				local eff_tab = {
					["$pp_colour_addr"] = 0,
					["$pp_colour_addg"] = 0,
					["$pp_colour_addb"] = 0,
					["$pp_colour_brightness"] = -1,
					["$pp_colour_contrast"] = 1,
					["$pp_colour_colour"] = 0,
					["$pp_colour_mulr"] = 0,
					["$pp_colour_mulg"] = 0,
					["$pp_colour_mulb"] = 0
				}
						  
				DrawColorModify(eff_tab)
				DrawMaterialOverlay("effects/tvscreen_noise002a", 0)
			end)
			--]]
			
			NewTimerSimple(tiem, function() snd:Stop() AddRender() end)
		end

		local function LastScene()
			local staticPos
			local newAng
			local toChangeAng
			local screamer
			  
			NewHookAdd("ShouldDrawLocalPlayer", "dronesrewrite_hell_govno", function() return false end)
			  
			NewHookAdd("CalcView", "dronesrewrite_hell_lastScene", function(ply, pos, ang, fov)
				if not staticPos then staticPos = pos end
				if not newAng then newAng = ang end
				if not toChangeAng then toChangeAng = Angle(0, newAng.y + 180, 0) end

				if not screamer then
					local ang = newAng
					ang.p = 0
					
					screamer = CreateModel("models/zombie/poison.mdl")
					screamer:SetPos(pos - Vector(0, 0, 60) - ang:Forward() * 50)
					screamer:SetAngles(ang)
					screamer:SetModelScale(1.2, 0)
					screamer:Spawn()
					screamer:SetSequence(2)

					local dlight = DynamicLight(LocalPlayer():EntIndex())
					if dlight then
						dlight.pos = pos - ang:Forward() * 40
						dlight.r = 255
						dlight.g = 0
						dlight.b = 0
						dlight.brightness = 10
						dlight.Decay = 300
						dlight.Size = 2000
						dlight.DieTime = CurTime() + 0.7
					end
				end

				newAng = LerpAngle(0.25, newAng, toChangeAng + AngleRand() * 0.06)

				local view = { }
				view.origin = staticPos
				view.angles = newAng
				view.fov = fov
			  
				return view
			end)
			
			surface.PlaySound("vo/npc/male01/pain07.wav")
			  
			NewTimerSimple(0.3, function() surface.PlaySound("npc/stalker/go_alert2a.wav") end)
			  
			NewTimerSimple(3, function()
				surface.PlaySound("hl1/ambience/particle_suck2.wav")
				  
				End()
				if screamer then screamer:Remove() end
				  
				local snd = AddSound("hl1/ambience/deadsignal2.wav")
				snd:Play()
				
				surface.PlaySound("beams/beamstart5.wav")
				--[[
				NewHookAdd("RenderScreenspaceEffects", "homoef", function()
					local eff_tab = {
					["$pp_colour_addr"] = 0,
					["$pp_colour_addg"] = 0,
					["$pp_colour_addb"] = 0,
					["$pp_colour_brightness"] = -1,
					["$pp_colour_contrast"] = 1,
					["$pp_colour_colour"] = 0,
					["$pp_colour_mulr"] = 0,
					["$pp_colour_mulg"] = 0,
					["$pp_colour_mulb"] = 0
					}
					  
					DrawColorModify(eff_tab)
					DrawMaterialOverlay("effects/tvscreen_noise002a", 0)
				end)
				--]]
					
				NewTimerSimple(10, function()
					snd:Stop()
						
					End()
				end)
			end)
		end

		AddRender()

		local function MakeCorpse()
			sound.Play("npc/zombie/zombie_alert1.wav", LocalPlayer():GetPos(), 90, math.random(40, 70))

			local tr = util.TraceLine({
				start = LocalPlayer():GetPos(),
				endpos = LocalPlayer():GetPos() + vector_up * 5000,
				filter = LocalPlayer()
			})

			local x = math.random(0, 360)
			local tr = util.TraceLine({
				start = tr.HitPos,
				endpos = tr.HitPos + Vector(math.cos(x), math.sin(x), 0) * math.random(1000, 2000),
				filter = LocalPlayer()
			})

			local tr = util.TraceLine({
				start = tr.HitPos,
				endpos = tr.HitPos - vector_up * 20000,
				filter = LocalPlayer()
			})

			local pos = tr.HitPos - tr.HitNormal * 8

			local corpses = {
				"models/humans/charple02.mdl",
				"models/humans/charple03.mdl",
				"models/humans/charple04.mdl",
				"models/humans/charple01.mdl"
			}
			
			local mdl = CreateModel(corpses[math.random(#corpses)])
			mdl:SetAngles(Angle(-45, math.random(0, 360), 0))
			mdl:SetNoDraw(false)
			mdl:DrawShadow(true)
			mdl:SetPos(pos)
		end

		local function MakeGuys()
			local tr = util.TraceLine({
				start = LocalPlayer():GetPos(),
				endpos = LocalPlayer():GetPos() + Vector(0, 0, 10000),
				filter = LocalPlayer()
			})

			local x = math.random(0, 360)
			local tr = util.TraceLine({
				start = tr.HitPos + tr.HitNormal * 32,
				endpos = tr.HitPos + Vector(math.cos(x), math.sin(x), 0) * math.random(1000, 2000),
				filter = LocalPlayer()
			})

			local tr = util.TraceLine({
				start = tr.HitPos + tr.HitNormal * 32,
				endpos = tr.HitPos - vector_up * 20000,
				filter = LocalPlayer()
			})

			local pos = tr.HitPos

			--ParticleEffect("fire_test2", pos, Angle(0, 0, 0))

			NewTimerSimple(2.2, function()
				sound.Play("vo/npc/male01/no02.wav", LocalPlayer():GetPos(), 75, math.random(70, 90), 1)

				local mdl = CreateModel("models/Humans/Group01/Male_Cheaple.mdl")
				mdl:SetModelScale(2, 0)
				mdl:SetAngles(Angle(0, (LocalPlayer():GetPos() - tr.HitPos):Angle().y, 0))
				mdl:SetPos(pos)
				mdl:SetMaterial("models/flesh")
				mdl:SetColor(Color(255, 0, 0))
				mdl:Spawn()
				  
				NewTimerSimple(math.Rand(1, 3), function() mdl:Remove() end)
			end)
		end
	  
		local function MakeCamera()
			local moan = AddSound("ambient/voices/crying_loop1.wav")
			moan:Play()
			moan:ChangePitch(math.random(50, 60), 0)

			surface.PlaySound("npc/zombie/foot_slide" .. math.random(1, 3) .. ".wav")
			surface.PlaySound("npc/barnacle/barnacle_tongue_pull" .. math.random(1, 3) .. ".wav")

			NewHookAdd("HUDPaint", "dronesrewrite_drawshit", function()
				  --surface.SetMaterial(Material("stuff/misc/room"))
				  --surface.SetDrawColor(Color(255, 255, 255))

				local movex = math.random(-600, 0)
				local movey = math.random(-600, 0)
				surface.DrawTexturedRect(movex, movey, ScrW() - movex, ScrH() - movey)
			end)

			NewTimerSimple(math.Rand(0.1, 0.2), function()
				hook.Remove("HUDPaint", "dronesrewrite_drawshit") 
				moan:Stop()
			end)
		end
	  
		local crying
		NewTimerSimple(3.5, function()
			crying = AddSound("ambient/voices/crying_loop1.wav")
			crying:Play()
		
			for i = 1, 6 do
				NewTimerSimple(math.Rand(1, 8), function()
					util.ScreenShake(LocalPlayer():GetPos(), 30, 7, 4, 1000)
					surface.PlaySound("physics/concrete/boulder_impact_hard" .. math.random(1, 4) .. ".wav")
				end)
			end
		end)
	  
		NewTimerSimple(7, function()
			NewTimerSimple(5, function() MakeNoise(3) end)
		
			NewTimerSimple(6, function()
				crying:Stop()
				Const = 1.2 -- instant shit

				for i = 1, 200 do
					MakeCorpse()
				end

				local no_drawing = {
					CHudHealth = true,
					CHudBattery = true,
					CHudCrosshair = true,
					CHudAmmo = true,
					CHudSecondaryAmmo = true,
					NetGraph = true
				}

				NewHookAdd("HUDShouldDraw", "dronesrewrite_hell_nohuddraw", function(name)
					if no_drawing[name] then return false end
				end)

				NewHookAdd("PlayerBindPress", "dronesrewrite_hell_shitmenu", function(ply, bind, p) 
					local tools = {
						"phys_swap",
						"slot",
						"invnext",
						"invprev",
						"lastinv",
						"gmod_tool",
						"gmod_toolmode"
					}

					for k, v in pairs(tools) do if bind:find(v) then return true end end
				end)

				--for i = 1, 10 do
				AddSound("chorror/cryscreams.mp3"):Play()
				--end
			
				sound.PlayURL("https://drive.google.com/uc?export=download&id=0B-bmGdZLSKZFX0xMNnR1OU5iRE0", "mono",function(sts)
					if IsValid(sts) then Noise = sts end
				end)
			  
				sound.PlayURL("https://drive.google.com/uc?export=download&id=0B-bmGdZLSKZFRDVSX3Z6Nk5oNVk", "mono",function(sts)
					if IsValid(sts) then Scream = sts end
				end)

				--NewHookAdd("HUDShouldDraw", "nohud", function() return false end)

				--[[local ang = LocalPlayer():EyeAngles()
				NewHookAdd("CalcView", "dronesrewrite_makeshitstatic", function(ply, _pos, _ang, fov)
					local view = { }
					view.origin = _pos
					view.angles = ang
					view.fov = fov
			
					ang = Lerp(0.2, ang, _ang)
					return view
				end)]]

				LocalPlayer():SetNoDraw(true)
				LocalPlayer():DrawViewModel(false)

				for i = 1, 300 do
					local floating = {
						"models/dismemberment/gibs/legs/lower_leg.mdl",
						"models/dismemberment/gibs/legs/upper_leg.mdl",
						"models/dismemberment/gibs/arms/lower_arm.mdl",
						"models/dismemberment/gibs/arms/upper_arm.mdl",
						"models/dismemberment/gibs/torso/torso_pelvis.mdl",
						"models/dismemberment/gibs/torso/torso_left_lower.mdl",
						"models/dismemberment/gibs/torso/torso_left_upper.mdl",
						"models/dismemberment/gibs/torso/torso_right_upper.mdl",
						"models/gibs/humans/eye_gib.mdl",
						"models/gibs/humans/heart_gib.mdl"
					}
				
					local e = CreateModel(floating[math.random(#floating)])
					e:SetModelScale(math.random(30, 60), 0)
					e:SetAngles(AngleRand())
				
					local vec = VectorRand() * 12000
					vec.z = math.abs(vec.z) / 3
					e:SetPos(LocalPlayer():GetPos() + vec)
					e:Spawn()

					e.RotDir = math.random(-1, 1)
					e.ZDist = math.Rand(1, 10)
					e.ZSpeed = math.Rand(0.3, 1.1)
				
					Models[i] = e
				end
			  
				sound.Play("npc/stalker/go_alert2a.wav", LocalPlayer():GetPos(), math.random(50, 120), math.random(30, 70), 1)
				util.ScreenShake(LocalPlayer():GetPos(), 3, 55, 5, 1000)
				timer.Create("dronesrewrite_loopscreamer", 1.5, 0, function()
					sound.Play("vo/ravenholm/madlaugh03.wav", LocalPlayer():GetPos(), 100, math.random(60, 80), 1)
					util.ScreenShake(LocalPlayer():GetPos(), 3, 55, 5, 1000)
				end)
			  
				NewTimerSimple(9, function()
					local dlight = DynamicLight(LocalPlayer():EntIndex())
					if dlight then
						dlight.pos = Vector(-2224.216797, -2918.063721, 2354.03125)
						dlight.r = 255
						dlight.g = 0
						dlight.b = 0
						dlight.brightness = 16
						dlight.Decay = 1000
						dlight.Size = 2000
						dlight.DieTime = CurTime() + 2
					end

					local pos = LocalPlayer():GetPos() + Vector(0, 0, 120)
					local ang = Angle(0, LocalPlayer():GetAngles().y, 0)

					local tr = util.TraceLine({
						start = pos,
						endpos = pos + ang:Forward() * 86,
						filter = LocalPlayer()
					})

					local rag_pos = tr.HitPos + tr.HitNormal * 32 - Vector(0, 0, 100)

					for i = 1, 16 do
						sound.Play("npc/stalker/go_alert2a.wav", LocalPlayer():GetPos(), 120, 80, 1)
					end

					local mdl = CreateModel("models/Humans/Charple01.mdl")
					mdl:SetModelScale(1.5, 0)
					mdl:SetAngles(ang + Angle(0, 180, 0))
					mdl:SetColor(Color(255, 0, 0))
					mdl:SetPos(rag_pos)
					mdl:Spawn()

					--ParticleEffect("fire_test2", rag_pos, Angle(0, 0, 0))

					NewHookAdd("CalcView", "dronesrewrite_doshit", function(ply, _pos, _ang, fov)
						local view = { }
						view.origin = pos + VectorRand()
						view.angles = ang
						view.fov = fov + math.random(-80, -50)
					  
						return view
					end)
				
					NewTimerSimple(1, function() 
						MakeNoise(0.5)
						mdl:Remove()
						hook.Remove("CalcView", "dronesrewrite_doshit") 
					end)
				end)

				NewTimerSimple(14, function()
					NewHookAdd("CalcView", "dronesrewrite_makeshit", function(ply, _pos, _ang, fov)
						local view = { }
						view.origin = _pos + VectorRand() * 25
						view.angles = _ang
						view.fov = fov

						return view
					end)

					NewTimerSimple(2, function() hook.Remove("CalcView", "dronesrewrite_makeshit") end)
				end)

				NewTimerSimple(25, function()
					NewHookAdd("CalcView", "dronesrewrite_makeshit", function(ply, _pos, _ang, fov)
						local view = { }
						view.origin = _pos + VectorRand() * 50
						view.angles = _ang + AngleRand() * 0.08
						view.fov = fov

						return view
					end)

					NewTimerSimple(3, function() hook.Remove("CalcView", "dronesrewrite_makeshit") end)
				end)

				NewTimerSimple(20, function()
					for i = 1, 50 do
						MakeNoise(0.5)
						MakeGuys()
					end

					NewTimerSimple(4.6, function() MakeNoise(0.6) end)
				end)

				NewTimerSimple(30, function()
					for i = 1, 20 do
						surface.PlaySound("npc/barnacle/barnacle_die" .. math.random(1, 2) .. ".wav")
					end
				end)

				NewTimerSimple(35, function()
					--- AOOSIDJOAIDOSDIFJAS
					for i = 1, 10 do
						sound.Play("vo/ravenholm/madlaugh03.wav", LocalPlayer():GetPos(), 100, math.random(30, 70), 1)
					end
				end)

				NewTimerSimple(40, function()
					NewHookAdd("CalcView", "dronesrewrite_makeshit", function(ply, _pos, _ang, fov)
						local view = { }
						view.origin = _pos
						view.angles = Angle(_ang.p, _ang.y + CurTime() * 100, math.random(-5, 5))
						view.fov = fov

						return view
					end)

					NewTimerSimple(3, function() hook.Remove("CalcView", "dronesrewrite_makeshit") end)
				end)
			  
				NewTimerSimple(48, function()
					MakeNoise(0.5)
				
					NewHookAdd("CalcView", "dronesrewrite_doshit", function(ply, _pos, _ang, fov)
						local view = { }
						view.origin = _pos
						view.angles = _ang
						view.fov = fov + math.random(-30, -10)
				  
						return view
					end)
				
					NewTimerSimple(4, function() hook.Remove("CalcView", "dronesrewrite_doshit") end)
				end)
			  
				NewTimerSimple(65, function()
					MakeNoise(0.5)
				
					sound.Play("npc/fast_zombie/fz_frenzy1.wav", Vector(-2957.615723, -1470.495605, -100.968750), 120, 75, 1)
				
					local dlight = DynamicLight(LocalPlayer():EntIndex())
					if dlight then
						dlight.pos = Vector(-3131.937988, -1468.487793, -120.96875)
						dlight.r = 255
						dlight.g = 0
						dlight.b = 0
						dlight.brightness = 10
						dlight.Decay = 300
						dlight.Size = 2000
						dlight.DieTime = CurTime() + 0.6
					end
				
					NewHookAdd("CalcView", "dronesrewrite_doshit", function(ply, _pos, _ang, fov)
						local view = { }
						view.origin = Vector(-2957.615723, -1470.495605, -100.968750) + VectorRand() * 12
						view.angles = Angle(0, 179, 0)
						view.fov = fov
					  
						return view
					end)
				
					local mdl = CreateModel("models/Zombie/Fast.mdl")
					mdl:SetModelScale(1.5, 0)
					mdl:SetAngles(Angle(0, 0, 0))
					mdl:SetMaterial("models/debug/debugwhite")
					mdl:SetColor(Color(255, 0, 0))
					mdl:SetPos(Vector(-3131.937988, -1468.487793, -140.96875))
					mdl:Spawn()
				
					NewTimerSimple(1, function()
						MakeNoise(0.3)

						--ParticleEffect("fire_test2", Vector(-3131.937988, -1468.487793, -120.96875), Angle(0, 0, 0))

						for i = 1, 18 do
							sound.Play("npc/stalker/go_alert2a.wav", LocalPlayer():GetPos(), 120, 80, 1)
						end
				  
						mdl:SetPos(Vector(-3031.937988, -1468.487793, -140.96875))
						mdl:SetSequence(5)
				  
						local dlight = DynamicLight(LocalPlayer():EntIndex())
						if dlight then
							dlight.pos = Vector(-3131.937988, -1468.487793, -120.96875)
							dlight.r = 255
							dlight.g = 0
							dlight.b = 0
							dlight.brightness = 16
							dlight.Decay = 300
							dlight.Size = 2000
							dlight.DieTime = CurTime() + 0.7
						end
					end)
				
					NewTimerSimple(2, function() 
						MakeNoise(0.5)
						mdl:Remove()
					  
						hook.Remove("CalcView", "dronesrewrite_doshit") 
					end)
					
				end)
			  
				NewTimerSimple(80, function()
					local tr = util.TraceLine({
						start = LocalPlayer():GetPos(),
						endpos = LocalPlayer():GetPos() + Vector(0, 0, 10000),
						filter = LocalPlayer()
					})

					local x = math.random(0, 360)
					local tr = util.TraceLine({
						start = tr.HitPos + tr.HitNormal * 32,
						endpos = tr.HitPos + Vector(math.cos(x), math.sin(x), 0) * 1000,
						filter = LocalPlayer()
					})

					local tr = util.TraceLine({
						start = tr.HitPos + tr.HitNormal * 32,
						endpos = tr.HitPos - vector_up * 20000,
						filter = LocalPlayer()
					})

					local pos = tr.HitPos

					sound.Play("vo/npc/vortigaunt/allwecanspare.wav", pos, 120, 75, 1)
					for i = 1, 8 do
						sound.Play("npc/stalker/go_alert2a.wav", LocalPlayer():GetPos(), math.random(50, 120), 80, 1)
					end
				
					local dlight = DynamicLight(LocalPlayer():EntIndex())
					if dlight then
						dlight.pos = pos + Vector(0, 30, 32)
						dlight.r = 255
						dlight.g = 0
						dlight.b = 0
						dlight.brightness = 1
						dlight.Decay = 1000
						dlight.Size = 2500
						dlight.DieTime = CurTime() + 2
					end
					
					NewHookAdd("CalcView", "dronesrewrite_doshit", function(ply, _pos, _ang, fov)
						local view = { }
						view.origin = pos + Vector(0, 100, 140) + VectorRand() * 4
						view.angles = Angle(11, -90, 0)
						view.fov = fov + math.random(-50, -30)
					  
						return view
					end)
			
					local mdl = CreateModel("models/Humans/Group01/Male_Cheaple.mdl")
					mdl:SetModelScale(2, 0)
					mdl:SetAngles(Angle(0, 90, 0))
					mdl:SetPos(tr.HitPos)
					mdl:SetMaterial("models/flesh")
					mdl:SetColor(Color(255, 0, 0))
					mdl:Spawn()
				
					NewTimerSimple(1.5, function() 
						MakeNoise(0.5)
						for i = 1, 16 do MakeGuys() end
					  
						mdl:Remove()
					  
						hook.Remove("CalcView", "dronesrewrite_doshit") 
					end)
				end)
			  
				NewTimerSimple(90, function()
					for i = 1, 18 do 
						sound.Play("drones/nightvisionon.wav", LocalPlayer():GetPos(), 100, math.random(18, 35), 1) 
					end
				
					LastScene()
				end)
			end)
		end)
	  
	  
		local emitter = ParticleEmitter(Vector(0, 0, 0))
	  
		NewHookAdd("Think", "countgay", function()
			if Const < 1.2 then 
				Const = math.Approach(Const, 1, 0.0015)
			else
				for i = 1, math.random(1, 3) do
					local newmdl = table.Random(mdl)
					local e = CreateModel(newmdl)
					local scale

					if string.find(newmdl, "HGIBS") then
						scale = 8
					else
						scale = math.Rand(1, 2)
					end

					e:SetModelScale(scale, 0)
					e:SetAngles(VectorRand():Angle())
				
					local vec = VectorRand() * 2000
					vec.z = vec.z / 2
					vec = LocalPlayer():GetPos() + vec + Vector(0, 0, 420)
					  
					e:SetPos(vec)
					e:Spawn()
					e.Speed = math.Rand(10, 35)

					--ParticleEffectAttach("skull_trail", PATTACH_ABSORIGIN_FOLLOW, e, 0)
					
					table.insert(Scrap, e)
				end

				if math.random(1, 3) == 1 then
					local debris = CreatePhysModel(table.Random(debrisrand))
					debris:SetPos(LocalPlayer():GetPos() + Vector(0, 0, 700))
					debris:SetAngles(AngleRand())
					debris:Spawn()
					debris:SetModelScale(math.Rand(2, 3), 0)

					local phys = debris:GetPhysicsObject()
					if phys:IsValid() then
						phys:Wake()       
						phys:SetVelocity(VectorRand() * 400)
						phys:AddAngleVelocity(VectorRand() * 100)
					end
				end

				--for i = 1, 10 do
				local tr = util.TraceLine({
				  start = LocalPlayer():GetPos(),
				  endpos = LocalPlayer():GetPos() + Vector(0, 0, 10000),
				  filter = LocalPlayer()
				})

				local x = math.random(0, 360)
				local tr = util.TraceLine({
					start = tr.HitPos + tr.HitNormal * 32,
					endpos = tr.HitPos + Vector(math.cos(x), math.sin(x), 0) * math.random(100, 300),
					filter = LocalPlayer()
				})

				local tr = util.TraceLine({
					start = tr.HitPos + tr.HitNormal * 32,
					endpos = tr.HitPos - vector_up * 10000,
					filter = LocalPlayer()
				})

				local pos = tr.HitPos

				--ParticleEffect("fire_test", pos, Angle(0, 0, 0))
				--end
		  
				if math.random(1, 50) == 1 then
					MakeGuys()
					if math.random(1, 3) == 1 then MakeNoise(math.Rand(0.2, 0.6)) end
				end

				if math.random(1, 120) == 1 then
					MakeCorpse()
				end

				if math.random(1, 130) == 1 then
					MakeCamera()
				end
		  
				local vec = VectorRand() * 4000
				vec.z = math.abs(vec.z)
				local p = emitter:Add("sprites/redglow1", LocalPlayer():GetPos() + vec)
		
				p:SetDieTime(10)
				p:SetStartAlpha(255)
				p:SetEndAlpha(0)
				p:SetStartSize(math.random(100, 300))
				p:SetRoll(math.Rand(-10, 10))
				p:SetRollDelta(math.Rand(-10, 10))
				p:SetEndSize(200)   
				p:SetCollide(true)
				p:SetGravity(Vector(0, 0, -20))
		  
				local vec = VectorRand() * 4000
				vec.z = math.abs(vec.z)
				local p = emitter:Add("particle/smokesprites_000" .. math.random(1, 9), LocalPlayer():GetPos() + vec)
				
				p:SetDieTime(2)
				p:SetStartAlpha(20)
				p:SetEndAlpha(0)
				p:SetStartSize(math.random(1000, 1600))
				p:SetRoll(math.Rand(-10, 10))
				p:SetRollDelta(math.Rand(-1, 1))
				p:SetEndSize(200)   
				p:SetCollide(true)
				p:SetGravity(Vector(0, 0, -20))
				p:SetColor(255, 0, 0)
			end
		
			for k, v in pairs(Models) do 
				local pos = v:GetPos()
				pos.z = pos.z + math.sin(CurTime() * v.ZSpeed) * v.ZDist
				
				v:SetPos(pos)
			  
				v:SetAngles(Angle(0, CurTime() * 15 * v.RotDir, 0))
			end
			
			for k, v in pairs(Scrap) do
				if v:IsValid() then
					v:SetPos(v:GetPos() - Vector(0, 0, v.Speed))
					if v:GetPos().z <= LocalPlayer():GetPos().z then v:Remove() end
				end
			end
		end)
	end
	  

	local function DoHell()
		if Hell then return end
		Hell = true
		
		EnableHell()
	end

	concommand.Add("hellstart", DoHell)
	concommand.Add("hellend", End)
end

nut.command.add("hellstart3", {
	adminOnly = true,
	syntax = "<string name>",
	onRun = function(client, arguments)
		local target = nut.command.findPlayer(client, arguments[1])
		if(IsValid(target)) then

		
			target:ConCommand("hellstart")
		end
	end
})

if SERVER then 
concommand.Add("_hell_start", function(ply,...)
    local args = {...}


        local target = nut.command.findPlayer(client, args[2][1])
        print(target) 
        target:ConCommand("hellstart")
    
end) 
concommand.Add("_hell_end", function(ply,...)
    local args = {...}


        local target = nut.command.findPlayer(client, args[2][1])
        print(target) 
        target:ConCommand("hellend")
    
end) 
end
nut.command.add("hellend", {

	adminOnly = true,
	syntax = "<string name>",
	onRun = function(client, arguments)
		local target = nut.command.findPlayer(client, arguments[1])
        print(target)
		if(IsValid(target)) then
			target:ConCommand("hellend")
		end
	end
})

if CLIENT then
    
	local Darkness = false
	
    local cache = { }
	timercache = { }
	soundcache = { }
	modelcache = { }
	
	    local CreatePhysModel = function(mdl)
	    local ent = ents.CreateClientProp()
		ent:SetModel(mdl)
		ent:PhysicsInit(SOLID_VPHYSICS)
		ent:SetMoveType(MOVETYPE_VPHYSICS)
		ent:SetSolid(SOLID_VPHYSICS)

		table.insert(modelcache, ent)

		return ent
	end
	

	local CreateModel = function(mdl, isragdoll)
		local ent

		if isragdoll then
			ent = ClientsideRagdoll(mdl)
		else
			ent = ClientsideModel(mdl, RENDERGROUP_OTHER)
		end
	  
		table.insert(modelcache, ent)
	  
		return ent
	end

	local AddSound = function(name)
		local snd = CreateSound(LocalPlayer(), name)
	  
		table.insert(soundcache, snd)
	  
		return snd
	end

	local NewHookAdd = function(str, name, func)
		--name = "dronesrewrite_hell_hooks" .. name
		hook.Add(str, name, func)
	  
		table.insert(cache, {
			str = str,
			name = name
		})
	end

	local NewTimerSimple = function(time, func)
		local name = "dronesrewrite_hell_timers" .. table.Count(timercache)
		timer.Create(name, time, 1, func)
	  
		table.insert(timercache, {
			name = name
		})
	end

	local StopTimers = function() for k, v in pairs(timercache) do timer.Destroy(v.name) end end
	local RemoveHooks = function() for k, v in pairs(cache) do hook.Remove(v.str, v.name) end end
	local StopSounds = function() for k, v in pairs(soundcache) do if v then v:Stop() end end end
	local RemoveModels = function() for k, v in pairs(modelcache) do SafeRemoveEntity(v) end end

		
		local function MakeNoise()
			-- local crying
			-- crying = AddSound("ambient/voices/crying_loop1.wav")
			-- crying:Play()
		
			sound.PlayURL("https://puu.sh/BRy17/9221799e30.mp3", "mono noblock",function(sts)
				if IsValid(sts) then 
					Noise = sts
					Noise:EnableLooping(true)
				end
			end)
		end
		
		local function EndDarkness()
			if IsValid(Noise) then Noise:Stop() end
			
			RemoveHooks()
			StopTimers()
			StopSounds()
			RemoveModels()
		
			LocalPlayer():ScreenFade( SCREENFADE.IN, Color( 0, 0, 0, 255 ), 1, 1 )
			-- timer.Destroy("dronesrewrite_loopscreamer")
			  
			Darkness = false
		end
		
		local function EnableDarkness()
		local Models = { }
		local Scrap = { }
	  
		local Const = 0.6
		local function AddRender()
			NewHookAdd("RenderScreenspaceEffects", "dronesrewrite_hell_render", function()
				local eff_tab = {
					["$pp_colour_addr"] = Const * 0.1,
					["$pp_colour_addg"] = Const * 0.1,
					["$pp_colour_addb"] = Const * 0.1,
					["$pp_colour_brightness"] = -0.1,
					["$pp_colour_contrast"] = 1 + Const * 0.9,
					["$pp_colour_colour"] = 0.4,
					["$pp_colour_mulr"] = 1,
					["$pp_colour_mulg"] = 1,
					["$pp_colour_mulb"] = 1
				}
			  
				DrawColorModify(eff_tab)
			  
				DrawBloom(Const * 1, Const, Const, Const, Const, Const, Const, Const, Const)
				DrawSharpen(Const * 0.7, Const * 4)
				DrawMotionBlur(Const * 0.3, Const, Const * 0.01)
			end)
		end
		
		local function Flicker()
			NewHookAdd("PreDrawHUD", "dronesrewrite_hell_flicker", function()
			  local TEMP_BLUR = Material("effects/flicker_256")
		
			cam.Start2D()
				local x, y = 0, 0
				local scrW, scrH = ScrW(), ScrH()
				surface.SetDrawColor(255, 255, 255)
				surface.SetMaterial( TEMP_BLUR )		
				for i = 1, 3 do
					TEMP_BLUR:SetFloat("$blur", (i / 2) * 3)
					TEMP_BLUR:Recompute()
					render.UpdateScreenEffectTexture()
					surface.DrawTexturedRect(x * -1, y * -1, scrW, scrH)
				end
			cam.End2D()
			end)
		end
		
		local function MakeGuys()

			local tr = util.TraceLine({
				start = LocalPlayer():GetPos(),
				endpos = LocalPlayer():GetPos() + Vector(0, 0, 10000),
				filter = LocalPlayer()
			})

			local x = math.random(0, 360)
			local tr = util.TraceLine({
				start = tr.HitPos + tr.HitNormal * 32,
				endpos = tr.HitPos + Vector(math.cos(x), math.sin(x), 0) * math.random(1000, 2000),
				filter = LocalPlayer()
			})

			local tr = util.TraceLine({
				start = tr.HitPos + tr.HitNormal * 32,
				endpos = tr.HitPos - vector_up * 20000,
				filter = LocalPlayer()
			})

			local pos = tr.HitPos

			--ParticleEffect("fire_test2", pos, Angle(0, 0, 0))

				--sound.Play("vo/npc/male01/no02.wav", LocalPlayer():GetPos(), 75, math.random(70, 90), 1)
				local mdl = CreateModel("models/Humans/Group01/Male_Cheaple.mdl")
				mdl:SetModelScale(2, 0)
				mdl:SetAngles(Angle(0, (LocalPlayer():GetPos() - tr.HitPos):Angle().y, 0))
				mdl:SetPos(pos)
				-- mdl:SetRenderMode(RENDERMODE_TRANSALPHA)
				-- mdl:SetMaterial("models/angelsaur/ghosts/shadow")
				mdl:SetColor(Color(0,0,0))
	            mdl:SetRenderFX(kRenderFxDistort)
				-- mdl:SetMaterial("models/flesh")
				-- mdl:SetColor(Color(255, 0, 0))
				mdl:Spawn()
	 end

	
		local function MakeCorpse(amount)
			-- sound.Play("npc/zombie/zombie_alert1.wav", LocalPlayer():GetPos(), 90, math.random(40, 70))

			local tr = util.TraceLine({
				start = LocalPlayer():GetPos(),
				endpos = LocalPlayer():GetPos() + vector_up * 5000,
				filter = LocalPlayer()
			})

			local x = math.random(0, 360)
			local tr = util.TraceLine({
				start = tr.HitPos,
				endpos = tr.HitPos + Vector(math.cos(x), math.sin(x), 0) * math.random(1000, 2000),
				filter = LocalPlayer()
			})

			local tr = util.TraceLine({
				start = tr.HitPos,
				endpos = tr.HitPos - vector_up * 20000,
				filter = LocalPlayer()
			})

			local pos = tr.HitPos - tr.HitNormal * 8
			
			local corpses = {
				"models/humans/charple02.mdl",
				"models/humans/charple03.mdl",
				"models/humans/charple04.mdl",
				"models/humans/charple01.mdl"
			}
			
			local mdl = CreateModel(corpses[math.random(#corpses)])
			mdl:SetAngles(Angle(-90, math.random(0, 360), 0))
			mdl:SetNoDraw(false)
			mdl:DrawShadow(true)
			mdl:SetPos(pos)
		end
		
	    for i = 1, 200 do
			MakeCorpse()
		end
		
		for i = 1, 200 do
			MakeGuys()
		end

        MakeNoise()
		Flicker()
		AddRender()
			
    for k, v in pairs(Models) do 
      local pos = v:GetPos()
      pos.z = pos.z + math.sin(CurTime() * v.ZSpeed) * v.ZDist
      
      v:SetPos(pos)
      
      v:SetAngles(Angle(0, CurTime() * 15 * v.RotDir, 0))
    end
    
    for k, v in pairs(Scrap) do
      if v:IsValid() then
        v:SetPos(v:GetPos() - Vector(0, 0, v.Speed))
        if v:GetPos().z <= LocalPlayer():GetPos().z then v:Remove() end
		end
      end
  end
	
	local function DoDarkness()
		if Darkness then return end
		Darkness = true
		LocalPlayer():ScreenFade( SCREENFADE.IN, Color( 0, 0, 0, 255 ), 1, 0 )		
		EnableDarkness()
	end
	
	
	concommand.Add("mat_corrupt", DoDarkness)
	concommand.Add("mat_repair", EndDarkness)
end 

nut.command.add("scdarkness", { 
	adminOnly = true,
	syntax = "<string name> [num length]",
	onRun = function(client, arguments, amount)
		local target = nut.command.findPlayer(client, arguments[1])
		local length = tonumber(arguments[2]) or 3
		
		if (IsValid(target)) then
			if (length > 2) then	
				target:ConCommand("mat_corrupt")	  	
				timer.Simple(length, function() 
					target:ConCommand("mat_repair")
				end)
			else
				client:notifyLocalized("The length needs to be more than 2 seconds!")
			end
		end
	end
})

nut.command.add("darknessend", {
	adminOnly = true,
	syntax = "<string name>",
	onRun = function(client, arguments)
		local target = nut.command.findPlayer(client, arguments[1])
		if(IsValid(target)) then
			target:ConCommand("mat_repair")
		end
	end
})