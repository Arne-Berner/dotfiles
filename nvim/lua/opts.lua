--[[ opts.lua ]]
local opt = vim.opt

-- [[ use bash to be faster ]]
opt.shell = "/bin/bash"

-- [[ Context ]]
opt.title = true
opt.showcmd = true
opt.history = 50
opt.colorcolumn = '80'           -- str:  Show col for max line length
-- except in rust
vim.api.nvim_create_autocmd('Filetype', { pattern = 'rust', command = 'set colorcolumn=100' })
opt.number = true                -- bool: Show line numbers
-- opt.relativenumber = true        -- bool: Show relative line numbers
opt.scrolloff = 4                -- int:  Min num lines of context
opt.signcolumn = "yes"           -- str:  Show the sign column

-- jump to last edit position on opening file
vim.api.nvim_create_autocmd(
	'BufReadPost',
	{
		pattern = '*',
		callback = function(ev)
			if vim.fn.line("'\"") > 1 and vim.fn.line("'\"") <= vim.fn.line("$") then
				-- except for in git commit messages
				-- https://stackoverflow.com/questions/31449496/vim-ignore-specifc-file-in-autocommand
				if not vim.fn.expand('%:p'):find('.git', 1, true) then
					vim.cmd('exe "normal! g\'\\""')
				end
			end
		end
	}
)

-- [[ Filetypes ]]
opt.encoding = 'utf8'            -- str:  String encoding to use
opt.fileencoding = 'utf8'        -- str:  File encoding to use

-- [[ Undo ]]
-- ends up in ~/.local/state/nvim/undo/
vim.opt.undofile = true

-- [[ Theme ]]
opt.syntax = "ON"                -- str:  Allow syntax highlighting
opt.termguicolors = true         -- bool: If term supports ui color then enable

-- [[ Search ]]
opt.ignorecase = true            -- bool: Ignore case in search patterns
opt.smartcase = true             -- bool: Override ignorecase if search contains capitals
opt.incsearch = true             -- bool: Use incremental search
opt.hlsearch = false             -- bool: Highlight search matches

-- [[ Whitespace ]]
opt.expandtab = true             -- bool: Use spaces instead of tabs
opt.shiftwidth = 4               -- num:  Size of an indent
opt.softtabstop = 4              -- num:  Number of spaces tabs count for in insert mode
opt.tabstop = 4                  -- num:  Number of spaces tabs count for
vim.cmd([[
  augroup LuaSettings
    autocmd!
    autocmd FileType lua setlocal shiftwidth=2 softtabstop=2 tabstop=2 
  augroup END
]])
-- vim.api.nvim_create_autocmd('Filetype', { pattern = 'lua', command = 'set shiftwidth = 2' })
-- vim.api.nvim_create_autocmd('Filetype', { pattern = 'lua', command = 'set softtabstop = 2' })
-- vim.api.nvim_create_autocmd('Filetype', { pattern = 'lua', command = 'set tabstop = 2' })
-- [[ wgsl ]]
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.wgsl",
  callback = function()
    vim.bo.filetype = "wgsl"
  end,
})

-- [[ Splits ]]
opt.splitright = true            -- bool: Place new window to right of current one
opt.splitbelow = true            -- bool: Place new window below the current one
opt.autoindent = true


-- terminal
vim.opt.shell = '/bin/fish'
