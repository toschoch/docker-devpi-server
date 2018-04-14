FROM alpine:3.7

# RUN apk add --update --no-cache bash ca-certificates && update-ca-certificates
RUN apk add --update --no-cache bash ca-certificates python3 \
    && python3 -m ensurepip \
    && rm -r /usr/lib/python*/ensurepip \
    && pip3 install --upgrade pip setuptools \
    && update-ca-certificates \
    && rm -r /root/.cache

RUN apk add --no-cache --virtual .build-deps gcc python3-dev libffi-dev musl-dev \
    && pip install devpi-server\
        devpi-web\
		devpi-theme-16\
    && apk del .build-deps \
    && rm -r /root/.cache


ENV DEVPI_SERVERDIR /devpi/server

RUN mkdir -p $DEVPI_SERVERDIR

VOLUME $DEVPI_SERVERDIR 

ENV DEVPI_PORT 3141

EXPOSE $DEVPI_PORT

WORKDIR /
ADD serve.sh /

CMD ["./serve.sh"]
