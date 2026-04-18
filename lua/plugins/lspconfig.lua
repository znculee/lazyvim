local has_ty = vim.fn.executable("ty") == 1

local servers = {
  pyright = {
    -- https://github.com/neovim/nvim-lspconfig/issues/726#issuecomment-1700845901
    capabilities = {
      textDocument = {
        publishDiagnostics = {
          tagSupport = {
            valueSet = { 2 },
          },
        },
      },
    },
    settings = {
      python = {
        analysis = {
          typeCheckingMode = "off",
        },
      },
    },
  },
}

if has_ty then
  servers.ty = {}
end

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        virtual_text = false,
      },
      servers = servers,
    },
  },
}
