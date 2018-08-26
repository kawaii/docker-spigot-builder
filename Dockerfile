FROM openjdk:10-jdk-slim
MAINTAINER Kane Valentine <kane@cute.im>

RUN set -ex; \
	\
	apt-get update; \
	apt-get install -y --no-install-suggests --no-install-recommends \
		curl \
		git \
	; \
        apt-get clean; \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV BUILDTOOLS_BUILD 75
ENV BUILDTOOLS_SHA1 70129cbf2862472b5c417e53eb3b54e61f810c25

WORKDIR /src/build/spigot/

RUN set -ex; \
	curl -o BuildTools.jar -fSL "https://hub.spigotmc.org/jenkins/job/BuildTools/${BUILDTOOLS_BUILD}/artifact/target/BuildTools.jar"; \
	echo "$BUILDTOOLS_SHA1 *BuildTools.jar" | sha1sum -c -; \
	chmod +x BuildTools.jar

RUN ["java", "-jar", "BuildTools.jar", "--rev", "1.12.2"]
