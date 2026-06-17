FROM camptocamp/mapfish_print:4.0

LABEL org.opencontainers.image.source=https://github.com/AGIBE/oereb_server_print
LABEL org.opencontainers.image.description="ÖREB-Server Kanton Bern - Print Engine"

RUN apt update && apt-get install --assume-yes gosu && apt-get clean && rm --force --recursive /var/lib/apt/lists/*

ENV TINI_VERSION=v0.19.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /usr/local/tomcat/bin/tini

COPY ./print-apps /usr/local/tomcat/webapps/ROOT/print-apps
COPY ./run_mfp_oereb.sh /usr/local/tomcat/bin/

WORKDIR /usr/local/tomcat/bin/
RUN groupadd oereb && useradd -g oereb oerebrunner
RUN chown -R oerebrunner:oereb /usr/local/tomcat/bin
RUN chown -R oerebrunner:oereb /usr/local/tomcat/webapps/ROOT/print-apps

RUN chmod +x run_mfp_oereb.sh
RUN chmod +x tini

ENTRYPOINT [ "gosu", "oerebrunner", "tini", "--" ]
CMD [ "run_mfp_oereb.sh" ]