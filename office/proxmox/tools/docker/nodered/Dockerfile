FROM nodered/node-red:latest

COPY custom-entrypoint.sh /usr/src/node-red/custom-entrypoint.sh

RUN chmod +x /usr/src/node-red/custom-entrypoint.sh

ENTRYPOINT ["/usr/src/node-red/custom-entrypoint.sh"]
