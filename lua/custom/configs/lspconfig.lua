local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require("lspconfig")

local servers = {"tsserver", "tailwindcss", "eslint"}

for _, lsp in ipairs(servers) do
  local server_config = {
    on_attach = on_attach,
    capabilities = capabilities,
  }

  if lsp == "tsserver" then
    server_config.init_options = {
      preferences = {
        disableSuggestions = true,
      }
    }
    server_config.commands = {
      OrganizeImports = {
        function()
          local params = {
            command = "_typescript.organizeImports",
            arguments = {vim.api.nvim_buf_get_name(0)},
          }
          vim.lsp.buf.execute_command(params)
        end,
        description = "Organize Imports",
      }
    }
  end

  lspconfig[lsp].setup(server_config)
end
