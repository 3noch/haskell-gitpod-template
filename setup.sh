#!/usr/bin/env bash

set -euo pipefail

sudo apt-get update
sudo apt-get install -y \
  build-essential \
  curl \
  git \
  gnupg2 \
  jq \
  libgmp3-dev \
  openssl \
  vim

# install ghcup: https://www.haskell.org/ghcup/install/
BOOTSTRAP_HASKELL_NONINTERACTIVE=1 \
  BOOTSTRAP_HASKELL_VERBOSE=1 \
  curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh

printf '%s\n' 'source "$HOME/.ghcup/env"' >> ~/.bashrc
source ~/.ghcup/env

ghcup install hls
ghcup install stack

cabal install hlint
cabal install ghcid

# run HLS once to bootstrap build
eval "$(ghcup whereis hls)"
