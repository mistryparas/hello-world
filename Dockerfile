FROM anapsix/alpine-java

MAINTAINER grouptest1

COPY ./env_script.sh /opt/env_script.sh

COPY ./target/nexustest2-4.0.*-SNAPSHOT.jar /opt/backend.jar

CMD ["java", "-jar", "/opt/backend.jar"]

EXPOSE 8080:8080
