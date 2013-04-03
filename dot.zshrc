#############################
# 環境変数
#############################

PATH=~/local/bin:$PATH:/usr/local/bin # パスの追加
EDITOR=/usr/bin/vim # エディタの指定
export EDITOR PATH

# coreutils
if which brew > /dev/null; then
  export PATH=$(brew --prefix coreutils)/libexec/gnubin:$PATH
fi

# 言語の設定
LANG=ja_JP.UTF-8
export LANG

# lv
export LV="-c -l"

# sudo 時に環境変数を引き継ぐ
alias sudo='sudo env PATH=$PATH'

# rbenv
export RBENV_ROOT="$HOME/.rbenv/"
export PATH="$RBENV_ROOT/bin:$PATH"
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

#############################
# 各種設定
#############################

#移動先がシンボリックリンクならば実際のディレクトリに移動する
#setopt chase_links

# cdr
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
zstyle ':chpwd:*' recent-dirs-max 5000
zstyle ':chpwd:*' recent-dirs-default yes
zstyle ':completion:*' recent-dirs-insert both

# emacs風キーバインド
bindkey -e

# rename用コマンドを有効にする
autoload -Uz zmv
alias zmv="noglob zmv"

# 履歴関連
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "" history-beginning-search-backward-end
bindkey "" history-beginning-search-forward-end
bindkey "" history-incremental-pattern-search-backward
bindkey "" history-incremental-pattern-search-forward

# vi風キーバインド
# bindkey -v
# bindkey '' vi-beginning-of-line
# bindkey '' vi-end-of-line

#lsをカラーに
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
# for Mac
#alias ls="ls -G"

## 履歴の保存先
HISTFILE=$HOME/.zsh-history

## メモリに展開する履歴の数
HISTSIZE=100001

## 保存する履歴の数
SAVEHIST=100000

## 補完機能の強化
autoload -U compinit
compinit
zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'

## コアダンプサイズを制限
limit coredumpsize 102400

## 出力の文字列末尾に改行コードが無い場合でも表示
unsetopt promptcr

## 色を使う
setopt prompt_subst

## ビープを鳴らさない
setopt nobeep

## 内部コマンド jobs の出力をデフォルトで jobs -l にする
setopt long_list_jobs

## 補完候補一覧でファイルの種別をマーク表示
setopt list_types

## サスペンド中のプロセスと同じコマンド名を実行した場合はリジューム
setopt auto_resume

## 補完候補を一覧表示
setopt auto_list

## 直前と同じコマンドをヒストリに追加しない
setopt hist_ignore_dups

# 履歴に加えられる新しいコマンドが古いものと重複している場合、古いものを削除する。
setopt hist_ignore_all_dups

# 古い履歴を削除する必要がある場合、まず重複しているものから削除する。
# このオプションを有効に機能させるためには、$HISTSIZEが$SAVEHISTよりも大きい値である必要がある。
setopt hist_expire_dups_first

## cd 時に自動で push
setopt auto_pushd

## 同じディレクトリを pushd しない
setopt pushd_ignore_dups

## ファイル名で #, ~, ^ の 3 文字を正規表現として扱う
setopt extended_glob

## TAB で順に補完候補を切り替える
setopt auto_menu

## zsh の開始, 終了時刻をヒストリファイルに書き込む
setopt extended_history

## =command を command のパス名に展開する
setopt equals

## --prefix=/usr などの = 以降も補完
setopt magic_equal_subst

## ヒストリを呼び出してから実行する間に一旦編集
setopt hist_verify

## ファイル名の展開で辞書順ではなく数値的にソート
setopt numeric_glob_sort

## 出力時8ビットを通す
setopt print_eight_bit

## ヒストリを共有
setopt share_history

## 補完候補のカーソル選択を有効に
zstyle ':completion:*:default' menu select=1

## 補完候補の色づけ
#eval `dircolors`
#export ZLS_COLORS=$LS_COLORS
#zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

## ディレクトリ名だけで cd
setopt auto_cd

## カッコの対応などを自動的に補完
setopt auto_param_keys

## ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt auto_param_slash

## スペルチェック
#setopt correct

## {a-c} を a b c に展開する機能を使えるようにする
setopt brace_ccl

## Ctrl+S/Ctrl+Q によるフロー制御を使わないようにする
setopt NO_flow_control

## コマンドラインの先頭がスペースで始まる場合ヒストリに追加しない
setopt hist_ignore_space

## コマンドラインでも # 以降をコメントと見なす
setopt interactive_comments

## ファイル名の展開でディレクトリにマッチした場合末尾に / を付加する
setopt mark_dirs

## history (fc -l) コマンドをヒストリリストから取り除く。
setopt hist_no_store

## 補完候補を詰めて表示
#setopt list_packed

## 最後のスラッシュを自動的に削除しない
setopt noautoremoveslash

# automating bundle exec
# [ -f ~/.bundler-exec.sh ] && source ~/.bundler-exec.sh

#############################
# エイリアスの設定
#############################
alias db_days='mysql -uroot --database="DaysSalesManager_production" --default-character-set=utf8'
alias db_edps='mysql -uroot --database="edps_development" --default-character-set=utf8'
alias grep='grep --color'
alias couchdb_d='sudo /usr/local/etc/init.d/couchdb'
alias c='clear'
alias d='date'
alias l='ls'
alias ll='ls -lh --color'
alias la='ls -a --color'
alias lla='ls -la --color'
alias v='vi'
alias red='rvm 1.8.7 && /opt/src/redmine-1.0.2/script/server -p 4000 -e production'
alias gemset='rvm gemset'
alias -g L='| lv'
alias -g H='| head'
alias -g T='| tail'
alias -g G='| grep'
alias -g W='| wc'
alias cdf='mkdir -p ~/work/files/`date +"%Y/%m/%d/"`; cd ~/work/files/`date +"%Y/%m/%d/"`'
alias cdm='mkdir -p ~/work/memo/`date +"%Y/%m"`; cd ~/work/memo/`date +"%Y/%m"`'
alias mlg='locate -r "memo\/.*\.rd$" | xargs lgrep'
alias mg='locate -r "memo\/.*\.rd$" | xargs grep'

# alias for ruby, rails
alias r='rails'
alias b='bundle'
alias be='bundle exec'

# alias for update-alternatives
alias u-alt='sudo update-alternatives'
alias u-altl='sudo update-alternatives --list'
alias u-altr='sudo update-alternatives --remove'
alias u-altr='sudo update-alternatives --remove'
alias u-altra='sudo update-alternatives --remove-all'
alias u-altc='sudo update-alternatives --config'
alias u-alti='sudo update-alternatives --install'

# alias for git
alias g='git'
alias gs='git show'
alias gss='git status'
alias gst='git stash'
alias gsp='git stash pop'
alias gm='git merge'
alias gf='git fetch'
alias gl='git log'
alias gco='git checkout'
alias gcl='git clone'
alias gcm='git commit'
alias gcf='git config'
alias gb='git branch'
alias gba='git branch --all'
alias gt='git tag'
alias gh='git help'
alias ga='git add'
alias gd='git diff'
alias gg='git grep'
alias ggc='git grep --cached'
alias ggi='git grep --no-cached'
alias ggt='git grep --untracked'
alias gdc='git diff --cached'
alias grc='git rm --cached'
alias gr='git remote'
#alias grso='git remote show origin'
alias grs='git reset'
alias grss='git reset --soft'
alias grsh='git reset --hard'
alias grca='git status | grep deleted | cut -c15- | xargs git rm --cached'
alias glp='g lp'
alias glpa='g lpa'

# alias for svn
alias sl='svn log | lv'
alias ss='svn status'
alias sd='svn diff'

# alias for git-svn
alias gsl='git svn log -v | lv'
alias gsr='git svn rebase'
alias dcommit='git svn dcommit'

# alias for Mac
alias p='open -a Preview'
alias t='open -a TextEdit'
alias tar='gnutar'

# Network
alias alive='ping 8.8.8.8'
alias alive-d='ping www.google.co.jp'

#############################
# プロンプトの設定
#############################
case ${UID} in
0)
    PROMPT="%B%{[31m%}%n${WINDOW:+"[$WINDOW]"}#%{[m%}%b "
#    PROMPT="%B%{[31m%}%/#%{[m%}%b "
    PROMPT2="%B%{[31m%}%_#%{[m%}%b "
    SPROMPT="%B%{[31m%}%r is correct? [n,y,a,e]:%{[m%}%b "
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
        PROMPT="%{[37m%}${HOST%%.*} ${PROMPT}"
    RPROMPT="%{[30m%}%}[%~]%{[m%}"
    ;;
*)
    PROMPT="%{[31m%}%n${WINDOW:+"[$WINDOW]"}$%{[m%} "
#    PROMPT="%{[31m%}%/%%%{[m%} "
    PROMPT2="%{[31m%}%_%%%{[m%} "
    SPROMPT="%{[31m%}%r is correct? [n,y,a,e]:%{[m%} "
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
        PROMPT="%{[37m%}${HOST%%.*} ${PROMPT}"
    RPROMPT="%{[30m%}%}[%~]%{[m%}"
    ;;
esac

# gitのbranchを表示
# ${fg[...]} や $reset_color をロード
autoload -U colors; colors

function rprompt-git-current-branch {
        local name st color

        if [[ "$PWD" =~ '/\.git(/.*)?$' ]]; then
                return
        fi
        name=`git branch 2> /dev/null | grep '^\*' | cut -b 3-`
        if [[ -z $name ]]; then
                return
        fi
        st=`git status 2> /dev/null`
        if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
                color=${fg[green]}
        elif [[ -n `echo "$st" | grep "^nothing added"` ]]; then
                color=${fg[yellow]}
        elif [[ -n `echo "$st" | grep "^# Untracked"` ]]; then
                color=${fg_bold[red]}
        else
                color=${fg[red]}
        fi

        # %{...%} は囲まれた文字列がエスケープシーケンスであることを明示する
        # これをしないと右プロンプトの位置がずれる
        echo " %{$color%}$name%{$reset_color%}"
}

# プロンプトが表示されるたびにプロンプト文字列を評価、置換する
setopt prompt_subst

RPROMPT='[%~`rprompt-git-current-branch`]'

#source ~/.zsh/zsh-vcs-prompt/zshrc.sh
#ZSH_VCS_PROMPT_ENABLE_CACHING='true'
#RPROMPT='$(vcs_super_info)'

#########################################
# zaw
#########################################

# zaw.zsh
source ~/.zsh/zaw/zaw.zsh
source ~/.zsh/zaw-git-reflog/zaw-git-reflog.zsh
source ~/.zsh/zaw-src-git-log/zaw-git-log.zsh

zstyle ':filter-select' max-lines 20
zstyle ':filter-select' case-insensitive yes # 絞り込みをcase-insensitiveに
zstyle ':filter-select' extended-search yes # ^: 行頭, $: 行末, smartcase searching: !
export ZAW_HISTORY_LIMIT=10000
bindkey '' zaw-history
bindkey '' zaw-bookmark
bindkey '' zaw-git-files
bindkey '' zaw-git-branches
bindkey '' zaw-git-reflog
bindkey '' zaw-git-log
#bindkey '' zaw-screens

#zaw-src-cdr
bindkey '^@' zaw-cdr # zaw-cdrをbindkey

## zaw.zsh source for the elements of the directory stack.
## https://github.com/nakamuray/zaw
## Thank you very much, nakamuray!
#
#zmodload zsh/parameter
#
#function zaw-src-dirstack() {
#    : ${(A)candidates::=$dirstack}
#    actions=("zaw-callback-execute" "zaw-callback-replace-buffer" "zaw-callback-append-to-buffer")
#    act_descriptions=("execute" "replace edit buffer" "append to edit buffer")
#}
#
#zaw-register-src -n dirstack zaw-src-dirstack

#########################################
# misc
#########################################

#PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
