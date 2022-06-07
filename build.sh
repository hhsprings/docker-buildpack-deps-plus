#! /bin/sh
myver=0.3
target_latest=22.10

for bpd_ver in \
             bookworm \
             bullseye \
             buster \
             sid \
             stretch \
             \
             xenial 16.04 \
             bionic 18.04 \
             focal 20.04 \
             hirsute 21.04 \
             impish 21.10 \
             jammy 22.04 \
             kinetic 22.10 \
    ; do
    t="${myver}-from-${bpd_ver}"

    docker build -f Dockerfile \
           -t hhsprings/buildpack-deps-plus:${t} \
           --build-arg _BUILDPACKDEPS_TAG=${bpd_ver} \
           --platform linux/amd64 \
           .
    if test "${bpd_ver}" = "${target_latest}" ; then
        docker tag \
               hhsprings/buildpack-deps-plus:${t} \
               hhsprings/buildpack-deps-plus:latest
    fi

done
