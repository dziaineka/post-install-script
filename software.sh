#!/usr/bin/env bash

PACKAGE_LIST=(
	vim
	tilix
	zsh
	fira-code-fonts
	lutris
	akmod-nvidia
	steam
	geary
	hydrapaper
	code
	gnome-extensions-app
	gnome-tweaks
)

FLATPAK_LIST=(
	com.spotify.Client
	info.febvre.Komikku
	org.glimpse_editor.Glimpse
	org.gnome.Podcasts
)

# add third party software

# vscode
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc --quiet
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'

# update repositories
sudo dnf check-update -yq

# iterate through packages and installs them if not already installed
for package_name in ${PACKAGE_LIST[@]}; do
	if ! sudo dnf list --installed | grep -q "^\<$package_name\>"; then
		echo "installing $package_name..."
		sleep .5
		sudo dnf install "$package_name" -yq
		echo "[INSTALLED] - $package_name"
	else
		echo "[INSTALLED] - $package_name"
	fi
done

for flatpak_name in ${FLATPAK_LIST[@]}; do
	if ! flatpak list | grep -q $flatpak_name; then
		echo "installing $flatpak_name..."
		sleep .5
		flatpak install "$flatpak_name" -y
		echo "[INSTALLED] - $flatpak_name"
	else
		echo "[INSTALLED] - $flatpak_name"
	fi
done
