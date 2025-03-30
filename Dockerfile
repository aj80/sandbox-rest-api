FROM maven:3.9.5 as build
WORKDIR /app
COPY pom.xml /app
RUN mvn dependency:resolve
copy . /app
RUN mvn clean
RUN mvn package -DskipTests -X

FROM openjdk:17
COPY --from=build /app/target/*.jar sandbox-rest-example.jar
EXPOSE 8080
CMD ["java", "-jar", "sandbox-rest-example.jar"]

