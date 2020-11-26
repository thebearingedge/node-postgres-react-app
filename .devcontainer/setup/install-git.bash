function install-git() {

  local credential_cache_timeout=604800
  local completion_url=https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
  local custom_prompt=$(cat << EOF
function parse_git_branch() {
  # changing directories lets us catch up
  # to Docker's layered file system
  # after killing an NPM script.
  cd .
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export PS1="\[\033[32m\]\w\[\033[33m\]\\\$(parse_git_branch)\[\033[00m\] λ "
EOF
)

  apt-get install -y git && \

  git config --global core.editor nano && \
  git config --global credential.helper "cache --timeout=$credential_cache_timeout" && \

  http -b get $completion_url > /home/dev/.local/git-completion.bash && \

  echo 'source /home/dev/.local/git-completion.bash' >> /home/dev/.bashrc && \
  echo "$custom_prompt" >> /home/dev/.bashrc

}
