#!/bin/bash

#Setting colored output
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

FILE=$(pwd)/notes.md

if test -f "$FILE"; then

	sed -n '/#usernames/,/#end/ p' notes.md > user.lst
	sed -n '/#passwords/,/#end/ p' notes.md > password.lst
sleep 1
	sed -i '$d' user.lst && sed -i '1d' user.lst
	sed -i '$d' password.lst && sed -i '1d' password.lst
else
	echo -e "${RED} -- notes.md does not exist${NC}"
	exit 0
fi


echo -e  " \n"
echo -e "${GREEN}-----------------------------${NC}"
echo -e "${GREEN}- user/passwordlist created -${NC}"
echo -e "${GREEN}-----------------------------${NC}"
echo -e " \n"
