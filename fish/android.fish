if status is-interactive
  fish_add_path ~/Android/build-tools/35.0.0
  fish_add_path ~/Android/platform-tools
  fish_add_path ~/Android/emulator
  fish_add_path ~/Android/cmdline-tools/latest/bin
  set -gx ANDROID_HOME ~/Android
  set -gx ANDROID_NDK_ROOT ~/Android/ndk/29.0.13113456
end
