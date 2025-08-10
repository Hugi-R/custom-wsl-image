FROM wsl-base:latest AS custom-base

RUN apt-get update && apt-get upgrade && apt-get install -y \
    sudo zsh curl htop jq unzip tree \
    git git-lfs build-essential cmake rustup golang-go \
    podman

RUN useradd -m -s /bin/bash hugo
# Default groups for new user, from /usr/lib/wsl/wsl-setup
RUN usermod -aG adm,cdrom,sudo,dip,plugdev hugo
# Allow sudo without password (common for WSL)
RUN echo 'hugo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER hugo
WORKDIR /home/hugo
# ZSH and Oh My ZSH setup, with zsh as default shell
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
COPY zsh/.zshrc .zshrc
COPY zsh/custom .oh-my-zsh/custom
RUN sudo chsh -s /bin/zsh hugo && rm .profile .bashrc .bash_logout
RUN mkdir -p .local/bin
# Node Version Manager
RUN sh -c "curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash"

USER root
RUN echo '[boot]' > /etc/wsl.conf && \
    echo 'systemd=true' >> /etc/wsl.conf && \
    echo '[user]' >> /etc/wsl.conf && \
    echo 'default=hugo' >> /etc/wsl.conf

USER hugo


FROM custom-base AS custom-cuda

USER root
RUN wget https://developer.download.nvidia.com/compute/cuda/repos/wsl-ubuntu/x86_64/cuda-keyring_1.1-1_all.deb &&\
    dpkg -i cuda-keyring_1.1-1_all.deb &&\
    rm cuda-keyring_1.1-1_all.deb &&\
    apt-get update &&\
    apt-get -y install cuda

USER hugo