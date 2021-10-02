#!/usr/bin/env bash
# Setup script for setting up a new macos machine
# Credit to Daria Sova at Mac O'Clock for the template (https://medium.com/macoclock/automating-your-macos-setup-with-homebrew-and-cask-e2a103b51af1)
echo "Running MacOS setup script..."

# Install xcode CLI
echo "Installing xcode CLI tools..."
xcode-select —-install

# Install homebrew if missing
echo "Checking if homebrew is installed..."
if test ! $(which brew); then
    echo "Installing homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Update homebrew recipes
echo "Updating brew recipes..."
brew update

# Install homebrew packages
BREW_PACKAGES=(
    git
    tmux
    flac
    ffmpeg
    exiftool
    gdb
    mac-cleanup
    nmap
    opus
    putty
    python@3.9
    x264
    x265
    youtube-dl
    zsh-syntax-highlighting
)

echo "Installing homebrew packages... (may take a while)."
echo "Packages: ${BREW_PACKAGES[@]}"
brew install ${BREW_PACKAGES[@]}

# Install homebrew casks
BREW_CASKS=(
    alfred
    iterm2
    spotify
    onedrive
    hookshot
    alt-tab
    visual-studio-code
    steam
    istat-menus
    discord
    google-chrome
    microsoft-remote-desktop
    microsoft-teams
    cryptomator
    coteditor
    atom
    obs
    obs-virtual-cam
    mullvadvpn
    lunar
    imageoptim
    audacity
    vlc
)
echo "Installing homebrew casks... (may take a while)."
echo "Casks: ${BREW_CASKS[@]}"
brew install --cask ${BREW_CASKS[@]}

echo "Starting OS configuration..."

echo "Showing filename extensions by default..."
defaults write NSGlobalDomain AppleShowAllExtensions -bool true;killall Finder

echo "Enabling tap-to-click..."
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

echo "Requiring password as soon as screensaver or sleep starts..."
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

echo "Enabling CTRL + CMD window dragging..."
defaults write -g NSWindowShouldDragOnGesture yes

echo "Enabling dock autohide..."
defaults write com.apple.dock autohide -bool true && \
killall Dock

echo "Disabling dock autohide delay..."
defaults write com.apple.dock autohide-delay -float 0;killall Dock

echo "Preventing Photos from automatically opening when connecting an iPhone or iPad..."
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

echo "Automatically expanding the save panel by default..."
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

echo "Making TextEdit create an untitled document at launch..."
defaults write com.apple.TextEdit NSShowAppCentricOpenPanelInsteadOfUntitledFile -bool false

echo "Showing path bar in Finder..."
defaults write com.apple.finder ShowPathbar -bool true

echo "Setting current folder to default search scope in Finder..."
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

echo "Stopping the power button from putting the Mac in stand-by..."
defaults write com.apple.loginwindow PowerButtonSleepsSystem -bool no

# Finished.
echo "Done! \nExiting..."