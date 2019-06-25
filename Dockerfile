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

RUN apk add --no-cache git
RUN apk --no-cache --update add firefox-esr
WORKDIR /opt
RUN git clone https://github.com/vijulincs/cloud-testing.git
RUN gauge -v
RUN chmod 777 /opt/cloud-testing/driver/geckodriver
cmd cd /opt/cloud-testing; mvn clean test
