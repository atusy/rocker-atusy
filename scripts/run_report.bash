#!/bin/bash
set  -e
R_HOME_ENVIRON="${R_HOME:-/usr/local/lib/R}/etc/Environ"
CHROME="${CHROME:-https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb}"

SCRIPTS="scripts_atusy"

wget -q "$CHROME"
bash /$SCRIPTS/install_apt.bash --no-install-recommends \
  "./$( basename "$CHROME" )" \
  `# fot webshot` \
  bzip2 phantomjs \
  `# for gt` \
  libglu1-mesa-dev \
  `# for rkrug/plantuml` \
  graphviz
rm "$( basename "$CHROME" )"

r -e "options(Ncpus = max(1L, parallel::detectCores())); remotes::install_github('atusy/atusydown', upgrade = 'always', dependencies = TRUE)"

echo "CHROMOTE_CHROME=$( command -v google-chrome )" >> "${R_HOME_ENVIRON}"
echo "QT_QPA_PLATFORM=offscreen" >> "${R_HOME_ENVIRON}"

