FROM ubuntu
MAINTAINER Steeve Morin "steeve.morin@gmail.com"

# make sure the package repository is up to date
RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN echo "deb http://ppa.launchpad.net/i2p-maintainers/i2p/ubuntu precise main" >> /etc/apt/sources.list
RUN apt-get update

RUN apt-get -y --force-yes install i2p
RUN sed -i s/RUN_DAEMON=\"false\"/RUN_DAEMON=\"true\"/ /etc/default/i2p
RUN /etc/init.d/i2p start
RUN echo "i2cp.tcp.bindAllInterfaces=true" >> /var/lib/i2p/i2p-config/router.config
RUN sed -i s/::1,127.0.0.1/0.0.0.0/ /var/lib/i2p/i2p-config/clients.config

CMD /etc/init.d/i2p start && tail -f /var/log/i2p/wrapper.log
