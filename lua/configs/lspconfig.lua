require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls", "pyright", "clangd", "cmake" }
vim.lsp.enable(servers)

-- special case for clangd: add custom flags
vim.lsp.config.clangd = {
  cmd = {
    "clangd",
    "--header-insertion=never",
  },
}

vim.lsp.set_log_level "trace"

-- read :h vim.lsp.config for changing options of lsp servers
