#!/usr/bin/env bash

# Run from the script's own directory, so borg_vars.sh and the rsync mirror
# are found no matter where (cron, systemd, another folder) this is started.
cd "$(dirname "$(readlink -f "$0")")" || exit 2

# Set to 0 to skip mirroring the dorianko.ch home directory.
SYNC_REMOTE=1

# some helpers and error handling:
info() { printf "\n%s %s\n\n" "$( date )" "$*" >&2; }
STARTED_AGENT=0
cleanup() { [ "$STARTED_AGENT" = 1 ] && ssh-agent -k > /dev/null; }
trap cleanup EXIT
trap 'echo $( date ) Backup interrupted >&2; exit 2' INT TERM

source ./borg_vars.sh

info "Starting backup"

rsync_exit=0
if [ "$SYNC_REMOTE" = 1 ]; then
    info "Syncing dorianko.ch home directory"
    mkdir -p ./dorianko.ch_backup/
    rsync -avhP --delete --exclude='/.*/' --exclude='*/.git/' --exclude='*/.venv/' --exclude='*/node_modules/' dorianko.ch:~/ ./dorianko.ch_backup/
    rsync_exit=$?
    # Map rsync's codes onto borg's scale: 24 (files vanished during transfer)
    # is a warning, anything else non-zero is an error.
    case $rsync_exit in
        0)  ;;
        24) rsync_exit=1 ;;
        *)  rsync_exit=2 ;;
    esac
fi

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
    --exclude 'home/*/.cache'       \
    --exclude 'var/tmp/*'           \
    --exclude 'home/*/.bitmonero'   \
    --exclude '**/node_modules'     \
    --exclude '**/.venv'            \
    --exclude 'home/*/.local/share/Steam/steamapps' \
    --exclude 'home/*/.local/share/Trash'           \
    --exclude 'home/*/.var/app/*/cache'             \
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
global_exit=0
for code in $rsync_exit $backup_exit $prune_exit $compact_exit; do
    [ "$code" -gt "$global_exit" ] && global_exit=$code
done

if [ ${global_exit} -eq 0 ]; then
    info "Sync, Backup, Prune, and Compact finished successfully"
elif [ ${global_exit} -eq 1 ]; then
    info "Sync, Backup, Prune, and/or Compact finished with warnings"
else
    info "Sync, Backup, Prune, and/or Compact finished with errors"
fi

exit ${global_exit}
