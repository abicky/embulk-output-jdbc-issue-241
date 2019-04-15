FROM openjdk:8u212-jdk-stretch

RUN curl --create-dirs -o ~/.embulk/bin/embulk -L "https://dl.bintray.com/embulk/maven/embulk-0.9.17.jar" \
  && chmod +x ~/.embulk/bin/embulk

RUN apt update \
  && apt install -y --no-install-recommends mysql-client \
  && curl --silent --show-error --location --fail --retry 3 --output /tmp/dockerize-linux-amd64.tar.gz https://circle-downloads.s3.amazonaws.com/circleci-images/cache/linux-amd64/dockerize-latest.tar.gz \
  && tar -C /usr/local/bin -xzvf /tmp/dockerize-linux-amd64.tar.gz \
  && rm -rf /tmp/dockerize-linux-amd64.tar.gz \
  && dockerize --version

WORKDIR /embulk

COPY bundle /embulk/bundle
RUN cd bundle && ~/.embulk/bin/embulk bundle

COPY . /embulk/

ENV PATH ~/.embulk/bin/:$PATH

CMD ["dockerize", "-wait", "tcp://mysql:3306", "./run.sh"]
