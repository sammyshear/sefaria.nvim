local log = require("sefaria.util.log")

local Sefaria = {}

--- Sefaria configuration with its default values.
---
---@type table
--- Default values:
---@eval return MiniDoc.afterlines_to_code(MiniDoc.current.eval_section)
Sefaria.options = {
    -- Prints useful logs about what event are triggered, and reasons actions are executed.
    debug = false,
}

---@private
local defaults = vim.deepcopy(Sefaria.options)

--- Defaults Sefaria options by merging user provided options with the default plugin values.
---
---@param options table Module config table. See |Sefaria.options|.
---
---@private
function Sefaria.defaults(options)
    Sefaria.options = vim.deepcopy(vim.tbl_deep_extend("keep", options or {}, defaults or {}))

    -- let your user know that they provided a wrong value, this is reported when your plugin is executed.
    assert(
        type(Sefaria.options.debug) == "boolean",
        "`debug` must be a boolean (`true` or `false`)."
    )

    return Sefaria.options
end

--- Define your sefaria setup.
---
---@param options table Module config table. See |Sefaria.options|.
---
---@usage `require("sefaria").setup()` (add `{}` with your |Sefaria.options| table)
function Sefaria.setup(options)
    Sefaria.options = Sefaria.defaults(options or {})

    log.warn_deprecation(Sefaria.options)

    return Sefaria.options
end

return Sefaria
