FROM ubuntu:18.04

ENV hadoop_ver 2.7.3
ENV spark_ver 2.4.5

RUN apt-get update && \
    apt-get install -y python3 openjdk-8-jdk curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /opt && \
    cd /opt && \
    curl -l https://archive.apache.org/dist/hadoop/core/hadoop-${hadoop_ver}/hadoop-${hadoop_ver}.tar.gz | \
        tar -zx hadoop-${hadoop_ver}/lib/native && \
    ln -s hadoop-${hadoop_ver} hadoop && \
    echo Hadoop ${hadoop_ver} native libraries installed in /opt/hadoop/lib/native
RUN ls -R /opt/hadoop/

RUN mkdir -p /opt && \
    cd /opt && \
    curl -l http://apache.mirrors.pair.com/spark/spark-${spark_ver}/spark-${spark_ver}-bin-hadoop2.7.tgz | \
        tar -zx && \
    ln -s spark-${spark_ver}-bin-hadoop2.7 spark && \
    echo Spark ${spark_ver} installed in /opt

RUN curl https://repo.maven.apache.org/maven2/com/amazonaws/aws-java-sdk/1.7.4/aws-java-sdk-1.7.4.jar -o /opt/spark/jars/aws-java-sdk-1.7.4.jar
RUN curl https://repo.maven.apache.org/maven2/org/apache/hadoop/hadoop-aws/2.7.3/hadoop-aws-2.7.3.jar -o /opt/spark/jars/hadoop-aws-2.7.3.jar


ADD log4j.properties /opt/spark/conf/log4j.properties
ADD spark-defaults.conf /opt/spark/conf/spark-defaults.conf
ENV PATH $PATH:/opt/spark/bin
ENV PYSPARK_DRIVER_PYTHON /usr/bin/python3
