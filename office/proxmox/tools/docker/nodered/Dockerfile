FROM nodered/node-red:latest

COPY custom-entrypoint.sh /custom-entrypoint.sh

RUN ls -la && chmod +x /custom-entrypoint.sh

ENTRYPOINT ["/custom-entrypoint.sh"]
