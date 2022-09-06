<p align="center">
<img src="https://cryptologos.cc/logos/ravencoin-rvn-logo.png" width="200">
</p>

# [KAWPOW](https://github.com/RavenProject/Ravencoin)

This repository containerizes the Kawpow mining software which runs the [KawPow](https://eips.ethereum.org/EIPS/eip-1057) Proof-of-Work algorithm. 

## [Building](https://github.com/RavenCommunity/kawpowminer#build)

To build the KawPow image locally:

```shell
docker build -t kawpow .
```

You can pull a pre-built image from `tthebc01/kawpow` that is based on [`nvidia/cuda:11.4.0-runtime-ubuntu:18.04`](https://hub.docker.com/layers/nvidia/cuda/11.4.0-runtime-ubuntu18.04/images/sha256-4dfdfec42da3308b94d1f9886f3db1593032c2a8a78586f900c5e29ffa496577?context=explore)

```shell
docker pull tthebc01/kawpow
```

### Customizing the CUDA version

KawPow requires the use of a GPU, so you will need to make sure the host CUDA version and container CUDA versions match. Check what CUDA release you are using:

```shell
nvidia-smi
```

Then build with an appropriate base image using the build-time arg `CUDAVERSION`. For example:

```shell
docker build -t kawpow --build-arg CUDAVERSION=11.4.0 .
```

## Starting KAWPOW

You will likely want to set the following runtime arguments to something besides the defaults:

- `WALLET`: The mining address to which shares should be attributed
- `POOL`: URL or IP address of the stratum server
- `PORT`: Port to connect to on the mining pool

Example:

```shell
docker run --name kawpow -d --rm --env POOL=west.us.rvnt.minermore.com --env PORT=4501 --env WALLET=4BXXX --gpus all tthebc01/kawpow
```