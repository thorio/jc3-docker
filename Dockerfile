FROM cm2network/steamcmd:root

ENV APPDIR=/app \
	STEAMAPPID=619960

RUN apt update &&\
	apt upgrade -y &&\
	apt install wget zip -y &&\
	mkdir -p ${APPDIR}/packages &&\
	wget https://dl.nanos.io/packages.zip -O ${APPDIR}/packages.zip &&\
	unzip ${APPDIR}/packages.zip -d ${APPDIR}/packages &&\
	rm ${APPDIR}/packages.zip &&\
	chown ${USER}:${USER} -R ${APPDIR}

USER ${USER}

RUN bash "${STEAMCMDDIR}/steamcmd.sh" +login anonymous +force_install_dir "$APPDIR" +app_update "$STEAMAPPID" +quit

COPY ./files ${APPDIR}/

WORKDIR ${APPDIR}

ENTRYPOINT ["/bin/bash", "./entry.sh"]
