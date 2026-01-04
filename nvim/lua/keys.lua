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
set('n', '<space>cd', "<CMD>tcd %:h<CR>")

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


-- [[ Terminal Mode ]]
set('t', '<c-w><c-w>', '<C-\\><C-n><C-w>w')
set('t', '<c-w><c-q>', '<C-\\><C-n><C-q>q')
set('t', '<c-w><c-c>', '<C-\\><C-n><C-c>c')
set('t', '<c-w><c-e>', '<C-\\><C-n>')
set('n', '<c-w><c-e>', ':terminal<CR>')
set('t', '<c-w>w', '<C-\\><C-n><C-w>w')
set('t', '<c-w>q', '<C-\\><C-n><C-q>q')
set('t', '<c-w>c', '<C-\\><C-n><C-c>c')
set('t', '<c-w>e', '<C-\\><C-n>')
set('n', '<c-w>e', ':terminal<CR>')
set('t', '<c-w><tab>', '<C-\\><C-n>g<tab>')

-- [[ Plugins ]]
