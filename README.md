# Those are my config files, so that I have a faster setup.
Do not run this in sudo .. for whatever reason you'd want to do that.


## TODO
- alias rm to mv to tmp

### format code
https://stackoverflow.com/questions/77147995/setting-up-formatters-in-neovim-with-mason-lsp-zero

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
sdkmanager --install "platforms;android-34" "emulator" "build-tools;34.0.0" "ndk;27.0.12077973" "platform-tools"
```
Whereas ndk just needs to be the newest version, since it is backward compatible. But platforms and build tools need to match your android version.

