#
ARG _BUILDPACKDEPS_TAG=22.04
FROM buildpack-deps:${_BUILDPACKDEPS_TAG}
ARG __APT_Y="-yq --no-install-recommends"

# ----------------------------------------------------------
#
# Install developping tools that buildpack-deps doesn't
# install but are very often needed.
#
# ----------------------------------------------------------
RUN apt-get -q update && \
    apt-get ${__APT_Y} upgrade
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
