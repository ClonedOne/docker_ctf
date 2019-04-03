# Select base image
FROM ubuntu:16.04

# Variable to be specified at build time
ARG binary

# Set the current working directory
WORKDIR /root

# Update the system, download any packages essential for the project
RUN dpkg --add-architecture i386
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y git build-essential make gcc vim gdb radare2 openssh-server libc6:i386 libstdc++6:i386 libseccomp2:i386 

# SSH config
RUN mkdir /root/.ssh
RUN mkdir /var/run/sshd
RUN chown -R root:root /root/.ssh
RUN chmod -R 700 /root/.ssh

# Allow ssh root login
RUN echo 'root:root' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

# Import any additional files into the environment (from the host)
ADD $binary .
RUN chmod +x $binary

# Open port 22
EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
