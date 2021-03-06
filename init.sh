#!/bin/bash

if [ ! -z "$FOLD_USER" ]; then
  export FOLD_ANON=false
fi

cat <<EOF | tee /etc/fahclient/config.xml
<config>
  <!-- Client Control -->
  <fold-anon v='$FOLD_ANON'/>

  <!-- Folding Slot Configuration -->
  <gpu v='false'/>

  <!-- Slot Control -->
  <power v='$FOLD_POWER'/>

  <!-- User Information -->
  <passkey v='$FOLD_PASSKEY'/>
  <user v='$FOLD_USER'/>
  <team v='$FOLD_TEAM'/>
  <gui-enabled v='false'/>

  <!--  HTTP Server - Web Server -->
  <allow v='0/0' />
  <web-allow v='0/0' />

  <!-- Folding Slots -->
  <slot id='0' type='CPU'/>
</config>
EOF

# Kick start folding service
/etc/init.d/FAHClient start 2> /dev/null
while [ ! -f /var/lib/fahclient/log.txt ]
do
  sleep 2 # or less like 0.2
done
tail -f /var/lib/fahclient/log.txt
