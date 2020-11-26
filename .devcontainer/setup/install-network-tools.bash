function install-network-tools() {

  apt-get -y -o Dpkg::Options::="--force-confdef" \
             -o Dpkg::Options::="--force-confold" \
    install \
      unzip \
      curl \
      host \
      httpie \
      telnet \
      iputils-ping \
      netcat-openbsd \
      traceroute && \

  mkdir -p /home/dev/.httpie && \

  cat << EOF > /home/dev/.httpie/config.json
{
    "__meta__": {
        "about": "HTTPie configuration file",
        "help": "https://httpie.org/doc#config",
        "httpie": "0.9.8"
    },
    "default_options": []
}
EOF

}
