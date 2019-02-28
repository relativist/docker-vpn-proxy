FROM ubuntu:14.04
MAINTAINER Tibor Sári <tiborsari@gmx.de>

RUN export DEBIAN_FRONTEND='noninteractive' && \
    apt-get update -qqy && \
    apt-get install --no-install-recommends -qqy \
        openvpn \
        python \
        iptables \
        squid \
        squidview \
        supervisor \
        wget \
        curl \
        $(apt-get -s dist-upgrade|awk '/^Inst.*ecurity/ {print $2}') \
    && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

VOLUME ["/vpn"]
RUN mkdir -p /opt/proxy_vpn
WORKDIR /opt/proxy_vpn



COPY squid.conf /etc/squid/squid.conf

COPY run_vpn.sh /opt/proxy_vpn
COPY certificates/$VPN_FILE_NAME /opt/proxy_vpn
COPY certificates/creds.txt /opt/proxy_vpn

RUN squid3 -z -F
RUN chmod +x run_vpn.sh

EXPOSE 3128

CMD ./run_vpn.sh


