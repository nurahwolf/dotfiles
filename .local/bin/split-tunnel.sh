#!/bin/bash
# A script to split routing for very silly overly done cisco openconnect VPNs

# Routes that we want to be used by the VPN link
ROUTES="10.7.4.0/22"

# Helpers to create dotted-quad netmask strings.
MASKS[1]="128.0.0.0"
MASKS[2]="192.0.0.0"
MASKS[3]="224.0.0.0"
MASKS[4]="240.0.0.0"
MASKS[5]="248.0.0.0"
MASKS[6]="252.0.0.0"
MASKS[7]="254.0.0.0"
MASKS[8]="255.0.0.0"
MASKS[9]="255.128.0.0"
MASKS[10]="255.192.0.0"
MASKS[11]="255.224.0.0"
MASKS[12]="255.240.0.0"
MASKS[13]="255.248.0.0"
MASKS[14]="255.252.0.0"
MASKS[15]="255.254.0.0"
MASKS[16]="255.255.0.0"
MASKS[17]="255.255.128.0"
MASKS[18]="255.255.192.0"
MASKS[19]="255.255.224.0"
MASKS[20]="255.255.240.0"
MASKS[21]="255.255.248.0"
MASKS[22]="255.255.252.0"
MASKS[23]="255.255.254.0"
MASKS[24]="255.255.255.0"
MASKS[25]="255.255.255.128"
MASKS[26]="255.255.255.192"
MASKS[27]="255.255.255.224"
MASKS[28]="255.255.255.240"
MASKS[29]="255.255.255.248"
MASKS[30]="255.255.255.252"
MASKS[31]="255.255.255.254"

export CISCO_SPLIT_INC=0

# Create environment variables that vpnc-script uses to configure network
function addroute()
{
    local ROUTE="$1"
    export CISCO_SPLIT_INC_${CISCO_SPLIT_INC}_ADDR=${ROUTE%%/*}
    export CISCO_SPLIT_INC_${CISCO_SPLIT_INC}_MASKLEN=${ROUTE##*/}
    export CISCO_SPLIT_INC_${CISCO_SPLIT_INC}_MASK=${MASKS[${ROUTE##*/}]}
    export CISCO_SPLIT_INC=$((${CISCO_SPLIT_INC}+1))
}

# Old function for generating NetworkManager 0.8 GConf keys
function translateroute ()
{
    local IPADDR="${1%%/*}"
    local MASKLEN="${1##*/}"
    local OCTET1="$(echo $IPADDR | cut -f1 -d.)"
    local OCTET2="$(echo $IPADDR | cut -f2 -d.)"
    local OCTET3="$(echo $IPADDR | cut -f3 -d.)"
    local OCTET4="$(echo $IPADDR | cut -f4 -d.)"

    local NUMADDR=$(($OCTET1*16581375 + $OCTET2*65536 + $OCTET3*256 + $OCTET4))
    local NUMADDR=$(($OCTET4*16581375 + $OCTET3*65536 + $OCTET2*256 + $OCTET1))
    if [ "$ROUTESKEY" = "" ]; then
        ROUTESKEY="$NUMADDR,$MASKLEN,0,0"
    else
        ROUTESKEY="$ROUTESKEY,$NUMADDR,$MASKLEN,0,0"
    fi
}

if [ "$reason" = "make-nm-config" ]; then
    echo "Put the following into the [ipv4] section in your NetworkManager config:"
    echo "method=auto"
    COUNT=1
    for r in $ROUTES; do
        echo "routes${COUNT}=${r%%/*};${r##*/};0.0.0.0;0;"
        COUNT=$(($COUNT+1))
    done
    exit 0
fi

for r in $ROUTES; do
    addroute $r
done

exec /etc/vpnc/vpnc-script
