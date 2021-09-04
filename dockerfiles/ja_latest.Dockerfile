ARG BASE="rocker/verse"
ARG TAG="latest"

FROM ${BASE}:${TAG}

ENV TZ="Asia/Tokyo" \
    R_HOME="/usr/local/lib/R" \
    NOTO_TRUE_TYPE="Sans Serif Mono" \
    NOTO_OPENTYPE="SansCJKjp SerifCJKjp"
COPY scripts /scripts_atusy
RUN bash /scripts_atusy/run_ja.bash

