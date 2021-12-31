FROM gitpod/workspace-base
COPY ./setup.sh /tmp/setup.sh
COPY --chown=gitpod *.cabal .
COPY --chown=gitpod app/ app/
RUN bash /tmp/setup.sh
