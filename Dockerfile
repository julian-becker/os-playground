FROM ubuntu:trusty
MAINTAINER Julian Becker <becker.julian@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -y \
 && apt-get install --no-install-recommends -y \
                    git ca-certificates \
                    x11vnc \
                    wget \
                    Xvfb \
                    openbox \
                    menu \
                    python \
                    python-numpy \
                    python-pip

RUN pip install pyxdg

RUN git clone https://github.com/kanaka/noVNC.git /root/noVNC

RUN git clone https://github.com/kanaka/websockify /root/noVNC/utils/websockify
RUN apt-get update \
 && apt-get install --no-install-recommends -y \
                    qemu

ENV DISPLAY :1

RUN echo ""
ADD startup.sh /startup.sh
RUN chmod 0755 /startup.sh

CMD /startup.sh
EXPOSE 6080
