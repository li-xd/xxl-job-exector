FROM openjdk:11.0.13-jdk-buster

ENV PARAMS=""

RUN cd /tmp && apt update && apt install git maven -y &&\
    git clone https://github.com/xuxueli/xxl-job.git -b 2.3.0 &&\
    cd xxl-job/xxl-job-executor-samples/xxl-job-executor-sample-springboot/ &&\
    mvn install &&\
    mv target/xxl-job-executor-sample-springboot-2.3.0.jar /usr/local/bin/xxl-job-executor.jar &&\
    rm -rf /tmp/xxl-job && \
    apt remove git maven -y && apt clean autoclean && apt autoremove --yes && rm -rf /var/lib/{apt,dpkg,cache,log}/

ENTRYPOINT ["sh","-c","java -jar /usr/local/bin/xxl-job-executor.jar $PARAMS"]