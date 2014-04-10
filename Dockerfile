FROM ubuntu

# make sure the package repository is up to date
RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN apt-get update

RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd

# set up root:root and me:me
RUN echo 'root:root' | chpasswd
RUN adduser me
RUN adduser me sudo
RUN echo 'me:me' | chpasswd

# install ltiweb dependencies
RUN apt-get install -y apache2 libapache2-mod-fcgid git make gcc autoconf libtool automake

RUN su - me -c 'git clone https://github.com/mitlti/lti-wp /home/me/lti-wp'
RUN cp /home/me/lti-wp/apache-dev.conf /etc/apache2/sites-available/lti-wp
RUN a2ensite lti-wp
RUN a2dissite 000-default

EXPOSE 80
EXPOSE 22

CMD /usr/sbin/sshd -D
