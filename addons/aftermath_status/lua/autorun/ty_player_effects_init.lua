
AddCSLuaFile("ty_config_buff_debuff.lua")
AddCSLuaFile("ty_shared_states.lua")
AddCSLuaFile("ty_effects.lua")
AddCSLuaFile("ty_cl.lua")



ty_effects = {["client"] = {["Interface"] = {}}}ty_effects.Player = {}

ty_effects.client.Interface.BuffOffset = {3, 4}
ty_effects.DEBUG = true -- Show console prints


ty_effects.Player.MaxHealth = 100 -- This is the max health a player starts with.
ty_effects.Player.WalkSpeed = 100
ty_effects.Player.RunSpeed = ty_effects.Player.WalkSpeed * 2
DARKRP = false
 
if DARKRP then -- Creates wrapper for darkRP instead of Helix/Nutscript :)
local meta = FindMetaTable( "Player" )
	function meta:GetCharacter()
		return self
	end
	
	function meta:GetStatus()
		return self.Status or {}
	end
	
	function meta:SetStatus(x) 
		 self.Status = x
	end

	function meta:GetStatusVar(x)
		return self.Status
	end
		function meta:SetStatusVar(x)
		self.Status = x
	end
	
			function meta:Save(x)
		
	end
end

function _getTimeSystem()
return os.time()
end

if CLIENT then

    include("ty_shared_states.lua")
    include("ty_effects.lua")
    include("ty_cl.lua") -- CLIENT UI


    function draw.Arc(cx, cy, radius, thickness, startang, endang, roughness, color)
        surface.SetDrawColor(color)
        surface.DrawArc(surface.PrecacheArc(cx, cy, radius, thickness, startang, endang, roughness))
    end

    function surface.PrecacheArc(cx, cy, radius, thickness, startang, endang, roughness)
        local triarc = {}
        -- local deg2rad = math.pi / 180

        -- Define step
        local roughness = math.max(roughness or 1, 1)
        local step = roughness

        -- Correct start/end ang
        local startang, endang = startang or 0, endang or 0

        if startang > endang then
            step = math.abs(step) * - 1
        end

        -- Create the inner circle's points.
        local inner = {}
        local r = radius - thickness
        for deg = startang, endang, step do
            local rad = math.rad(deg)
            -- local rad = deg2rad * deg
            local ox, oy = cx + (math.cos(rad) * r), cy + (-math.sin(rad) * r)
            table.insert(inner, {
                x = ox,
                y = oy,
                u = (ox - cx) / radius + .5,
                v = (oy - cy) / radius + .5,
            })
        end

        -- Create the outer circle's points.
        local outer = {}
        for deg = startang, endang, step do
            local rad = math.rad(deg)
            -- local rad = deg2rad * deg
            local ox, oy = cx + (math.cos(rad) * radius), cy + (-math.sin(rad) * radius)
            table.insert(outer, {
                x = ox,
                y = oy,
                u = (ox - cx) / radius + .5,
                v = (oy - cy) / radius + .5,
            })
        end

        -- Triangulize the points.
        for tri = 1, #inner * 2 do -- twice as many triangles as there are degrees.
            local p1, p2, p3
            p1 = outer[math.floor(tri / 2) + 1]
            p3 = inner[math.floor((tri + 1) / 2) + 1]
            if tri%2 == 0 then --if the number is even use outer.
                p2 = outer[math.floor((tri + 1) / 2)]
            else
                p2 = inner[math.floor((tri + 1) / 2)]
            end

            table.insert(triarc, {p1, p2, p3})
        end

        -- Return a table of triangles to draw.
        return triarc
    end

    function surface.DrawArc(arc) --Draw a premade arc.
        for k, v in ipairs(arc) do
            surface.DrawPoly(v)
        end
    end


    timer.Simple(1, function()
        include("ty_shared_states.lua")
        include("ty_effects.lua")
        include("ty_cl.lua") -- SERVER
    end)
else

    include("ty_shared_states.lua")
    include("ty_effects.lua")
    include("ty_sv.lua") -- SERVER
    timer.Simple(1, function()
        include("ty_shared_states.lua")
        include("ty_effects.lua")
        include("ty_sv.lua") -- SERVER
    end)
end
