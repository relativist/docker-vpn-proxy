FROM ubuntu:14.04
MAINTAINER Tibor Sári <tiborsari@gmx.de>

RUN export DEBIAN_FRONTEND='noninteractive' && \
    apt-get update -qqy && \
    apt-get install --no-install-recommends -qqy \
        openvpn \
        python \
        squid \
        squidview \
        supervisor \
        wget \
        curl \
        $(apt-get -s dist-upgrade|awk '/^Inst.*ecurity/ {print $2}') \
    && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

VOLUME ["/vpn"]
WORKDIR /

RUN squid3 -z -F

COPY squid.conf /etc/squid/squid.conf
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY run_vpn.sh /
RUN chmod +x /run_vpn.sh

EXPOSE 3128

# Set up the command arguments
#CMD ["/usr/bin/supervisord"]
CMD ./run_vpn.sh


