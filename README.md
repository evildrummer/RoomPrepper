# RoomPrepper (This is a fork of https://github.com/evildrummer/RoomPrepper)
A simple script to create folders and a notes file. I use it for TryhackMe and HackTheBox

Also check out my writeups for TryHackMe / HackTheBox or Vulnhub machines --> https://www.luceast.de/blog/

Add me on TryHackMe --> https://tryhackme.com/p/LucEast

[Changelog:latest]
 
- added option to continue even if ICMP is disabled on target
- changed default editor from nano to vim
- added parent folder "writeups"

The folders for the platform will be created in the home directory (~/writeups/PLATFORM/BOXNAME)

## Usage:

./start_new_room.sh    
./createLists.sh (to create a user.lst & password.lst out of your notes.md)

## Screen with example input

![Screenshot](images/input.png)

## When the script is finishing

![Screenshot](images/start_new_room.png)

## The notes will be opened at the end and they look like this.

![Screenshot](images/notes.png)


It´s super handy when you use terminator/tmux or konsole with split screen layout. So you can start with gobuster and other tools.

![Screenshot](images/terminator.png)



