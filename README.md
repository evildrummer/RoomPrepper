# RoomPrepper
A simple script to create folders and a notes file. I use it for TryhackMe and HackTheBox

Before you start make sure that the following directories exist:
~/THM (for TryHackme)
~/HTB (for HackTheBox)

[Changelog:latest]
- added folder screenshot
- added second try for IP after ping
- added createLists.sh
-> now you can execute createLists.sh to generate a user.lst and password.lst (i.e. for hydra)
- added check for already existing folders of the machine (i.e. HackAllTheThings)
- filled notes.md with examples and changed topics

## Usage:

./start_new_room  
./createLists.sh (to create a user.lst & password.lst out of your notes.md)

## Screen with example input

![Screenshot](images/input.png)

## When the script is finishing

![Screenshot](images/start_new_room.png)

## The notes will be opened at the end and they look like this.

![Screenshot](images/notes.png)


It´s super handy when you use terminator with split screen layout. So you can start with gobuster and other tools.

![Screenshot](images/terminator.png)



