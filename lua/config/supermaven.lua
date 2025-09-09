local M = {}

M.setup = function()
    require("supermaven-nvim").setup({
        keymaps = {
            accept_suggestion = "<S-Tab>",
            clear_suggestion = "<C-]>",
            accept_word = "<C-Tab>",
        },
        ignore_filetypes = {},
        color = {
            suggestion_color = "#ffffff",
            cterm = 244,
        },
        log_level = "info",
        disable_inline_completion = false,
        disable_keymaps = false,
        condition = function()
            return true
        end,
    })

    -- Additional keymaps for Supermaven
    local map = vim.keymap.set
    local opts = { noremap = true, silent = true }
    
    -- Toggle Supermaven
    map("n", "<leader>st", function()
        require("supermaven-nvim.api").toggle()
    end, { desc = "Toggle Supermaven" })
    
    -- Start Supermaven
    map("n", "<leader>ss", function()
        require("supermaven-nvim.api").start()
    end, { desc = "Start Supermaven" })
    
    -- Stop Supermaven
    map("n", "<leader>sx", function()
        require("supermaven-nvim.api").stop()
    end, { desc = "Stop Supermaven" })
    
    -- Restart Supermaven
    map("n", "<leader>sr", function()
        require("supermaven-nvim.api").restart()
    end, { desc = "Restart Supermaven" })
end

M.setup()

return M
