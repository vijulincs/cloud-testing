FROM maven:3.6-jdk-8-alpine

  # Install gauge plugins
  RUN wget "https://github.com/getgauge/gauge/releases/download/v1.0.3/gauge-1.0.3-linux.x86_64.zip" && \
      unzip gauge-1.0.3-linux.x86_64.zip -d/usr/local/bin && \
      rm -rf gauge-1.0.3-linux.x86_64.zip && \
      gauge install java && \
      gauge install html-report && \
      gauge install xml-report && \
      gauge -v && \
      mvn -v

  # Install Cloud SK for GSUTIL
ARG CLOUD_SDK_VERSION=251.0.0
ENV CLOUD_SDK_VERSION=$CLOUD_SDK_VERSION

ENV PATH /google-cloud-sdk/bin:$PATH
RUN apk --no-cache add \
        curl \
        python \
        py-crcmod \
        bash \
        libc6-compat \
        openssh-client \
        git \
        gnupg \
    && curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
    tar xzf google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
    rm google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
    ln -s /lib /lib64 && \
    gcloud config set core/disable_usage_reporting true && \
    gcloud config set component_manager/disable_update_check true && \
    gcloud config set metrics/environment github_docker_image && \
    gcloud --version

RUN apk add --no-cache git
RUN apk --no-cache --update add firefox-esr
WORKDIR /opt
RUN git clone https://github.com/vijulincs/cloud-testing.git
RUN gauge -v
RUN chmod 777 /opt/cloud-testing/driver/geckodriver
cmd cd /opt/cloud-testing; mvn clean test; gsutil cp -f /opt/cloud-testing/reports gs://testbucketsalman/
