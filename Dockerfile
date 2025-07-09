FROM kasmweb/ubuntu-jammy-desktop:1.17.0-rolling-daily
USER root

ENV HOME /home/kasm-default-profile
ENV STARTUPDIR /dockerstartup
ENV INST_SCRIPTS $STARTUPDIR/install
WORKDIR $HOME

######### Customize Container Here ###########


RUN touch $HOME/Desktop/hello.txt
RUN sh -c 'echo "deb http://deb.opera.com/opera/ stable non-free" >> /etc/apt/sources.list.d/opera.list'
RUN sh -c 'wget -O - http://deb.opera.com/archive.key | apt-key add -'
RUN apt-get update
RUN apt install opera-stable -y


######### End Customizations ###########

RUN chown 1000:0 $HOME
RUN $STARTUPDIR/set_user_permission.sh $HOME

ENV HOME /home/kasm-user
WORKDIR $HOME
RUN mkdir -p $HOME && chown -R 1000:0 $HOME

USER 1000
