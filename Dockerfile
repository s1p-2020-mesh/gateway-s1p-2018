ARG  JAVA_VERSION
FROM adoptopenjdk:${JAVA_VERSION:-8}-jre-hotspot
RUN mkdir /opt/app
COPY target/*-0.0.1-SNAPSHOT.jar /opt/app/app.jar
CMD ["java", "-jar", "/opt/app/app.jar"]