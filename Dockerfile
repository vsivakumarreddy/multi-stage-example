# ----------- Stage 1: Build the app --------------
FROM openjdk:8-jdk as builder

RUN apt-get update && apt-get install -y maven
RUN mkdir -p /app/source
WORKDIR /app/source

COPY . /app/source
RUN ./mvnw clean package -DskipTests


# ----------- Stage 2: Run the app ----------------
FROM openjdk:8-jdk

WORKDIR /app
COPY --from=builder /app/source/target/*.jar /app/app.jar

EXPOSE 8080

ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app/app.jar"]
