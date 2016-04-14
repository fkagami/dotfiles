# Path to your oh-my-zsh installation.
# 基本設定
# export TERM=xterm-256color
export EDITOR=vim           # エディタをvimに設定
export LANG=ja_JP.UTF-8     # 文字コードをUTF-8に設定
setopt no_beep              # ビープ音を鳴らさないようにする
setopt auto_cd              # ディレクトリ名と一致した場合にcd
setopt auto_pushd           # cd時にディレクトリスタックにpushd
autoload -U colors; colors  # 色を使用できるようにする
setopt prompt_subst         # プロンプトに式展開を適用
export LSCOLORS=gxfxcxdxbxegedabagacad  # lsの色設定
autoload -U compinit
compinit -u

# cdr
autoload -Uz add-zsh-hock
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook

# antigen
if [[ -f $HOME/.zsh/antigen/antigen.zsh ]]; then
  source $HOME/.zsh/antigen/antigen.zsh
  antigen bundle mollifier/anyframe # 追加
  antigen apply
fi

# oh my zsh の設定
ZSH_THEME='wedisagree'
plugins=(git ruby osx bundler brew rails emoji-clock)

# VCSのブランチ名をプロンプトに表示
autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '(%s)-[%b]'
zstyle ':vcs_info:*' actionformats '(%s)-[%b|%a]'
precmd () {
  psvar=()
  LANG=en_US.UTF-8 vcs_info
  [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}

# キーバインド
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey '^F' forward-word
bindkey '^B' backward-word

# プロンプト
PROMPT="%{${fg[yellow]}%}%/%{${reset_color}%} "
PROMPT2="%{${fg[yellow]}%}%_%{${reset_color}%} "
#SPROMPT="%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%} "
PROMPT="%1(v|%F{green}%1v%f|)"
[ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && PROMPT="%{${fg[cyan]}%}%n@${HOST%%.*} ${PROMPT}"

# 補完
autoload -U compinit; compinit  # 補完機能を有効にする
setopt auto_list                # 補完候補を一覧で表示する
setopt auto_menu                # 補完キー連打で補完候補を順に表示する
setopt auto_param_keys          # 括弧などを自動的に補完
setopt auto_param_slash         # ディレクトリの補完時に末尾に/を付加
setopt complete_aliases         # エイリアスを設定したコマンドにも補完機能を適用
setopt correct                  # コマンドを修正
setopt correct_all              # コマンドだけでなくファイル名等も修正
setopt hist_expand              # 補完時にヒストリを展開
setopt list_packed              # 補完候補を詰めて表示する
setopt list_types               # 補完候補にファイルの種類も表示する
setopt magic_equal_subst        # =以降も補完する
setopt mark_dirs                # 補完対象がディレクトリの場合末尾に/を付加
setopt nolistbeep               # 補完表示時にビープ音を鳴らさない
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # 大文字小文字を区別しない
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS} #補完候補に色を付ける


# 履歴
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups     # 連続して重複したコマンドラインはヒストリに追加しない
setopt share_history        # 履歴の共有
setopt hist_no_store        # historyコマンドをhistoryに保存しない
setopt hist_reduce_blanks   # 余分なスペースを削除してヒストリに記録する
setopt extended_history     # 履歴ファイルに時刻を記録
setopt inc_append_history   # 履歴をインクリメンタルに追加
setopt hist_ignore_space    # スペースで始まるコマンド行はヒストリリストから削除
setopt hist_verify          # ヒストリを呼び出してから実行する間に一旦編集可能
autoload history-search-end
# 履歴検索機能のショートカット
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

# エイリアス
source ~/dotfiles/zshrc.alias

# manコマンドに色をつける
export MANPAGER='less -R'
man() {
    env \
        LESS_TERMCAP_mb=$(printf "\e[1;31m") \
        LESS_TERMCAP_md=$(printf "\e[1;31m") \
        LESS_TERMCAP_me=$(printf "\e[0m") \
        LESS_TERMCAP_se=$(printf "\e[0m") \
        LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
        LESS_TERMCAP_ue=$(printf "\e[0m") \
        LESS_TERMCAP_us=$(printf "\e[1;32m") \
        man "$@"
}

# その他
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="$HOME/local/bin:$PATH"
if [ -d "$HOME/.rbenv" ]; then
  eval "$(rbenv init -)"
fi

if [ -e "~/perl5/perlbrew/etc/bashrc" ]; then
  source ~/perl5/perlbrew/etc/bashrc
fi

PS1="$PS1"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")'

export ZSH=/Users/fumiyasu-kagami/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="wedisagree"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

# User configuration

export PATH="/Users/fumiyasu-kagami/.rbenv/shims:/Users/fumiyasu-kagami/local/bin:/Users/fumiyasu-kagami/.rbenv/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#

setopt hist_ignore_all_dups

function peco_select_history() {
  local tac
  if which tac > /dev/null; then
    tac="tac"
  else
    tac="tail -r"
  fi
  BUFFER=$(fc -l -n 1 | eval $tac | peco --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle clear-screen
}
zle -N peco_select_history
bindkey '^r' peco_select_history

eval "$(~/.cpad/bin/cpad init)"

DISABLE_CORRECTION="true"

# The next line updates PATH for the Google Cloud SDK.
source '/Users/fumiyasu-kagami/google-cloud-sdk/path.zsh.inc'

# The next line enables shell command completion for gcloud.
source '/Users/fumiyasu-kagami/google-cloud-sdk/completion.zsh.inc'
