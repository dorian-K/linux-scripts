#!/bin/bash

# Start GNOME Keyring with secrets, ssh and pkcs11 components
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)

# Export required desktop session variables

export SSH_AUTH_SOCK

# Optionally start nm-applet (acts as a NetworkManager secret agent)
#nm-applet &
