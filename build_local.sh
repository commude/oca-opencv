#! /bin/bash

# Determine the number of CPUs to build with.
if [ -n "${MAX_JOBS}" ]; then
    MAKE_NCPUS="$MAX_JOBS"
elif [ -n "${MAKE_NCPUS}" ]; then
    MAKE_NCPUS="$MAKE_NCPUS"
elif [ "$(uname)" == 'Darwin' ]; then
    MAKE_NCPUS="$(sysctl -n hw.ncpu)"
else
    MAKE_NCPUS="$(nproc)"
fi

ROOT_DIRECTORY="$( cd `dirname $0`; pwd -P )"
mkdir -p $ROOT_DIRECTORY/build
cd "$ROOT_DIRECTORY/build"
cmake $ROOT_DIRECTORY "$@"
make -j$MAKE_NCPUS
make install

