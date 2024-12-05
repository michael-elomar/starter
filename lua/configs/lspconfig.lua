require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls", "clangd", "pyright", "cmake" }
vim.lsp.enable(servers)
local lspconfig = require "lspconfig"

-- EXAMPLE
local nvlsp = require "nvchad.configs.lspconfig"

-- read :h vim.lsp.config for changing options of lsp servers


for _, lsp in ipairs(servers) do
   local opts = {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }

  -- Special case for clangd
  if lsp == "clangd" then
    opts.cmd = { "clangd", "--header-insertion=never" }
  end
  lspconfig[lsp].setup(opts)
end
