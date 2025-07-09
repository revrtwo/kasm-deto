FROM kasmweb/ubuntu-jammy-desktop:1.17.0-rolling-daily
USER root

ENV HOME /home/kasm-default-profile
ENV STARTUPDIR /dockerstartup
ENV INST_SCRIPTS $STARTUPDIR/install
WORKDIR $HOME

RUN sh -c 'echo "deb http://deb.opera.com/opera/ stable non-free" >> /etc/apt/sources.list.d/opera.list'
RUN sh -c 'wget -O - http://deb.opera.com/archive.key | apt-key add -'
RUN apt-get update
RUN apt install opera-stable -y

RUN mkdir -p /root/.local/share/applications && \
    printf '[Desktop Entry]\nName=Opera\nComment=Launch Opera browser\nExec=opera --no-sandbox\nIcon=opera\nTerminal=false\nType=Application\nCategories=Network;WebBrowser;\n' > /root/.local/share/applications/opera.desktop && \
    chmod +x /root/.local/share/applications/opera.desktop && \
    mkdir -p /home/kasm-user/Desktop && \
    cp /root/.local/share/applications/opera.desktop /home/kasm-user/Desktop/ && \
    chmod +x /home/kasm-user/Desktop/opera.desktop

RUN printf '[Desktop Entry]\nType=Application\nExec=opera --no-sandbox\nHidden=false\nNoDisplay=false\nX-GNOME-Autostart-enabled=true\nName=Opera No Sandbox\nComment=Launch Opera browser with no sandbox\n' > /etc/xdg/autostart/opera.desktop

RUN chown 1000:0 $HOME
RUN $STARTUPDIR/set_user_permission.sh $HOME
ENV HOME /home/kasm-user
WORKDIR $HOME
RUN mkdir -p $HOME && chown -R 1000:0 $HOME
USER 1000

COPY /src/images/bg_default.png /usr/share/backgrounds/
