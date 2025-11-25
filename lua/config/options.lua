-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- Load the fast temp directory from Fish shell environment
local tmp_dir = os.getenv("NVIM_TMP_DIR")

-- Check if the variable is set, otherwise use the default location
local cache_dir = vim.fn.stdpath("cache")
local base_dir = tmp_dir and (tmp_dir .. "/") or (cache_dir .. "/")

-- 1. Swap files (directory): Use /tmp (RAM) for speed
vim.opt.directory = base_dir .. "swp//"

-- 2. Undo history (undodir): Use /tmp (RAM) for speed
vim.opt.undodir = base_dir .. "undo//"

-- 3. Backup files (backupdir): Set it to /tmp as well
vim.opt.backupdir = base_dir .. "bak//"

-- 4. Session/shada history
-- IMPORTANT: Shada (history) should NOT be on /tmp, as it disappears on restart.
-- We leave it in the default location:
-- vim.opt.shadafile = cache_dir .. "/shada" -- (LazyVim handles this)
