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

# Waiting Forever or Until Someone Presses Enter to Stop the Container
echo "[hit enter key to exit] or run 'docker stop <container>'"
read

echo "##############################"
echo "  Stopping FRRouting..."
echo "##############################"
/usr/lib/frr/frr stop

echo "Done."
echo "exited $0"
