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

pause(){

 read -n1 -rsp $'Press any key to continue or Ctrl+C to exit...\n'

}


# set variables
read -p 'Which platform are you using (THM or HTB) ?: ' PLATFORM
read -p 'Enter the name of the machine (e.g. HackPark): ' HOST
BOXDIR=~/$PLATFORM/$HOST

# check if directory already exists
if test -d $BOXDIR; then

	echo -e "${RED}Directory already exists !${NC}"
	exit 0
fi

read -p 'Type in the IP address for the machine (e.g. 10.11.12.3): ' IP
echo $IP | xclip -selection clipboard

clear

# Ping the IP from input to verify VPN/Network connectivity

echo -e  " \n"
echo -e "${YELLOW}-----------------------------${NC}"
echo -e "${YELLOW}- Checking Host Connectivity - ${NC}"
echo -e "${YELLOW}-----------------------------${NC}"
echo -e " \n"

echo $IP > ip.txt
if ping -q -c 1 -W 1 $IP >/dev/null; then

        echo -e "${GREEN}Host is reachable${NC}"
        echo -e "${GREEN}Die IP lautet: $IP${NC}"


    else
        echo -e "${RED}Host is NOT reachable${NC}"
        read -p 'Starting VPN Connection first or type in IP again and hit enter to continue (last value = '$IP') : ' IP2

        if test -z $IP2; then

            echo 'pinging IP -> ' $IP''
            if ping -q -c 1 -W 1 $IP >/dev/null;then
            echo -e "${GREEN}Host is reachable${NC}"
            else
                echo -e "${RED}Host is NOT reachable! exiting....${NC}"
                exit 0
            fi

        else
            echo 'pinging IP again -> ' $IP2''
            if ping -q -c 1 -W 1 $IP2 >/dev/null ; then
                echo -e "${GREEN}Host is reachable${NC}"
                echo $IP2 > ip.txt
                IP=$(cat ip.txt)

            else
                echo -e "${RED}Host is NOT reachable! exiting....${NC}"
                exit 0
            fi
        fi
fi


sleep 1

# Creating the folders
# ~/PLATFORM/
# ~/PLATFORM/HOSTNAME
# ~/PLATFORM/HOSTNAME/nmap
# ~/PLATFORM/HOSTNAME/log
# ~/PLATFORM/HOSTNAME/screenshots

echo -e "\n"
echo -e "${YELLOW}------------------------${NC}"
echo -e "${YELLOW}- Creating directories -${NC}"
echo -e "${YELLOW}------------------------${NC}"
echo -e "\n"

mkdir $BOXDIR
echo "--> Folder for room $HOST created ..."
sleep 1
mkdir $BOXDIR/nmap
echo "--> nmap folder created ..."
sleep 1
mkdir $BOXDIR/log
echo "--> log folder created ..."
mkdir $BOXDIR/screenshots
echo "--> screenshots folder created ..."


sleep 1

# Starting the standard nmap command
echo -e "\n"
echo -e "${YELLOW}--------------------------------${NC}"
echo -e "${YELLOW}-  Starting standard Nmap Scan -${NC}"
echo -e "${YELLOW}--------------------------------${NC}"
echo -e "\n"

sleep 2

nmap -sCV $IP -v -T5  -oA $BOXDIR/nmap/initial


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

echo "--> import remaining template and files"
cat fillin.txt >> $BOXDIR/notes.md
cat notes_template.md >> $BOXDIR/notes.md
cp createLists.sh $BOXDIR
chmod +x $BOXDIR/createLists.sh


sleep 1

echo "--> Cleaning files"
rm fillin.txt ip.txt

sleep 2

echo -e "\n"
echo -e "${GREEN}FINISHED! Opening notes${NC}"

sleep 4

nano $BOXDIR/notes.md
