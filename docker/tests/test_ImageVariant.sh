#!/bin/bash

ROOT=~/practice/docker
DIR=~/practice/docker/concepts

PASS=0
FAIL=0

# CASE 1: build with alpine
docker build \
    --check \
    -t build_with_alpine \
    -f ${DIR}/ImageVariant.Dockerfile \
    --build-arg IMAGE=alpine \
    ${ROOT}
exit_code=$?
if [ $exit_code -eq 0 ]; then
    ((PASS++))
else
    ((FAIL++))
fi

# CASE 2: image tag
docker build \
    --check \
    -t build_with_alpine:3.22 \
    -f ${DIR}/ImageVariant.Dockerfile \
    --build-arg IMAGE=alpine \
    --build-arg TAG=3.22 \
    ${ROOT}

exit_code=$?
if [ $exit_code -eq 0 ]; then
    ((PASS++))
    echo $'\e[32m'Case 2: Image and Tag [PASS]$'\e[0m'
else
    ((FAIL++))
    echo $'\e[31m'Case 2: Image and Tag [FAIL]$'\e[0m'
fi

# CASE 3: can't use buildArg in From
if [ ! -d ${ROOT}/tmp ]; then
    mkdir ${ROOT}/tmp
fi

cat > ${ROOT}/tmp/case3.Dockerfile << 'EOF'
# check=skip=all
ARG BADARG=cantUseAsFrom
FROM scratch AS "$BADARG"
EOF

docker build \
    -f ${ROOT}/tmp/case3.Dockerfile \
    --build-arg BADARG=heyboss \
    ${ROOT}

exit_code=$?
if [ $exit_code -eq 1 ]; then
    ((PASS++))
    echo $'\e[32m'Case 3: Invalid ARG in FROM [PASS - Expected failure]$'\e[0m'
else 
    ((FAIL++))
    echo $'\e[31m'Case 3: Invalid ARG in FROM [FAIL - Should have failed]$'\e[0m'
fi
rm -r ${ROOT}/tmp

TOTAL=$((PASS+FAIL))
if [ $FAIL -eq 0 ]; then
    echo $'\e[32m'✓ ImageVariant Test: $PASS/$TOTAL tests passed$'\e[0m'
else
    echo $'\e[31m'✗ ImageVariant Test: $PASS/$TOTAL tests passed, $FAIL failed$'\e[0m'
fi