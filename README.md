To build this slave and push it to Docker Hub

```
docker build . -t jenkins-slave-sbt-centos7
docker tag xxxx gnunn/jenkins-slave-sbt-centos7:latest
docker push gnunn/jenkins-slave-sbt-centos7:latest
```

Note change the gnunn repository reference to your username. To use it in OpenShift, you need to have a configmap that includes it, see the included example.

