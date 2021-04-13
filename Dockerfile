FROM debian

ENV KAFKA_VERSION=2.7.0
ENV KAFKA_URL=https://apache.mirrors.nublue.co.uk/kafka/${KAFKA_VERSION}/kafka_2.13-${KAFKA_VERSION}.tgz
ENV KAFKA_TMP_DEST=/opt/kafka.tgz
ENV KAFKA_WORKDIR=/opt/kafka

RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y \
  software-properties-common \
  awscli \
  python3 python3-pip \
  dnsutils net-tools \
  curl traceroute tcpdump httpie \
  jq \
  htop \
  wget \ 
  openjdk-11-jdk \ 
  ant \
  unzip \
  ca-certificates-java && \ 
  apt-get clean && \
  update-ca-certificates -f;
    
# Setup JAVA_HOME -- useful for docker commandline
ENV JAVA_HOME /usr/lib/jvm/java-11-openjdk-amd64/
RUN export JAVA_HOME
RUN wget $KAFKA_URL -O ${KAFKA_TMP_DEST} && \
    mkdir -p ${KAFKA_WORKDIR} && \
    tar -xvzpf ${KAFKA_TMP_DEST} --strip-components=1 -C ${KAFKA_WORKDIR}
    
ADD bashrc /root/.bashrc

WORKDIR /opt/kafka

CMD "bash"
