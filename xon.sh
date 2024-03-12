#!/usr/bin/env bash 

if [ ! -d "/var/run/netns" ]; then
  echo "No namespaces. Exiting"
  exit 1
fi

if [ $# -eq 0 ]; then
  echo "No arguments given. Usage: sudo ./xon.sh <namespace>"
  echo "Exiting"
  exit 1
fi

for NS in $(ls /var/run/netns); do
  if [ "${NS}" = "${1}" ]; then
    sudo ip netns exec ${NS} xterm & &>/dev/null
    exit 0
  fi
done
echo "Error: Namespace ${1} not found. Exiting"
exit 1
  
