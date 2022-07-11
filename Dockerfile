FROM openjdk:11
ADD target/student-microservice-jenkins-*.jar student-microservice-jenkins.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar","-Xms256m","-Xmx2048m","/student-microservice-jenkins.jar"]
