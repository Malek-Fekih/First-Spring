#
# Build stage
#
FROM maven:3.5.2-jdk-8-alpine AS build
COPY src /home/app/src
COPY pom.xml /home/app
WORKDIR /home/app
RUN mvn clean package

#
# Package stage
#
FROM openjdk:8-jre-alpine
COPY --from=build /home/app/target/new-project-0.0.1-SNAPSHOT.jar /usr/local/lib/app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/usr/local/lib/app.jar"]