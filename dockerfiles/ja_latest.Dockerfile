ARG BASE="rocker/verse"
ARG TAG="latest"

FROM ${BASE}:${TAG}

ENV TZ="Asia/Tokyo" \
    R_HOME="/usr/local/lib/R" \
    NOTO_TRUE_TYPE="Sans Serif Mono" \
    NOTO_OPENTYPE="SansCJKjp SerifCJKjp"
COPY scripts /scripts_atusy
RUN --mount=type=secret,id=dotenv,dst=/run/secrets/.env \
    set -a && . /run/secrets/.env && set + a && \
    bash /scripts_atusy/run_ja.bash

