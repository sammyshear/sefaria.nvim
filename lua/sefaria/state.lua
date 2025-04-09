local log = require("sefaria.util.log")

local state = {}

---Saves the state in the global _G.Sefaria.state object.
---
---@private
function state:save()
    log.debug("state.save", "saving state globally to _G.Sefaria.state")

    _G.Sefaria.state = self
end

return state
