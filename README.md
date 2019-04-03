# Docker ctf

Set of scripts to create a docker image from ubuntu 16 with support to 32bit
executables (a few 32bit libraries pre-installed) and active ssh server.
It is designed to be used when playing pwn challenges to streamline the process
of developing the exploit script (pwntools) while testing on a local machine
even when the host runs osx/win.

A couple of common tools gcc/vim/gdb/radare2 are already automatically
installed.

## usage

Run `./build $binary_to_send_to_conatiner` to create the docker image.
This will take a couple of minutes.

`./start.sh` spawns the containers and maps port 22 to port 2222 on the host.

`ssh root@localhost -p 2222` or the ssh module form `pwntools` to ssh into the
container.

`./clean.sh` to stop and remove the container. If uncommented the last line will
also remove the image.
