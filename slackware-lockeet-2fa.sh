#!/bin/sh
#####################################################################
# Creating the rule that allows using the 2fa Lockeet key in
# slackware!
# Some keys that have the same ID (096e:0858) can benefit:
#
# For check:
# $ lsusb | grep 096e:0858

#####################################################################

# Only root
[ $UID -ne 0 ] && { echo "Need root."; exit 1 ;}

if [ -e /etc/udev/rules.d/70-lockeet.rules ]; then
    echo "Rule exist."
    exit 0
fi

# Create new rules
cat <<EOF > /etc/udev/rules.d/70-lockeet.rules
KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="18d1|096e", ATTRS{idProduct}=="5026|0858|085b", TAG+="uaccess"
EOF


# Reload rules
udevadm control --reload-rules
udevadm trigger
