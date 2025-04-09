-- You can use this loaded variable to enable conditional parts of your plugin.
if _G.SefariaLoaded then
    return
end

_G.SefariaLoaded = true

vim.api.nvim_create_user_command("Parsha", function()
    require("sefaria").parsha()
end, {})

vim.api.nvim_create_user_command("SearchSefaria", function(args)
    require("sefaria").search(args["args"])
end, { nargs = "?" })
