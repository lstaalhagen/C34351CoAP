#!/usr/bin/env bash 

# Check for root 
[ $(id -u) -ne 0 ] && echo "Script must be executed with sudo" && exit 1

if [ ! -d "/var/run/netns" ]; then
  echo "No namespaces. Exiting"
  exit 1
fi

if [ $# -lt 2 ]; then
  echo "Too few arguments. Usage: sudo ./cmdon.sh <namespace> <command> [<arguments>]"
  echo "Exiting"
  exit 1
fi

FOUND="FALSE"
for NS in $(ls /var/run/netns); do
  if [ "${NS}" = "${1}" ]; then
    FOUND="TRUE"
    shift
    ip netns exec "${NS}" $* &
  fi
done
if [ "${FOUND}" = "FALSE" ]; then
  echo "Error: Namespace ${1} not found. Exiting"
  exit 1
fi
