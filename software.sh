#!/usr/bin/env bash

INSTALL_LIST=(
	zsh
	libreoffice-writer
	code
	kate
	htop
)

REMOVE_LIST=(
	kwrite
	kmail
	kamoso
	falkon
	mediawriter
	kolourpaint
	kmines
	kontact
	krusader
	konversation
	kmahjongg
	calligra-core
	ktorrent
	akregator
	dragon
	korganizer
	kget
	kaddressbook
	juk
	k3b
	kpat
)

FLATPAK_LIST=(
	com.spotify.Client
	org.mozilla.Thunderbird
	com.discordapp.Discord
)

# add vscode repository
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc --quiet
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'

sudo dnf check-update -yq

for package_name in ${REMOVE_LIST[@]}; do
	echo "removing $package_name..."
	sleep .5
	sudo dnf remove "$package_name" -yq
done

for package_name in ${INSTALL_LIST[@]}; do
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
		flatpak install "$flatpak_name" -y --noninteractive
		echo "[INSTALLED] - $flatpak_name"
	else
		echo "[INSTALLED] - $flatpak_name"
	fi
done
