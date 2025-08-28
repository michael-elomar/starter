local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "prettier" },
    html = { "prettier" },
    cpp = { "clang_format" },
    c = { "clang_format" },
    c_cpp = { "clang-format" }, -- hack to install the package
    python = { "black" },
  },

  formatters = {
    clang_format = {
      command = "/usr/bin/clang-format-11",
      prepend_args = { "--style=file", "--fallback-style=none" },
    },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options
