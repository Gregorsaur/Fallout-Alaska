print("dababy")
local NPC = {} -- DO NOT TOUCH

NPC.Name = "Anna Fieldling"
NPC.Category = "Fusion: vNPC"
NPC.Base 			= "base_nextbot"
NPC.Spawnable		= true
NPC.PrintName = NPC.Name
NPC.data = {
    bones = {
        [1] = Vector(1, 1, 1),
    },
    move_bones = {
        [1] = Vector(0, 0, 0),
    },
    skin = Vector(2, 2, 2),
    facial_hair = 0,
    hair = {3, Vector(255 / 255, 255 / 255, 255 / 255)},
    eyecolor = 2,
	parts = {
	{
    slot = "chest",
    model = "models/thespireroleplay/humans/group104/female.mdl",
    skipFlags = {}
	}
}
}




local shop_id = "test_01"
local shop = CHAT_LIB:RegisterShop(shop_id)
shop:AddNewItem("weapon_revolver",100)



NPC.ShopID = shop_id
NPC.Dialog = {

 ["name"] = NPC.Name,
  ["1"] = {
 
  response = "what was you saying again?", -- this is if we want the chat to loop back to the start
  action = "say",
  data = "hello!",
  choices = "shop"
  },

    ["shop"] = { 
  response = "Shop",
  action = "open_shop",
  data = shop_id,
  choices = ""
  },

    ["bye"] = { 
  response = "Goodbye.",
  action = "close",
  },

}  




function NPC:Initialize()
	self:SetModel( "models/yshera/humans/female.mdl" )
  	self.LoseTargetDist	= 2000	-- How far the enemy has to be before we lose them
	self.SearchRadius 	= 1000	-- How far to search for enemies
	--if SERVER then self:StartActivity( ACT_BUSY_LEAN_LEFT ) end
    if SERVER then self:SetUseType(SIMPLE_USE) self:SetMaxHealth(1) end
	if CLIENT then 
    self:ApplyMorph(self.data) 
    end
	self.DisplayName  = true
	self.ForcedFriendly = true
	self:SetHealth(1)
	local oob = 12
	self:SetCollisionBounds( Vector(-oob,-oob,0), Vector(oob,oob,72) )
	TRANSFORM_LOCALLY_BG(self,self.data)
	self:SetNWInt("lvl", 99)
	
	 self:BehaveStart()
end
NPC.Faction = "DestructObject"

ENT = NPC

function ENT:IsNPC() 
return true
end
function ENT:RunBehaviour_implement()
	while ( false == true ) do

		if self.action  and self.action == 1 then 
			self:ResetSequenceInfo()
	
			self:PlaySequenceAndWait("throw1",2,0.4)
			
			local vPoint = self.action_player:GetPos()
local effectdata = EffectData()
effectdata:SetOrigin( vPoint )
util.Effect( "HelicopterMegaBomb", effectdata )
self.action_player:TakeDamage(2000)
				self.action = 0
			self:StartActivity( ACT_BUSY_LEAN_LEFT ) 
		
		end
	coroutine.yield()
	end
end
function ENT:BehaveStart()

	self.BehaveThread = coroutine.create( function() self:RunBehaviour_implement() end )
	
end

function ENT:BehaveUpdate( fInterval )

	if ( !self.BehaveThread ) then return end

	--
	-- Give a silent warning to developers if RunBehaviour has returned
	--
	if ( coroutine.status( self.BehaveThread ) == "dead" ) then

		self.BehaveThread = nil
		Msg( self, " Warning: ENT:RunBehaviour() has finished executing\n" )

		return

	end

	--
	-- Continue RunBehaviour's execution
	--
	local ok, message = coroutine.resume( self.BehaveThread )
	if ( ok == false ) then

		self.BehaveThread = nil
		ErrorNoHalt( self, " Error: ", message, "\n" )

	end

end


function ENT:BodyUpdate()

	local act = self:GetActivity()

	--
	-- This helper function does a lot of useful stuff for us.
	-- It sets the bot's move_x move_y pose parameters, sets their animation speed relative to the ground speed, and calls FrameAdvance.
	--
	if ( act == ACT_RUN || act == ACT_WALK ) then

		self:BodyMoveXY()

		-- BodyMoveXY() already calls FrameAdvance, calling it twice will affect animation playback, specifically on layers
		return

	end

	--
	-- If we're not walking or running we probably just want to update the anim system
	--
	self:FrameAdvance()

end


function ENT:PlaySequenceAndWait( name, speed,delayMod )

	local len = self:SetSequence( name )
	speed = speed or 1
	delayMod = delayMod or 1
	self:ResetSequenceInfo()
	self:SetCycle( 0 )
	self:SetPlaybackRate( speed )

	-- wait for it to finish
	coroutine.wait( (len / speed) )

end 




function ENT:OnTakeDamage( dmginfo )

dmginfo:SetDamage(0)

self.action = 1
self.action_player = dmginfo:GetAttacker()
end
----------------------------------------------------
-- ENT:Get/SetEnemy()
-- Simple functions used in keeping our enemy saved
----------------------------------------------------
function ENT:SetEnemy(ent)
	self.Enemy = ent
end
function ENT:GetEnemy()
	return self.Enemy
end
function ENT:TakeDamage()

end
function ENT:Use(user)
	if ply:IsPlayer()  then
    net.Start("network_npc_interact") 
    net.WriteEntity(self) 
    net.Send(user) 
	end
end
----------------------------------------------------
-- ENT:HaveEnemy()
-- Returns true if we have a enemy
----------------------------------------------------
ENT.AutomaticFrameAdvance = true -- Must be set on client

function ENT:Think()
	-- Do stuff

	self:NextThink( CurTime() ) -- Set the next think to run as soon as possible, i.e. the next frame.

	return true -- Apply NextThink call
end

----------------------------------------------------
-- ENT:FindEnemy()
-- Returns true and sets our enemy if we find one
----------------------------------------------------
function ENT:FindEnemy()

	return false
end

----------------------------------------------------
-- ENT:RunBehaviour()
-- This is where the meat of our AI is
----------------------------------------------------
function ENT:RunBehaviour()



end	

----------------------------------------------------
-- ENT:ChaseEnemy()
-- Works similarly to Garry's MoveToPos function
--  except it will constantly follow the
--  position of the enemy until there no longer
--  is one.
----------------------------------------------------
function ENT:ChaseEnemy( options ) 


end




if CY_LINK_LOADED then

scripted_ents.Register( NPC, "npc_"..debug.getinfo(1, "S").source:sub(2):match("(.+)%.lua"):sub(#"npc_addons/ghostfrp/lua/npc"-1)..".lua" )
end

return NPC -- DO NOT TOUCH 2. Electric Boogaloo