local function AddFile(File, directory)
    local prefix = string.lower(string.Left(File, 3))

    if SERVER and prefix == "sv_" then
        include(directory .. File)
        print("[AUTOLOAD] SERVER INCLUDE: " .. File)
    elseif prefix == "sh_" then
        if SERVER then
            AddCSLuaFile(directory .. File)
            print("[AUTOLOAD] SHARED ADDCS: " .. File)
        end

        include(directory .. File)
        print("[AUTOLOAD] SHARED INCLUDE: " .. File)
    elseif prefix == "cl_" then
        if SERVER then
            AddCSLuaFile(directory .. File)
            print("[AUTOLOAD] CLIENT ADDCS: " .. File)
        elseif CLIENT then
            include(directory .. File)
            print("[AUTOLOAD] CLIENT INCLUDE: " .. File)
        end
    end
end

local function IncludeDir(directory)
    directory = directory .. "/"
    local files, directories = file.Find(directory .. "*", "LUA")

    for _, v in ipairs(files) do
        if string.EndsWith(v, ".lua") then
            AddFile(v, directory)
        end
    end

    for _, v in ipairs(directories) do
        print("[AUTOLOAD] Directory: " .. v)
        IncludeDir(directory .. v)
    end
end


if SERVER then
    AddCSLuaFile("cl_pipboy.lua")
	AddCSLuaFile("cl_nut_ui_overwrite.lua")
    include("sv_pipboy.lua")
else
    include("cl_pipboy.lua")
	include("cl_nut_ui_overwrite.lua")
end

if SERVER then 
IncludeDir("pipboy") 
else 
IncludeDir("pipboy") 
hook.Add("ReloadPipboy","reloadplugins",function() 
	IncludeDir("pipboy") 
end)
end



 