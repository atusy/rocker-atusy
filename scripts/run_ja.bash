#!/bin/bash
set -e

TZ="${TZ:-Asia/Tokyo}"
R_HOME_ENVIRON="${R_HOME:-/usr/local/lib/R}/etc/Renviron"
NOTO_TRUETYPE="${NOTO_TRUETYPE:-Sans Serif Mono}"
NOTO_OPENTYPE="${NOTO_OPENTYPE:-SansCJKjp SerifCJKjp}"

SCRIPTS="scripts_atusy"

# TIMEZONE

ln -sf "/usr/share/zoneinfo/${TZ}" /etc/localtime
sed -E -e 's/^TZ=.*$//g' "${R_HOME_ENVIRON}" 
echo "TZ=${TZ}" >> "${R_HOME_ENVIRON}"


# FONT 

bash /${SCRIPTS}/install_apt.bash --no-install-recommends \
  fonts-ipaexfont-gothic \
  fonts-ipaexfont-mincho

bash /${SCRIPTS}/install_noto_fonts.bash \
  truetype $NOTO_TRUETYPE 
bash /${SCRIPTS}/install_noto_fonts.bash \
  opentype $NOTO_OPENTYPE 

# extrafont is facing "No FontName. Skipping."
# related: https://stackoverflow.com/questions/61204259/how-can-i-resolve-the-no-font-name-issue-when-importing-fonts-into-r-using-ext
#
install2.r --ncpus -1 extrafont ragg systemfonts
r -e 'remotes::install_version("Rttf2pt1", version = "1.3.8")'
r -e "extrafont::font_import(prompt = FALSE); extrafont::loadfonts()"


# TLMGR

bash /${SCRIPTS}/install_tlmgr.bash \
  `# for kableExtra` \
  multirow wrapfig float colortbl tabu threeparttable threeparttablex ulem makecell xcolor \
  `# for kableExtra (additional)` \
  varwidth environ trimspaces \
  `# for Japanese in XeLaTeX` \
  realscripts metalogo xltxtra zxjatype xecjk zxjafont \
  `# for Pandoc https://pandoc.org/MANUAL.html#creating-a-pdf ` \
  biblatex bidi csquotes footnotehyper makecmds microtype polyglossia setspace unicode-math xurl

