alias e "emacs"
alias ec "emacsclient -n -a=emacs"
alias pacup "sudo pacman -Syu"
alias aup "yaourt -Syu --aur"

set -gx PATH /home/alphonse/projects/adhocracy3.mercator/bin ~/.local/bin ~/local/bin $PATH

set -gx A3_ROOT /home/alphonse/projects/adhocracy3.mercator
set -gx LD_LIBRARY_PATH /home/alphonse/projects/adhocracy3.mercator/python/parts/opt/lib/

set -gx PYTHONPATH /home/alphonse/projects/adhocracy3.mercator/src /home/alphonse/projects/adhocracy3.mercator/src/substanced/ $A3_ROOT/eggs/pyramid-*.egg/ $A3_ROOT/eggs/*.egg $PYTHONPATH

set -gx EDITOR "emacsclient -a=emacs"

set --erase fish_greeting

function homegit
  set -lx GIT_DIR "$HOME/unixconf/.git"
  set -lx GIT_WORK_TREE "$HOME"
  git $argv
end

