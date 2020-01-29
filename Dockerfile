FROM openjdk:12-jdk-alpine

ARG BUILD_AUTHORS
ARG BUILD_DATE
ARG BUILDTOOLS_BUILD
ARG BUILDTOOLS_SHA1SUM
ARG BUILD_VERSION

LABEL org.opencontainers.image.authors=$BUILD_AUTHORS \
      org.opencontainers.image.created=$BUILD_DATE \
      org.opencontainers.image.version=$BUILD_VERSION

RUN set -ex; \
	\
	apk add --update \
		curl \
		git

ENV BUILDTOOLS_BUILD $BUILDTOOLS_BUILD
ENV BUILDTOOLS_SHA1 $BUILDTOOLS_SHA1SUM

WORKDIR /src/build/spigot/

RUN set -ex; \
	curl -o BuildTools.jar -fSL "https://hub.spigotmc.org/jenkins/job/BuildTools/${BUILDTOOLS_BUILD}/artifact/target/BuildTools.jar"; \
	echo "$BUILDTOOLS_SHA1 *BuildTools.jar" | sha1sum -c -; \
	chmod +x BuildTools.jar

ENV BUILD_VERSION $BUILD_VERSION
RUN java -jar BuildTools.jar --rev ${BUILD_VERSION}
