FROM alpine:latest
# yosys
RUN apt-get update && apt-get install -y \
    git \
    build-essential clang lld libfl-dev \
	libreadline-dev gawk tcl-dev libffi-dev \
	graphviz xdot pkg-config python3 libboost-system-dev \
	libboost-python-dev libboost-filesystem-dev zlib1g-dev
RUN cd /usr/local/bin \
    git clone https://github.com/YosysHQ/yosys.git \
    cd yosys \
    git submodule update --init --recursive \
    make -j8 \
    make install