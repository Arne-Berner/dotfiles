" Title:        Paste Plugin
" Description:  A Plugin to Paste your images into md and typst files with the correct formatting
" Last Change:  13.9.2024
" Maintainer:   Arne Berner
" A long way to create a custom Plugin

" Prevents the plugin from being loaded multiple times. If the loaded
" variable exists, do nothing more. Otherwise, assign the loaded
" variable and continue running this instance of the plugin.
if exists("g:loaded_pasteplugin")
    finish
endif
let g:loaded_pasteplugin = 1


" Exposes the plugin's functions for use as commands in Neovim.
command! -nargs=1 MarkdownPaste lua require("paste-plugin").insert_md('<args>')
command! -nargs=1 TypstPaste lua require("paste-plugin").insert_typst('<args>')

