FROM anapsix/alpine-java

MAINTAINER grouptest1

COPY ./target/nexustest2-2.0.*-SNAPSHOT.jar /opt/backend.jar

ENTRYPOINT ["/bin/sh", "/opt/env_script.sh"]

EXPOSE 8080:8080
