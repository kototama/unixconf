alias e "emacs"
alias ec "emacsclient -n -a=emacs"
alias pacup "sudo pacman -Syu"
alias aup "yaourt -Syu --aur"

set -gx PYENV_ROOT ~/.pyenv

set -gx PATH $PYENV_ROOT/bin ~/.local/bin ~/local/bin $PATH



# ~/.stack/programs/x86_64-linux/ghc-7.8.4/bin $PATH

set -gx EDITOR "emacsclient -a=emacs"

switch (hostname)
       case adorno
            source ~/.config/fish/work.fish
       case '*'
            . ~/.config/fish/home.fish            
end

# pyenv
status --is-interactive; and . (pyenv init -|psub)
