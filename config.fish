if status is-interactive 
and not set -q TMUX
  nohup kanata --cfg ~/dotfiles/kanata.kbd &
  tmux -2 new-session -A -s main
  # Adapted from https://unix.stackexchange.com/a/176885/347104
  # Create session 'main' or attach to 'main' if already exists.
end

if status is-interactive
  fish_add_path /opt/nvim/
  fish_add_path ~/.local/bin/
  fish_add_path ~/Shellscript/
  fish_add_path ~/Typst/
  fzf_key_bindings
  fish_vi_key_bindings
  alias vi "nvim"
  alias tree 'tree -I "target/"'
  export SHELL="/bin/fish"

  # for esp dev with rust
  fish_add_path /home/arne/.rustup/toolchains/esp/xtensa-esp-elf/esp-13.2.0_20230928/xtensa-esp-elf/bin
  export LIBCLANG_PATH="/home/arne/.rustup/toolchains/esp/xtensa-esp32-elf-clang/esp-16.0.4-20231113/esp-clang/lib"
  # for android dev
  fish_add_path ~/AndroidSdk/build-tools/34.0.0
  fish_add_path ~/AndroidSdk/platform-tools
  fish_add_path ~/AndroidSdk/emulator
  fish_add_path ~/AndroidSdk/cmdline-tools/latest/bin
  set -gx ANDROID_HOME ~/AndroidSdk
  set -gx ANDROID_NDK_ROOT ~/AndroidSdk/ndk/27.0.12077973
end
