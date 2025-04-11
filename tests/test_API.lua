local Helpers = dofile("tests/helpers.lua")

-- See https://github.com/echasnovski/mini.nvim/blob/main/lua/mini/test.lua for more documentation

local child = Helpers.new_child_neovim()

local T = MiniTest.new_set({
    hooks = {
        -- This will be executed before every (even nested) case
        pre_case = function()
            -- Restart child process with custom 'init.lua' script
            child.restart({ "-u", "scripts/minimal_init.lua" })
        end,
        -- This will be executed one after all tests from this set are finished
        post_once = child.stop,
    },
})

-- Tests related to the `setup` method.
T["setup()"] = MiniTest.new_set()

T["setup()"]["sets exposed methods and default options value"] = function()
    child.lua([[require('sefaria').setup()]])

    -- global object that holds your plugin information
    Helpers.expect.global_type(child, "_G.Sefaria", "table")

    -- config
    Helpers.expect.global_type(child, "_G.Sefaria.config", "table")

    -- assert the value, and the type
    Helpers.expect.config(child, "debug", false)
    Helpers.expect.config_type(child, "debug", "boolean")
end

T["setup()"]["overrides default values"] = function()
    child.lua([[require('sefaria').setup({
        -- write all the options with a value different than the default ones
        debug = true,
    })]])

    -- assert the value, and the type
    Helpers.expect.config(child, "debug", true)
    Helpers.expect.config_type(child, "debug", "boolean")
end

-- Tests relating to the parsha command
T["parsha()"] = MiniTest.new_set()

T["parsha()"]["checks to see if the parsha text is successfully fetched"] = function()
    child.lua([[require('sefaria').parsha()]])

    Helpers.expect.global_type(child, "_G.Sefaria", "table")

    Helpers.expect.state_type(child, "parsha_text", "table")
end

return T
