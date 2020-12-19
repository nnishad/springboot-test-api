FROM openjdk:8-jre-alpine
ADD admin/demo-0.0.1-SNAPSHOT.jar demo-0.0.1-SNAPSHOT.jar
CMD java -Xmx200m -jar demo-0.0.1-SNAPSHOT.jar
