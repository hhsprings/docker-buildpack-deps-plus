#! /bin/sh
export __push=$(if test "z${1}" = "z--push" ; then echo true ; else echo false ; fi)
myver=0.3
target_latest=22.10

trap 'rm -f _suites' 0 1 2 3 15
cat << __EOF__ > _suites
bookworm
bullseye
buster
sid
stretch
xenial
16.04
bionic
18.04
focal
20.04
hirsute
21.04
impish
21.10
jammy
22.04
kinetic
22.10
__EOF__

docker buildx create --name=mybuilder --use  # for multiple platforms
for bpd_ver in `tac _suites | grep -v ^#` ; do
    t="${myver}-from-${bpd_ver}"
    t_opt="-t hhsprings/buildpack-deps-plus:${t}"
    if test "${bpd_ver}" = "${target_latest}" ; then
        t_opt="${t_opt} -t hhsprings/buildpack-deps-plus:latest"
    fi
    docker buildx build -f Dockerfile \
           ${t_opt} \
           --build-arg _BUILDPACKDEPS_TAG=${bpd_ver} \
           --platform linux/arm/v5 \
           -o type=image,push=${__push} \
           .
done
#linux/amd64,linux/ppc64le,linux/arm64/v8,linux/mips64le,linux/riscv64,linux/i386,linux/arm/v7,linux/s390x
