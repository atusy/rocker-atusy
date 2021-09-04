if [[ "$1" =~ "truetype|opentype" ]]
then
  echo "First argument must be truetype of opentype, but '$1' is given" 1>&2
  exit 1
fi
if [[ $# -eq 1 ]]
then
  echo "WARNING: No fonts are specified."
  exit 0
fi

DIST="/usr/share/fonts/$1/noto"
shift 1
mkdir -p "${DIST}"
for _NOTO_FONT in "$@"
do
  _ZIP="Noto${_NOTO_FONT}-hinted.zip"
  wget -q "https://noto-website-2.storage.googleapis.com/pkgs/${_ZIP}"
  unzip -n "${_ZIP}" -d "${DIST}/noto"
  rm "${_ZIP}"
done 
chmod 644 ${DIST}/noto/*

