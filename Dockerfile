FROM ubuntu

RUN apt-get update && apt-get install -y software-properties-common
RUN add-apt-repository -y ppa:hugin/hugin-builds && apt-get update

RUN apt-get install -y ffmpeg imagemagick hugin-tools
RUN apt-get install -y curl

RUN export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)" && \
		echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
		curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -

RUN apt-get update && apt-get install -y google-cloud-sdk

COPY entrypoint.sh /opt/entrypoint.sh

ENTRYPOINT /opt/entrypoint.sh
