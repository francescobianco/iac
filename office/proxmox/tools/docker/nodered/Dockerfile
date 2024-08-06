FROM nodered/node-red:latest

USER root
COPY custom-entrypoint.sh /custom-entrypoint.sh
RUN ls -la && chmod +x /custom-entrypoint.sh

USER node-red
ENTRYPOINT ["/custom-entrypoint.sh"]
