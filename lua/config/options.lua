-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- Läs in den snabba temp-katalogen från Fish shell-miljön
local tmp_dir = os.getenv("NVIM_TMP_DIR")

-- Kontrollera om variabeln är satt, annars använd standardplatsen
local cache_dir = vim.fn.stdpath("cache")
local base_dir = tmp_dir and (tmp_dir .. "/") or (cache_dir .. "/")

-- 1. Swap-filer (directory): Använd /tmp (RAM) för hastighet
vim.opt.directory = base_dir .. "swp//"

-- 2. Undo-historik (undodir): Använd /tmp (RAM) för hastighet
vim.opt.undodir = base_dir .. "undo//"

-- 3. Backup-filer (backupdir): Sätt den till /tmp också
vim.opt.backupdir = base_dir .. "bak//"

-- 4. Session/shada-historik
-- VIKTIGT: Shada (historiken) bör INTE vara på /tmp, eftersom den försvinner vid omstart.
-- Vi låter den ligga kvar på standardplatsen:
-- vim.opt.shadafile = cache_dir .. "/shada" -- (LazyVim hanterar detta)
