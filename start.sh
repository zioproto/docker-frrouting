#!/bin/bash

# Finish Function runs when the Container is being Stopped.
function finish {
  echo "#######################################"
  echo "  CAUGHT A SIGNAL: stopping FRRouting"
  echo "#######################################"
  /usr/lib/frr/frr stop
  exit 0
}

trap finish HUP INT QUIT TERM

echo "##############################"
echo "  Applying Sysctl Values"
echo "##############################"
/sbin/sysctl -p -w /etc/sysctl.d/99frr_defaults.conf

echo "##############################"
echo "  Starting FRRouting..."
echo "##############################"
/usr/lib/frr/frr start

while true; do sleep 3600; done
