ARG CUDAVERSION=11.4.0

# Build layer
FROM nvidia/cuda:${CUDAVERSION}-devel-ubuntu18.04 as builder

# install required packages
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    git \
    build-essential \
    cmake \
    automake \
    libtool \
    autoconf \
    wget \ 
    libgl-dev

# build the kawpow binary
RUN git clone https://github.com/RavenCommunity/kawpowminer.git
RUN cd kawpowminer && \
    git submodule update --init --recursive && \
    mkdir build && \
    cd build && \
    cmake .. -DETHASHCUDA=ON -DETHASHCL=ON -DAPICORE=ON
WORKDIR /kawpowminer/build
RUN make -sj $(nproc)

# Runtime layer
FROM nvidia/cuda:${CUDAVERSION}-runtime-ubuntu18.04

# Set some defaults
ENV PATH=/kawpowminer/build/kawpowminer:$PATH
ENV POOL=west.us.rvnt.minermore.com
ENV PORT=4501

# get the binaries from the previous layer
COPY --from=builder /kawpowminer/build /kawpowminer/build 

# add a non-root user
RUN useradd -ms /bin/bash kawpowminer
USER kawpowminer
WORKDIR /home/kawpowminer

# get entrypoint script
COPY kawpow.sh .

# set entrypoint
ENTRYPOINT ["bash","kawpow.sh"]