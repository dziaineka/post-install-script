#!/usr/bin/env bash

RESTORE=$(echo -en '\033[0m')
RED=$(echo -en '\033[00;31m')
GREEN=$(echo -en '\033[00;32m')

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

for package_name in ${REMOVE_LIST[@]}; do
	if ! sudo dnf list --installed | grep -q "^\<$package_name\>"; then
		echo "${RED}[UNINSTALLED]${RESTORE} - $package_name"
	else
		echo "removing $package_name..."
		sleep .5
		sudo dnf remove "$package_name" -yq
		echo "${RED}[UNINSTALLED]${RESTORE} - $package_name"
	fi
done

for package_name in ${INSTALL_LIST[@]}; do
	if ! sudo dnf list --installed | grep -q "^\<$package_name\>"; then
		echo "installing $package_name..."
		sleep .5
		sudo dnf install "$package_name" -yq
		echo "${GREEN}[INSTALLED]${RESTORE} - $package_name"
	else
		echo "${GREEN}[INSTALLED]${RESTORE} - $package_name"
	fi
done

for flatpak_name in ${FLATPAK_LIST[@]}; do
	if ! flatpak list | grep -q $flatpak_name; then
		echo "installing $flatpak_name..."
		sleep .5
		flatpak install "$flatpak_name" -y --noninteractive
		echo "${GREEN}[INSTALLED]${RESTORE} - $flatpak_name"
	else
		echo "${GREEN}[INSTALLED]${RESTORE} - $flatpak_name"
	fi
done
