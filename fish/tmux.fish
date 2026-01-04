if status is-interactive 
and not set -q TMUX
  tmux -2 new-session -A -s main
  # Adapted from https://unix.stackexchange.com/a/176885/347104
  # Create session 'main' or attach to 'main' if already exists.
end
