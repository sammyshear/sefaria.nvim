-- You can use this loaded variable to enable conditional parts of your plugin.
if _G.SefariaLoaded then
    return
end

_G.SefariaLoaded = true

-- Useful if you want your plugin to be compatible with older (<0.7) neovim versions
if vim.fn.has("nvim-0.7") == 0 then
    vim.cmd("command! Sefaria lua require('sefaria').toggle()")
else
    vim.api.nvim_create_user_command("Sefaria", function()
        require("sefaria").toggle()
    end, {})
end
