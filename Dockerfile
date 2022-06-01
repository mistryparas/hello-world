FROM openjdk:17-alpine
MAINTAINER cloudops-devops

ARG JAR_FILE

RUN echo "JAR_FILE:- ${JAR_FILE}"

COPY ${JAR_FILE} /opt/backend.jar

CMD ["java", "-jar", "/opt/backend.jar"]

EXPOSE 8080:8080
