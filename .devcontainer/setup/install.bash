set -e

apt-get -qq update

apt-get install -y man && \
  dpkg -l | grep ^ii | cut -d' ' -f3 | xargs apt-get install -y --reinstall

apt-get install -y sudo && \
  useradd -m -s /bin/bash -G sudo dev && \
  echo "dev ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/dev && \
  chmod 0440 /etc/sudoers.d/dev && \
  touch /home/dev/.sudo_as_admin_successful

apt-get install -y locales

echo "LC_ALL=en_US.UTF-8" >> /etc/environment
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf

locale-gen en_US.UTF-8

ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

apt-get -y install \
  nano \
  psmisc \
  bash-completion \
  build-essential

__dirname=$(dirname $BASH_SOURCE)
source $__dirname/install-network-tools.bash
source $__dirname/install-git.bash
source $__dirname/install-postgres.bash
source $__dirname/install-node.bash

function announce() {
  echo -e "\n\n\n\n\nSetting up $1...\n\n\n\n\n"
  sleep 2
}

function bail() {
  echo -e "\n\n\n\n\nFailed to set up $1... exiting.\n\n\n\n\n" 1>&2
  exit 1
}

mkdir -p /home/dev/.local

announce "network tools" && install-network-tools || bail "network tools"
announce "Git" && install-git || bail "Git"
announce "PostgreSQL" && install-postgres || bail "PostgreSQL"
announce "Node.js" && install-node || bail "Node.js"

chown -R dev:dev /home/dev

apt-get autoremove
