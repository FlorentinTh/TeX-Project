FROM florentinth/texlive-full:2020

LABEL maintainer "Florentin Thullier <florentin.thullier1@uqac.ca>"

ENV CLEAN=true

RUN apt-get update \
  && apt-get install -y python3-venv python3-pip python3-pygments && rm -rf /var/lib/apt/lists/*

COPY ./docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN cat /usr/local/bin/docker-entrypoint.sh | tr -d '\r' > /usr/local/bin/docker-entrypoint.sh.new
RUN rm -rf /usr/local/bin/docker-entrypoint.sh
RUN mv /usr/local/bin/docker-entrypoint.sh.new /usr/local/bin/docker-entrypoint.sh
RUN chmod 775 /usr/local/bin/docker-entrypoint.sh

RUN mkdir -p /tex

WORKDIR /tex/src

VOLUME [ "/tex/src" ]

ENTRYPOINT docker-entrypoint.sh -c ${CLEAN}