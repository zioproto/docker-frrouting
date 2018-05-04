FROM ubuntu:16.04
MAINTAINER Saverio Proto <saverio.proto@switch.ch>
RUN /usr/bin/apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 7EB364B4A88BBC95
RUN /usr/bin/apt-get update -yq && /usr/bin/apt-get install -yq apt-transport-https

RUN echo deb [arch=amd64] https://apps3.cumulusnetworks.com/repos/deb xenial roh-3 > /etc/apt/sources.list.d/cumulus-apps-deb-xenial.list

RUN /usr/bin/apt-get update -yq && /usr/bin/apt-get install -yq \
    iptables \
    iproute \
    libc-ares2 \
    libjson-c2 \
    logrotate \
    wget \
    python \
    python-ipaddr \
    libsnmp30 \
    frr \
    && rm -rf /var/lib/apt/lists/*

COPY 99frr_defaults.conf /etc/sysctl.d/99frr_defaults.conf
COPY start.sh /usr/lib/frr/start.sh
COPY daemons /etc/frr/daemons

ENTRYPOINT ["/usr/lib/frr/start.sh"]
