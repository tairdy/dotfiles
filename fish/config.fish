if status is-interactive
    # Commands to run in interactive sessions can go here
end

alias vim='nvim'
alias python='python3'
alias pip='pip3'
set -gx TERM xterm-256color

set -g fish_greeting ""


# theme
set -g theme_color_scheme terminal-dark
set -g fish_prompt_pwd_dir_length 1
set -g theme_display_user yes
set -g theme_hide_hostname no
set -g theme_hostname always

set -x PATH $HOME/.nodebrew/current/bin $PATH
set -g GOPATH $HOME/go
set -gx PATH $GOPATH/bin $PATH

set -gx EDITOR nvim
set -x OPENAI_API_KEY
set -gx PATH bin $PATH
set -gx PATH ~/bin $PATH
set -gx PATH /opt/homebrew/bin $PATH
set -U fish_user_paths $PYENV_ROOT/bin $fish_user_paths
set -x PYENV_ROOT $HOME/.pyenv
set -x PATH $PYENV_ROOT/shims $PATH

pyenv init - | source

if type -q eza
    alias ll 'eza -lasnew -g --icons'
    alias lla 'll -a'
    alias llt 'eza --tree'
    alias ll2 'eza --tree --level=2'

end

function fish_user_key_bindings

    # vim-like
    bind \cl forward-char
    # prevent iterm2 from closing when typing Ctrl-D (EOF)
    bind \cd delete-char

end

# Setting PATH for Python 3.10
set -x PATH "/Library/Frameworks/Python.framework/Versions/3.10/bin" "$PATH"


starship init fish | source
fish_add_path $HOME/.local/bin


