ARG UBUNTU_VERSION=22.04
ARG NVIDIA_CUDA_VERSION=12.3.1

#
# Docker builder stage.
#
FROM nvidia/cuda:${NVIDIA_CUDA_VERSION}-devel-ubuntu${UBUNTU_VERSION} as builder


ARG CUDA_ARCHITECTURES=native
ENV QT_XCB_GL_INTEGRATION=xcb_egl

# Prevent stop building ubuntu at time zone selection.
ENV DEBIAN_FRONTEND=noninteractive

# Prepare and empty machine for building.
RUN apt-get update && \
    apt-get install -y --no-install-recommends --no-install-suggests \
        git \
        cmake \
        ninja-build \
        build-essential \
        libboost-program-options-dev \
        libboost-filesystem-dev \
        libboost-graph-dev \
        libboost-system-dev \
        libeigen3-dev \
        libflann-dev \
        libfreeimage-dev \
        libmetis-dev \
        libgoogle-glog-dev \
        libgtest-dev \
        libsqlite3-dev \
        libglew-dev \
        qtbase5-dev \
        libqt5opengl5-dev \
        libcgal-dev \
        libceres-dev

# Build and install COLMAP.
ARG COLMAP_GIT_COMMIT=5966e487f6fdaa29c5fee7121a3d863d289d0eb7

RUN git clone https://github.com/colmap/colmap.git
RUN cd colmap && \
    git fetch https://github.com/colmap/colmap.git ${COLMAP_GIT_COMMIT} && \
    git checkout FETCH_HEAD && \
    mkdir build && \
    cd build && \
    cmake .. -GNinja -DCMAKE_CUDA_ARCHITECTURES=${CUDA_ARCHITECTURES} \
        -DCMAKE_INSTALL_PREFIX=/colmap_installed && \
    ninja install

RUN cp -r /colmap_installed /usr/local/


# Install PoseLib
ARG POSELIB_GIT_COMMIT=0439b2d361125915b8821043fca9376e6cc575b9

RUN git clone --recursive https://github.com/vlarsson/PoseLib.git
RUN cd PoseLib && \
    git fetch https://github.com/vlarsson/PoseLib.git ${POSELIB_GIT_COMMIT} && \
    git checkout FETCH_HEAD && \
    mkdir build && \
    cd build && \
    cmake .. -GNinja -DCMAKE_INSTALL_PREFIX=/poselib_installed && \
    ninja install

RUN cp -r /poselib_installed /usr/local/


# Install Glomap
ARG GLOMAP_GIT_COMMIT=main

RUN git clone --recursive https://github.com/bidbest/glomap.git
RUN cd glomap && \
    git fetch https://github.com/bidbest/glomap.git ${GLOMAP_GIT_COMMIT} && \
    git checkout FETCH_HEAD && \
    mkdir build && \
    cd build && \
    cmake .. -GNinja -DCMAKE_INSTALL_PREFIX=/glomap_installed && \
    ninja install

RUN cp -r /glomap_installed /usr/local/

# Add all paths 
RUN echo "export PATH=${PATH}:/usr/local/colmap_installed/bin:/usr/local/poselib_installed/bin:/usr/local/glomap_installed/bin" >> ~/.bashrc