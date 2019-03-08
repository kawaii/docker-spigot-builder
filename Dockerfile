FROM openjdk:10-jdk-slim
LABEL maintainer="Kane Valentine <kane@cute.im>"

RUN set -ex; \
	\
	apt-get update -qq; \
	apt-get install -qq --no-install-suggests --no-install-recommends \
		curl \
		git \
	; \
        apt-get clean; \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV BUILDTOOLS_BUILD 91
ENV BUILDTOOLS_SHA1 5bfeb7048d630fe5e4b2cbd974ecb785df80e537

WORKDIR /src/build/spigot/

RUN set -ex; \
	curl -o BuildTools.jar -fSL "https://hub.spigotmc.org/jenkins/job/BuildTools/${BUILDTOOLS_BUILD}/artifact/target/BuildTools.jar"; \
	echo "$BUILDTOOLS_SHA1 *BuildTools.jar" | sha1sum -c -; \
	chmod +x BuildTools.jar

RUN ["java", "-jar", "BuildTools.jar", "--rev", "1.13.2"]
