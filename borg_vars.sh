
#!/bin/sh

HOST="truenas-dork.dorianko.ch.local"

# Setting this, so the repo does not need to be given on the commandline:
export BORG_REPO=borg@${HOST}:/mnt/p1/backups

if ! ping -c 1 "$HOST" > /dev/null 2>&1; then
    echo "Host $HOST is down. Exiting."
    exit 1
fi

if [ -f ~/.ssh/id_dorkframe ]; then
    KEYFILE=~/.ssh/id_dorkframe
elif [ -f ~/.ssh/id_dorkframe_better ]; then
    KEYFILE=~/.ssh/id_dorkframe_better
elif [ -f ~/.ssh/id_ed25519 ]; then
    KEYFILE=~/.ssh/id_ed25519
else
    echo "Neither id_dorkframe nor id_dorkframe_better nor id_ed25519 exists. Exiting."
    exit 1
fi
export BORG_PASSPHRASE=$(age --decrypt -i $KEYFILE ~/.ssh/borg_keyphrase)

if ! ssh-add -l >/dev/null 2>&1; then
    eval $(ssh-agent -s)
fi

# Get the fingerprint of the public key
KEY_FP=$(ssh-keygen -lf "${KEYFILE}.pub" | awk '{print $2}')

# Check if this fingerprint is in the agent
if ssh-add -l 2>/dev/null | grep -q "$KEY_FP"; then
    echo "Key $KEYFILE is loaded in ssh-agent."
else
    echo "Key $KEYFILE is NOT loaded in ssh-agent."
    ssh-add $KEYFILE
fi


