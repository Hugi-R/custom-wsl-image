# Hugi's custom WSL image
A very simple script to build a modified Ubuntu WSL image, using docker.

# Howto
Download the base image from [Ubuntu](https://ubuntu.com/desktop/wsl).

Edit `Dockerfile` and `build.sh` to suit your needs.

Run
```shell
build.sh <path_ubuntu_image.wsl>
```

# How this work
See this [Ubuntu article](https://documentation.ubuntu.com/wsl/latest/howto/custom-ubuntu-distro) for a complete explanation without Docker.

Turns out, WSL work similarly to containers, where a kernel is shared, and the distro's just a rootfs.
Since the .wsl is a tarball of the rootfs of a distro, we can import it as a Docker image.
We can them modify it, either interactively, by launching a container, or by using a Dockerfile.
Then we export the modified rootfs as a tarball with .wsl extension.

Just double-click on the .wsl in Windows to install it.
