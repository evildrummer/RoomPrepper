# RoomPrepper
A simple script to create folders and a notes file. I use it for TryhackMe and HackTheBox

Before you start make sure that the following directories exist:
~/THM (for TryHackme)
~/HTB (for HackTheBox)

Also check out my writeups for TryHackMe / HackTheBox or Vulnhub machines --> https://writeupsforhacking.wordpress.com/

[Changelog:latest]
 
- parts of script placed in functions
- it´s possible to "load" existing notes when folders already existing of you start again by deleting it


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



