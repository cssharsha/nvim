local M = {}

M.opts = {
    adapters = {
        -- Main coding model
        ollama_coder = function()
            return require("codecompanion.adapters").extend("ollama", {
                name = "ollama_coder",
                env = {
                    url = "http://192.168.50.133:11336"
                },
                schema = {
                    model = {
                        default = "qwen2.5-coder:14b"
                    },
                    num_ctx = {
                        default = 8192
                    },
                    num_predict = {
                        default = -1
                    },
                    temperature = {
                        default = 0.1
                    },
                    top_p = {
                        default = 0.9
                    },
                    top_k = {
                        default = 40
                    }
                }
            })
        end,
        -- General chat model (lighter)
        ollama_chat = function()
            return require("codecompanion.adapters").extend("ollama", {
                name = "ollama_chat",
                env = {
                    url = "http://192.168.50.133:11336"
                },
                schema = {
                    model = {
                        default = "qwen2.5-coder:14b"
                    },
                    num_ctx = {
                        default = 4096
                    },
                    num_predict = {
                        default = -1
                    },
                    temperature = {
                        default = 0.3
                    }
                }
            })
        end,
        -- Default ollama adapter
        ollama = function()
            return require("codecompanion.adapters").extend("ollama", {
                env = {
                    url = "http://192.168.50.133:11336"
                },
                schema = {
                    model = {
                        default = "qwen2.5-coder:14b"
                    },
                    num_ctx = {
                        default = 8192
                    },
                    num_predict = {
                        default = -1
                    },
                    temperature = {
                        default = 0.1
                    }
                }
            })
        end
    },
    strategies = {
        chat = {
            adapter = "ollama_chat",
        },
        inline = {
            adapter = "ollama_coder",
        },
        agent = {
            adapter = "ollama_coder",
        }
    },
    opts = {
        log_level = "DEBUG",
    },
}

return M