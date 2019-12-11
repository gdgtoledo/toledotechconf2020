#!/bin/bash

function deploy() {
	git config git-ftp.deployedsha1file git-ftp.log
	
	# W A R N I N G!! The git-ftp init has to be done the first time we upload to the remote server
	# otherwise, the push will fail
	#git ftp init --user "$FTP_USERNAME" --passwd "$FTP_PASSWORD" "ftp://$FTP_SERVER/httpdocs" || true
	git ftp push --user "$FTP_USERNAME" --passwd "$FTP_PASSWORD" "ftp://$FTP_SERVER/httpdocs"  || true
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
	sudo apt-get update
	sudo apt-get -y install git-ftp
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
