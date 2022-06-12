FROM anapsix/alpine-java

MAINTAINER grouptest1

COPY ./env_script.sh /opt/env_script.sh

COPY ./target/automation-0.0.*-SNAPSHOT.jar /opt/backend.jar

CMD ["openssl", "rand", "-base64", "6", ">", "/tmp/hostname.txt"]

CMD ["java", "-jar", "/opt/backend.jar"]

EXPOSE 8080:8080
