FROM openjdk:8-jre-slim

# aws_sdk_ver must match the version associated with hadoop-aws
# You can check the package name/version by clicking the version of hadoop in use here:
#     https://mvnrepository.com/artifact/org.apache.hadoop/hadoop-aws
ENV hadoop_ver 3.1.3
ENV spark_ver 2.4.5
ENV aws_sdk_ver 1.11.271

ARG spark_uid=185

RUN apt-get update && \
    apt-get install -y curl libpam-modules python3 python3-pip tini && \
    echo "auth required pam_wheel.so use_uid" >> /etc/pam.d/su && \
    chgrp root /etc/passwd && chmod ug+rw /etc/passwd && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /opt && \
    cd /opt && \
    curl -l http://apache.mirrors.pair.com/hadoop/common/hadoop-${hadoop_ver}/hadoop-${hadoop_ver}.tar.gz | \
    tar -xz && \
    ln -s hadoop-${hadoop_ver} hadoop && \
    echo "Hadoop ${hadoop_ver} installed"


# TODO: Can we not extract all directories from the spark archive?
RUN cd /opt && \
    curl -l http://apache.mirrors.pair.com/spark/spark-${spark_ver}/spark-${spark_ver}-bin-without-hadoop.tgz | \
        tar -zx && \
    ln -s spark-${spark_ver}-bin-without-hadoop spark && \
    mkdir -p /opt/spark/work-dir && \
    cp /opt/spark/kubernetes/dockerfiles/spark/entrypoint.sh /opt && \
    echo "Spark ${spark_ver} installed in /opt"


RUN curl https://repo.maven.apache.org/maven2/org/apache/hadoop/hadoop-aws/${hadoop_ver}/hadoop-aws-${hadoop_ver}.jar -o /opt/spark/jars/hadoop-aws-${hadoop_ver}.jar
RUN curl https://repo.maven.apache.org/maven2/com/amazonaws/aws-java-sdk-bundle/${aws_sdk_ver}/aws-java-sdk-bundle-${aws_sdk_ver}.jar -o /opt/spark/jars/aws-java-sdk-bundle-${aws_sdk_ver}.jar


ADD log4j.properties /opt/spark/conf/log4j.properties
ADD spark-env.sh /opt/spark/conf/spark-env.sh
ADD spark-defaults.conf /opt/spark/conf/spark-defaults.conf
ADD decom.sh /opt/decom.sh

# ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/jre/
ENV SPARK_HOME /opt/spark
ENV PATH $PATH:${SPARK_HOME}/bin
ENV PYSPARK_DRIVER_PYTHON /usr/bin/python3

WORKDIR /opt/spark/work-dir
RUN chmod g+w /opt/spark/work-dir

ENTRYPOINT [ "/opt/entrypoint.sh" ]

# Specify the User that the actual main process will run as
USER ${spark_uid}
