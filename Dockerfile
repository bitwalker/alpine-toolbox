FROM gliderlabs/alpine:edge

MAINTAINER Paul Schoenfelder <paulschoenfelder@gmail.com>

# Important!  Update this no-op ENV variable when this Dockerfile
# is updated with the current date. It will force refresh of all
# of the base images and things like `apt-get update` won't be using
# old cached versions when the Dockerfile is built.
ENV REFRESHED_AT 2016-04-9 \
    LANG en_US.UTF-8 \
    HOME /opt/me
# Set this so that CTRL+G works properly
ENV TERM=xterm

# Install Erlang
RUN mkdir -p ${HOME} && \
    adduser -s /bin/sh -u 1001 -G root -h ${HOME} -S -D default && \
    chown -R 1001:0 ${HOME} && \
    apk --no-cache upgrade && \
    apk-install \
      curl wget drill tcptraceroute tcpdump ca-certificates \
      elixir vim && \
    update-ca-certificates --fresh

WORKDIR ${HOME}

USER 1001

CMD ["/bin/sh"]
