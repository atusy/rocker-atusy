ARG BASE="atusy/ja-verse"
ARG TAG="latest"

FROM ${BASE}:${TAG}

ENV R_HOME="/usr/local/lib/R" \
    CHROME="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
COPY scripts /scripts_atusy
RUN --mount=type=secret,id=dotenv,dst=/run/secrets/.env \
    set -a && . /run/secrets/.env && set + a && \
    bash /scripts_atusy/run_report.bash

