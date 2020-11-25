FROM ubuntu:18.04

WORKDIR /root

ADD sources.tar.gz /etc/apt/

RUN apt update -y && \
    apt install git build-essential cmake libgtk2.0-dev pkg-config \
    libavcodec-dev libavformat-dev libswscale-dev -y && \
    git clone --depth 1 https://github.com/opencv/opencv.git --branch 4.3.0 && \
    cd opencv && mkdir build && cd build && \
    cmake -D CMAKE_BUILD_TYPE=Release -D BUILD_SHARED_LIBS=NO .. && \
    cat /proc/cpuinfo | grep "processor" | wc -l | xargs make -j && \
    make install && cd ../.. && \
    rm -rf opencv

RUN apt install libeigen3-dev -y
