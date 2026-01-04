function start_kanata_process
    if pgrep -f kanata > /dev/null

    else
        nohup kanata --cfg ~/dotfiles/my-kanata/kanata.kbd &
    end
end

if status is-interactive
  start_kanata_process
end
