#!/bin/bash

# Before you start make sure that the following directories exist:
# ~/THM (for TryHackme)
# ~/HTB (for HackTheBox)
# 
#
# Put the script and the notes_template.md in the same directory
#
# Usage: script.sh $PLATFORM $IP $HOSTNAME
#
# Setting colored output
RED='\033[0;31m'
YELLOW='\033[0;33m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# check for arguments at start
#if [[ $# -ne 3 ]] ; then
#    echo -e "\n"
#    echo -e "${RED} -- Syntax: SCRIPT PLATFORM(THM or HTB) IP NAME-OF-BOX -- ${NC}"
#    echo -e "${GREEN}--> Example: ./start_new_room.sh THM 1.2.3.4 Meltdown <--${NC}"
#
#	exit 0
#fi





# set variables
read -p 'Which platform are you using (THM or HTB) ?: ' PLATFORM
read -p 'Type in the IP address for the machine (e.g. 10.11.12.3): ' IP
read -p 'Enter the name of the machine (e.g. HackPark): ' HOST
BOXDIR=~/$PLATFORM/$HOST



# Pause function for debugging
pause(){
 read -n1 -rsp $'Press any key to continue or Ctrl+C to exit...\n'
}


clear

# Ping the IP from arguments to verify VPN/Network connectivity
echo -e  " \n"
echo -e "${YELLOW}-----------------------------${NC}"
echo -e "${YELLOW}- Checking Host onnectivity - ${NC}"
echo -e "${YELLOW}-----------------------------${NC}"
echo -e " \n"


if ping -q -c 1 -W 1 $IP >/dev/null; then
  echo -e "${GREEN}Host is reachable${NC}"
else
  echo -e "${RED}Host is NOT reachable${NC}"
  echo "Starting VPN Connection first!"
  exit 0
fi

sleep 2

# Creating the folders
# ~/PLATFORM/
# ~/PLATFORM/HOSTNAME
# ~/PLATFORM/HOSTNAME/nmap

echo -e "\n"
echo -e "${YELLOW}------------------------${NC}"
echo -e "${YELLOW}- Creating directories -${NC}"
echo -e "${YELLOW}------------------------${NC}"
echo -e "\n"

mkdir $BOXDIR
echo "--> Folder for room $HOST created ..."
sleep 1
mkdir $BOXDIR/nmap
echo "--> nmap Folder created ..."

sleep 1

# Starting the standard nmap command
echo -e "\n"
echo -e "${YELLOW}--------------------------------${NC}"
echo -e "${YELLOW}-  Starting standard Nmap Scan -${NC}"
echo -e "${YELLOW}--------------------------------${NC}"
echo -e "\n"

sleep 3

nmap -sCV $IP -v -T4 -oA $BOXDIR/nmap/initial


echo -e "\n"
echo -e "${YELLOW}-------------------------------${NC}"
echo -e "${YELLOW}- Creating notes for the box  -${NC}"
echo -e "${YELLOW}-------------------------------${NC}"
echo -e "\n"

sleep 1

echo "--> Grep TCP and UDP Ports"
egrep "tcp|udp" $BOXDIR/nmap/initial.nmap >> fillin.txt

sleep 1

echo "--> Set IP and hostname"
echo -e "[IP]" >> $BOXDIR/notes.md
echo -e "$IP \n" >> $BOXDIR/notes.md
echo -e "[Host]" >> $BOXDIR/notes.md
echo -e "$HOST \n" >> $BOXDIR/notes.md

sleep 1

echo "--> Fill open ports section"
echo -e "[open ports]" >> $BOXDIR/notes.md

sleep 1

echo "--> import remaining template"
cat fillin.txt >> $BOXDIR/notes.md
cat notes_template.md >> $BOXDIR/notes.md

sleep 1

echo "--> Cleaning files"
rm fillin.txt

sleep 3

echo -e "\n"
echo -e "${GREEN}FINISHED! Opening notes${NC}"

sleep 5

nano $BOXDIR/notes.md
