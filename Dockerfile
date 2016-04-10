FROM gliderlabs/alpine:edge

MAINTAINER Paul Schoenfelder <paulschoenfelder@gmail.com>

# Important!  Update this no-op ENV variable when this Dockerfile
# is updated with the current date. It will force refresh of all
# of the base images and things like `apt-get update` won't be using
# old cached versions when the Dockerfile is built.
ENV REFRESHED_AT=2016-04-9T5:03 \
    LANG=en_US.UTF-8 \
    HOME=/opt/me \
    # Set this so that CTRL+G works properly
    TERM=xterm \
    S6_VERSION=v1.17.1.1 \
    GODNSMASQ_VERSION=1.0.5

# Install Erlang
RUN mkdir -p ${HOME} && \
    adduser -S -u 1001 -G root -s /bin/sh -h ${HOME} -D default && \
    chown -R 1001:0 ${HOME} && \
    chmod 774 ${HOME} && \
    apk --no-cache upgrade && \
    apk-install \
      curl wget drill tcptraceroute tcpdump ca-certificates \
      elixir vim grep && \
    wget https://github.com/janeczku/go-dnsmasq/releases/download/${GODNSMASQ_VERSION}/go-dnsmasq-min_linux-amd64 --no-check-certificate --quiet -O /usr/sbin/go-dnsmasq && \
    chmod 774 /usr/sbin/go-dnsmasq /etc/hosts /etc/resolv.conf && \
    # Other + cleanup
    update-ca-certificates --fresh

WORKDIR ${HOME}

COPY bin /

USER 1001

ENTRYPOINT ["/init"]
CMD ["/bin/sh"]
