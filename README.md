matsuu/hengband
===============

Dockerfile for 変愚蛮怒(hengband)

## Container Image

* Docker Hub [matsuu/hengband](https://hub.docker.com/r/matsuu/hengband/)
* GitHub Container Registry [ghcr.io/matsuu/hengband](https://github.com/matsuu/docker-nethack/pkgs/container/hengband)

## Usage

### tty

    docker run -it matsuu/hengband

### x11

    xhost +
    docker run -it matsuu/hengband -mx11

fontsize 24pt:

    docker run -it -e ANGBAND_X11_FONT=monospace-24 matsuu/hengband -mx11

### Help

    docker run -it --rm matsuu/hengband --help


## Build-It-Yourself

    git clone https://github.com/matsuu/docker-hengband.git
    cd docker-hengband
    docker build -t hengband .
    docker run -it hengband

## References

* [変愚蛮怒 公式WEB](https://hengband.github.io/)
* GitHub [matsuu/docker-hengband](https://github.com/matsuu/docker-hengband)
* Docker Hub [matsuu/hengband](https://hub.docker.com/r/matsuu/hengband/)
* GitHub Container Registry [ghcr.io/matsuu/hengband](https://github.com/matsuu/docker-nethack/pkgs/container/hengband)
