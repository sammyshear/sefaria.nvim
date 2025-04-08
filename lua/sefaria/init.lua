local main = require("sefaria.main")
local config = require("sefaria.config")

local Sefaria = {}

--- Toggle the plugin by calling the `enable`/`disable` methods respectively.
function Sefaria.toggle()
    if _G.Sefaria.config == nil then
        _G.Sefaria.config = config.options
    end

    main.toggle("public_api_toggle")
end

--- Initializes the plugin, sets event listeners and internal state.
function Sefaria.enable(scope)
    if _G.Sefaria.config == nil then
        _G.Sefaria.config = config.options
    end

    main.toggle(scope or "public_api_enable")
end

--- Disables the plugin, clear highlight groups and autocmds, closes side buffers and resets the internal state.
function Sefaria.disable()
    main.toggle("public_api_disable")
end

-- setup Sefaria options and merge them with user provided ones.
function Sefaria.setup(opts)
    _G.Sefaria.config = config.setup(opts)
end

_G.Sefaria = Sefaria

return _G.Sefaria
