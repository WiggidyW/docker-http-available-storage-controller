FROM alpine

LABEL maintainer="wiggidy" mail="wiggidy@riseup.net"
LABEL description="Controller for wiggidy/http-available-storage which returns the IP of the node with the most available storage. (KUBERNETES)"

ENV POD_PORT=8080 \
    POD_NAMESPACE=default \
    POD_LABELS=app=wiggidy-storage,tier=daemonset

RUN apk add --no-cache python3 \
 && pip3 install --no-cache-dir \
# Installing requests manually even though kubernetes includes it to prepare for the unlikely scenario where kubernetes library no longer includes it.
    requests \
    kubernetes

COPY ./root /

RUN chmod +x /init.py

EXPOSE 8080

CMD ["/init.sh"]
