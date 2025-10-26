FROM maven:3.8.6-openjdk-11 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

FROM openjdk:11-jre-slim
WORKDIR /app
COPY --from=build /app/target/blue-green-app-1.0.jar /app/app.jar
EXPOSE 8080
CMD ["java", "-jar", "app.jar"]