FROM ubuntu
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y dbus-x11 sudo bash net-tools novnc  x11vnc xvfb supervisor xfce4 gnome-shell ubuntu-gnome-desktop gnome-session gdm3 tasksel ssh terminator git nano curl wget zip unzip docker.io falkon firefox wine playonlinux chromium-bsu

RUN dpkg --add-architecture i386 wget -qO - https://dl.winehq.org/wine-builds/winehq.key | sudo apt-key add - apt-add-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ focal main' apt update apt install --install-recommends winehq-stable 

RUN sudo adduser akuhnet --gecos "First Last,RoomNumber,WorkPhone,HomePhone" --disabled-password
RUN echo "akuhnet:123" | sudo chpasswd

COPY novnc.zip /novnc.zip
COPY . /system

RUN unzip -o /novnc.zip -d /usr/share
RUN rm /novnc.zip

RUN chmod +x /system/conf.d/websockify.sh
RUN chmod +x /system/supervisor.sh

CMD ["/system/supervisor.sh"]
