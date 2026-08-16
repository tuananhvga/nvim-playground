ARG BASE_IMAGE=menci/archlinuxarm:base-devel-20260727.30245897478
FROM ${BASE_IMAGE}

ARG USERNAME=nvim
ARG USER_UID=1000
ARG USER_GID=1000

ARG GO_VERSION=1.26.0
ARG GOPLS_VERSION=v0.23.0
ARG DELVE_VERSION=v1.26.3
ARG TREE_SITTER_CLI_VERSION=0.26.11

# ------------------------------------------------------------
# Disable pacman sandbox
#
# Required when the container runtime does not provide
# the Landlock functionality used by recent pacman versions.
# ------------------------------------------------------------
RUN sed -i '/^\[options\]/a DisableSandbox' /etc/pacman.conf

# ------------------------------------------------------------
# System packages
#
# Arch Linux is rolling release, so perform a full system
# upgrade together with package installation.
# ------------------------------------------------------------
RUN pacman -Syu --noconfirm \
        ca-certificates \
        git \
        curl \
        wget \
        unzip \
        ripgrep \
        fd \
        nodejs \
        npm \
        clang \
        cmake \
        ninja \
        gettext \
        zsh \
        go \
        tree-sitter-cli \
        neovim \
    && pacman -Scc --noconfirm

# ------------------------------------------------------------
# Go tools
# ------------------------------------------------------------
RUN GOBIN=/usr/local/bin \
        go install golang.org/x/tools/gopls@${GOPLS_VERSION} \
    && GOBIN=/usr/local/bin \
        go install github.com/go-delve/delve/cmd/dlv@${DELVE_VERSION}

# ------------------------------------------------------------
# Non-root user
# ------------------------------------------------------------
RUN groupadd --gid ${USER_GID} ${USERNAME} \
    && useradd \
        --uid ${USER_UID} \
        --gid ${USER_GID} \
        --create-home \
        --shell /bin/zsh \
        ${USERNAME}

# ------------------------------------------------------------
# XDG directories
# ------------------------------------------------------------
RUN mkdir -p \
        /home/${USERNAME}/.local/share/nvim \
        /home/${USERNAME}/.local/state/nvim \
        /home/${USERNAME}/.cache/nvim \
    && chown -R ${USERNAME}:${USERNAME} /home/${USERNAME}

ENV HOME=/home/${USERNAME}
ENV XDG_CONFIG_HOME=/home/${USERNAME}/.config
ENV XDG_DATA_HOME=/home/${USERNAME}/.local/share
ENV XDG_STATE_HOME=/home/${USERNAME}/.local/state
ENV XDG_CACHE_HOME=/home/${USERNAME}/.cache

# ------------------------------------------------------------
# Neovim configuration
#
# Build context:
#
# .
# ├── Dockerfile
# └── nvim/
# ------------------------------------------------------------
USER ${USERNAME}

COPY --chown=${USERNAME}:${USERNAME} cli /home/${USERNAME}/cli
COPY --chown=${USERNAME}:${USERNAME} nvim /home/${USERNAME}/.config/nvim

RUN nvim --headless "+Lazy! sync" +qa

WORKDIR /home/${USERNAME}/cli

CMD ["zsh"]
