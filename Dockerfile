#
ARG _BUILDPACKDEPS_TAG=22.04
FROM --platform=linux/amd64,linux/ppc64le,linux/arm64/v8,linux/mips64le,linux/riscv64,linux/i386,linux/arm/v7,linux/arm/v5,linux/s390x buildpack-deps:${_BUILDPACKDEPS_TAG}
ARG __APT_Y="-yq --no-install-recommends"

# ----------------------------------------------------------
#
# Install developping tools that buildpack-deps doesn't
# install but are very often needed.
#
# ----------------------------------------------------------
RUN apt-get update
RUN apt-get install ${__APT_Y} yasm
RUN apt-get install ${__APT_Y} cmake
RUN apt-get install ${__APT_Y} libexpat1-dev
RUN apt-get install ${__APT_Y} libtiff-dev
RUN apt-get install ${__APT_Y} libopenjp2-7-dev

# ----------------------------------------------------------
#
# Cleanup
#
# ----------------------------------------------------------
RUN rm -rf /var/lib/apt/lists/*
