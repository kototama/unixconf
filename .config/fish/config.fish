alias e "emacs"
alias ec "emacsclient -n -a=emacs"
alias pacup "sudo etckeeper pre-install; and sudo pacman -Syu; and sudo etckeeper post-install"
alias aup "sudo etckeeper pre-install; and yaourt -Syu --aur; and sudo etckeeper post-install"
alias ll "ls -alh"

set -gx PYENV_ROOT ~/.pyenv

set -gx PATH /opt/alex/3.1.7/bin/ /opt/happy/1.19.5/bin/ /opt/ghc/7.10.3/bin $PYENV_ROOT/bin ~/.local/bin ~/local/bin $PATH

# for XMonad with Java applications
set -gx _JAVA_AWT_WM_NONREPARENTING 1

# ~/.stack/programs/x86_64-linux/ghc-7.8.4/bin $PATH

set -gx EDITOR "emacsclient -a=emacs"

switch (id -ng)
       case 'miaou'
            . ~/.config/fish/work.fish
       case '*'
            . ~/.config/fish/home.fish
end
