local log = require("sefaria.util.log")

local state = {
    parsha_text = {},
}

---State init
---
---@private
function state:init()
    self.parsha_text = {}
end

---Saves the state in the global _G.Sefaria.state object.
---
---@private
function state:save()
    log.debug("state.save", "saving state globally to _G.Sefaria.state")

    _G.Sefaria.state = self
end

---Set the parsha_text
---
---@param text table
---@private
function state:set_parsha_text(text)
    self.parsha_text = text
end

---Get the parsha_text
---
---@private
function state:get_parsha_text()
    return self.parsha_text
end

return state
