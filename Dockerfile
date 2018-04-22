FROM ubuntu

RUN apt-get update && apt-get install -y software-properties-common
RUN add-apt-repository -y ppa:hugin/hugin-builds && apt-get update

RUN apt-get install -y ffmpeg imagemagick hugin-tools
RUN apt-get install -y curl

COPY entrypoint.sh /opt/entrypoint.sh

ENTRYPOINT /opt/entrypoint.sh
