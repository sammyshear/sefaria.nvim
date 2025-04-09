local main = require("sefaria.main")
local config = require("sefaria.config")

local Sefaria = {}

function Sefaria.parsha()
    local parsha_info = main.parsha()
    if parsha_info == nil then
        return nil
    end

    local bufnr = vim.api.nvim_create_buf(true, true)
    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, parsha_info.text[1])
    vim.api.nvim_set_option_value("modifiable", false, { buf = bufnr })
    vim.wo.wrap = true
    vim.api.nvim_win_set_buf(0, bufnr)
end

function Sefaria.search(query)
    main.search(query)
end

-- setup Sefaria options and merge them with user provided ones.
function Sefaria.setup(opts)
    _G.Sefaria.config = config.setup(opts)
end

_G.Sefaria = Sefaria

return _G.Sefaria
