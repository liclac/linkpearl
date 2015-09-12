# Load global rbenv into all shells
export RBENV_ROOT="/usr/local/rbenv"
export PATH="$RBENV_ROOT/bin:$PATH"
eval "$(rbenv init -)"

# Allow user-specific gem installations
export GEM_HOME="$HOME/.gem"
export PATH="$GEM_HOME/bin:$PATH"
