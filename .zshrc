# =========================
# BASE ZSH CLEAN JDM
# =========================

autoload -Uz compinit && compinit
setopt HIST_SAVE_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt SHARE_HISTORY

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# =========================
# MODERN TOOLS
bindkey '^T' fzf-file-widget
# =========================

# =========================
# FZF THEME (JDM RED CLEAN)
# =========================

export FZF_DEFAULT_OPTS="
--height 40%
--layout=reverse
--border
--cycle
--ansi
--color=fg:#c0caf5,bg:#1a1b26,hl:#ED445F
--color=fg+:#ffffff,bg+:#1a1b26,hl+:#ED445F
--color=info:#7aa2f7,prompt:#ED445F,pointer:#ED445F
--color=marker:#ED445F,spinner:#ED445F,header:#444b6a
"

alias ls='eza --icons --group-directories-first'
alias cat='bat'
alias grep='rg'

# =========================
# FZF (CTRL+R MELHORADO)
# =========================

source /usr/share/fzf/key-bindings.zsh 2>/dev/null
source /usr/share/fzf/completion.zsh 2>/dev/null

# =========================
# STARSHIP (PROMPT ENGINE)
# =========================

# =========================
# ZSH PLUGINS (IMPORTANT)
# =========================

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null
eval "$(starship init zsh)"

# HYFETCH ON START (clean)
if [[ $- == *i* ]]; then
    hyfetch
fi
export PATH="$HOME/.local/bin:$PATH"
alias hx='helix'

ai() {
  ollama run qwen2.5-coder "$@"
}
export TMPDIR=~/pip-tmp
export PATH="$HOME/.local/bin:$PATH"
