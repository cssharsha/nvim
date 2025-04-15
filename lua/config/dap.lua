-- ~/.config/nvim/lua/config/dap.lua
local dap = require("dap")
local dapui = require("dapui")
local dap_python = require("dap-python")
local mason_dap = require("mason-nvim-dap")
local map = vim.keymap.set

-- Ensure debuggers are installed via Mason
mason_dap.setup({
    ensure_installed = { "cppdbg", "debugpy" }, -- C++ (via cpptools) and Python
    handlers = {},                            -- Keep empty, setup handled below or manually
})

-- C/C++ Debugger Configuration (cppdbg requires VS Code C++ extension files)
-- You might need to manually point to the adapter if mason install fails,
-- or use alternatives like codelldb installed via Mason.
dap.adapters.cppdbg = {
    id = "cppdbg",
    type = "executable",
    command = vim.fn.stdpath("data") .. "/mason/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7", -- Adjust path if necessary
}
dap.configurations.cpp = {
    {
        name = "Launch file",
        type = "cppdbg",
        request = "launch",
        program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopAtEntry = false,
        setupCommands = { -- Optional: Example for GDB pretty printing
            {
                text = "-enable-pretty-printing",
                description = "enable pretty printing",
                ignoreFailures = true
            },
        },
    },
    {
        name = "Attach to gdbserver :1234", -- Example attach config
        type = "cppdbg",
        request = "launch",
        MIMode = "gdb",
        miDebuggerServerAddress = "localhost:1234",
        miDebuggerPath = "/usr/bin/gdb", -- Ensure gdb is installed
        cwd = "${workspaceFolder}",
        program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
    },
}
dap.configurations.c = dap.configurations.cpp -- Use same config for C

-- Python Debugger Configuration (using nvim-dap-python)
dap_python.setup(vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python") -- Path to debugpy python executable
-- dap_python.load_launchjs() -- Load configurations from launch.json if present

-- DAP UI Configuration
dapui.setup({
    layouts = {
        {
            elements = {
                { id = "scopes",      size = 0.25 },
                { id = "breakpoints", size = 0.25 },
                { id = "stacks",      size = 0.25 },
                { id = "watches",     size = 0.25 },
            },
            size = 40,
            position = "left",
        },
        {
            elements = {
                { id = "repl",    size = 0.5 },
                { id = "console", size = 0.5 },
            },
            size = 10,
            position = "bottom",
        },
    },
    floating = {
        max_height = nil, -- Use default
        max_width = nil, -- Use default
        border = "rounded",
        mappings = {
            close = { "q", "<Esc>" },
        },
    },
    windows = { indent = 1 },
    render = {
        max_type_length = nil, -- Use default
    },
})

-- Auto open/close DAP UI
dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end

-- Debugger Keymaps (using <leader>d prefix)
map("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
map("n", "<leader>dB", function() dap.set_breakpoint(vim.fn.input("Breakpoint condition: ")) end,
    { desc = "Conditional Breakpoint" })
map("n", "<leader>dl", function() dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: ")) end,
    { desc = "Log Point" })
map("n", "<leader>dc", dap.continue, { desc = "Continue" })
map("n", "<leader>do", dap.step_over, { desc = "Step Over" })
map("n", "<leader>di", dap.step_into, { desc = "Step Into" })
map("n", "<leader>du", dap.step_out, { desc = "Step Out" })
map("n", "<leader>dr", dap.repl.open, { desc = "Open REPL" })
map("n", "<leader>dK", function() dap.up() end, { desc = "Frame Up" })                                      -- Mnemonic: K for up
map("n", "<leader>dJ", function() dap.down() end, { desc = "Frame Down" })                                  -- Mnemonic: J for down
map("n", "<leader>dt", dap.terminate, { desc = "Terminate Debug Session" })
map({ "n", "v" }, "<leader>dh", function() require("dapui").eval() end, { desc = "Hover Variables (DAP)" }) -- Hover/Evaluate

print("DAP config loaded")
