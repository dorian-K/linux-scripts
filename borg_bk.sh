##!/bin/sh

HOST="truenas-dork.dorianko.ch.local"

if ! ping -c 1 "$HOST" > /dev/null 2>&1; then
    echo "Host $HOST is down. Exiting."
    exit 1
fi

# Setting this, so the repo does not need to be given on the commandline:
export BORG_REPO=borg@${HOST}:/mnt/p1/backups

# some helpers and error handling:
info() { printf "\n%s %s\n\n" "$( date )" "$*" >&2; }
trap 'echo $( date ) Backup interrupted >&2; exit 2' INT TERM

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


info "Starting backup"

# Backup the most important directories into an archive named after
# the machine this script is currently running on:

nice -n 15                          \
 ionice -c2 -n7                     \
  borg create                       \
    --verbose                       \
    --filter AME                    \
    --list                          \
    --stats                         \
    --show-rc                       \
    --compression lz4               \
    --exclude-caches                \
    --exclude 'home/*/.cache/*'     \
    --exclude 'var/tmp/*'           \
    --exclude '**/.git/*'           \
    --exclude 'home/*/.cache'       \
                                    \
    ::'{hostname}-{now}'            \
    "$HOME" "/etc"

backup_exit=$?

info "Pruning repository"

# Use the `prune` subcommand to maintain 7 daily, 4 weekly and 6 monthly
# archives of THIS machine. The '{hostname}-*' matching is very important to
# limit prune's operation to this machine's archives and not apply to
# other machines' archives also:

borg prune                          \
    --list                          \
    --glob-archives '{hostname}-*'  \
    --show-rc                       \
    --keep-daily    7               \
    --keep-weekly   4               \
    --keep-monthly  6

prune_exit=$?

# actually free repo disk space by compacting segments

info "Compacting repository"

borg compact

compact_exit=$?

# use highest exit code as global exit code
global_exit=$(( backup_exit > prune_exit ? backup_exit : prune_exit ))
global_exit=$(( compact_exit > global_exit ? compact_exit : global_exit ))

if [ ${global_exit} -eq 0 ]; then
    info "Backup, Prune, and Compact finished successfully"
elif [ ${global_exit} -eq 1 ]; then
    info "Backup, Prune, and/or Compact finished with warnings"
else
    info "Backup, Prune, and/or Compact finished with errors"
fi

if [[ $(hostname) == "rasp-new" ]]; then
    ssh-agent -k
fi

exit ${global_exit}
