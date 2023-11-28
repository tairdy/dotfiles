alias vim='nvim'
if status is-interactive
    # Commands to run in interactive sessions can go here

end

set -gx TERM xterm-256color

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
set -x OPENAI_API_KEY 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

set -gx PATH bin $PATH
set -gx PATH ~/bin $PATH
set -gx PATH /opt/homebrew/bin $PATH

set -U fish_user_paths ~/opt/anaconda3/bin $fish_user_paths
set -U fish_user_paths $PYENV_ROOT/bin $fish_user_paths
set -x PYENV_ROOT $HOME/.pyenv
set -x PATH  $PYENV_ROOT/shims $PATH

set -g PATH /Users/tairdy/.deta/bin $PATH

pyenv init - | source

if type -q exa 
  alias ll 'exa -l -g --icons'
  alias lla 'll -a'
  alias llt 'exa --tree'
  alias ll2 'exa --tree --level=2'

end 

function fish_user_key_bindings

  # peco
  bind \cr peco_select_history # Bind for peco select history to Ctrl+R
  bind \cf peco_change_directory # Bind for peco change directory to Ctrl+F

  # vim-like
  bind \cl forward-char

  # prevent iterm2 from closing when typing Ctrl-D (EOF)
  bind \cd delete-char

end

#starship
#starship init fish | source
source (conda info --root)/etc/fish/conf.d/conda.fish



# powerline
function fish_prompt
    powerline-shell --shell bare $status
end



# Setting PATH for Python 3.10
# The original version is saved in /Users/tairdy/.config/fish/config.fish.pysave
set -x PATH "/Library/Frameworks/Python.framework/Versions/3.10/bin" "$PATH"

#test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish ; or true




