#!/bin/sh

# gpg (GnuPG) 1.4.16

# trust imported key with level 5=ULTIMATE (6 in ownertrust)
fpr=$(gpg --fingerprint --with-colon --list-keys GPG_KEY_ID | grep fpr | cut -d':' -f10) && echo "$fpr:6" | gpg --import-ownertrust