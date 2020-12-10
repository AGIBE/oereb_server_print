FROM camptocamp/mapfish_print:3.25

RUN apt update && apt-get install --assume-yes gosu && apt-get clean && rm --force --recursive /var/lib/apt/lists/*

ENV TINI_VERSION v0.19.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini

COPY ./print-apps /usr/local/tomcat/webapps/ROOT/print-apps
COPY ./run_mfp_oereb.sh /usr/local/tomcat/bin/

WORKDIR /usr/local/tomcat/bin/

ENTRYPOINT [ "run_mfp_oereb.sh" ]