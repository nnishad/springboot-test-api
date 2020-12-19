FROM openjdk:8-jre-alpine
ADD test-service-0.0.1-SNAPSHOT.jar test-service-0.0.1-SNAPSHOT.jar
CMD java -Xmx200m -jar test-service-0.0.1-SNAPSHOT.jar
