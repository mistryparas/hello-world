FROM anapsix/alpine-java

MAINTAINER grouptest1

COPY ./target/nexustest2-2.0.*-SNAPSHOT.jar /opt/backend.jar

CMD ["java", "-jar", "/opt/backend.jar"]

EXPOSE 8080:8080
