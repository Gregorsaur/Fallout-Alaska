--ENUMERATIONS--
STATE_OVERRIDE_OVERWRITE,STATE_OVERRIDE_ADD_DURATION,STATE_OVERRIDE_OVERWRITE_IF_DURATION_LONGER= 0,1,2
TY_SHARED_STATES = true
Debug = {}
--DEBUG FUNCTIONS-- 
function Debug.Print(...) if ty_effects.DEBUG and true == false then MsgC(Color( 255, 125, 125 ), "Ty_Drug_Base: ",Color(235,235,235)) MsgC(...) MsgC("\n") end end
  
--STATE ID TABLE--   
--Convert strings into ints to allow for better networking.
STATE_ID_TO_STRING,STATE_STRING_TO_ID=STATE_ID_TO_STRING or {[1]="empty"} ,STATE_STRING_TO_ID or {["empty"]=1}
TY_BUFFS={}
function util:addPlayerState(str,uID)
	uID = uID or 0    
	STATE_ID_TO_STRING[uID]=str
	STATE_STRING_TO_ID[str]=uID
	return uID 
end   
 
TY_PSUEDO_BUFFS = {} 
TY_STACKSDODECAY = {}
TY_HOOKS = {}
TY_PERSIST={}

--Effect Class    

  
function createState(name,uID,isPsuedo) 
 	local _ = {}
	_.networkID = util:addPlayerState(name,uID)
	_.name = name
	Debug.Print("has created a new drug state ",'"',name,'" with id of ',uID ) 
	if isPsuedo then
		TY_PSUEDO_BUFFS[(uID)]=_
	end
	TY_BUFFS = TY_BUFFS or {}
	TY_BUFFS[tostring(_.networkID)]=_
	if SERVER then 
		function _:push(typeofhook,func) 
			hook.Add(typeofhook,"hook_"..typeofhook.."_id:".._.networkID, function(player,a,b,c) if player.isBuffActive then local active,stacks =  player:isBuffActive(_.networkID) if active then func(player,stacks,a,b,c) end end end)
		end
		
		function _:pushEvent(typeofhook,func,id) 
		TY_HOOKS[typeofhook] = TY_HOOKS[typeofhook] or {} 
		TY_HOOKS[typeofhook][id] = func
		end
		
		function _:decayStack(i) 
		TY_STACKSDODECAY[_.networkID]=i
		end
		
		function _:setPersist(v)
		TY_PERSIST[_.networkID] = v==true
		end
		
		
	else
		function _:push() end
		function _:pushEvent() end
		function _:decayStack() end 
		function _:setPersist(v)
		end
	end
	hook.Run("PostEffectCreation",_) 
	timer.Simple(1/100,function()  hook.Run("PostEffectCreation",_) end)
	return _
end
  
function buff(name,uID,a)
	local _ = createState(name,uID,a)
	_.IsDebuff = false
	return _
end

function debuff(name,uID,a)
	local _ = createState(name,uID,a)
	_.IsDebuff = true
	return _
end 

function get_buff(id)
	return TY_BUFFS[tostring(id)]
end
 
 


--METATABLE-- (have to use Player MetaTable as Helix is shit and don't have basic functionality
local _player = FindMetaTable( "Player" )
 

function _player:getMaxHealth(buffs)							   
	local maxhealth = hook.Call( "GetPlayerMaxHealth" ) or ty_effects.Player.MaxHealth or 100

	for i,_ in pairs(buffs) do
	local v=get_buff(_.id)
	 
		if v and v.attributes and v.attributes.health then 
			maxhealth = maxhealth * (1+(v.attributes.health *_.stacks))
		end
	end
	if maxhealth != self:GetMaxHealth() then
	self:maxHealth(maxhealth)
	end
	return maxhealth
end 


function _player:calcuateResistance(buffs)							   
	local resist = 1

	for i,_ in pairs(buffs) do
	v=get_buff(_.id)
	 
		if v and v.attributes and v.attributes.resistance then 
			resist = resist * (1-(v.attributes.resistance *_.stacks))
		end
	end

	self.resistance = resist
	

end 

function _player:calcuateSpeed(buffs)							

	local walkspeed = hook.Call( "GetPlayerSpeed" ) or 175 or 200	
	local runspeed = hook.Call( "GetPlayerRunSpeed" ) or ty_effects.Player.RunSpeed or 250
	local multiplier = 1
	local disableSprint = false 
	local stopDisablesprint = false
	for i,_ in pairs(buffs) do
	v=get_buff(_.id)
	if v and v.attributes then
		if v.attributes.speed then
			multiplier = multiplier * (1+(v.attributes.speed *_.stacks))
		end
		if v.attributes.disableSprint then
		disableSprint = true
		end
		if v.attributes.stopDisableSprint then
		stopDisablesprint = true
		end
		end
	end

	self:SetWalkSpeed(walkspeed*multiplier)
	self:SetRunSpeed(walkspeed*multiplier)

end  


 
function _player:isBuffActive(id) 

if SERVER then
if self["getChar"] then else return end
char = self:getChar()
if char then
if TY_PSUEDO_BUFFS[id] then
return TY_PSUEDO_BUFFS[id].check(self)
else
	--[[for i,v in pairs (char:getData("status")) do 
		if v[1] == id and v[2]-_getTimeSystem() > 0 then
			return v[2]-_getTimeSystem() > 0, v[3] or 1
		end
		end ]]
		if (char.statuses and char.statuses[STATE_ID_TO_STRING[id]]) then
		
		return true,char.statuses[STATE_ID_TO_STRING[id]]
		end
		end
end end
	return false
end 

function _player:getActiveBuffs(_select,select_val) 
if self["getChar"] then else return {} end
local char = self:getChar()
if SERVER then

	local states = {} 
	for i,v in pairs(TY_PSUEDO_BUFFS) do 
		if (_select  and v.IsDebuff == select_val ) or  !_select    then
		if v.check(self) then
		table.insert(states,{["id"]=i,["time"]=0,["stacks"]=1}) 
		end
		end 
	end
	for i,v in pairs (char:getData("status",{}) ) do 
		if v[2]-_getTimeSystem() > 0 then
		if (_select and get_buff(v[1]).IsDebuff == select_val) or  !_select    then
		table.insert(states,{["id"]=v[1],["time"]=v[2],["stacks"]=v[3] or 1}) 
		end
		end
	end
	return states
	

	else -- Client Implement
	if (self.states) then 
		local states = {}
			for i,v in pairs(TY_PSUEDO_BUFFS) do 
				if (_select and v.check(self) and v.IsDebuff == select_val ) or  !_select    then
				table.insert(states,{["id"]=i,["time"]=0}) 
				end 
			end
			for i,v in pairs (self.states or {}) do 
				if v-_getTimeSystem() > -1 and ((_select and get_buff(i).IsDebuff == select_val) or  !_select ) then
				table.insert(states,{["id"]=i,["time"]=v}) 
				end
			end
		return states
		
		else 
	return {}
		end
	return {}
	end
	return {}
end 


hook.Call("ty_states_init")
hook.Call("ty_update_drug_index")

--hook.Add( "ty_states_init", "_ty_states_init", function() end) )