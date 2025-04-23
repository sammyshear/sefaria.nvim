local api = require("sefaria.util.api")
local state = require("sefaria.state")
local Snacks = require("snacks")

-- internal methods
local main = {}

--- Get Parsha and Related Texts
---
---@private
function main.parsha()
    local calendar = api.get_calendar()
    if calendar == nil then
        return nil
    end

    local parsha_ref = ""
    local parsha_title = ""
    for _, item in ipairs(calendar.calendar_items) do
        if item.title.en == "Parashat Hashavua" then
            parsha_ref = item.ref
            parsha_title = item.displayValue.en
        end
    end

    local parsha = api.get_text(parsha_ref)
    if parsha == nil then
        return nil
    end

    local text = parsha.versions[1].text

    local related = api.get_related(parsha_ref)
    if related == nil then
        return nil
    end

    local commentaries = {}
    for _, item in ipairs(related.links) do
        if item.type == "commentary" then
            commentaries[#commentaries + 1] = item.ref
        end
    end

    state:set_parsha_text(text[1])
    state:save()

    return {
        parsha_ref = parsha_ref,
        parsha_title = parsha_title,
        text = text,
        commentaries = commentaries,
    }
end

--- Snacks Picker for Commentaries on Parsha
---
--- @param parsha table
---@private
function main.commentaries(parsha)
    local items = {}
    for i = 1, #parsha.commentaries do
        table.insert(items, { text = parsha.commentaries[i] })
    end

    Snacks.picker.pick({
        items = items,
        preview = "none",
        format = "text",
        confirm = function(picker, item)
            picker:close()

            local data = api.get_text(item.text)

            if data == nil then
                return
            end

            local text = {}

            if data.versions[1] == nil then
                vim.print("No versions found")
                return
            end

            if type(data.versions[1].text) == "string" then
                text[1] = data.versions[1].text
            elseif type(data.versions[1].text) == "table" then
                text = data.versions[1].text
            end

            local bufnr = vim.api.nvim_create_buf(true, true)
            vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { text[1] })
            vim.api.nvim_set_option_value("modifiable", false, { buf = bufnr })
            vim.wo.wrap = true
            vim.api.nvim_win_set_buf(0, bufnr)
        end,
    })
end

--- Snacks picker for Searching Sefaria
---
--- @param query string
---@private
function main.search(query)
    local data = api.post_search(query)

    if data == nil then
        return nil
    end

    local gen_items = function(tbl)
        local items = {}
        for i = 1, #tbl do
            table.insert(
                items,
                { text = tbl[i]._id, preview = { text = tbl[i].highlight.exact[1] } }
            )
        end
        return items
    end

    Snacks.picker.pick({
        items = gen_items(data.hits.hits),
        preview = "preview",
        format = "text",
        confirm = function(picker, item)
            picker:close()

            local bufnr = vim.api.nvim_create_buf(true, true)
            vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { item.preview.text })
            vim.api.nvim_set_option_value("modifiable", false, { buf = bufnr })
            vim.wo.wrap = true
            vim.api.nvim_win_set_buf(0, bufnr)
        end,
    })
end

return main
