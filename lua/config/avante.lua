local M = {}

M.opts = {
	-- add any opts here
	-- this file can contain specific instructions for your project
	-- instructions_file = "avante.md",
	-- for example
	provider = "ollama",
	providers = {
		claude = {
			endpoint = "https://api.anthropic.com",
			model = "claude-sonnet-4-20250514",
			timeout = 30000, -- Timeout in milliseconds
			extra_request_body = {
				temperature = 0.75,
				max_tokens = 20480,
			},
		},
		openai = {
			endpoint = "https://api.openai.com/v1",
			model = "gpt-4o", -- your desired model (or use gpt-4o, etc.)
			timeout = 30000, -- Timeout in milliseconds, increase this for reasoning models
			extra_request_body = {
				temperature = 0,
				max_completion_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
				reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
			},
		},
		ollama = {
			endpoint = "http://127.0.0.1:11434",
			model = "qwen2.5-coder:14b",
			timeout = 30000, -- Timeout in milliseconds
			extra_request_body = {
				options = {
					temperature = 0.75,
					num_ctx = 20480,
					keep_alive = "5m",
				},
			},
			is_env_set = function()
				return true
			end,
		},
	},
	behaviour = {
		auto_suggestions = false, -- Experimental stage
		auto_set_highlight_group = true,
		auto_set_keymaps = true,
		auto_apply_diff_after_generation = false,
		support_paste_from_clipboard = false,
		minimize_diff = true, -- Whether to remove unchanged lines when applying a code block
		enable_token_counting = true, -- Whether to enable token counting. Default to true.
		auto_approve_tool_permissions = false, -- Default: show permission prompts for all tools
		-- Examples:
		-- auto_approve_tool_permissions = true,                -- Auto-approve all tools (no prompts)
		-- auto_approve_tool_permissions = {"bash", "replace_in_file"}, -- Auto-approve specific tools only
	},
	-- Maybe enable it later
	-- dual_boost = {
	-- 	enabled = false,
	-- 	first_provider = "claude",
	-- 	second_provider = "ollama",
	-- 	prompt = "Based on the two reference outputs below, generate a response that incorporates elements from both but reflects your own judgment and unique perspective. Do not provide any explanation, just give the response directly. Reference Output 1: [{{provider1_output}}], Reference Output 2: [{{provider2_output}}]",
	-- 	timeout = 60000, -- Timeout in milliseconds
	-- },
}

return M
