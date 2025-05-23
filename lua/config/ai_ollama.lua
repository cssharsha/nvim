local M = {}

M.opts = {
    provider = "gemini",
    behaviour = {
        auto_suggestions = false, -- Experimental stage
        auto_set_highlight_group = true,
        auto_set_keymaps = true,
        auto_apply_diff_after_generation = false,
        support_paste_from_clipboard = false,
    },
    gemini = {
        -- @see https://ai.google.dev/gemini-api/docs/models/gemini
        -- model = "gemini-2.5-pro-exp-03-25",
        model = "gemini-2.5-pro-preview-03-25",
        -- model = "gemini-1.5-flash",
        temperature = 0,
        max_tokens = 4096,
    },
    mcp = {                  -- Some plugins group MCP options like this
        auto_approve = false -- Recommended: set to false for manual approval
    },
}

return M
