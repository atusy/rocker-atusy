set -e
tlmgr update --self
tlmgr install "$@"
tlmgr path add
chown -R rstudio:staff /opt/texlive
chown -R rstudio:staff /usr/local/texlive
chmod -R 777 /opt/texlive
chmod -R 777 /usr/local/texlive
 
