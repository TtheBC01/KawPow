<p align="center">
<img src="https://cryptologos.cc/logos/ravencoin-rvn-logo.png" width="200">
</p>

# [KAWPOW](https://github.com/RavenProject/Ravencoin)

This repository containerizes the Kawpow mining software which runs the [KawPow](https://eips.ethereum.org/EIPS/eip-1057) Proof-of-Work algorithm. 

## [Building](https://xmrig.com/docs/miner/build/ubuntu)

To build the KawPow image locally:

```shell
docker build -t kawpow .
```

You can pull a pre-built image from `tthebc01/kawpow` that is based on [`nvidia/cuda:11.4.0-runtime-ubuntu:18.04`](https://hub.docker.com/layers/nvidia/cuda/11.4.0-runtime-ubuntu18.04/images/sha256-4dfdfec42da3308b94d1f9886f3db1593032c2a8a78586f900c5e29ffa496577?context=explore)

```shell
docker pull tthebc01/kawpow
```

### Customizing the CUDA version

If you are going to use your GPU with this image, you will need to make sure the host CUDA version and container CUDA versions match. Check what CUDA release you are using:

```shell
nvidia-smi
```

Then build with an appropriate base image using the build-time arg `CUDAVERSION`:

```shell
docker build -t kawpow --build-arg CUDAVERSION=11.4.0 .
```

## Starting KAWPOW

You will need the following information handy to start the container:

1. The address and port of the [stratum](https://en.bitcoinwiki.org/wiki/Stratum_mining_protocol) server for the pool you want to mine with. Some popular choices are [2Miners](https://2miners.com/rvn-mining-pool), [MineMore](https://minermore.com/pool/RVN/), or [Nanopool](https://nanopool.org/).
2. The address of the wallet you want to receive you mining rewards in.
3. A name for your mining rig. 

```shell
docker run -d --rm --env POOL=west.us.rvnt.minermore.com --env PORT=4501 --env RIG_ID="cyberskull" --env WALLET=4BXXX --gpus all tthebc01/kawpow
```