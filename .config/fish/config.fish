alias e "emacs"
alias ec "emacsclient -n -a=emacs"
alias pacup "sudo pacman -Syu"
alias aup "yaourt -Syu --aur"

set -gx PATH ~/.local/bin ~/local/bin $PATH

set -gx EDITOR "emacsclient -a=emacs"

switch (hostname)
       case adorno
            source ~/.config/fish/work.fish
       case '*'
          echo "not adorno"
end

