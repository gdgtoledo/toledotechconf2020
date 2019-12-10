#!/bin/bash

function deploy() {
	git ftp init --user "$FTP_USERNAME" --passwd "$FTP_PASSWORD" "ftp://$FTP_SERVER/httpdocs"
	git ftp push --user "$FTP_USERNAME" --passwd "$FTP_PASSWORD" "ftp://$FTP_SERVER/httpdocs"
}

function install_dependencies() {
	if which git-ftp >/dev/null; then
		echo "Git FTP already installed"
	else
    	echo "Installing Git FTP"
		if [[ "$OSTYPE" == "linux-gnu" ]]; then
			install_linux
		elif [[ "$OSTYPE" == "darwin"* ]]; then
			install_mac
		else
			echo "OS not supported"
			exit 1
		fi
	fi
}

function install_linux() {
	apt-get -qq -y install git-ftp
}

function install_mac() {
	brew install git
	brew install brotli
	brew install git-ftp
}

function main() {
	install_dependencies
	deploy
}

main "$@"
