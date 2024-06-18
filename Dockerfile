#
# Build stage
#
FROM maven:3.8.5-openjdk-17 AS build
COPY src /home/app/src
COPY pom.xml /home/app
RUN mvn -f /home/app/pom.xml clean package -DskipTests

#
# Package stage
#
FROM openjdk:17.0.1-jdk-slim
COPY --from=build /home/app/target/nlr-pt-7-1.0.jar nlr-pt-7.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "nlr-pt-7.jar"]