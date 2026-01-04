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
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "javascript", "typescript", "lua", "html" },
  callback = function()
    vim.bo.tabstop = 2
    vim.bo.softtabstop = 2
    vim.bo.shiftwidth = 2
    vim.bo.expandtab = true
  end,
  desc = "Set tabstop options for specific languages",
})

-- [[closing reference and such after open]]
vim.api.nvim_create_autocmd("WinLeave", {
  pattern = "*",  -- Match all windows
  callback = function()
    if vim.bo.filetype == "qf" then
      vim.cmd("q")
    end
  end,
  desc = "Close quickfix window when leaving it",
})

-- [[ Splits ]]
opt.splitright = true            -- bool: Place new window to right of current one
opt.splitbelow = true            -- bool: Place new window below the current one
opt.autoindent = true


-- terminal
vim.opt.shell = '/bin/fish'
