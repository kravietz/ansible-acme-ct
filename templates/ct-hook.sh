#!/bin/bash
set -e
EVENT_NAME="$1"
[ "$EVENT_NAME" = "live-updated" ] || exit 42

# full list at https://www.certificate-transparency.org/known-logs
CT_LOGS="{{ct_logs | join(' ') }}"
CT_UMASK="0022"

[ -e "/etc/default/acme-ct" ] && . /etc/default/acme-ct
[ -e "/etc/conf.d/acme-ct" ] && . /etc/conf.d/acme-ct
[ -z "$ACME_STATE_DIR" ] && ACME_STATE_DIR="/var/lib/acme"

umask $CT_UMASK

while read name; do
  certdir="$ACME_STATE_DIR/live/$name"
  if [ -z "$name" -o ! -e "$certdir" ]; then
    continue
  fi

  sctdir="$certdir/scts"
  mkdir -p "$sctdir"

  for log in $CT_LOGS; do
    log_hash=$(echo -n "$log" | sha256sum | cut -d " " -f 1)
    sctpath="$sctdir/${log_hash}.sct"

    if [ ! -e "$sctpath" ]; then
      /usr/bin/ct-submit "$log" <"$certdir/fullchain" >"$sctpath"
    fi
  done
done

exit 0
