# docker-spigot-builder

Dockerfile to automate the Spigot Minecraft server build process. You should use this as part of a multistage build to create your own Spigot server containers, or check out [my own Spigot server container here](https://github.com/kawaii/docker-spigot-server).

Upon a successful build, the Spigot binary will be placed in `/src/build/spigot/` and can be copied out as part of your server Dockerfile instructions. This has the benefit of only running the server binary in a pure JRE environment, without all the build tools and unnecessary bloat within the container:

```
FROM kawaii/spigot-builder:1.15.2 as BUILD

FROM openjdk:12-jdk-alpine
COPY --from=BUILD /src/build/spigot/spigot-1.15.2.jar /usr/bin/spigot.jar
```

## Usage

### ... via [`docker build`](https://docs.docker.com/engine/reference/commandline/build/)
This image requires a number of build-time arguments to be passed through. It should be noted that this is **not** a Spigot server image but rather an image to _build_ a server binary to then be used in other images. The `BUILD_AUTHORS` and `BUILD_DATE` arguments are optional and not required to build a working image. 

```
docker build \                         
  --build-arg BUILD_AUTHORS="Kane 'kawaii' Valentine <kane@cute.im>" \
  --build-arg BUILD_DATE=$(date -u +'%Y-%m-%dT%H:%M:%SZ') \
  --build-arg BUILDTOOLS_BUILD=101 \
  --build-arg BUILDTOOLS_SHA1SUM=a6ef99c422578158b12239e5a2654314dd82aa4c \
  --build-arg BUILD_VERSION=1.15.2 \
  --tag kawaii/spigot-builder:1.15.2 \
$PWD
```
