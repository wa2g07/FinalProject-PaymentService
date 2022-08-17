FROM gradle:jdk17-alpine AS build-stage

COPY ./ ./
RUN  ./gradlew build --exclude-task test 

FROM openjdk:17-alpine

ENV SERVICE_PORT=8083
COPY --from=build-stage /home/gradle/build/libs/PaymentService-0.0.1-SNAPSHOT.jar /app.jar

ENTRYPOINT ["java","-jar","app.jar"]