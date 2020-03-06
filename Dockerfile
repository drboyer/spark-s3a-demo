FROM ubuntu:18.04

# aws_sdk_ver must match the version associated with hadoop-aws
# You can check the package name/version by clicking the version of hadoop in use here:
#     https://mvnrepository.com/artifact/org.apache.hadoop/hadoop-aws
ENV hadoop_ver 3.1.3
ENV spark_ver 2.4.5
ENV aws_sdk_ver 1.11.271

RUN apt-get update && \
    apt-get install -y python3 openjdk-8-jdk curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /opt && \
    cd /opt && \
    curl -l http://apache.mirrors.pair.com/hadoop/common/hadoop-${hadoop_ver}/hadoop-${hadoop_ver}.tar.gz | \
    tar -xz && \
    ln -s hadoop-${hadoop_ver} hadoop && \
    echo "Hadoop ${hadoop_ver} installed"


RUN mkdir -p /opt && \
    cd /opt && \
    curl -l http://apache.mirrors.pair.com/spark/spark-${spark_ver}/spark-${spark_ver}-bin-without-hadoop.tgz | \
        tar -zx && \
    ln -s spark-${spark_ver}-bin-without-hadoop spark && \
    echo "Spark ${spark_ver} installed in /opt"


RUN curl https://repo.maven.apache.org/maven2/org/apache/hadoop/hadoop-aws/${hadoop_ver}/hadoop-aws-${hadoop_ver}.jar -o /opt/spark/jars/hadoop-aws-${hadoop_ver}.jar
RUN curl https://repo.maven.apache.org/maven2/com/amazonaws/aws-java-sdk-bundle/${aws_sdk_ver}/aws-java-sdk-bundle-${aws_sdk_ver}.jar -o /opt/spark/jars/aws-java-sdk-bundle-${aws_sdk_ver}.jar


ADD log4j.properties /opt/spark/conf/log4j.properties
ADD spark-env.sh /opt/spark/conf/spark-env.sh
ADD spark-defaults.conf /opt/spark/conf/spark-defaults.conf
ENV PATH $PATH:/opt/spark/bin
ENV PYSPARK_DRIVER_PYTHON /usr/bin/python3
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/jre/
