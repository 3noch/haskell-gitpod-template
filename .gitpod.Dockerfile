FROM gitpod/workspace-base

RUN sudo apt-get update
RUN sudo apt-get install -y \
  build-essential \
  curl \
  git \
  gnupg2 \
  jq \
  libgmp3-dev \
  openssl \
  vim

# install ghcup: https://www.haskell.org/ghcup/install/
RUN BOOTSTRAP_HASKELL_NONINTERACTIVE=1 \
  BOOTSTRAP_HASKELL_VERBOSE=1 \
  curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh
RUN printf '%s\n' 'source "$HOME/.ghcup/env"' >> ~/.bashrc

RUN . ~/.ghcup/env && ghcup install hls
RUN . ~/.ghcup/env && ghcup install stack

RUN . ~/.ghcup/env && cabal install hlint
RUN . ~/.ghcup/env && cabal install ghcid

WORKDIR /tmp/project
COPY --chown=gitpod *.cabal .
COPY --chown=gitpod app/ app/
# run HLS once to bootstrap build
RUN . ~/.ghcup/env && eval "$(ghcup whereis hls)"

WORKDIR /home/gitpod
