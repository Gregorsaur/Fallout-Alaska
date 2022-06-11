util.AddNetworkString("halo_server2Client, Create")
util.AddNetworkString("getDataRequestCC")

local function init_MO ()
local PLUGIN = {}
local char = nut.meta.character

print("======JOB_HUNTER_MO======")

concommand.Add("purge_apperance", function(ply) 
ply:getChar():RemoveAllParts()
 end)
concommand.Add("add_apperance2", function(ply) 
local self = ply:getChar()

self:AddPartSlot({
    slot = "human_head",
    model = "models/tnb/techcom/female_61.mdl",
    skipFlags = {HIDE_HEAD}
}) 
   --    local apperance = self:getApperance()
   --    apperance.height = 1.05
   --    self:setApperance(apperance)

 end) 
 
--
--hook.Add( "EntityTakeDamage", "EntityDamageExample", function( target, dmginfo )
--	if ( target:IsPlayer() and target:getChar():getData("isInsi") == true) then
--		dmginfo:ScaleDamage( 0.35)
--		target.TotalDamage = (target.TotalDamage or 0 ) + dmginfo:GetDamage()
--		target.AmountPerTick = target.TotalDamage/4
--	end
--end )
--
--timer.Create("insihp_decay", 0.5, 0, function() 
--for i,v in pairs(player.GetAll()) do 
--if v.AmountPerTick and v.TotalDamage > 0 then 
--
--	local d = DamageInfo() 
--	d:SetDamage( v.AmountPerTick )
--	d:SetAttacker( v )
--	d:SetDamageType( DMG_PLASMA ) 
--
--	v:TakeDamageInfo( d )
--	
--
-- v.TotalDamage =  v.TotalDamage - v.AmountPerTick
--end
--end 
--end)

hook.Add("PlayerSpawn", "inisi",function(target) target.TotalDamage = 0 target.AmountPerTick=0 end)

net.Receive("getDataRequestCC, Create", function(len, player) 
local e = net.ReadEntity()
net.Start("getDataRequestCC")
net.WriteEntity(e)
net.WriteTable(self:getApperance())
net.Send(player)


end)




function char:updateOnServer()
    TRANSFORM_LOCALLY_BG(self:getPlayer(), self:getApperance())
end


    local char = nut.meta.character

    function char:updateOnServer()
        TRANSFORM_LOCALLY_BG(self:getPlayer(), self:getApperance())
    end

    function char:RemoveAllParts()
        local apperance = self:getApperance()
        apperance.parts = {}
        self:setApperance(apperance)
    end

    function char:RemoveSlot(slot)
        local apperance = self:getApperance()
        apperance.parts = apperance.parts or {}
       if apperance.parts[slot] then apperance.parts[slot] = nil end
        self:setApperance(apperance)
    end
    function char:AddPartSlot(data)
        local apperance = self:getApperance()
        apperance.parts = apperance.parts or {}
        apperance.parts[data.slot] = data
        self:setApperance(apperance)
    end

--[[ 
player.GetAll()[1]:getChar():AddPartSlot({
    slot = "chest",
    model = "models/thespireroleplay/humans/group015/male.mdl",
    skipFlags = {HIDE_TORSO}
}) ]]
function PLUGIN:syncCharList(client)
    if (not client.nutCharList) then return end
    net.Start("nutCharList")
    net.WriteUInt(#client.nutCharList, 32)

    for i = 1, #client.nutCharList do
        net.WriteUInt(client.nutCharList[i], 32)
    end

    net.Send(client)
end

local function response(message)
    net.Start("nutCharChoose")
    net.WriteString(L(message or "", client))
    net.Send(client)
end

DOCREATECHARACTER = false

local stats = {"Strength", "Perception", "Endurance", "Charisma", "Intelligence", "Agility", "Luck"}

net.Receive("halo_server2Client, Create", function(len, player)
    print("CREATE")
    local tblData = net.ReadTable()
    local plyNameChosen = tblData.CharacterName

    if plyNameChosen:match("[^%w%s]") or #plyNameChosen <= 1 then
        player:SendLua("chat.AddText('Invalid Character Name') ")

        return
    end

    fact = fact == 1 and FACTION_SANGHELIOS or FACTION_UNSC
	if type(tblData.trait) == "string" then tblData.trait = 0 end
    local data = {
        ["name"] = plyNameChosen,
        ["desc"] = "Not Set",
        -- ["bonescales"] =    tblData.Bones,
        ["model"] = tblData.model,
        ["steamID"] = player:SteamID64(),
		["trait"] = (tblData.trait or 2 ) - 1
    }

    local originalData = data
    DOCREATECHARACTER = true

    if DOCREATECHARACTER == true then
        nut.char.create(data, function(id)
            if (IsValid(player)) then
                local char = nut.char.loaded[id]
                PrintTable(nut.attribs.list)

                for k, v in pairs(nut.attribs.list) do
                    print("==========================", k, "==========================")
                    PrintTable(v)
                    char:setAttrib(k, tblData[v.name])
                end

                PrintTable(tblData)
                char:setApperance(tblData.charData)
                nut.char.loaded[id]:sync(player)
                table.insert(player.nutCharList, id)
                PLUGIN:syncCharList(player)
                char:setFaction(FACTION_WASTELANDER)
                hook.Run("OnCharCreated", player, nut.char.loaded[id], originalData)
                --response(id)
                timer.Simple(1, function() end)
                player:SendLua([[
		  if _G["§"] then _G["§"]:Remove() end
          		  nut.gui.character:Remove()
		   nutMultiChar:chooseCharacter(]] .. id .. [[)
           ]])
                --  
                if SERVER then end
            end
        end)
    end
end)
    end
hook.Add("InitializedPlugins", "InitializedPlugins:NUTCHARSV_MORPH",init_MO)
init_MO()

hook.Add("CreateCorpseHus","f_hus", function(corpse, victim, char) 
 


print("corpse: ", corpse, victim, char )
netstream.Start(player.GetAll(),"corpseApp",corpse:EntIndex(), victim:EntIndex())
end) 
