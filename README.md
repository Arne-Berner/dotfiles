# Those are my config files, so that I have a faster setup.
Do not run this in sudo .. for whatever reason you'd want to do that.


## TODO
- alias rm to mv to tmp
- turn the android studio instructions into a bash file
- add typst to setup

### format code
https://stackoverflow.com/questions/77147995/setting-up-formatters-in-neovim-with-mason-lsp-zero

## Kanata
In order to use kanata, you need to clone arne-berner/my-kanata into dotfiles root (here).

## Android Studio
### Installing cmdline-tools
- create AndroidSdk directory
- [Download cli tools](https://developer.android.com/studio)
- unzip it into AndroidSdk
- in unzipped cmdline-tools create a folder: latest
- move content of cmdline-tools into latest

### Installing other packages
In most cases you need to install the emulator/platform tools/ndk via the sdkmanager. 
```cmd
sdkmanager --list | grep <NAME YOU ARE LOOKING FOR
```
You most likely will need to install
```cmd
sdkmanager emulator
sdkmanager --install "platforms;android-34" "emulator" "build-tools;34.0.0" "ndk;27.0.12077973" "platform-tools" "system-images;android-34;google_atd;x86_64"
```
Whereas ndk just needs to be the newest version, since it is backward compatible. But platforms and build tools need to match your android version. system-images will be the emulator version and should probably also match the android version you are looking for. After that you need to agree to the licenses with:
```cmd
sdkmanager --licenses
```

### emulator
Create an android virtual device (AVD)
```cmd
avdmanager create avd -n Android34 -k "system-images;android-34;google_apis;x86_64"
```
Where Android34 is the name of the avd.
[more infos here](https://developer.android.com/tools/avdmanager)
then run it via:
```cmd
emulator -avd Android34
```
