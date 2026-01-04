# Merken: 
## lsp
grn rename
gra code_action
grr references
gri implementation
grt type_definition (klappt nicht für macros)
gO  document_symbol (quasi eine übersicht der file)
c-s in insert, hilft es dir die signature zu füllen

selbst geadded:
grd definition() (nützlich für rust, klappt auch mit macros)  -- das selbe wie grD
grD declaration()

<C-w>d diagnostic at cursor (error)
:lua vim.diagnostic.setqflist()

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
### Regex
sdlfkj fuzzy match
'math  exact
'math' exact boundary (word that include math at word boundaries)
^math  math first
.mp3$  end with .mp3
!fire  everything without fire
!^fire everything not starting with fire
!fire$ everything not ending with fire

^core go$ | rb$ | py$
core at beginning, ending with go, or rb, or py

## cursor
[[ next section (nächste function meistens)
[/ zum nächsten comment
[d next diagnostic 
]d ist backward
[D first diagnostic

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
O-w,v split vertically
c-w,w next window (FAST!!)
c-w,= alle windows gleich, bis auf current
c-w,_ resize window to number

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


## regex
gn -> count
gc -> confirm
i -> ignore case
I -> don't ignore

^beginning
end$
. = single char

* greedy match preceding character 0 or more times
/abc* match 'ab' or 'abc' or 'abccc' or 'abcccccc' etc

\+ greedy match preceding character 1 or more times
/abc\+ match 'abc' or 'abccc' but not 'ab'

\? match preceding character 0 or 1 times (\= can also be used)
/abc\? match 'ab' or 'abc' but not 'abcc'

\{-} non-greedy match preceding character 0 or more times
Consider this line of text 'This is a sample text'
/h.\{-}s will match: 'his'
/h.*s will match: 'his is a s'

\{min,max} greedy match preceding character min to max times (including min and max)
min or max can be left unspecified as they default to 0 and infinity respectively
greedy match, tries to match as much as possible

\{-min,max} non-greedy match, tries to match as less as possible

\{number} match exactly with specified number
/c\{5} match exactly 'ccccc'

[abcde] match any of 'a' or 'b' or 'c' or 'd' or 'e' ONE time use [a-e] as shortform
[^abcde] match any character other than 'a' or 'b' or 'c' or 'd' or 'e' use [^a-e] as shortform
[aeiou] match vowel character
[^aeiou] match consonant character
\a matches alphabet character, short-cut for [a-zA-Z]
\A matches other than alphabet [^a-zA-Z]
\l matches lowercase alphabets [a-z]
\L matches other than lowercase alphabets [^a-z]
\u matches uppercase alphabets [A-Z]
\U matches other than uppercase alphabets [^A-Z]
\d matches digit character [0-9]
\D matches other than digit [^0-9]
\x matches hexademical character [0-9a-fA-F]
\X matches other than hexademical [^0-9a-fA-F]
\w matches any alphanumeric character or underscore [a-zA-Z0-9_]
\W match other than alphanumeric character or underscore [^a-zA-Z0-9_]
\s matches white-space characters space and tab
\S matches other than white-space characters
\t used in replacestring to insert a Tab character
\r used in replacestring to insert a newline character

(or works too)


## Rust
g:rust_cargo_check_all_targets~  (check runs tests und bench)
*/nvim/lazy/rust.vim/README.md
