FROM gitpod/workspace-full

# install ghcup: https://www.haskell.org/ghcup/install/
RUN curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | \
  BOOTSTRAP_HASKELL_NONINTERACTIVE=1 \
  BOOTSTRAP_HASKELL_VERBOSE=1 \
  BOOTSTRAP_HASKELL_INSTALL_HLS=1 \
  BOOTSTRAP_HASKELL_INSTALL_STACK=1 \
  BOOTSTRAP_HASKELL_GHC_VERSION=8.10.7 \
  sh
RUN printf '%s\n' 'source "$HOME/.ghcup/env"' >> ~/.bashrc

RUN . ~/.ghcup/env && cabal install hlint
RUN . ~/.ghcup/env && cabal install ghcid

RUN mkdir /tmp/project
WORKDIR /tmp/project
COPY --chown=gitpod *.project .
COPY --chown=gitpod *.cabal .
COPY --chown=gitpod app/ app/
# run HLS once to bootstrap build
RUN . ~/.ghcup/env && cabal build
RUN . ~/.ghcup/env && eval "$(ghcup whereis hls)"

WORKDIR /home/gitpod
