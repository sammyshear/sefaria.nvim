local log = require("sefaria.util.log")

local state = { enabled = false }

---Sets the state to its original value.
---
---@private
function state:init()
    self.enabled = false
end

---Saves the state in the global _G.Sefaria.state object.
---
---@private
function state:save()
    log.debug("state.save", "saving state globally to _G.Sefaria.state")

    _G.Sefaria.state = self
end

--- Sets the global state as enabled.
---
---@private
function state:set_enabled()
    self.enabled = true
end

--- Sets the global state as disabled.
---
---@private
function state:set_disabled()
    self.enabled = false
end

---Whether the Sefaria is enabled or not.
---
---@return boolean: the `enabled` state value.
---@private
function state:get_enabled()
    return self.enabled
end

return state
