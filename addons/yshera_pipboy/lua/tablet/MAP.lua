print"Loaded Screen"
--local PlyItems = player.GetAll()[1]:getChar():getInv():Add("potato", 1)    
local x, y = 100, 100
local width, height = 25, 25
local gridSize = 25
local framerate = 1 / 10
local direction = "RIGHT"

local canvasSize = {
    x = gridSize * 35,
    y = gridSize * 25
}

local directions = {
    [KEY_W] = "UP",
    [KEY_A] = "LEFT",
    [KEY_S] = "DOWN",
    [KEY_D] = "RIGHT",
}

local length = 3
local bodylocs = {}
local movementsqueued = {}

for i = 1, length do
    table.insert(bodylocs, {x, y})
end

local nextTime = CurTime() + 1 / 5
local firstTime = true
    local foodPos = {
        ["x"] = gridSize * 32,
        ["y"] = gridSize * 23
    } 
local function regenFoodLoc() 
            foodPos["x"] = math.random(0, 34) * gridSize
            foodPos["y"] = math.random(0, 24) * gridSize
            for i,v in pairs(bodylocs) do 
            if foodPos.x == v[1] and foodPos.y == v[2] then
            regenFoodLoc() 
            break
      end
   end
end
local function reset() 
    direction = "RIGHT"
            regenFoodLoc() 
            x, y = 100, 100
             length = 3
             bodylocs = {}
             movementsqueued = {}

            for i = 1, length do
                table.insert(bodylocs, {x, y})
            end
end
local function isCollideWithSelf()
    local isCollide = false
    if bodylocs[1][1] < 0 or bodylocs[1][1] > canvasSize.x-gridSize  or bodylocs[1][2] < 0 or bodylocs[1][2] > canvasSize.y-gridSize then 
    reset() 
    end
    for i, v in pairs(bodylocs) do
        if i ~= 1 and
             bodylocs[1][1] == v[1] and bodylocs[1][2] == v[2] then
        reset() 
            return true
            
        end

     
    end
       return false
end

tablet.pages["MAP"] = function(color_main)
end

tablet.pages["snake"] = function(color_main)
    local oldW, oldH = ScrW(), ScrH()

    surface.SetDrawColor(pip_color)

    render.SetViewPort(128, 128, canvasSize.x, canvasSize.y)
    surface.DrawOutlinedRect(0, 0, canvasSize.x, canvasSize.y)

    if firstTime then
        firstTime = false
        regenFoodLoc()
    end

    for i, v in pairs(directions) do
        if input.WasKeyPressed(i) then
            if #movementsqueued <= 2 then
                table.insert(movementsqueued, v)
            end
        end
    end

    if nextTime < CurTime() then
        direction = movementsqueued[1] or direction

        if movementsqueued[1] then
            table.remove(movementsqueued, 1)
        end

        nextTime = CurTime() + framerate

        if direction == "UP" then
            y = y - gridSize
        elseif direction == "RIGHT" then
            x = x + gridSize
        elseif direction == "DOWN" then
            y = y + gridSize
        elseif direction == "LEFT" then
            x = x - gridSize
        end

        table.insert(bodylocs, 1, {x, y})

        table.remove(bodylocs, length + 1)

        if foodPos.x == x and foodPos.y == y then
            length = length + 1

            regenFoodLoc() 
        end
        isCollideWithSelf()
    end
    local transp = 600
    for i, v in pairs(bodylocs) do
        local n  = surface.GetDrawColor()
    local perc= 600/transp
    surface.SetDrawColor(n.r * perc,n.g* perc,n.b* perc,255)
        transp = transp - 1
        surface.DrawRect(v[1], v[2], width, height)
    end
    local n  = surface.GetDrawColor()
    local perc= 600/transp
    surface.SetDrawColor(pip_color)
    surface.DrawRect(foodPos.x + 6, foodPos.y + 6, 13, 13)
    render.SetViewPort(0, 0, oldW, oldH)
end

hook.Add("PlayerBindPress", "Minigames", function(ply, bind, pressed)
    if PIPBOY_ON_SCREEN and pipboy.SelectedHeader == "snake" then
        if bind == "+forward" then
            return true
        elseif bind == "+moveleft" then
            return true
        elseif bind == "+moveright" then
            return true
        elseif bind == "+back" then
            return true
        end
    end
end)