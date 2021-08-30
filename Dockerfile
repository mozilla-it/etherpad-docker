FROM etherpad/etherpad:1.8.12

USER root

RUN export DEBIAN_FRONTEND=noninteractive; \
    mkdir -p /usr/share/man/man1 && \
    apt-get -qq update && \
    apt-get -qq --no-install-recommends install \
        ca-certificates \
        curl \
        jq \
        && \
    apt-get -qq clean && \
    rm -rf /var/lib/apt/lists/*

USER etherpad

ENV SKIN_NAME="no-skin"

COPY etherpad-manage.sh .
COPY index.html src/templates/index.html
