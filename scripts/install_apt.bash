apt-get update
apt-get install -y "$@"
apt-get clean
rm -rf /var/lib/apts/lists/*
