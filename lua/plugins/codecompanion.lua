return {
  "olimorris/codecompanion.nvim",
  event = "VeryLazy",
  dependencies = {
    { "nvim-lua/plenary.nvim" },
    { "nvim-treesitter/nvim-treesitter" },
    {
      "j-hui/fidget.nvim",
      opts = {
        notification = {
          window = {
            winblend = 0, -- https://github.com/j-hui/fidget.nvim/issues/11
          },
        },
      },
    },
  },
  init = function()
    require("plugins.codecompanion.fidget-spinner"):init()
  end,
  opts = {
    interactions = {
      chat = {
        adapter = "omlx",
        roles = {
          -- Show just the model name in the chat heading.
          llm = function(adapter)
            local model = adapter.model and adapter.model.name
            if not model then
              local default = adapter.schema and adapter.schema.model and adapter.schema.model.default
              model = type(default) == "function" and adapter.formatted_name or default
            end
            return tostring(model or adapter.formatted_name)
          end,
        },
        slash_commands = {
          ["file"] = {
            callback = "interactions.chat.slash_commands.builtin.file",
            description = "Select a file using Telescope",
            opts = {
              provider = "fzf_lua",
              contains_code = true,
            },
          },
        },
        opts = {
          system_prompt = "",
        },
      },
      inline = {
        adapter = "omlx",
      },
      cmd = {
        adapter = "omlx",
      },
    },
    adapters = {
      http = {
        omlx = function()
          return require("codecompanion.adapters").extend("openai_compatible", {
            name = "omlx",
            env = {
              url = "http://127.0.0.1:8000",
              api_key = "OMLX_API_KEY",
            },
            handlers = {
              -- omlx streams reasoning tokens in a separate `reasoning_content`
              -- delta field (DeepSeek-style). The base openai_compatible adapter
              -- only reads `content`, so surface the reasoning here or it's dropped.
              parse_message_meta = function(self, data)
                local extra = data.extra
                if extra and extra.reasoning_content then
                  data.output.reasoning = { content = extra.reasoning_content }
                  if data.output.content == "" then
                    data.output.content = nil
                  end
                end
                return data
              end,
            },
            schema = {
              model = {
                default = os.getenv("CODECOMPANION_OMLX_MODEL"),
              },
            },
          })
        end,
      },
    },
  },
  keys = {
    { "<leader>a", "", desc = "+ai", mode = { "n", "v" } },
    { "<leader>an", "<cmd>CodeCompanionChat<cr>", mode = { "n", "v" }, desc = "New Chat" },
    { "<leader>aa", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, desc = "Toggle Chat" },
    { "<leader>ac", "<cmd>CodeCompanionChat Add<cr>", mode = "v", desc = "Add Code to Chat" },
    { "<leader>ai", "<cmd>CodeCompanion<cr>", mode = { "n", "v" }, desc = "Inline Prompt" },
  },
}
