FROM florentinth/texlive-full:latest

LABEL maintainer "Florentin Thullier <florentin.thullier1@uqac.ca>"

COPY ./docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN cat /usr/local/bin/docker-entrypoint.sh | tr -d '\r' > /usr/local/bin/docker-entrypoint.sh.new
RUN rm -rf /usr/local/bin/docker-entrypoint.sh
RUN mv /usr/local/bin/docker-entrypoint.sh.new /usr/local/bin/docker-entrypoint.sh
RUN chmod 775 /usr/local/bin/docker-entrypoint.sh

RUN mkdir -p /tex

COPY . ./tex

WORKDIR /tex/src

RUN cat ./Makefile | tr -d '\r' > ./Makefile.new
RUN rm -rf ./Makefile
RUN mv ./Makefile.new ./Makefile

VOLUME [ "/tex/src" ]

ENTRYPOINT docker-entrypoint.sh -c ${CLEAN}