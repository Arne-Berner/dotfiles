# Those are my config files, so that I have a faster setup.
Do not run this in sudo .. for whatever reason you'd want to do that.


## TODO
- alias rm to mv to tmp
- turn the android studio instructions into a bash file (and make it opt in)
- create a minimal setup (only nvim and some normal utilities: fzf, python3, fish, tmux, lua, git)
- make rust an opt in
- make esp config an opt in
- make typst config an opt in
- make wgsl config an opt in
- make android config an opt in

### format code
https://stackoverflow.com/questions/77147995/setting-up-formatters-in-neovim-with-mason-lsp-zero

## Kanata
In order to use kanata, you need to clone arne-berner/my-kanata into dotfiles root (here). 

## Everything git related
### Commits
```bash
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

The commit type subject line should be all lowercase with a character limit of 40 to encourage succinct descriptions.

The optional commit body should be used to provide further detail that cannot fit within the character limitations of the subject line description. 
It is also a good location to utilize BREAKING CHANGE: <description> to note the reason for a breaking change within the commit.

The footer is also optional. We use the footer to link the github project story that would be closed with these changes for example: Closes GITHUB TICKET #123 .

The commit type can include the following:

feat – a new feature is introduced with the changes  
fix – a bug fix has occurred  
chore – changes that do not relate to a fix or feature and don't modify src or test files (for example updating dependencies)  
refactor – refactored code that neither fixes a bug nor adds a feature  
docs – updates to documentation such as a the README or other markdown files  
style – changes that do not affect the meaning of the code, likely related to code formatting such as white-space, missing semi-colons, and so on.  
test – including new or correcting previous tests  
perf – performance improvements  
ci – continuous integration related  
build – changes that affect the build system or external dependencies  
revert – reverts a previous commit  

Example:
```bash

fix: fix foo to enable bar

This fixes the broken behavior of the component by doing xyz. 

BREAKING CHANGE
Before this fix foo wasn't enabled at all, behavior changes from <old> to <new>

Closes D2IQ-12345
```

All commits should clearly be one of the types above. If you feel like your changes where more than one category, try to break up the changes into smaller commits with 
```
git add <FILENAME>
git commit
```

### Issues
If you find any bugs or features, or you want to clean up the project as a whole then you should create an issue for that. This has the advantage of creating a branch automatically with the right naming scheme.

Try to fix the issue yourself most of the time and ask the person that could be related to a bug/cleanup for the review.

As of now the Issues are created in german. Please add a description that will still make sense to you in a month from now.

### Pullrequests & Reviews
If you are done with your issue, please create a pull request. Here are the golden rules for pull requests and reviews:
1. If you create a pull request, check for other pull requests and review any open pull requests.
2. Reviewing a pull requests means at least trying the feature on your machine once. Ask yourself: Does this PR solve the issue?

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
