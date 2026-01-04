function gdiff
    git difftool $argv
end

function gmerge
    git mergetool $argv
end

function acp
    git add . && git commit -m $argv && git push
end

function ac
    git add . && git commit -m $argv
end

function gs
    git status
end
