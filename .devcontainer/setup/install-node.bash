function install-node() {

  curl -sL https://deb.nodesource.com/setup_14.x | bash && \
  apt-get install -y nodejs && \
  mkdir -p /home/dev/.config/configstore && \
  cat << EOF > /home/dev/.config/configstore/update-notifier-npm.json
{
  "optOut": true,
  "lastUpdateCheck": 0
}
EOF

}
