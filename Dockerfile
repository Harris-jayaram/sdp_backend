# Stage 1: Build the application
FROM maven:3.8.5-openjdk-17 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the entire project into the working directory
COPY . .

# Run Maven to clean and package the project, skipping tests
RUN mvn clean package -DskipTests

# Stage 2: Create a smaller image with the application
FROM openjdk:17.0.1-jdk-slim

# Copy the built JAR file from the build stage
COPY --from=build /app/target/demo-0.0.1-SNAPSHOT.jar demo.jar

# Expose the port on which the application will run
EXPOSE 7777

# Define the entry point to run the application
ENTRYPOINT ["java", "-jar", "demo.jar"]
