#!/bin/sh

wpctl status \
  | grep -A10 'Sinks:' \
  | awk '/^\s*│\s*\*/ { $1=""; $2=""; $3=""; sub(/^[ \t]+/, ""); print; exit }'