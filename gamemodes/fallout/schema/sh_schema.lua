SCHEMA.name = "Fallout: Alaskan Frontie"
SCHEMA.author = "Horizon Networks"
SCHEMA.desc = ""
nut.char.registerVar("talents", {
    field = "_talents",
    default = {},
    isLocal = true,
})
nut.config.add("Research", {}, desc, callback, data, noNetworking, schemaOnly)
if (SERVER) then
    local SQLITE_ALTER_TABLES = [[
            ALTER TABLE `nut_characters` ADD `status` TEXT NOT NULL , ADD `_skills` TEXT NOT NULL AFTER `status`,ADD `_quest` TEXT NOT NULL AFTER `status`, ADD `_talents` TEXT NOT NULL AFTER `_skills`, ADD `_apperance` TEXT NOT NULL AFTER `_talents`
        ]]

    nut.db.waitForTablesToLoad():next(function()
        nut.db.query(SQLITE_ALTER_TABLES):catch(function(x)
        end)
    end):catch(function() end)
end