FROM ubuntu:16.04
MAINTAINER Eric Pulvino <eric@cumulusnetworks.com>

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
    && rm -rf /var/lib/apt/lists/*
RUN wget -O /root/frr.deb https://apps3.cumulusnetworks.com/repos/deb/pool/roh-3/f/frr/frr_3.1+cl3u2-1~ubuntu16.04+1~1506550809.d4b6eca_amd64.deb
RUN wget -O /root/frr_doc.deb https://apps3.cumulusnetworks.com/repos/deb/pool/roh-3/f/frr/frr-doc_3.1+cl3u2-1~ubuntu16.04+1~1506550809.d4b6eca_all.deb
RUN wget -O /root/frr_dbg.deb https://apps3.cumulusnetworks.com/repos/deb/pool/roh-3/f/frr/frr-dbg_3.1+cl3u2-1~ubuntu16.04+1~1506550809.d4b6eca_amd64.deb
RUN wget -O /root/frr-pythontools.deb https://apps3.cumulusnetworks.com/repos/deb/pool/roh-3/f/frr/frr-pythontools_3.1+cl3u2-1~ubuntu16.04+1~1506550809.d4b6eca_all.deb
RUN dpkg -i /root/frr.deb; \
    dpkg -i /root/frr-pythontools.deb; \
    dpkg -i /root/frr_doc.deb; \
    dpkg -i /root/frr_dbg.deb; \
    rm -rfv /root/*deb

COPY 99frr_defaults.conf /etc/sysctl.d/99frr_defaults.conf
COPY start.sh /usr/lib/frr/start.sh
COPY daemons /etc/frr/daemons

ENTRYPOINT ["/usr/lib/frr/start.sh"]
