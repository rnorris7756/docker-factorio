FROM ubuntu:16.04

RUN  apt-get update \
  && apt-get install -y curl xz-utils\
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

RUN useradd -m -d /opt/factorio -s /bin/bash factorio \
  && chown -R factorio.factorio /opt/factorio
USER factorio

ENV HOME /opt/factorio
ENV SAVEFILE /opt/factorio/saves/factorio_save.zip

WORKDIR /opt/factorio

RUN   curl -s https://www.factorio.com/download-headless/experimental | grep -m1 -o "/get-download/.*/headless/linux64" | awk '{print " -L https://www.factorio.com"$1" -o /tmp/factorio.tar.xz"}' | xargs curl \
&& tar xf /tmp/factorio.tar.xz -C /opt \
&& rm -rf /tmp/factorio.tar.xz

ADD  init.sh /opt/factorio/

EXPOSE 34197/udp
CMD ["./init.sh"]
