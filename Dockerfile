FROM gliderlabs/alpine:latest

MAINTAINER Paul Schoenfelder <paulschoenfelder@gmail.com>

# Important!  Update this no-op ENV variable when this Dockerfile
# is updated with the current date. It will force refresh of all
# of the base images and things like `apt-get update` won't be using
# old cached versions when the Dockerfile is built.
ENV REFRESHED_AT 2016-04-6 \
    LANG en_US.UTF-8 \
    HOME /opt/me
# Set this so that CTRL+G works properly
ENV TERM=xterm

# Install Erlang
RUN mkdir -p ${HOME} && \
    adduser -s /bin/sh -u 1001 -G root -h ${HOME} -S -D default && \
    chown -R 1001:0 ${HOME} && \
    echo 'http://dl-4.alpinelinux.org/alpine/edge/main' >> /etc/apk/repositories && \
    echo 'http://dl-4.alpinelinux.org/alpine/edge/community' >> /etc/apk/repositories && \
    apk -U upgrade && \
    apk --update add curl wget tcpdump python python-dev ncurses-libs ca-certificates \
                     erlang erlang-dev erlang-kernel erlang-hipe erlang-compiler \
                     erlang-stdlib erlang-erts erlang-tools erlang-syntax-tools erlang-sasl \
                     erlang-crypto erlang-public-key erlang-ssl erlang-ssh erlang-asn1 \
                     erlang-inets erlang-mnesia erlang-odbc erlang-xmerl erlang-runtime-tools \
                     erlang-observer erlang-os-mon erlang-erl-interface erlang-parsetools && \
    update-ca-certificates --fresh && \
    rm -rf /var/cache/apk/*

USER default

CMD ["/bin/sh"]
