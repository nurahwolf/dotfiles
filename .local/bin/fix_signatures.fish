#!/usr/bin/env fish
set GPG_CONF '/etc/pacman.d/gnupg/gpg.conf'
set WORKING_DIR (mktemp -d /tmp/bootstrap.XXXXXXXX)

cd "$WORKING_DIR" || err "Could not enter directory $WORKING_DIR"

curl -O 'https://www.blackarch.org/keyring/blackarch-keyring.pkg.tar.zst'
curl -O 'https://mirror.cachyos.org/cachyos-keyring-2-1-any.pkg.tar.zst'

if ! grep -q 'allow-weak-key-signatures' $GPG_CONF
	echo 'allow-weak-key-signatures' >> $GPG_CONF
end

pacman --config /dev/null -U blackarch-keyring.pkg.tar.zst
pacman --config /dev/null -U cachyos-keyring-2-1-any.pkg.tar.zst
