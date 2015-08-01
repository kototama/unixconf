function homegit
  set -lx GIT_DIR "$HOME/unixconf/.git"
  set -lx GIT_WORK_TREE "$HOME"
  git $argv
end