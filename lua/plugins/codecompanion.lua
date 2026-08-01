local function ollama_adapter(opts)
  return require("codecompanion.adapters").extend(
    "ollama",
    vim.tbl_deep_extend("force", {
      env = { url = "http://127.0.0.1:11434" },
      schema = { model = { default = os.getenv("CODECOMPANION_OLLAMA_MODEL") } },
    }, opts or {})
  )
end

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
        adapter = "ollama",
        roles = {
          -- Show just the model name in the chat heading.
          llm = function(adapter)
            return adapter.model and adapter.model.name or adapter.formatted_name
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
      },
      inline = {
        adapter = "ollama_nothink",
      },
      cmd = {
        adapter = "ollama_nothink",
      },
    },
    adapters = {
      http = {
        ollama = function()
          return ollama_adapter()
        end,
        -- Inline and cmd discard reasoning output, so don't pay to generate it.
        ollama_nothink = function()
          return ollama_adapter({
            name = "ollama_nothink",
            schema = { think = { default = false } },
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
