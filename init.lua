vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "michael-elomar/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "autocmds"

vim.schedule(function()
  require "mappings"
end)

-- Function to strip trailing whitespace
local function strip_trailing_whitespaces()
  local view = vim.fn.winsaveview()
  vim.cmd [[%s/\s\+$//e]]
  vim.fn.winrestview(view)
end

-- Autocommand to call the function before writing a file
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = strip_trailing_whitespaces,
})

vim.opt.colorcolumn = "80,100"

vim.opt.tabstop = 4 -- visual width of tab
vim.opt.shiftwidth = 4 -- >> indents by 4
vim.opt.expandtab = false -- use real tabs, not spaces (set true if you prefer spaces)

-- Indentation behavior
vim.opt.autoindent = true -- copy indent from current line
vim.opt.smartindent = true -- smart auto indent for C-like syntax
vim.opt.cindent = true -- advanced C indentation
vim.opt.cinoptions = ":0,N-s" -- align 'case' with 'switch', don't over-indent namespace

vim.api.nvim_create_user_command("Format", function(args)
  local range = nil
  if args.count ~= -1 then
    local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
    range = {
      start = { args.line1, 0 },
      ["end"] = { args.line2, end_line:len() },
    }
  end
  require("configs.conform").format { async = true, lsp_format = "fallback", range = range }
end, { range = true })
