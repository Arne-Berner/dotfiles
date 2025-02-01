--[[ keys.lua ]]
local map = vim.api.nvim_set_keymap
local set = vim.keymap.set
-- map.noremap = true
-- nnoremap etc, ist nicht recursive
-- das heißt, wenn ich a zu z zuweise
-- und b zu a. dann würde b zu z werden mit rekursion
-- set ist default nicht rekursiv

-- jeweils rekursiv:
-- n, i, v, x
-- set('mode', 'wird gedrückt', 'kommt raus')
-- vim.opt.relativenumber = true        -- bool: Show relative line numbers


-- [[ Normal Mode ]]
-- make current file to current directory
set('n', '<space>cd', "<CMD>lcd %:h<CR>")

-- search and replace
set('n', '<C-f>', ':%s/')

-- center search results
vim.keymap.set('n', 'n', 'nzz', { silent = true })
vim.keymap.set('n', 'N', 'Nzz', { silent = true })
vim.keymap.set('n', '*', '*zz', { silent = true })
vim.keymap.set('n', '#', '#zz', { silent = true })
vim.keymap.set('n', 'g*', 'g*zz', { silent = true })

-- make j and k move by visual line, not actual line, when text is soft-wrapped
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')

-- "very magic" (less escaping needed) regexes by default
vim.keymap.set('n', '?', '?\\v')
vim.keymap.set('n', '/', '/\\v')
vim.keymap.set('c', '%s/', '%sm/')

-- toggles between buffers
set('n', '<Tab>', '<C-^>')


-- [[ Insert Mode ]]
-- mit Ctrl-V Dinge einfügen
set('i', '<C-v>', '<Esc>:set paste<CR>"+p:set nopaste<CR>a')
set('i', 'jj', '<esc>')


-- [[ Virtual Mode ]]
-- ctrl c für copy
set('v', '<C-c>', '"+y')


-- [[ Plugins ]]
--
-- telescope
local builtin = require('telescope.builtin')
-- uses git_files, if available
local function toggle_git_or_find()
    local success, result = pcall(builtin.git_files)
    if not success then
        result = builtin.find_files()
    end
    return result
end

-- Now you can set the keybinding to call this function
set('n', '<C-T>', toggle_git_or_find, {})
set('n', '<C-Z>', builtin.buffers, {})
set('n', '<C-Q>', builtin.help_tags, {})

-- Oil
set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })


-- keys that are available
-- ctrl e (context actions)
-- ctrl m
-- 
--
-- Merken: ctrl d und ctrl u sind runter und hoch ne halbe seite
-- ansonsten {} benutzen
--
-- Bacon
set("n", "!", ":BaconLoad<CR>:w<CR>:BaconNext<CR>", { desc = "Navigate to next bacon location" })
set("n", ",", ":BaconList<CR>", { desc = "Open bacon locations list" })
