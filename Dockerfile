FROM maven:3.6.0-jdk-8

  # Install gauge plugins
  RUN wget "https://github.com/getgauge/gauge/releases/download/v1.0.0/gauge-1.0.0-linux.x86_64.zip" && \
unzip gauge-1.0.0-linux.x86_64.zip -d/usr/local/bin && \
rm -rf gauge-1.0.0-linux.x86_64.zip && \
gauge install java && \
      gauge install html-report && \
      gauge install xml-report && \
      gauge -v && \
      mvn -v

FROM alpine/git as clone
WORKDIR /usr/local/bin
RUN git clone https://github.com/vijulincs/cloud-testing.git
FROM maven:3.6-jdk-8-alpine
WORKDIR /usr/local/bin
COPY --from=clone /usr/local/bin/cloud-testing /usr/local/bin
cmd mvn clean test
