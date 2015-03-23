alias e "emacs"
alias ec "emacsclient -n -a=emacs"
alias pacup "sudo pacman -Syu"
alias aup "yaourt -Syu --aur"

set -gx PATH /home/alphonse/projects/adhocracy3.mercator/bin ~/.local/bin $PATH

set -gx A3_ROOT /home/alphonse/projects/adhocracy3.mercator
set -gx LD_LIBRARY_PATH /home/alphonse/projects/adhocracy3.mercator/python/parts/opt/lib/

set -gx EDITOR "emacsclient -a=emacs"

set fish_git_dirty_color red
set fish_git_not_dirty_color green

function parse_git_branch
  set -l branch (git branch 2> /dev/null | grep -e '\* ' | sed 's/^..\(.*\)/\1/')
  set -l git_diff (git diff)

  if test -n "$git_diff"
    echo (set_color $fish_git_dirty_color)$branch(set_color normal)
  else
    echo (set_color $fish_git_not_dirty_color)$branch(set_color normal)
  end
end

function fish_prompt
  if test -d .git
    printf '%s@%s %s%s%s (%s)\n> ' (whoami) (hostname|cut -d . -f 1) (set_color $fish_color_cwd) (prompt_pwd) (set_color normal) (parse_git_branch)
  else
    printf '%s@%s %s%s%s> ' (whoami) (hostname|cut -d . -f 1) (set_color $fish_color_cwd) (prompt_pwd) (set_color normal)
  end
end

function homegit
  set -lx GIT_DIR "$HOME/unixconf/.git"
  set -lx GIT_WORK_TREE "$HOME"
  git $argv
end
