Java Builder Container
======================
Container containing everything you need to build your Java Maven project.
Your code is mapped to a local volume: /project
Your maven dependencies will be cached in a local volume: /repository`

https://codefresh.io/docker-tutorial/java_docker_pipeline/

https://dzone.com/articles/maven-build-local-project-with-docker-why
```
docker build -t javabuilder .

#docker push javabuilder

docker run -it \
           --rm  \
           -v $(pwd):/project \
           -v $(echo "$HOME/.m2/repository"):/repository \
          --name=appdev javabuilder
```
