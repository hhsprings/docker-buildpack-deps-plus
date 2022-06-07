#! /bin/sh
for myver in 0.2 latest ; do
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

        if test "${myver}" = "latest" ; then
            docker build -f Dockerfile \
                   -t hhsprings/buildpack-deps-plus:latest \
                   --build-arg _BUILDPACKDEPS_TAG=${bpd_ver} .
        fi
    done
done
