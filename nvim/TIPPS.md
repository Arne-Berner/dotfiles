# Merken: 
## lsp keys
grn rename
gra code_action
grr references
gri implementation
grt type_definition (nutzlos für rust)
gO  document_symbol (quasi eine übersicht der file)
c-s in insert, hilft es dir die signature zu füllen

selbst geadded:
grd definition() (nützlich für rust, klappt auch mit macros) 
grD declaration()

## normal
ctrl-w i (c-w,c-i) -> geh auf die declaration in einem neuen window (sucht  einfach das wort unterm cursor...)
ctrl d runter ne halbe seite
ctrl u hoch ne halbe seite
ansonsten {} benutzen
gx          ist in einen link rein
:term       ruft einen Terminal auf (vielleicht auf windows switchen?
]p & [p     paste mit identation
gf          quasi go to filename
c-w T       move current window to new tab page
gt          go to next tab page
gT          go to prev tab page
g<tab>      last accessed tab
<space>cd   current directory für den tab

## OIL
also das tabsuch programm
gx      open file in program
g~      set tab cwd to this dir
c-p     preview

## Telescope
c-t h   kann die hilfe fzf (auch mit sowas wie hotkeys)
c-t t   git
c-t z   buffer
c-t g   ripgrep
c-t r   ripgrep
c-t gc  git commits mit diff bei select
c-t gs  git status 
c-t gb  git branches
c-x     go to file selected as split
c-v     go to file selected as vertical split
c-t     go to file selected as tab

## cursor
[[ next section (nächste function meistens)
[/ zum nächsten comment
[d next diagnostic 
]d ist backward
[D first diagnostic
<C-w>d diagnostic at cursor (error)

## Visual mode
a" kann alles (inklusive der ") in der " auswählen
(klappt auch mit klammern, wörtern, blöcken usw.
aB (die ganze function in {})
ap paragraph, sentence

## windows
(klappen alle auch mit c-X,c-X)
C-w,o close alle außer das (ctrl-w ctrl-o klappt auch)
C-w,c close current
c-w,p preview window
c-w,q quit current
c-w,r rotate window (:joy:)
c-w,s split
c-w,v split vertically
c-w,w next window (FAST!!)

## help
:help ...
:helpgrep ...
:filter word command
c-d autocompletions list
:map <key>
ctrl-w g } springt auf den tag in einem neuen window
ctrl-w } auch? also kürzer
CTRL-] ist wohl in help links
]b ist einen buffer zurück springen

## Terminal (oof)
:sus -> einmal kurz da hin gesprungen, wo man her kam.  (fg wieder zurück)
:sh -> new shell
c-\c-n sollte in normal mode gehen (habe es auf esc)


## register
:reg zeigt alle register


Here are the 10 Vim register types:

The unnamed register ("").
The numbered registers ("0-9).
The small delete register ("-).
The named registers ("a-z).
The read-only registers (":, ".,and "%).
The alternate file register ("#).
The expression register ("=).
The selection registers ("* and "+).
The black hole register ("_).
The last search pattern register ("/).
### insert
ctrl-r<register> pasted was auch immer da ist.
