# docker-spigot-builder

Dockerfile to automate the Spigot Minecraft server build process. You should use this as part of a multistage build to create your own Spigot server containers, or check out [my own Spigot server container here](https://github.com/kawaii/docker-spigot-server).

Upon a successful build, the Spigot binary will be placed in `/src/build/spigot/` and can be copied out as part of your server Dockerfile instructions. This has the benefit of only running the server binary in a pure JRE environment, without all the build tools and unnecessary bloat within the container:

```
FROM kawaii/spigot-builder:1.13.2 as BUILD

FROM openjdk:11-jre-slim
COPY --from=BUILD /src/build/spigot/spigot-1.13.2.jar /usr/bin/spigot-1.13.2.jar
```
