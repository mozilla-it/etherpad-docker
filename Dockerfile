FROM etherpad/etherpad:1.8.12

ENV SKIN_NAME="no-skin"

COPY index.html src/templates/index.html
