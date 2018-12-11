FROM openjdk:10-jdk-slim
MAINTAINER Kane Valentine <kane@cute.im>

RUN set -ex; \
	\
	apt-get update -qq; \
	apt-get install -qq --no-install-suggests --no-install-recommends \
		curl \
		git \
	; \
        apt-get clean; \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV BUILDTOOLS_BUILD 83
ENV BUILDTOOLS_SHA1 580e9adf818315dc3221814a188db0995d780b20

WORKDIR /src/build/spigot/

RUN set -ex; \
	curl -o BuildTools.jar -fSL "https://hub.spigotmc.org/jenkins/job/BuildTools/${BUILDTOOLS_BUILD}/artifact/target/BuildTools.jar"; \
	echo "$BUILDTOOLS_SHA1 *BuildTools.jar" | sha1sum -c -; \
	chmod +x BuildTools.jar

RUN ["java", "-jar", "BuildTools.jar", "--rev", "1.13.2"]
