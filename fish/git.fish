function acp
    git add . && git commit -m $argv && git push
end

function ac
    git add . && git commit -m $argv
end

# Expand "gl" into "git log"
abbr -a gl 'git log'

# Examples you might also like:
abbr -a gs 'git status'
abbr -a gch 'git checkout'
abbr -a gpl 'git pull'
abbr -a gps 'git push'
abbr -a ga 'git add'
abbr -a gdiff 'git difftool'
abbr -a gmerge 'git mergetool'

