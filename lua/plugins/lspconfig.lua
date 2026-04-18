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
  -- When ty is active, disable overlapping capabilities on pyright
  -- so symbols, hover, definitions, etc. come from ty instead.
  servers.pyright.on_attach = function(client, _)
    client.server_capabilities.hoverProvider = false
    client.server_capabilities.documentSymbolProvider = false
    client.server_capabilities.definitionProvider = false
    client.server_capabilities.referencesProvider = false
  end
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
