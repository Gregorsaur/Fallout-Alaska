PLUGIN.name = "Item Clear"
PLUGIN.author = "Barata"
PLUGIN.desc = "Clears items!"

local resetTime = (60 * 60) -- 1 Hour
local MapCleanupTime = (60 * 360) -- 6 Hours

if (SERVER) then -- Quick and dirty, but it works.
	function PLUGIN:InitializedPlugins()
		timer.Create("clearWorldItemsWarning", resetTime - (60 * 10), 0, function() -- WORLD ITEMS CLEANUP
			for i, v in pairs(player.GetAll()) do
				v:ChatPrint("[ WARNING ]  World items will be cleared in 10 Minutes!")
				v:notify("World items will be cleared in 10 Minutes!")
			end
		end)
		timer.Create("mapCleanupWarning", MapCleanupTime - (60 * 10), 0, function()  -- MAP CLEANUP
			for i, v in pairs(player.GetAll()) do
				v:ChatPrint("[ WARNING ]  Automatic Map Cleanup in 10 Minutes!")
				v:notify("World items will be cleared in 10 Minutes!")
			end
		end)
		timer.Create("clearWorldItemsWarningFinal", resetTime - 60, 0, function() -- WORLD ITEMS CLEANUP
			for i, v in pairs(player.GetAll()) do
				v:ChatPrint("[ WARNING ]  World items will be cleared in 60 Seconds!")
				v:notify("World items will be cleared in 60 Seconds!")
			end
		end)
		timer.Create("mapCleanupWarningFinal", MapCleanupTime -  60, 0, function() -- MAP CLEANUP
			for i, v in pairs(player.GetAll()) do
				v:ChatPrint("[ WARNING ]  Automatic Map Cleanup in 60 Seconds!")
				v:notify("World items will be cleared in 60 Seconds!")
			end
		end)
		timer.Create("clearWorldItems", resetTime, 0, function() -- WORLD ITEMS CLEANUP
			for i, v in pairs(ents.FindByClass("nut_item")) do
				v:Remove()
			end
		end)
		timer.Create("AutomaticMapCleanup", MapCleanupTime, 0, function()  -- MAP CLEANUP
			for i, v in pairs(player.GetAll()) do
				v:ChatPrint("[ WARNING ]  Map Cleanup Inbound! Brace for Impact!")
			end
			RunConsoleCommand("gmod_admin_cleanup")
		end)
	end
end
