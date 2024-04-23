# Stage 1: Build the application
FROM maven:3.8.4-openjdk-8 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package

# Stage 2: Create the final image
FROM adoptopenjdk:8-jdk-hotspot
WORKDIR /app
COPY --from=build /app/target/*jar /app/app.jar

# Set entrypoint (adjust based on your application)
ENTRYPOINT ["java", "-jar", "app.jar"]

# Set the final image name (referencing the ARG)
LABEL name=dkalunge/spring-boot-in-k8-via-terraform