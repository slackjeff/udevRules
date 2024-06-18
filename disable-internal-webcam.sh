#!/bin/sh
#####################################################################
# UDEV Rule to disable the internal laptop webcam
#####################################################################

# Only root
[ $UID -ne 0 ] && { echo "Need root."; exit 1 ;}

if [ -e /etc/udev/rules.d/40-disable-internal-webcam.rules ]; then
    echo "Rule exist."
    exit 0
fi

# Create new rules
cat <<EOF > /etc/udev/rules.d/40-disable-internal-webcam.rules
ATTRS{idVendor}=="13d3", ATTRS{idProduct}=="5a24", RUN="/bin/sh -c 'echo 0 >/sys/\$devpath/authorized'"
EOF


# Reload rules
udevadm control --reload-rules
udevadm trigger
