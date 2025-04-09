local curl = require("plenary.curl")
local url_util = require("sefaria.util.url")

local api = {}

--- Sefaria GET Calendar
---
---@private
function api.get_calendar()
    local url = "https://www.sefaria.org/api/calendars"

    local response = curl.get(url)
    if response.status ~= 200 then
        return nil
    end
    local data = vim.json.decode(response.body)

    return data
end

--- Sefaria POST Search
---
--- @param query string
function api.post_search(query)
    if query == nil then
        return nil
    end
    local url = "https://www.sefaria.org/api/search-wrapper"

    local response = curl.post(url, {
        body = '{ "query":"' .. query .. '" }',
        headers = { ["Content-Type"] = "application/json", accept = "application/json" },
    })
    if response.status ~= 200 then
        return nil
    end
    local data = vim.json.decode(response.body)

    return data
end

--- Sefaria GET Text
---
--- @param text string
function api.get_text(text)
    if text == nil then
        return nil
    end
    text = url_util.encode(text)

    local url = "https://www.sefaria.org/api/v3/texts/" .. text
    local query = { version = "english", return_format = "text_only" }

    local response = curl.get(url, { query = query })
    if response.status ~= 200 then
        return nil
    end
    local data = vim.json.decode(response.body)

    return data
end

--- Sefaria GET Related
---
--- @param text string
function api.get_related(text)
    if text == nil then
        return nil
    end
    text = url_util.encode(text)

    local url = "https://www.sefaria.org/api/related/" .. text

    local response = curl.get(url)
    if response.status ~= 200 then
        return nil
    end
    local data = vim.json.decode(response.body)

    return data
end

return api
